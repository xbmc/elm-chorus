module Pages.Music.Top exposing (Model, Msg, Params, page)

import Colors exposing (greyIcon)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
import Element.Input as Input
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Request
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Svg.Attributes
import WSDecoder exposing (ItemDetails, SongObj)



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
    { currentlyPlaying : ItemDetails
    , song_list : List SongObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { currentlyPlaying = shared.currentlyPlaying, song_list = shared.song_list }
    , sendAction """{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "limits": { "start" : 0, "end": 25 }, "properties": [ "artist", "duration", "album", "track" ], "sort": { "order": "ascending", "method": "track", "ignorearticle": true } }, "id": "libSongs"}"""
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
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| greyIcon))
        }


menuBar =
    column [ Element.height fill, Element.width (fillPortion 1) ]
        [ Element.link []
            { url = Route.toString Route.Music
            , label = Element.text "Music"
            }
        , Element.link []
            { url = Route.toString Route.Music__Genres
            , label = Element.text "Genres"
            }
        , Element.link []
            { url = Route.toString Route.Music__Genres
            , label = Element.text "Top Music"
            }
        , Element.link []
            { url = Route.toString Route.Music__Artists
            , label = Element.text "Artists"
            }
        , Element.link []
            { url = Route.toString Route.Music__Albums
            , label = Element.text "Albums"
            }
        , Element.link []
            { url = Route.toString Route.Music__Videos
            , label = Element.text "Videos"
            }
        ]



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Music"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, spacingXY 5 7 ]
                (List.map
                    (\song ->
                        row [ Element.width fill, paddingXY 5 5, Background.color (rgb 0.2 0.2 0.2), mouseOver [ Background.color (rgb 0.4 0.4 0.4) ], Element.Events.onDoubleClick (SetCurrentlyPlaying song) ]
                            [ materialButton ( Filled.play_arrow, SetCurrentlyPlaying song )
                            , materialButton ( Filled.thumb_up, SetCurrentlyPlaying song )
                            , el [ Font.color (Element.rgb 0.8 0.8 0.8) ] (Element.text song.label)
                            , row [ alignRight ]
                                (List.map
                                    (\artist ->
                                        el [ Font.color (Element.rgb 0.8 0.8 0.8), paddingXY 5 0 ] (Element.text artist)
                                    )
                                    song.artist
                                )
                            , el [ alignRight, Font.color (Element.rgb 0.8 0.8 0.8) ] (Element.text (String.fromInt song.duration))
                            , materialButton ( Filled.more_horiz, SetCurrentlyPlaying song )
                            ]
                    )
                    model.song_list
                )
            ]
        ]
    }
