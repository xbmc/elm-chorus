module Pages.Playlists exposing (Model, Msg, Params, page)

import Components.VerticalNavPlaylists
import Element exposing (..)
import Json.Decode as Decode exposing (Decoder, string)
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Spa.Generated.Route as Route exposing (Route)
import WSDecoder exposing (LocalPlaylists, localPlaylistDecoder)
import Url exposing (percentEncode)

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
    ( case shared.flags.localPlaylists of
        Just localPlaylists ->
            case Decode.decodeString localPlaylistDecoder localPlaylists of
                Ok decodedLocalPlaylists ->
                    { localPlaylists = Just decodedLocalPlaylists }

                Err _ ->
                    { localPlaylists = Nothing }
        Nothing ->
            { localPlaylists = Nothing }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NewPlaylist


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewPlaylist ->
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
    , body = [ case model.localPlaylists of
                    Nothing ->
                        Components.VerticalNavPlaylists.view
                            "playlists"
                            Route.Top
                            []
                            NewPlaylist
                    Just localPlaylists -> 
                        Components.VerticalNavPlaylists.view
                            "playlists"
                            Route.Top
                            (List.map
                                (\playlist ->
                                    { route = Route.Playlists__Name_String { name = percentEncode playlist.name }
                                    , label = playlist.name
                                    }
                                )
                                localPlaylists.localPlaylists
                            )
                            NewPlaylist
                ]
    }
