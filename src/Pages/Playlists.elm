module Pages.Playlists exposing (Model, Msg, Params, page)

import Components.LayoutType exposing (DialogType(..))
import Components.VerticalNavPlaylists
import Element exposing (..)
import Json.Decode as Decode exposing (Decoder, string)
import Shared
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import WSDecoder exposing (LocalPlaylists, localPlaylistDecoder)


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
    { playlists : LocalPlaylists
    , showDialog : DialogType
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { playlists = shared.playlists, showDialog = shared.showDialog }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NewPlaylist
    | CloseDialog


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewPlaylist ->
            ( { model | showDialog = TextInputDialog }, Cmd.none )

        CloseDialog ->
            ( { model | showDialog = None }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | showDialog = model.showDialog }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Playlists"
    , body =
        [ Components.VerticalNavPlaylists.view
            "playlists"
            Route.Top
            (List.map
                (\playlist ->
                    { route = Route.Playlists__Name_String { name = percentEncode playlist.name }
                    , label = playlist.name
                    }
                )
                model.playlists.localPlaylists
            )
            NewPlaylist
        ]
    }
