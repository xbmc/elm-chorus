port module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Browser.Navigation exposing (Key, pushUrl)
import Element exposing (..)
import Element.Font as Font
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Url exposing (Url)
import Json.Decode as D
import Components
--modules
import Method exposing (Method(..), methodToStr)
import WSDecoder exposing (PlayerObj(..), paramsResponseDecoder, resultResponseDecoder, ResultResponse(..))
import Request exposing (Params, propertyToStr, paramsToObj, request)

-- INIT

type alias Flags =
    ()

type alias Model =
    { flags : Flags
    , url : Url
    , key : Key
    , rightMenu : Bool
    , players : List PlayerObj
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model
        flags
        url
        key
        False
        []
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
    | ReceiveParamsResponse String
    | ReceiveResultResponse ResultResponse

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
                    , sendAction (request method (Just {playerid = param.playerid, properties = param.properties}))
                    )

        Recv message ->
            ( model
            , Cmd.none
            )

        ReceiveParamsResponse params ->
            ( model
            , Cmd.none
            )

        ReceiveResultResponse result ->
            case result of 
                ResultA str ->  
                    ( model
                    , Cmd.none
                    )
                ResultB playerObjects ->
                    ( { model | players = playerObjects }
                    , Cmd.none
                    )

-- SUBSCRIPTIONS

decodeWS message = 
    case D.decodeString resultResponseDecoder message of 
      Ok resultMessage ->
          ReceiveResultResponse resultMessage
      Err err ->
          case D.decodeString paramsResponseDecoder message of 
            Ok paramsMessage ->
              ReceiveParamsResponse message
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
        , playPauseMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , skipMsg = toMsg (Request Input_Home (Nothing))
        , reverseMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , muteMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , repeatMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , shuffleMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        }
