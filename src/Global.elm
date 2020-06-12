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

import Action exposing (Method(..), Param(..))
import Browser.Navigation as Nav
import Components
import Document exposing (Document)
import Generated.Route as Route exposing (Route)
import Task
import Url exposing (Url)
import Json.Encode as Encode



-- INIT


type alias Flags =
    ()


type alias Model =
    { flags : Flags
    , url : Url
    , key : Nav.Key
    , rightMenu : Bool
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model
        flags
        url
        key
        False
    , Cmd.none
    )



-- PORTS


port sendAction : String -> Cmd msg


port responseReceiver : (String -> msg) -> Sub msg



-- UPDATE


type Msg
    = Navigate Route
    | Send Method Param Int



{- convert method param int to json action -}
toStr : Method -> Param -> Int -> String
toStr method param int =
    Encode.encode 0 
        <| Encode.object
            [ ( "jsonrpc", Encode.string "2.0" )
            , ( "method", Encode.string "Input.ExecuteAction" )
            , ( "params"
              , Encode.object
                    [ ("action", Encode.string "playpause")
                    ]
              )
            , ( "id", Encode.int 0 )
            ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate route ->
            ( model
            , Nav.pushUrl model.key (Route.toHref route)
            )

        Send method param int ->
            ( model
            , sendAction (toStr method param int)
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



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
        , playPauseMsg = toMsg (Send InputExecuteAction Playpause 0)
        , skipMsg = toMsg (Send InputExecuteAction Skipnext 0)
        , reverseMsg = toMsg (Send InputExecuteAction Skipprevious 0)
        , muteMsg = toMsg (Send InputExecuteAction Mute 0)
        , repeatMsg = toMsg (Send InputExecuteAction Play 0)
        , shuffleMsg = toMsg (Send InputExecuteAction Play 0)
        }



-- COMMANDS


send : msg -> Cmd msg
send =
    Task.succeed >> Task.perform identity


navigate : Route -> Cmd Msg
navigate route =
    send (Navigate route)
