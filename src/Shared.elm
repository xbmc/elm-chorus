port module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

--modules

import Browser.Navigation exposing (Key, pushUrl)
import Components
import Element exposing (..)
import Element.Font as Font
import Json.Decode as D
import Method exposing (Method(..), methodToStr)
import Request exposing (Params, Property(..), paramsToObj, propertyToStr, request)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Url exposing (Url)
import WSDecoder exposing (Item, ItemDetails, PType(..), ParamsResponse, PlayerObj(..), ResultResponse(..), paramsResponseDecoder, resultResponseDecoder)



-- INIT


type alias Flags =
    ()


type alias Model =
    { flags : Flags
    , url : Url
    , key : Key
    , rightMenu : Bool
    , controlMenu : Bool
    , players : List PlayerObj
    , currentlyPlaying : ItemDetails
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( { flags = flags, url = url, key = key, rightMenu = False, controlMenu = False, players = [], currentlyPlaying = ItemDetails "" 0 "" }
    , Cmd.none
    )



-- PORTS


port sendAction : String -> Cmd msg


port responseReceiver : (String -> msg) -> Sub msg



-- UPDATE


type Msg
    = Navigate Route
    | Request Method (Maybe Params)
    | Recv String
    | PlayPause
    | ReceiveParamsResponse ParamsResponse
    | ReceiveResultResponse ResultResponse
    | ToggleRightMenu
    | ToggleControlMenu
    | SendTextToKodi
    | ScanVideoLibrary
    | ScanMusicLibrary


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate route ->
            ( model
            , pushUrl model.key (Route.toString route)
            )

        Request method params ->
            case params of
                Nothing ->
                    ( model
                    , sendAction (request method Nothing)
                    )

                Just param ->
                    ( model
                    , sendAction (request method (Just { playerid = param.playerid, songid = Nothing, properties = param.properties }))
                    )

        Recv message ->
            ( model
            , Cmd.none
            )

        PlayPause ->
            ( model
            , sendAction """{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id": 1 }"""
            )

        ReceiveParamsResponse params ->
            ( model
            , sendAction """{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "duration", "thumbnail"], "playerid": 0 }, "id": "AudioGetItem"}"""
            )

        ReceiveResultResponse result ->
            case result of
                ResultA str ->
                    ( model
                    , Cmd.none
                    )

                ResultB playerObjects ->
                    ( { model | players = playerObjects }
                      --chain messages, once we get players we gotta see what's playing
                      --{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "album", "artist", "duration", "thumbnail", "file", "fanart", "streamdetails"], "playerid": 0 }, "id": "AudioGetItem"}
                    , sendAction
                        (request Player_GetItem
                            (Just
                                { playerid = Just 0
                                , songid = Nothing
                                , properties = Just [ Title, Album, Artist, Duration, Thumbnail ]
                                }
                            )
                        ) -- Player.getproperties percentage
                    )

                ResultC item ->
                    ( { model | currentlyPlaying = item }
                    , Cmd.none
                    )

        ToggleRightMenu ->
            ( { model | rightMenu = not model.rightMenu }
            , Cmd.none
            )

        ToggleControlMenu ->
            ( { model | controlMenu = not model.controlMenu }
            , Cmd.none
            )

        SendTextToKodi ->
            ( model, Cmd.none )

        ScanVideoLibrary ->
            -- todo
            ( model, sendAction """""" )

        ScanMusicLibrary ->
            -- todo
            ( model, sendAction """""" )



-- SUBSCRIPTIONS


decodeWS message =
    case D.decodeString paramsResponseDecoder message of
        Ok paramsMessage ->
            ReceiveParamsResponse paramsMessage

        Err err ->
            case D.decodeString resultResponseDecoder message of
                Ok resultMessage ->
                    ReceiveResultResponse resultMessage

                Err err2 ->
                    Recv message


subscriptions : Model -> Sub Msg
subscriptions _ =
    responseReceiver decodeWS



-- VIEW


view :
    { page : Document msg, toMsg : Msg -> msg }
    -> Model
    -> Document msg
view { page, toMsg } model =
    Components.layout
        { page = page
        , currentlyPlaying = model.currentlyPlaying
        , playPauseMsg = toMsg PlayPause
        , skipMsg = toMsg (Request Input_Home Nothing)
        , reverseMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , muteMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , repeatMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , shuffleMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , controlMenu = model.controlMenu
        , controlMenuMsg = toMsg ToggleControlMenu
        , rightMenu = model.rightMenu
        , rightMenuMsg = toMsg ToggleRightMenu
        , sendTextToKodiMsg = toMsg SendTextToKodi
        , scanVideoLibraryMsg = toMsg ScanMusicLibrary
        , scanMusicLibraryMsg = toMsg ScanMusicLibrary
        }
