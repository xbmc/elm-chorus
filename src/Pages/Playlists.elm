module Pages.Playlists exposing (Model, Msg, Params, page)

import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Json.Decode as Decode exposing (Decoder, string)
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
    { localPlaylists : Maybe LocalPlaylists }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( 
        case Decode.decodeString localPlaylistDecoder shared.flags.localPlaylists of
            Ok decodedLocalPlaylists -> 
                { localPlaylists = Just decodedLocalPlaylists }

            Err _ -> 
                { localPlaylists = Nothing }
    ,
        Cmd.none 
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
    shared


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
    , body = []
    }
