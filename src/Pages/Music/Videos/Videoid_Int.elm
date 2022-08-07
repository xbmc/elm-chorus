module Pages.Music.Videos.Videoid_Int exposing (Model, Msg, Params, page)

import Colors exposing (black, cardHover, darkGreyIcon, greyIcon, white, whiteIcon)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font exposing (Font)
import Element.Input as Input
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (AlbumObj, ArtistObj, SongObj, VideoObj)


page : Page Params Model Msg
page =
    Page.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , save = save
        , load = load
        }



-- INIT


type alias Params =
    { videoid : Int }


type alias Model =
    { artist_list : List ArtistObj
    , videoid : Int
    , video : Maybe VideoObj
    , album_list : List AlbumObj
    , video_list : List VideoObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { videoid = params.videoid
      , video = getVideos params.videoid shared.video_list
      , album_list = shared.album_list
      , artist_list = shared.artist_list
      , video_list = shared.video_list
      }
    , Cmd.none
    )


getVideos : Int -> List VideoObj -> Maybe VideoObj
getVideos id videolist =
    List.head (List.filter (\video -> id == video.videoid) videolist)



-- UPDATE


type Msg
    = SetCurrentlyPlaying VideoObj
    | QueueMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying video ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next video -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"musicvideoid": """ ++ String.fromInt video.videoid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        QueueMsg ->
            ( model, sendAction """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"musicvideoid": 1}}}""" )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


materialButtonRight : ( Icon msg, msg ) -> Element msg
materialButtonRight ( icon, action ) =
    Input.button [ paddingXY 5 0 ]
        { onPress = Just action
        , label = Element.html (icon 18 (MITypes.Color <| darkGreyIcon))
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Music.Videos.Videoid_Int"
    , body =
        [ case model.video of
            Nothing ->
                column [ Element.height fill, Element.width fill ]
                    [ Element.text (String.fromInt model.videoid)
                    ]

            Just video ->
                column [ Element.height fill, Element.width fill, Background.color Colors.sidebar ]
                    [ row [ Element.height (fillPortion 1), Element.width fill, Background.color (Element.rgba255 50 53 55 1), Element.htmlAttribute (Html.Attributes.class "card-parent"), paddingXY 20 10 ]
                        [ column [ Element.width (px 250), Element.height (px 250), Element.htmlAttribute (Html.Attributes.class "card-parent") ]
                            [ case video.thumbnail of
                                "" ->
                                    image [ Element.height (fill |> maximum 250), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = "/thumbnail_default.png"
                                        , description = "Default Thumbnail"
                                        }

                                _ ->
                                    image [ Element.height (fill |> maximum 250), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode video.thumbnail ] []
                                        , description = "Thumbnail"
                                        }
                            , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 135), Element.width (fill |> minimum 230 |> maximum 240), Background.color cardHover ]
                                [ row [ alignTop, alignRight, paddingXY 15 15 ]
                                    [ Input.button []
                                        { onPress = Nothing
                                        , label = Element.html (Filled.thumb_up 25 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    ]
                                , el [ htmlAttribute (Html.Attributes.style "margin" "auto"), paddingEach { top = 0, left = 0, right = 0, bottom = 50 } ]
                                    (Input.button []
                                        { onPress = Just (SetCurrentlyPlaying video)
                                        , label = Element.html (Filled.play_arrow 45 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    )
                                ]
                            ]
                        , column [ alignTop, Element.height fill, Element.width (fillPortion 7), paddingXY 10 35 ]
                            [ el [ Font.color white, Font.size 30 ] (Element.text video.label)
                            , column [ paddingEach { top = 30, left = 0, right = 0, bottom = 0 }, spacingXY 0 12, Font.size 14 ]
                                [ row []
                                    [ el [ Font.color white ] (Element.text "Artist(s): ")
                                    , row []
                                        (List.map
                                            (\artist ->
                                                Element.text artist
                                            )
                                            video.artist
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Album: ")
                                    , el [] (Element.text video.album)
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Genre: ")
                                    , row []
                                        (List.map
                                            (\genre ->
                                                Element.text genre
                                            )
                                            video.genre
                                        )
                                    ]
                                ]
                            , el [ paddingXY 0 20, Font.size 15 ] (Element.text "Music Video")
                            , row [ spacingXY 10 0 ]
                                [ Input.button [ paddingXY 12 8, Background.color Colors.navTextHover ]
                                    { onPress = Just (SetCurrentlyPlaying video)
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Play"), Element.html (Filled.play_circle_filled 16 (MITypes.Color <| whiteIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Just QueueMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Queue"), Element.html (Filled.add_circle 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Nothing -- TODO : make stream button work when the stream functionality has been implemented
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Stream"), Element.html (Filled.cast_connected 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Nothing -- TODO : Add More menu dropdown
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "More"), Element.html (Filled.more_vert 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                ]
                            ]
                        ]
                    , column [ Element.height (fillPortion 5), Element.width fill, paddingXY 35 35, spacingXY 5 7 ]
                        [ el [ Font.size 30, Font.color black ] (Element.text "Related music videos from YouTube") ]
                    ]
        ]
    }
