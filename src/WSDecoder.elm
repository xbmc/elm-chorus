module WSDecoder exposing (AlbumObj, ArtistObj, Connection(..), FileObj, FileType(..), Item, ItemDetails, LeftSidebarMenuHover(..), LocalPlaylists, MovieObj, PType(..), ParamsResponse, Path, PlayerObj(..), PlaylistObj, ResultResponse(..), SongObj, SourceObj, TvshowObj, localPlaylistDecoder, localPlaylistEncoder, paramsResponseDecoder, prepareDownloadDecoder, resultResponseDecoder)

import Json.Decode as Decode exposing (Decoder, at, bool, float, int, list, maybe, string)
import Json.Decode.Pipeline exposing (custom, optional, required)
import Json.Encode as Encode
import Method exposing (Method(..), methodToStr, strToMethod)



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
        ]


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
