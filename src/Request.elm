module Request exposing (Params, propertyToStr, paramsToObj, request)

import Json.Encode as Encode exposing (list, string)
import Method exposing (Method(..), methodToStr)

-- SEND REQUEST 

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
