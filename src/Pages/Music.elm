module Pages.Music exposing (Params, Model, Msg, page)

import Shared exposing (sendAction)
import Element exposing (..)
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
    ( {currentlyPlaying = ItemDetails "" 0 "", song_list = []}
    , sendAction """{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "limits": { "start" : 0, "end": 25 }, "properties": [ "artist", "duration", "album", "track" ], "sort": { "order": "ascending", "method": "track", "ignorearticle": true } }, "id": "libSongs"}"""
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared--{shared | field = model.field}


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
        , column [Element.width fill]
            (List.map 
                (\song -> 
                    row [Element.width fill] 
                        [ el [] (Element.text song.label)
                        , el [alignRight] (Element.text (String.fromInt(song.duration)))
                        ]
                ) 
            model.song_list)
        ]
    }