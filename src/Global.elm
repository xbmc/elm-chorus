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

import Action exposing (Method(..), methodToStr)
import Browser.Navigation as Nav
import Components
import Document exposing (Document)
import Generated.Route as Route exposing (Route)
import Task
import Url exposing (Url)
import Json.Encode as Encode
import Dict exposing (Dict)


-- INIT

type alias Flags =
    ()

{-Player stuff-}
type PlayerType
    = Audio 
    | Picture

type alias PlayerObj =
    { id : Int
    , playertype: PlayerType
    }

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

{-
dictToStr : Dict Key Value -> String 
dictToStr dict =
    Dict.foldr (\key val str -> str  ++ key ++ ":" ++ val ++ ",") "" dict
-}
type Property
    = Title
    | Album
    | Artist
    | Season
    | Episode
    | Duration
    | Showtitle
    | TVshowid
    | Thumbnail
    | File
    | Fanart
    | Streamdetails

type alias Limit =
    { start : Int 
    , end : Int
    }

type alias Params =
    { playerid : Maybe Int
    , properties : Maybe (List Property)
    , limits : Maybe Limit
    }


request : Method -> Maybe { playerid : Maybe Int, properties : Maybe (List Property) } -> String
request method params =
    Encode.encode 0
        <| case params of
                Nothing -> -- No params provided
                    Encode.object
                    [ ( "jsonrpc", Encode.string "2.0" )
                    , ( "method", Encode.string (methodToStr method)) 
                    , ( "id", Encode.int 1)
                    ]
                Just param -> -- params
                    Encode.object
                    [ ( "jsonrpc", Encode.string "2.0" )
                    , ( "method", Encode.string (methodToStr method)) 
                    , ( "params", Encode.string "param") -- encode type alias to json
                    , ( "id", Encode.int 1)
                    ]

-- PORTS

port sendAction : String -> Cmd msg


port responseReceiver : (String -> msg) -> Sub msg


-- UPDATE

type Msg
    = Navigate Route
    | Request Method Params

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate route ->
            ( model
            , Nav.pushUrl model.key (Route.toHref route)
            )

        Request method param ->
            ( model
            , sendAction (request method (Just {playerid = param.playerid, properties = param.properties}))
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
        , playPauseMsg = toMsg (Request Player_PlayPause (Params (Just 0) Nothing Nothing))
        , skipMsg = toMsg (Request Player_PlayPause (Params (Just 0) Nothing Nothing))
        , reverseMsg = toMsg (Request Player_PlayPause (Params (Just 0) Nothing Nothing))
        , muteMsg = toMsg (Request Player_PlayPause (Params (Just 0) Nothing Nothing))
        , repeatMsg = toMsg (Request Player_PlayPause (Params (Just 0) Nothing Nothing))
        , shuffleMsg = toMsg (Request Player_PlayPause (Params (Just 0) Nothing Nothing))
        }

-- COMMANDS

send : msg -> Cmd msg
send =
    Task.succeed >> Task.perform identity


navigate : Route -> Cmd Msg
navigate route =
    send (Navigate route)
