module Pages.Music exposing (Params, Model, Msg, page)

import Shared exposing (sendAction)
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Html exposing (..)
import Html.Attributes exposing (..)
import Request
import WSDecoder exposing (Song, ItemDetails)


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
    , song_list : List Song
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( {currentlyPlaying = shared.currentlyPlaying, song_list = shared.song_list}
    , sendAction """{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "limits": { "start" : 0, "end": 25 }, "properties": [ "artist", "duration", "album", "track" ], "sort": { "order": "ascending", "method": "track", "ignorearticle": true } }, "id": "libSongs"}"""
    )



-- UPDATE


type Msg
    = PlayPause


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayPause ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( {model | currentlyPlaying = shared.currentlyPlaying, song_list = shared.song_list} , Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- VIEW


view : Model -> Document Msg
view model =
    { title = "Music"
    , body = 
        [ Element.text "Songs:"
        , column [Element.height fill, Element.width fill, scrollbars, clipY, spacingXY 5 7]
            (List.map 
                (\song -> 
                    row [Element.width fill, paddingXY 5 5, Border.width 2, Border.rounded 4, mouseOver [ Background.color <| rgb255 86 182 139 ]]--Element.Events.onClick PlayPause] 
                        [ el [] (Element.text song.label)
                        , el [alignRight] (Element.text (String.fromInt(song.duration)))
                        ]
                ) 
            model.song_list)
        ]
    }