module Pages.Music.Album.Albumid_Int exposing (Model, Msg, Params, page)

import Color
import Colors exposing (cardHover, darkGreyIcon, greyIcon, white, whiteIcon)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font exposing (Font, extraLight)
import Element.Input as Input
import Helper exposing (durationToString)
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Shared exposing (sendActions)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (AlbumObj, SongObj)


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
    { albumid : Int }


type alias Model =
    { albumid : Int
    , album : Maybe AlbumObj
    , song_list : List SongObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { albumid = params.albumid, album = getAlbum params.albumid shared.album_list, song_list = List.filter (\song -> song.albumid == params.albumid) shared.song_list }, Cmd.none )


checkAlbumId : Int -> AlbumObj -> Bool
checkAlbumId firstId album =
    if firstId == album.albumid then
        True

    else
        False


getAlbum : Int -> List AlbumObj -> Maybe AlbumObj
getAlbum id albumlist =
    List.head (List.filter (\album -> checkAlbumId id album) albumlist)


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| Colors.darkGreyIcon))
        }



-- UPDATE


type Msg
    = SetCurrentlyPlaying SongObj
    | PlayMsg
    | QueueMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying song ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next song -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": """ ++ String.fromInt song.songid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        PlayMsg ->
            let
                added_songs =
                    List.map (\song -> """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": """ ++ String.fromInt song.songid ++ """}}}""") model.song_list

                output =
                    [ """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}""" ]
                        ++ added_songs
                        ++ [ """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}""" ]
            in
            ( model, sendActions output )

        QueueMsg ->
            ( model, sendActions (List.map (\song -> """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": """ ++ String.fromInt song.songid ++ """}}}""") model.song_list) )


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
    { title = "Music.Album.Albumid_Int"
    , body =
        [ case model.album of
            Nothing ->
                column [ Element.height fill, Element.width fill ]
                    [ Element.text (String.fromInt model.albumid)
                    ]

            Just album ->
                column [ Element.height fill, Element.width fill, Background.color Colors.sidebar ]
                    [ row [ Element.height (fillPortion 1), Element.width fill, Background.color (Element.rgba255 50 53 55 1), Element.htmlAttribute (Html.Attributes.class "card-parent"), padding 30 ]
                        [ column [ Element.width (px 250), Element.height (px 250), Element.htmlAttribute (Html.Attributes.class "card-parent") ]
                            [ image [ Element.height (fill |> maximum 230), Element.width (fillPortion 2 |> maximum 230) ]
                                { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
                                , description = "Thumbnail"
                                }
                            , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 230), Element.width (fill |> minimum 230 |> maximum 230), Background.color cardHover ]
                                [ row [ alignTop, alignRight, paddingXY 15 15 ]
                                    [ Input.button []
                                        { onPress = Just PlayMsg
                                        , label = Element.html (Filled.thumb_up 30 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    ]
                                , el [ htmlAttribute (Html.Attributes.style "margin" "auto"), paddingEach { top = 0, left = 0, right = 0, bottom = 50 } ]
                                    (Input.button []
                                        { onPress = Just PlayMsg
                                        , label = Element.html (Filled.play_arrow 60 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    )
                                ]
                            ]
                        , column [ alignTop, Element.height fill, Element.width (fillPortion 7), paddingXY 10 25 ]
                            [ row [] [ el [ Font.color white, Font.size 30 ] (Element.text album.label), el [ alignBottom, paddingXY 10 0, Font.size 15 ] (Element.text (String.fromInt album.year)) ]
                            , column [ paddingXY 0 35, spacingXY 0 10, Font.size 14 ]
                                [ row []
                                    [ el [ Font.color white ] (Element.text "Artist(s): ")
                                    , row []
                                        (List.map
                                            (\artist ->
                                                Element.text artist
                                            )
                                            album.artist
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Genre: ")
                                    , row []
                                        (List.map
                                            (\genre ->
                                                Element.text genre
                                            )
                                            album.genre
                                        )
                                    ]
                                ]
                            , row [ spacingXY 10 0 ]
                                [ Input.button [ paddingXY 12 8, Background.color Colors.navTextHover ]
                                    { onPress = Just PlayMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Play"), Element.html (Filled.play_circle_filled 16 (MITypes.Color <| whiteIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Just QueueMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Queue"), Element.html (Filled.add_circle 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Just PlayMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Stream"), Element.html (Filled.cast_connected 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Just PlayMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "More"), Element.html (Filled.more_vert 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                ]
                            ]
                        ]
                    , column [ Element.height (fillPortion 5), Element.width fill, paddingXY 15 25, spacingXY 5 7 ]
                        (List.map
                            (\song ->
                                el [ Element.width (fill |> maximum 1200), paddingEach { left = 10, top = 0, right = 60, bottom = 0 } ]
                                    (row [ Element.width fill, paddingXY 5 5, Background.color Colors.sidebar, Font.size 13, Element.Events.onDoubleClick (SetCurrentlyPlaying song), Element.htmlAttribute (Html.Attributes.class "song-card-parent"), htmlAttribute <| Html.Attributes.style "border-bottom" "1px solid rgb(216 ,216 ,216 ,0.5)" ]
                                        [ column [ paddingEach { left = 0, top = 0, right = 0, bottom = 0 }, Element.width (px 300), Element.height (px 30) ]
                                            [ row [ spacing 10 ]
                                                [ el [ Font.color (Element.rgba255 43 47 48 0.5), paddingXY 10 10, Element.htmlAttribute (Html.Attributes.class "hide-onhover") ] (Element.text (String.fromInt song.track))
                                                , el [ Font.color Colors.black ] (Element.text song.label)
                                                ]
                                            , el [ Element.width (px 35), Element.height (px 35), Element.htmlAttribute (Html.Attributes.class "song-icons") ] (materialButton ( Filled.play_arrow, SetCurrentlyPlaying song ))
                                            ]
                                        , column [ alignRight, Element.width (px 300) ]
                                            [ row [ alignRight ]
                                                [ row [ Element.width (px 300), alignLeft ]
                                                    (List.map
                                                        (\artist ->
                                                            el [ Font.color (Element.rgba255 43 47 48 0.5), paddingXY 5 0 ] (Element.text artist)
                                                        )
                                                        song.artist
                                                    )
                                                , el [ alignRight, Font.color (Element.rgba255 43 47 48 0.5), Element.htmlAttribute (Html.Attributes.class "hide-onhover") ] (song.duration |> durationToString |> Element.text)
                                                ]
                                            , row [ alignRight, Element.htmlAttribute (Html.Attributes.class "song-icons") ] [ materialButtonRight ( Filled.thumb_up, SetCurrentlyPlaying song ), materialButtonRight ( Filled.add_box, SetCurrentlyPlaying song ), materialButtonRight ( Filled.more_horiz, SetCurrentlyPlaying song ) ]
                                            ]
                                        ]
                                    )
                            )
                            model.song_list
                        )
                    , case album.fanart of
                        "" ->
                            Element.none

                        _ ->
                            column [ Element.htmlAttribute (Html.Attributes.class "image-gradient"), alignRight, alignTop ]
                                [ image [ Element.width (fillPortion 2 |> maximum 550) ]
                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.fanart ] []
                                    , description = "Fanart"
                                    }
                                ]
                    ]
        ]
    }
