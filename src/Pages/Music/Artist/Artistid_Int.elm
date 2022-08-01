module Pages.Music.Artist.Artistid_Int exposing (Model, Msg, Params, page)

import Colors exposing (cardHover, darkGreyIcon)
import Components.SectionHeader
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
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
import WSDecoder exposing (AlbumObj, ArtistObj, SongObj)


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
    { artistid : Int }


type alias Model =
    { artistid : Int
    , artist : Maybe ArtistObj
    , album_list : List AlbumObj
    , song_list : List SongObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { artistid = params.artistid
      , artist = getArtist params.artistid shared.artist_list
      , album_list = shared.album_list
      , song_list = shared.song_list
      }
    , Cmd.none
    )


checkArtistId : Int -> ArtistObj -> Bool
checkArtistId firstId artist =
    if firstId == artist.artistid then
        True

    else
        False


getArtist : Int -> List ArtistObj -> Maybe ArtistObj
getArtist id artistlist =
    List.head (List.filter (\artist -> checkArtistId id artist) artistlist)


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| Colors.greyIcon))
        }



-- UPDATE


type Msg
    = SetCurrentlyPlaying SongObj


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
    { title = "Music.Artist.Artistid_Int"
    , body =
        [ case model.artist of
            Nothing ->
                column [ Element.height fill, Element.width fill ]
                    [ Element.text (String.fromInt model.artistid)
                    ]

            Just artist ->
                column [ Element.height fill, Element.width fill ]
                    [ row [ Element.height (fillPortion 1), Element.width fill, Background.color Colors.navHeaderBackground ]
                        [ image [ Element.height (fill |> minimum 240 |> maximum 240), Element.width (fillPortion 1 |> maximum 240) ]
                            { src = crossOrigin "http://localhost:8080" [ "image", percentEncode artist.thumbnail ] []
                            , description = "Thumbnail"
                            }
                        , column [ alignTop, Element.height fill, Element.width (fillPortion 7), paddingXY 5 5 ]
                            [ Element.text artist.label
                            , row []
                                [ Element.text "Buttons"
                                ]
                            ]
                        ]
                    , case model.artist of
                        Nothing ->
                            el [] (Element.text "")

                        Just art ->
                            column [ Element.height fill, Element.width fill, spacingXY 5 5 ]
                                (List.map
                                    (\album ->
                                        row [ Element.height fill, Element.width fill ]
                                            [ column [ Element.height fill, Element.width (fillPortion 1), paddingXY 5 5 ]
                                                [ case album.thumbnail of
                                                    "" ->
                                                        image [ Element.width (fillPortion 1), Element.height fill ]
                                                            { src = "https://via.placeholder.com/170"
                                                            , description = "Hero Image"
                                                            }

                                                    _ ->
                                                        column [ Element.height fill, Element.width fill, spacingXY 5 5 ]
                                                            [ el [ Element.below (Element.text album.label) ]
                                                                (image [ Element.width (fillPortion 1), Element.height fill ]
                                                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
                                                                    , description = "Thumbnail"
                                                                    }
                                                                )
                                                            ]
                                                ]
                                            , column [ Element.height fill, Element.width (fillPortion 3), paddingXY 5 5, spacingXY 5 7 ]
                                                (List.map
                                                    (\song ->
                                                        el [ Element.width fill, paddingEach { left = 10, top = 0, right = 60, bottom = 0 } ]
                                                            (row [ Element.width fill, paddingXY 5 5, Background.color Colors.background, mouseOver [ Background.color (rgba 223 223 223 0.5) ], Font.size 13, Element.Events.onDoubleClick (SetCurrentlyPlaying song), Element.htmlAttribute (Html.Attributes.class "song-card-parent"), htmlAttribute <| Html.Attributes.style "border-bottom" "1px solid rgb(216 ,216 ,216 ,1)" ]
                                                                [ column [ paddingEach { left = 0, top = 0, right = 500, bottom = 0 }, Element.width (px 600) ]
                                                                    [ row [ spacing 10 ]
                                                                        [ case song.thumbnail of
                                                                            "" ->
                                                                                image [ Element.width (px 35), Element.height (px 35) ]
                                                                                    { src = "https://via.placeholder.com/170x170"
                                                                                    , description = "Hero Image"
                                                                                    }

                                                                            _ ->
                                                                                image [ Element.width (px 35), Element.height (px 35) ]
                                                                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode song.thumbnail ] []
                                                                                    , description = "Thumbnail"
                                                                                    }
                                                                        , el [ Font.color (Element.rgba255 43 47 48 0.5) ] (Element.text (String.fromInt song.track))
                                                                        , el [ Font.color Colors.black ] (Element.text song.label)
                                                                        ]
                                                                    , el [ Element.htmlAttribute (Html.Attributes.class "song-play"), Background.color cardHover, Element.width (px 35), Element.height (px 35) ] (materialButton ( Filled.play_arrow, SetCurrentlyPlaying song ))
                                                                    ]
                                                                , column [ alignRight, Element.width (px 300) ]
                                                                    [ row [ alignRight ]
                                                                        [ row [ Element.width (px 300), alignLeft ]
                                                                            (List.map
                                                                                (\artistitem ->
                                                                                    el [ Font.color (Element.rgba255 43 47 48 0.5), paddingXY 5 0 ] (Element.text artistitem)
                                                                                )
                                                                                song.artist
                                                                            )
                                                                        , el [ alignRight, Font.color (Element.rgba255 43 47 48 0.5), Element.htmlAttribute (Html.Attributes.class "song-duration") ] (song.duration |> durationToString |> Element.text)
                                                                        ]
                                                                    , row [ alignRight, Background.color (rgba 223 223 223 0.4), Element.htmlAttribute (Html.Attributes.class "song-icons") ] [ materialButtonRight ( Filled.thumb_up, SetCurrentlyPlaying song ), materialButtonRight ( Filled.add_box, SetCurrentlyPlaying song ), materialButtonRight ( Filled.more_horiz, SetCurrentlyPlaying song ) ]
                                                                    ]
                                                                ]
                                                            )
                                                    )
                                                    (List.filter (\song -> song.albumid == album.albumid) model.song_list)
                                                 --filtered song list
                                                )
                                            ]
                                    )
                                    (List.filter (\album -> List.member art.label album.artist) model.album_list)
                                 -- album list
                                )
                    ]
        ]
    }
