module Pages.Music.Top.Top exposing (Model, Msg, Params, page)

import Colors exposing (blackIcon, cardHover, darkGreyIcon, greyIcon, whiteIcon)
import Components.SectionHeader
import Components.VerticalNavMusic
import Element exposing (..)
import Element.Background as Background
import Element.Events
import Element.Font as Font
import Element.Input as Input
import Helper exposing (durationToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (AlbumObj, ItemDetails, SongObj)



--import Components exposing ()


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
    ()


type alias Model =
    { currentlyPlaying : Maybe ItemDetails
    , song_list : List SongObj
    , route : Route
    , album : List AlbumObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { route } =
    ( { currentlyPlaying = shared.currentlyPlaying, song_list = shared.song_list, route = route, album = shared.album_list }
    , sendAction """{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "limits": { "start" : 0, "end": 25 }, "properties": [ "artist", "duration", "album", "track" ,"thumbnail"], "sort": { "order": "ascending", "method": "track", "ignorearticle": true } }, "id": "libSongs"}"""
    )



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
    { shared | currentlyPlaying = model.currentlyPlaying, song_list = model.song_list }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | song_list = shared.song_list }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 5 ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| whiteIcon))
        }


materialButtonRight : ( Icon msg, msg ) -> Element msg
materialButtonRight ( icon, action ) =
    Input.button [ paddingXY 5 0 ]
        { onPress = Just action
        , label = Element.html (icon 18 (MITypes.Color <| darkGreyIcon))
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Music"
    , body =
        [ row [ Element.height fill, Element.width fill, Background.color Colors.background ]
            [ Components.VerticalNavMusic.view model.route
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7 ]
                (List.append
                    [ Components.SectionHeader.view "Top Songs" Nothing False [ { title = "Toggle select all", action = Nothing } ]
                    ]
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
                                    , column [ Element.width (px 300) ]
                                        [ row []
                                            (List.map
                                                (\album ->
                                                    el [ Font.color (Element.rgba255 43 47 48 0.5), paddingXY 5 0 ] (Element.text album.label)
                                                )
                                                (List.filter (\album -> song.albumid == album.albumid) model.album)
                                            )
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
                                            , el [ alignRight, Font.color (Element.rgba255 43 47 48 0.5), Element.htmlAttribute (Html.Attributes.class "song-duration") ] (song.duration |> durationToString |> Element.text)
                                            ]
                                        , row [ alignRight, Background.color (rgba 223 223 223 0.4), Element.htmlAttribute (Html.Attributes.class "song-icons") ] [ materialButtonRight ( Filled.thumb_up, SetCurrentlyPlaying song ), materialButtonRight ( Filled.add_box, SetCurrentlyPlaying song ), materialButtonRight ( Filled.more_horiz, SetCurrentlyPlaying song ) ]
                                        ]
                                    ]
                                )
                        )
                        model.song_list
                    )
                )
            ]
        ]
    }
