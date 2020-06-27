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
import Json.Encode as Encode exposing (list, string)
import Json.Decode exposing (Decoder, field, int)


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
    , responses : List String
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model
        flags
        url
        key
        False
        []
        []
    , Cmd.none
    )

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
    | Percentage
    | Time
    | Totaltime
    | Speed

-- convert property type to string
propertyToStr : Property -> String
propertyToStr prop =
    case prop of
        Title ->
            "title"
        Album -> 
            "album"
        Artist ->
            "artist"
        Season ->
            "season"
        Episode ->
            "episode"
        Duration ->
            "duration"
        Showtitle ->
            "showtitle"
        TVshowid ->
            "tvshowid"
        Thumbnail ->
            "thumbnail"
        File ->
            "file"
        Fanart ->
            "fanart"
        Streamdetails ->
            "streamdetails"
        --Player getPosition
        Percentage->
            "percentage"
        Time ->
            "time"
        Totaltime ->
            "totaltime"
        Speed ->
            "speed"

type alias Limit =
    { start : Int 
    , end : Int
    }

type alias Params =
    { playerid : Maybe Int
    , properties : Maybe (List Property)
    , limits : Maybe Limit
    }

type alias Response =
    { method : String 
    , params : Maybe Params
    }

-- convert params record to Json object
paramsToObj : Maybe { playerid: Maybe Int, properties : Maybe (List Property) } -> Encode.Value
paramsToObj params =
    case params of
        Nothing ->
            Encode.string "Nothing"
        Just param ->
            case param.playerid of
                Nothing ->
                    case param.properties of
                        Nothing ->
                            Encode.object
                                []
                        Just properties ->
                            Encode.object
                                [ ("properties", (list string (List.map propertyToStr (Maybe.withDefault [] param.properties))))
                                ]
                Just playerid ->
                    case param.properties of
                        Nothing ->
                            Encode.object
                                [("playerid", Encode.int (Maybe.withDefault 0 param.playerid))]
                        Just properties ->
                            Encode.object
                                [ ("playerid", Encode.int (Maybe.withDefault 0 param.playerid))
                                , ("properties", (list string (List.map propertyToStr (Maybe.withDefault [] param.properties))))
                                ]
-- send jsonrpc request with custom record
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
                        , ( "params", paramsToObj (Just {playerid = param.playerid, properties = param.properties})) -- encode records to json
                        , ( "id", Encode.int 1)
                        ]

-- PORTS

port sendAction : String -> Cmd msg


port responseReceiver : (String -> msg) -> Sub msg


-- UPDATE

type Msg
    = Navigate Route
    | Request Method (Maybe Params)
    | Recv String

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

        Recv response ->
            ( { model | responses = model.responses ++ [response] }
            , Cmd.none
            )

-- SUBSCRIPTIONS
{-methodDecoder : Decoder Response
methodDecoder =
    map2 Response
        (field "method" string)
        (field "params" )-}

subscriptions : Model -> Sub Msg
subscriptions model =
    responseReceiver Recv

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
