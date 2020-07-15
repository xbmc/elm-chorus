port module Global exposing
    ( Flags
    , Model
    , Msg
    , init
    , navigate
    , subscriptions
    , update
    , view
    )

import Browser.Navigation as Nav
import Components
import Document exposing (Document)
import Generated.Route as Route exposing (Route)
import Task
import Url exposing (Url)
import Json.Decode as D
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
    , key : Nav.Key
    , rightMenu : Bool
    , players : List PlayerObj
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
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
            , Nav.pushUrl model.key (Route.toHref route)
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
    { page : Document msg
    , global : Model
    , toMsg : Msg -> msg
    }
    -> Document msg
view { page, global, toMsg } =
    Components.layout
        { page = page
        , playPauseMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , skipMsg = toMsg (Request Input_Home (Nothing))
        , reverseMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , muteMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , repeatMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        , shuffleMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing)))
        }

-- COMMANDS

send : msg -> Cmd msg
send =
    Task.succeed >> Task.perform identity


navigate : Route -> Cmd Msg
navigate route =
    send (Navigate route)
