module WSDecoder exposing (AlbumObj, ArtistObj, Connection(..), DefaultElement, FileObj, FileType(..), Item, ItemDetails, LeftSidebarMenuHover(..), LocalPlaylists, LocalSettings, MovieObj, Option, PType(..), ParamsResponse, Path, PlayerObj(..), PlaylistObj, ResultResponse(..), SettingDefault(..), SettingsObj, SongObj, SourceObj, TvshowObj, VideoObj, decodeLocalSettings, encodeLocalSettings, localPlaylistDecoder, localPlaylistEncoder, paramsResponseDecoder, prepareDownloadDecoder, resultResponseDecoder, stringInDefaultElementToString)

import Json.Decode as Decode exposing (Decoder, at, bool, float, int, list, nullable, string)
import Json.Decode.Pipeline exposing (custom, optional, required)
import Json.Encode as Encode
import Method exposing (Method(..))



-----------------------
-- "params" response --
-----------------------
-- Item


type alias Item =
    { id : Int
    , itype : String
    }


itemDecoder : Decoder Item
itemDecoder =
    Decode.succeed Item
        |> required "id" int
        |> required "type" string



-- Player
-- PType


type PType
    = Audio
    | Video


parsePType : String -> Result String PType
parsePType string =
    case string of
        "audio" ->
            Ok Audio

        "video" ->
            Ok Video

        _ ->
            Err ("Invalid direction: " ++ string)


fromResult : Result String a -> Decoder a
fromResult result =
    case result of
        Ok a ->
            Decode.succeed a

        Err errorMessage ->
            Decode.fail errorMessage


pTypeDecoder : Decoder PType
pTypeDecoder =
    Decode.string |> Decode.andThen (fromResult << parsePType)



-- Player Type


type PlayerType
    = Internal
    | External


parsePlayerType : String -> Result String PlayerType
parsePlayerType string =
    case string of
        "internal" ->
            Ok Internal

        "external" ->
            Ok External

        _ ->
            Err ("Invalid direction: " ++ string)


playerTypeDecoder : Decoder PlayerType
playerTypeDecoder =
    Decode.string |> Decode.andThen (fromResult << parsePlayerType)



{-
   PlayerObj =
       playerid : Int
       speed : Int
       playertype : Maybe PlayerType
       ptype : Maybe PType
-}
--variants A and B have different shape


type PlayerObj
    = PlayerA Int Int
    | PlayerB Int PlayerType PType


playerSpdDecoder : Decoder PlayerObj
playerSpdDecoder =
    Decode.succeed PlayerA
        |> required "playerid" int
        |> required "speed" int


playerwoSpdDecoder : Decoder PlayerObj
playerwoSpdDecoder =
    Decode.succeed PlayerB
        |> required "playerid" int
        |> required "playertype" playerTypeDecoder
        |> required "type" pTypeDecoder


playerDecoder : Decoder PlayerObj
playerDecoder =
    Decode.oneOf [ playerSpdDecoder, playerwoSpdDecoder ]



-- Params Response


type alias ParamsResponse =
    { item : Item
    , player : PlayerObj
    }


paramsResponseDecoder : Decoder ParamsResponse
paramsResponseDecoder =
    Decode.succeed ParamsResponse
        |> custom (at [ "params", "data", "item" ] itemDecoder)
        |> custom (at [ "params", "data", "player" ] playerDecoder)



-- end "params"
-----------------------
-- "result" response --
-----------------------


type ResultResponse
    = ResultA String
    | ResultB (List PlayerObj)
    | ResultC ItemDetails
    | ResultD (List SongObj)
    | ResultE (List ArtistObj)
    | ResultF (List AlbumObj)
    | ResultG (List MovieObj)
    | ResultH Float Int --percentage/speed
    | ResultI (List SourceObj)
    | ResultJ Bool Float --muted/volume
    | ResultK (List FileObj)
    | ResultL (List SettingsObj)
    | ResultM (List VideoObj)



--main decoder which tries everyone else


resultResponseDecoder : Decoder ResultResponse
resultResponseDecoder =
    Decode.oneOf [ stringDecoder, listDecoder, detailDecoder, queryDecoder ]


stringDecoder : Decoder ResultResponse
stringDecoder =
    Decode.succeed ResultA
        |> required "result" string


listDecoder : Decoder ResultResponse
listDecoder =
    Decode.succeed ResultB
        |> required "result" (list playerDecoder)



-- Song/Video GetItem decoder


detailDecoder : Decoder ResultResponse
detailDecoder =
    Decode.succeed ResultC
        |> required "result" itemDetailDecoder


itemDetailDecoder : Decoder ItemDetails
itemDetailDecoder =
    Decode.succeed ItemDetails
        |> custom (at [ "item", "title" ] string)
        |> custom (at [ "item", "artist" ] (list string))
        |> custom (at [ "item", "duration" ] int)
        |> custom (at [ "item", "thumbnail" ] string)


type alias ItemDetails =
    { title : String
    , artist : List String
    , duration : Int
    , thumbnail : String
    }



--queries decoder


queryDecoder : Decoder ResultResponse
queryDecoder =
    Decode.oneOf
        [ percentDecoder
        , songQueryDecoder
        , artistQueryDecoder
        , albumQueryDecoder
        , movieQueryDecoder
        , sourceQueryDecoder
        , volumeDecoder
        , fileQueryDecoder
        , settingsQueryDecoder
        ]


settingsQueryDecoder : Decoder ResultResponse
settingsQueryDecoder =
    Decode.succeed ResultL
        |> custom (at [ "result", "settings" ] (list settingsDecoder))


songQueryDecoder : Decoder ResultResponse
songQueryDecoder =
    Decode.succeed ResultD
        |> custom (at [ "result", "songs" ] (list songDecoder))


songDecoder : Decoder SongObj
songDecoder =
    Decode.succeed SongObj
        |> required "label" string
        |> required "artist" (list string)
        |> required "duration" int
        |> required "songid" int
        |> required "albumid" int
        |> required "genre" (list string)


type alias SongObj =
    { label : String
    , artist : List String
    , duration : Int
    , songid : Int
    , albumid : Int
    , genre : List String
    }


artistQueryDecoder : Decoder ResultResponse
artistQueryDecoder =
    Decode.succeed ResultE
        |> custom (at [ "result", "artists" ] (list artistDecoder))


artistDecoder : Decoder ArtistObj
artistDecoder =
    Decode.succeed ArtistObj
        |> required "label" string
        |> required "artistid" int
        |> required "thumbnail" string
        |> required "genre" (list string)


type alias ArtistObj =
    { label : String
    , artistid : Int
    , thumbnail : String
    , genre : List String
    }


videoQueryDecoder : Decoder ResultResponse
videoQueryDecoder =
    Decode.succeed ResultM
        |> custom (at [ "result", "videos" ] (list videoDecoder))


videoDecoder : Decoder VideoObj
videoDecoder =
    Decode.succeed VideoObj
        |> required "label" string
        |> required "artist" (list string)
        |> required "albumid" int
        |> required "duration" int
        |> required "videoid" int
        |> required "thumbnail" string
        |> required "genre" (list string)


type alias VideoObj =
    { label : String
    , artistid : List String
    , albumid : Int
    , duration : Int
    , videoid : Int
    , thumbnail : String
    , genre : List String
    }


albumQueryDecoder : Decoder ResultResponse
albumQueryDecoder =
    Decode.succeed ResultF
        |> custom (at [ "result", "albums" ] (list albumDecoder))


albumDecoder : Decoder AlbumObj
albumDecoder =
    Decode.succeed AlbumObj
        |> required "label" string
        |> required "albumid" int
        |> required "artist" (list string)
        |> required "thumbnail" string
        |> required "genre" (list string)
        |> required "playcount" int
        |> required "dateadded" string


type alias AlbumObj =
    { label : String
    , albumid : Int
    , artist : List String
    , thumbnail : String
    , genre : List String
    , playcount : Int
    , dateadded : String
    }


type alias SettingsObj =
    { control : SettingControl
    , default : Maybe SettingDefault
    , enabled : Bool
    , help : Maybe String
    , id : String
    , label : String
    , level : Level
    , parent : String
    , settingType : Elementtype
    , value : Maybe SettingDefault
    , addontype : Maybe String
    , allowempty : Maybe Bool
    , allownewoption : Maybe Bool
    , data : Maybe String
    , options : Maybe (List Option)
    , maximum : Maybe Int
    , minimum : Maybe Int
    , step : Maybe Int
    , definition : Maybe Definition
    , delimiter : Maybe String
    , elementtype : Maybe Elementtype
    , maximumItems : Maybe Int
    , minimumItems : Maybe Int
    , sources : Maybe (List Decode.Value)
    , writable : Maybe Bool
    }


type alias SettingControl =
    { delayed : Bool
    , format : Elementtype
    , controlType : Type
    , multiselect : Maybe Bool
    , formatlabel : Maybe String
    , heading : Maybe String
    , minimumlabel : Maybe String
    , hidden : Maybe Bool
    , verifynewvalue : Maybe Bool
    }


type Type
    = Button
    | Edit
    | Spinner
    | Toggle
    | TypeList


type Elementtype
    = Action
    | Addon
    | Boolean
    | ElementtypeList
    | ElementtypeString
    | Integer
    | Paths


type SettingDefault
    = BoolInSettingDefault Bool
    | IntegerInSettingDefault Int
    | StringInSettingDefault String
    | UnionArrayInSettingDefault (List DefaultElement)


type DefaultElement
    = IntegerInDefaultElement Int
    | StringInDefaultElement String


type alias Definition =
    { allowempty : Maybe Bool
    , allownewoption : Maybe Bool
    , control : DefinitionControl
    , default : DefaultElement
    , enabled : Bool
    , help : String
    , id : String
    , label : String
    , level : Level
    , options : List Option
    , parent : String
    , definitionType : Elementtype
    , value : DefaultElement
    }


type alias DefinitionControl =
    { delayed : Bool
    , format : Elementtype
    , multiselect : Bool
    , controlType : Elementtype
    }


type Level
    = Basic
    | Standard


type alias Option =
    { label : String
    , value : DefaultElement
    }



-- decoders and encoders


settingsDecoder : Decoder SettingsObj
settingsDecoder =
    Decode.succeed SettingsObj
        |> required "control" settingControl
        |> optional "default" (nullable settingDefault) Nothing
        |> required "enabled" bool
        |> optional "help" (nullable string) Nothing
        |> required "id" string
        |> required "label" string
        |> required "level" level
        |> required "parent" string
        |> required "type" elementtype
        |> optional "value" (nullable settingDefault) Nothing
        |> optional "addontype" (nullable string) Nothing
        |> optional "allowempty" (nullable bool) Nothing
        |> optional "allownewoption" (nullable bool) Nothing
        |> optional "data" (nullable string) Nothing
        |> optional "options" (nullable (list option)) Nothing
        |> optional "maximum" (nullable int) Nothing
        |> optional "minimum" (nullable int) Nothing
        |> optional "step" (nullable int) Nothing
        |> optional "definition" (nullable definition) Nothing
        |> optional "delimiter" (nullable string) Nothing
        |> optional "elementtype" (nullable elementtype) Nothing
        |> optional "maximumItems" (nullable int) Nothing
        |> optional "minimumItems" (nullable int) Nothing
        |> optional "sources" (nullable (list Decode.value)) Nothing
        |> optional "writable" (nullable bool) Nothing


settingControl : Decoder SettingControl
settingControl =
    Decode.succeed SettingControl
        |> required "delayed" bool
        |> required "format" elementtype
        |> required "type" purpleType
        |> optional "multiselect" (nullable bool) Nothing
        |> optional "formatlabel" (nullable string) Nothing
        |> optional "heading" (nullable string) Nothing
        |> optional "minimumlabel" (nullable string) Nothing
        |> optional "hidden" (nullable bool) Nothing
        |> optional "verifynewvalue" (nullable bool) Nothing


purpleType : Decoder Type
purpleType =
    string
        |> Decode.andThen
            (\str ->
                case str of
                    "button" ->
                        Decode.succeed Button

                    "edit" ->
                        Decode.succeed Edit

                    "spinner" ->
                        Decode.succeed Spinner

                    "toggle" ->
                        Decode.succeed Toggle

                    "list" ->
                        Decode.succeed TypeList

                    somethingElse ->
                        Decode.fail <| "Invalid Type: " ++ somethingElse
            )


elementtype : Decoder Elementtype
elementtype =
    string
        |> Decode.andThen
            (\str ->
                case str of
                    "action" ->
                        Decode.succeed Action

                    "addon" ->
                        Decode.succeed Addon

                    "boolean" ->
                        Decode.succeed Boolean

                    "list" ->
                        Decode.succeed ElementtypeList

                    "string" ->
                        Decode.succeed ElementtypeString

                    "integer" ->
                        Decode.succeed Integer

                    "path" ->
                        Decode.succeed Paths

                    somethingElse ->
                        Decode.fail <| "Invalid Elementtype: " ++ somethingElse
            )


settingDefault : Decoder SettingDefault
settingDefault =
    Decode.oneOf
        [ Decode.map UnionArrayInSettingDefault (list defaultElement)
        , Decode.map BoolInSettingDefault bool
        , Decode.map IntegerInSettingDefault int
        , Decode.map StringInSettingDefault string
        ]


defaultElement : Decoder DefaultElement
defaultElement =
    Decode.oneOf
        [ Decode.map IntegerInDefaultElement int
        , Decode.map StringInDefaultElement string
        ]


stringInDefaultElementToString : DefaultElement -> String
stringInDefaultElementToString element =
    case element of
        IntegerInDefaultElement int ->
            String.fromInt int

        StringInDefaultElement string ->
            string


definition : Decoder Definition
definition =
    Decode.succeed Definition
        |> optional "allowempty" (nullable bool) Nothing
        |> optional "allownewoption" (nullable bool) Nothing
        |> required "control" definitionControl
        |> required "default" defaultElement
        |> required "enabled" bool
        |> required "help" string
        |> required "id" string
        |> required "label" string
        |> required "level" level
        |> required "options" (list option)
        |> required "parent" string
        |> required "type" elementtype
        |> required "value" defaultElement


definitionControl : Decoder DefinitionControl
definitionControl =
    Decode.succeed DefinitionControl
        |> required "delayed" bool
        |> required "format" elementtype
        |> required "multiselect" bool
        |> required "type" elementtype


level : Decoder Level
level =
    string
        |> Decode.andThen
            (\str ->
                case str of
                    "basic" ->
                        Decode.succeed Basic

                    "standard" ->
                        Decode.succeed Standard

                    somethingElse ->
                        Decode.fail <| "Invalid Level: " ++ somethingElse
            )


option : Decoder Option
option =
    Decode.succeed Option
        |> required "label" string
        |> required "value" defaultElement


movieQueryDecoder : Decoder ResultResponse
movieQueryDecoder =
    Decode.succeed ResultG
        |> custom (at [ "result", "movies" ] (list movieDecoder))


movieDecoder : Decoder MovieObj
movieDecoder =
    Decode.succeed MovieObj
        |> required "label" string
        |> required "movieid" int
        |> required "thumbnail" string
        |> required "file" string


type alias MovieObj =
    { label : String
    , movieid : Int
    , thumbnail : String
    , file : String
    }


type alias TvshowObj =
    { label : String
    , tvshowid : Int
    , thumbnail : String
    }


percentDecoder : Decoder ResultResponse
percentDecoder =
    Decode.succeed ResultH
        |> custom (at [ "result", "percentage" ] float)
        |> custom (at [ "result", "speed" ] int)


sourceQueryDecoder : Decoder ResultResponse
sourceQueryDecoder =
    Decode.succeed ResultI
        |> custom (at [ "result", "sources" ] (list sourceDecoder))


sourceDecoder : Decoder SourceObj
sourceDecoder =
    Decode.succeed SourceObj
        |> required "label" string
        |> required "file" string


type alias SourceObj =
    { label : String
    , file : String
    }


volumeDecoder : Decoder ResultResponse
volumeDecoder =
    Decode.succeed ResultJ
        |> custom (at [ "result", "muted" ] bool)
        |> custom (at [ "result", "volume" ] float)


fileQueryDecoder : Decoder ResultResponse
fileQueryDecoder =
    Decode.succeed ResultK
        |> custom (at [ "result", "files" ] (list fileDecoder))


type alias FileObj =
    { label : String
    , file : String
    , filetype : FileType
    }


fileDecoder : Decoder FileObj
fileDecoder =
    Decode.succeed FileObj
        |> required "label" string
        |> required "file" string
        |> required "filetype" fileTypeDecoder



-- file Type


type FileType
    = Directory
    | File


parseFileType : String -> Result String FileType
parseFileType string =
    case string of
        "directory" ->
            Ok Directory

        "file" ->
            Ok File

        _ ->
            Err ("Invalid filetype: " ++ string)


fileTypeDecoder : Decoder FileType
fileTypeDecoder =
    Decode.string |> Decode.andThen (fromResult << parseFileType)



-- LeftSidebar Icon Hover type


type LeftSidebarMenuHover
    = NoneHover
    | Music
    | Movies
    | TVShow
    | Playlist
    | Browser
    | ThumbsUp
    | Addons
    | Settings
    | Help



--kodi ws connection


type Connection
    = Connected
    | Disconnected
    | NotAsked



--local settings encode/decode


type alias LocalSettings =
    { localSettingsList : List LocalSettingsList
    }


type alias LocalSettingsList =
    { name : String
    , value : String
    }


decodeLocalSettings : Decoder LocalSettings
decodeLocalSettings =
    Decode.succeed LocalSettings
        |> required "localSettingsList" (list localSettingsList)


encodeLocalSettings : LocalSettings -> String
encodeLocalSettings x =
    Encode.encode 0 <|
        Encode.object
            [ ( "localSettingsList", Encode.list encodeLocalSettingsList x.localSettingsList )
            ]


localSettingsList : Decoder LocalSettingsList
localSettingsList =
    Decode.succeed LocalSettingsList
        |> required "name" string
        |> required "value" string


encodeLocalSettingsList : LocalSettingsList -> Encode.Value
encodeLocalSettingsList x =
    Encode.object
        [ ( "name", Encode.string x.name )
        , ( "value", Encode.string x.value )
        ]



--local playlist encode/decode


type alias LocalPlaylists =
    { localPlaylists : List PlaylistObj }


localPlaylistDecoder : Decoder LocalPlaylists
localPlaylistDecoder =
    Decode.succeed LocalPlaylists
        |> required "localPlaylists" (list playlistObjDecoder)


localPlaylistEncoder : LocalPlaylists -> String
localPlaylistEncoder localPlaylist =
    Encode.encode 0 <|
        Encode.object
            [ ( "localPlaylists", Encode.list playlistObjEncoder localPlaylist.localPlaylists )
            ]


type alias PlaylistObj =
    { name : String
    , songs : List Int --store songids
    }


playlistObjDecoder : Decoder PlaylistObj
playlistObjDecoder =
    Decode.succeed PlaylistObj
        |> required "name" string
        |> required "songs" (list int)


playlistObjEncoder : PlaylistObj -> Encode.Value
playlistObjEncoder playlistObj =
    Encode.object
        [ ( "name", Encode.string playlistObj.name )
        , ( "songs", Encode.list Encode.int (List.map (\song -> song) playlistObj.songs) )
        ]



-- Files.PrepareDownload decoder


prepareDownloadDecoder : Decoder Path
prepareDownloadDecoder =
    Decode.succeed Path
        |> custom (at [ "result", "details", "path" ] string)


type alias Path =
    { path : String }



{- introspectDecoder : Decoder ResultResponse
   introspectDecoder =
           Decode.succeed ResultC
               |> required "methods" (firstFieldAs introspectObjDecoder)

   introspectObjDecoder : Decoder IntrospectObj
   introspectObjDecoder =
       Decode.succeed IntrospectObj
           |> required "params" (list paramsIntrospectDecoder)
           --|> required "returns" returnsIntrospectDecoder

   paramsIntrospectDecoder : Decoder ParamsItem
   paramsIntrospectDecoder =
       Decode.succeed ParamsItem
           |> required "name" string

   type alias ParamsItem =
       { name : String }

   type alias IntrospectObj =
       { description : String
       , params : List String
       , returns : String
       }

   firstFieldAs : Decoder a -> Decoder a
   firstFieldAs decoder =
     Decode.keyValuePairs decoder
       |> Decode.andThen (\pairs ->
         case pairs of
           [] -> Decode.fail "Empty Object"
           (_, value) :: _ ->  Decode.succeed value
       )
-}
-- end "result"
{- resultsDecoder : Decoder (List Result)
   resultsDecoder =
     Decode.oneOf
       [ Decode.list resultDecoder
       , Decode.map (\result -> [result]) resultDecoder
       ]
-}
