port module Shared exposing
    ( Flags
    , Model
    , Msg
    , decodeWS
    , init
    , responseReceiver
    , sendAction
    , sendActions
    , setStorage
    , storeAddonSettings
    , storeInterfaceSettings
    , subscriptions
    , update
    , view
    )

--modules

import Browser.Navigation exposing (Key, pushUrl)
import Components.Frame
import Components.LayoutType exposing (DialogType(..))
import Element exposing (..)
import Http exposing (Part)
import I18Next
import Json.Decode as D
import Json.Encode as E exposing (Value)
import List.Extra exposing (unique)
import Material.Icons exposing (settings)
import Method exposing (Method(..))
import Request exposing (Params, Property(..), request)
import SharedType exposing (..)
import SingleSlider exposing (SingleSlider)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Time
import Translations
import Url exposing (Url)
import WSDecoder exposing (AlbumObj, ArtistObj, Connection(..), FileObj, ItemDetails, LeftSidebarMenuHover(..), LocalPlaylists, LocalSettings, MovieObj, PType(..), ParamsResponse, PlayerObj(..), PlaylistObj, ResultResponse(..), SettingsObj, SongObj, SourceObj, TvshowObj, VideoObj, decodeLocalSettings, localPlaylistDecoder, localPlaylistEncoder, paramsResponseDecoder, resultResponseDecoder)



-- INIT


type alias Flags =
    { innerWidth : Int
    , innerHeight : Int
    , localPlaylists : Maybe String
    , translations : E.Value
    , interfaceLocalSettings : Maybe String
    , addonLocalSettings : Maybe String
    }


type alias Model =
    { flags : Flags
    , url : Url
    , key : Key
    , connection : Connection
    , leftSidebarMenuHover : LeftSidebarMenuHover
    , rightSidebarExtended : Bool
    , controlMenu : Bool
    , showRightSidebarMenu : Bool
    , isPartyMode : Bool
    , players : List PlayerObj
    , currentlyPlaying : Maybe ItemDetails
    , playing : Bool
    , shuffle : Bool
    , mute : Bool
    , repeat : RepeatType
    , artist_list : List ArtistObj
    , album_list : List AlbumObj
    , video_list : List VideoObj
    , settings_list : List SettingsObj
    , song_list : List SongObj
    , genre_list : List String
    , movie_list : List MovieObj
    , tvshow_list : List TvshowObj
    , source_list : List SourceObj
    , file_list : List FileObj
    , volumeSlider : SingleSlider Msg
    , progressSlider : SingleSlider Msg
    , windowWidth : Int
    , windowHeight : Int
    , searchString : String
    , showDialog : DialogType
    , prepareDownloadPath : Maybe String
    , playlistName : String
    , playlists : LocalPlaylists
    , translations : I18Next.Translations
    , interfaceLocalSettings : LocalSettings
    , addonLocalSettings : LocalSettings
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        decodedlocalPlaylists =
            case flags.localPlaylists of
                Nothing ->
                    { localPlaylists = [] }

                Just localPlaylists ->
                    case D.decodeString localPlaylistDecoder localPlaylists of
                        Ok playlists ->
                            playlists

                        Err _ ->
                            { localPlaylists = [] }

        decodedTranslations =
            D.decodeValue I18Next.translationsDecoder flags.translations |> Result.withDefault I18Next.initialTranslations

        decodedInterfaceSettings =
            case flags.interfaceLocalSettings of
                Nothing ->
                    { localSettingsList =
                        [ { name = "language", value = "English" }
                        , { name = "player", value = "Auto" }
                        , { name = "controls", value = "Kodi" }
                        , { name = "Ignore article", value = "true" }
                        , { name = "Album artists", value = "true" }
                        , { name = "Focus playlist", value = "true" }
                        , { name = "headers", value = "true" }
                        , { name = "thumbs Up", value = "false" }
                        , { name = "device name", value = "false" }
                        , { name = "port", value = "9090" }
                        , { name = "host", value = "localhost" }
                        , { name = "Poll interval", value = "10 sec" }
                        , { name = "settings level", value = "Standard" }
                        , { name = "proxy", value = "false" }
                        , { name = "nfo", value = "true" }
                        , { name = "movie db", value = "" }
                        , { name = "fanart tv", value = "" }
                        , { name = "youtube", value = "" }
                        ]
                    }

                Just localSettings ->
                    case D.decodeString decodeLocalSettings localSettings of
                        Ok playlists ->
                            playlists

                        Err _ ->
                            { localSettingsList =
                                [ { name = "language", value = "English" }
                                , { name = "player", value = "Auto" }
                                , { name = "controls", value = "Kodi" }
                                , { name = "Ignore article", value = "true" }
                                , { name = "Album artists", value = "true" }
                                , { name = "Focus playlist", value = "true" }
                                , { name = "headers", value = "true" }
                                , { name = "thumbs Up", value = "false" }
                                , { name = "device name", value = "false" }
                                , { name = "port", value = "9090" }
                                , { name = "host", value = "localhost" }
                                , { name = "Poll interval", value = "10 sec" }
                                , { name = "settings level", value = "Standard" }
                                , { name = "proxy", value = "false" }
                                , { name = "nfo", value = "true" }
                                , { name = "movie db", value = "" }
                                , { name = "fanart tv", value = "" }
                                , { name = "youtube", value = "" }
                                ]
                            }

        decodedAddonSettings =
            case flags.addonLocalSettings of
                Nothing ->
                    { localSettingsList =
                        [ { name = "aac", value = "true" }
                        , { name = "wma", value = "true" }
                        , { name = "default", value = "true" }
                        , { name = "sens", value = "true" }
                        , { name = "input", value = "true" }
                        , { name = "rtmp", value = "false" }
                        , { name = "universal album", value = "true" }
                        , { name = "genric album", value = "true" }
                        , { name = "local", value = "true" }
                        , { name = "universal artist", value = "true" }
                        , { name = "genric artist", value = "true" }
                        , { name = "music", value = "true" }
                        , { name = "fanart", value = "true" }
                        , { name = "imdb", value = "true" }
                        , { name = "music brainz", value = "true" }
                        , { name = "audio", value = "true" }
                        , { name = "movie scraper", value = "true" }
                        , { name = "movie database", value = "true" }
                        , { name = "movie database python", value = "true" }
                        , { name = "movie database tv", value = "true" }
                        , { name = "tmdb", value = "true" }
                        , { name = "joystick", value = "true" }
                        , { name = "youtube", value = "true" }
                        , { name = "addon", value = "true" }
                        , { name = "weather", value = "true" }
                        , { name = "english", value = "true" }
                        , { name = "ui", value = "true" }
                        , { name = "black", value = "true" }
                        , { name = "dim", value = "true" }
                        , { name = "certifi", value = "true" }
                        , { name = "chardet", value = "true" }
                        , { name = "idna", value = "true" }
                        , { name = "python image", value = "true" }
                        , { name = "python crypto", value = "true" }
                        , { name = "requests", value = "true" }
                        , { name = "six", value = "true" }
                        , { name = "url lib", value = "true" }
                        , { name = "version", value = "true" }
                        , { name = "estouchy", value = "true" }
                        , { name = "estuary", value = "true" }
                        , { name = "chorus", value = "true" }
                        ]
                    }

                Just localSettings ->
                    case D.decodeString decodeLocalSettings localSettings of
                        Ok playlists ->
                            playlists

                        Err _ ->
                            { localSettingsList =
                                [ { name = "aac", value = "true" }
                                , { name = "wma", value = "true" }
                                , { name = "default", value = "true" }
                                , { name = "sens", value = "true" }
                                , { name = "input", value = "true" }
                                , { name = "rtmp", value = "false" }
                                , { name = "universal album", value = "true" }
                                , { name = "genric album", value = "true" }
                                , { name = "local", value = "true" }
                                , { name = "universal artist", value = "true" }
                                , { name = "genric artist", value = "true" }
                                , { name = "music", value = "true" }
                                , { name = "fanart", value = "true" }
                                , { name = "imdb", value = "true" }
                                , { name = "music brainz", value = "true" }
                                , { name = "audio", value = "true" }
                                , { name = "movie scraper", value = "true" }
                                , { name = "movie database", value = "true" }
                                , { name = "movie database python", value = "true" }
                                , { name = "movie database tv", value = "true" }
                                , { name = "tmdb", value = "true" }
                                , { name = "joystick", value = "true" }
                                , { name = "youtube", value = "true" }
                                , { name = "addon", value = "true" }
                                , { name = "weather", value = "true" }
                                , { name = "english", value = "true" }
                                , { name = "ui", value = "true" }
                                , { name = "black", value = "true" }
                                , { name = "dim", value = "true" }
                                , { name = "certifi", value = "true" }
                                , { name = "chardet", value = "true" }
                                , { name = "idna", value = "true" }
                                , { name = "python image", value = "true" }
                                , { name = "python crypto", value = "true" }
                                , { name = "requests", value = "true" }
                                , { name = "six", value = "true" }
                                , { name = "url lib", value = "true" }
                                , { name = "version", value = "true" }
                                , { name = "estouchy", value = "true" }
                                , { name = "estuary", value = "true" }
                                , { name = "chorus", value = "true" }
                                ]
                            }
    in
    ( { flags = flags
      , url = url
      , key = key
      , connection = NotAsked
      , leftSidebarMenuHover = NoneHover
      , rightSidebarExtended = False
      , isPartyMode = False
      , controlMenu = False
      , showRightSidebarMenu = False
      , players = []
      , currentlyPlaying = Nothing
      , playing = False
      , shuffle = False
      , repeat = Off
      , mute = False
      , artist_list = []
      , album_list = []
      , video_list = []
      , settings_list = []
      , song_list = []
      , genre_list = []
      , movie_list = []
      , tvshow_list = []
      , source_list = []
      , file_list = []
      , volumeSlider =
            SingleSlider.init
                { min = 0
                , max = 100
                , value = 50
                , step = 1
                , onChange = VolumeSliderChange
                }
      , progressSlider =
            SingleSlider.init
                { min = 0
                , max = 100
                , value = 1
                , step = 1
                , onChange = ProgressSliderChange
                }
      , windowWidth = flags.innerWidth
      , windowHeight = flags.innerHeight
      , searchString = ""
      , showDialog = None
      , prepareDownloadPath = Nothing
      , playlistName = ""
      , playlists = decodedlocalPlaylists
      , translations = decodedTranslations
      , interfaceLocalSettings = decodedInterfaceSettings
      , addonLocalSettings = decodedAddonSettings
      }
    , sendActions
        [ """{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "properties": [ "artist", "duration", "album", "track", "genre", "albumid" ] }, "id": "libSongs"}"""
        , """{"jsonrpc": "2.0", "method": "AudioLibrary.GetAlbums", "params": { "properties": ["playcount", "artist", "genre", "rating", "thumbnail", "year", "mood", "style", "dateadded"] }, "id": "libAlbums"}"""
        , """{"jsonrpc": "2.0", "method": "AudioLibrary.GetArtists", "params": { "properties": [ "thumbnail", "fanart", "born", "formed", "died", "disbanded", "yearsactive", "mood", "style", "genre" ] }, "id": 1}"""
        , """{"jsonrpc": "2.0", "method": "VideoLibrary.GetMusicVideos", "params": { "properties": [ "title", "thumbnail", "artist", "album", "genre", "lastplayed", "year", "runtime", "fanart", "file", "streamdetails" ] }, "id": "libMusicVideos"}"""
        , """{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": { "properties" : ["art", "rating", "thumbnail", "playcount", "file"] }, "id": "libMovies"}"""
        , """{"jsonrpc": "2.0", "method": "VideoLibrary.GetTVShows", "params": { "properties": ["art", "genre", "plot", "title", "originaltitle", "year", "rating", "thumbnail", "playcount", "file", "fanart"] }, "id": "libTvShows"}"""
        , """{"jsonrpc": "2.0", "method": "Files.GetSources", "params": { "media": "video" }, "id": 1 }""" --get video and music sources
        , """{"jsonrpc": "2.0", "method": "Files.GetSources", "params": { "media": "music" }, "id": 1 }"""
        , """{"jsonrpc": "2.0", "method": "Player.SetShuffle", "params": { "playerid": 0, "shuffle": false }, "id": 1 }""" --set shuffle to false on init
        , """{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "off" }, "id": 1 }""" --set repeat to off on init
        ]
    )



-- PORTS


port sendActions : List String -> Cmd msg



--single cmd


sendAction json =
    sendActions [ json ]


port responseReceiver : (String -> msg) -> Sub msg


port connection : (String -> msg) -> Sub msg


port setStorage : String -> Cmd msg


port storeInterfaceSettings : String -> Cmd msg


port storeAddonSettings : String -> Cmd msg



-- UPDATE


type Msg
    = Navigate Route
    | Request Method (Maybe Params)
    | Recv String
    | PlayPause
    | SkipForward
    | SkipPrevious
    | ToggleMute
    | ToggleShuffle
    | ToggleRepeat
    | QueryPlayers Time.Posix
    | ReceiveParamsResponse ParamsResponse
    | ReceiveResultResponse ResultResponse
    | ToggleRightSidebar
    | ToggleControlMenu
    | ToggleShowRightSidebarMenu
    | ClearPlaylistMsg
    | ToggleLeftSidebarMusicHover
    | ToggleLeftSidebarMoviesHover
    | ToggleLeftSidebarPlaylistHover
    | ToggleLeftSidebarBrowserHover
    | ToggleLeftSidebarAddonsHover
    | ToggleLeftSidebarThumbsUpHover
    | ToggleLeftSidebarSettingsHover
    | ToggleLeftSidebarTVShowsHover
    | ToggleLeftSidebarHelpHover
    | ToggleLeftSidebarNotHover
    | SendTextToKodi
    | ScanVideoLibrary
    | ScanMusicLibrary
    | VolumeSliderChange Float
    | ProgressSliderChange Float
    | SearchChanged String
    | AttemptReconnectionDialog
    | CloseDialog
    | NewPlaylist String
    | RefreshPlaylistMsg
    | PartyModeToggleMsg


songname : SongObj -> String
songname song =
    song.label


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

        Recv state ->
            case state of
                "Connected" ->
                    ( { model | connection = Connected, showDialog = None }
                    , Cmd.none
                    )

                "Disconnected" ->
                    ( { model | connection = Disconnected, showDialog = ConnectionDialog }
                    , Cmd.none
                    )

                _ ->
                    ( model
                    , Cmd.none
                    )

        PlayPause ->
            ( { model | playing = not model.playing }
            , sendAction """{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id": 1 }"""
            )

        SkipForward ->
            ( model
            , sendAction """{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "skipnext" }, "id": 1 }"""
            )

        SkipPrevious ->
            ( model
            , sendAction """{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "skipprevious" }, "id": 1 }"""
            )

        ToggleMute ->
            ( { model | mute = not model.mute }
            , sendAction """{"jsonrpc": "2.0","method": "Application.SetMute","params": { "mute": "toggle" },"id": 1}"""
            )

        ToggleShuffle ->
            case model.shuffle of
                False ->
                    ( { model | shuffle = True }
                    , sendAction """{"jsonrpc":"2.0","method":"Player.SetShuffle","params":{"playerid":0,"shuffle":true},"id":1}"""
                    )

                True ->
                    ( { model | shuffle = False }
                    , sendAction """{"jsonrpc":"2.0","method":"Player.SetShuffle","params":{"playerid":0,"shuffle":false},"id":1}"""
                    )

        ToggleRepeat ->
            case model.repeat of
                Off ->
                    ( { model | repeat = One }
                    , sendAction """{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "one" }, "id": 1}"""
                    )

                One ->
                    ( { model | repeat = All }
                    , sendAction """{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "all" }, "id": 1}"""
                    )

                All ->
                    ( { model | repeat = Off }
                    , sendAction """{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "off" }, "id": 1}"""
                    )

        QueryPlayers _ ->
            ( model
            , sendAction """{"jsonrpc": "2.0", "method": "Player.GetActivePlayers", "id": 1}"""
            )

        ReceiveParamsResponse _ ->
            ( model
            , Cmd.none
            )

        ReceiveResultResponse result ->
            case result of
                --connected or disconnected
                ResultA _ ->
                    ( model
                    , Cmd.none
                    )

                ResultB playerObjects ->
                    ( { model | players = playerObjects }
                      --chain messages, once we get players, see what's playing
                    , sendActions
                        (List.map
                            (\player ->
                                case player of
                                    PlayerA playerid speed ->
                                        ""

                                    PlayerB playerid playertype ptype ->
                                        case ptype of
                                            Video ->
                                                """{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "album", "artist", "season", "episode", "duration", "showtitle", "tvshowid", "thumbnail", "file", "fanart", "streamdetails"], "playerid": """ ++ String.fromInt playerid ++ """ }, "id": "VideoGetItem"}"""

                                            Audio ->
                                                """{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "album", "artist", "duration", "genre", "thumbnail", "file", "fanart", "streamdetails"], "playerid": """ ++ String.fromInt playerid ++ """ }, "id": "AudioGetItem"}"""
                            )
                            model.players
                        )
                    )

                ResultC item ->
                    ( { model | currentlyPlaying = Just item }
                    , sendActions
                        [ """{"jsonrpc":"2.0","method":"Player.GetProperties","params":{"playerid":0,"properties":["percentage", "speed"]},"id":"0"}"""
                        , """{"jsonrpc": "2.0", "method": "Application.GetProperties", "params" : { "properties" : [ "volume", "muted" ] }, "id": 0}""" --get volume on start
                        ]
                    )

                ResultD songlist ->
                    let
                        genrelist =
                            unique (List.concatMap (\song -> song.genre) songlist)
                    in
                    ( { model | song_list = songlist, genre_list = genrelist }, Cmd.none )

                ResultE artistlist ->
                    ( { model | artist_list = artistlist }
                    , Cmd.none
                    )

                ResultF albumlist ->
                    ( { model | album_list = albumlist }
                    , Cmd.none
                    )

                ResultG movielist ->
                    ( { model | movie_list = movielist }
                    , Cmd.none
                    )

                ResultH percent playing ->
                    case playing of
                        0 ->
                            let
                                newSlider =
                                    SingleSlider.update percent model.progressSlider
                            in
                            ( { model | progressSlider = newSlider, playing = False }, Cmd.none )

                        1 ->
                            let
                                newSlider =
                                    SingleSlider.update percent model.progressSlider
                            in
                            ( { model | progressSlider = newSlider, playing = True }, Cmd.none )

                        _ ->
                            let
                                newSlider =
                                    SingleSlider.update percent model.progressSlider
                            in
                            ( { model | progressSlider = newSlider }, Cmd.none )

                ResultI sourcelist ->
                    ( { model | source_list = model.source_list ++ sourcelist }
                    , Cmd.none
                    )

                ResultJ muted volume ->
                    let
                        newSlider =
                            SingleSlider.update volume model.volumeSlider
                    in
                    case muted of
                        False ->
                            ( { model | volumeSlider = newSlider }, Cmd.none )

                        True ->
                            ( { model | volumeSlider = newSlider }, Cmd.none )

                ResultK filelist ->
                    ( { model | file_list = filelist }
                    , Cmd.none
                    )

                ResultL settingsList ->
                    ( { model | settings_list = settingsList }
                    , Cmd.none
                    )

                ResultM videosList ->
                    ( { model | video_list = videosList }
                    , Cmd.none
                    )

        ToggleRightSidebar ->
            ( { model | rightSidebarExtended = not model.rightSidebarExtended }
            , Cmd.none
            )

        ClearPlaylistMsg ->
            ( model
            , sendActions
                [ """{"jsonrpc":"2.0","method":"Playlist.Clear","params":{"playlistid":0},"id":"0"}"""
                ]
            )

        RefreshPlaylistMsg ->
            ( model
            , sendActions
                [ """{"jsonrpc":"2.0","method":"Playlist.GetItems","params":{"playlistid":0},"id":"0"}"""
                ]
            )

        PartyModeToggleMsg ->
            ( { model | isPartyMode = not model.isPartyMode }
            , sendActions
                [ """{"jsonrpc":"2.0","method":"Player.SetPartymode","params":{"playerid":0, "partymode":"""
                    ++ (if model.isPartyMode then
                            "true"

                        else
                            "false" ++ """},"id":"0"}"""
                       )
                ]
            )

        ToggleControlMenu ->
            ( { model | controlMenu = not model.controlMenu }
            , Cmd.none
            )

        ToggleLeftSidebarMusicHover ->
            ( { model | leftSidebarMenuHover = Music }
            , Cmd.none
            )

        ToggleLeftSidebarMoviesHover ->
            ( { model | leftSidebarMenuHover = Movies }
            , Cmd.none
            )

        ToggleLeftSidebarBrowserHover ->
            ( { model | leftSidebarMenuHover = Browser }
            , Cmd.none
            )

        ToggleLeftSidebarPlaylistHover ->
            ( { model | leftSidebarMenuHover = Playlist }
            , Cmd.none
            )

        ToggleLeftSidebarHelpHover ->
            ( { model | leftSidebarMenuHover = Help }
            , Cmd.none
            )

        ToggleLeftSidebarThumbsUpHover ->
            ( { model | leftSidebarMenuHover = ThumbsUp }
            , Cmd.none
            )

        ToggleLeftSidebarAddonsHover ->
            ( { model | leftSidebarMenuHover = Addons }
            , Cmd.none
            )

        ToggleLeftSidebarSettingsHover ->
            ( { model | leftSidebarMenuHover = Settings }
            , Cmd.none
            )

        ToggleLeftSidebarTVShowsHover ->
            ( { model | leftSidebarMenuHover = TVShow }
            , Cmd.none
            )

        ToggleLeftSidebarNotHover ->
            ( { model | leftSidebarMenuHover = NoneHover }
            , Cmd.none
            )

        ToggleShowRightSidebarMenu ->
            ( { model | showRightSidebarMenu = not model.showRightSidebarMenu }
            , Cmd.none
            )

        SendTextToKodi ->
            ( model, Cmd.none )

        ScanVideoLibrary ->
            -- todo
            ( model, sendAction """{ "jsonrpc": "2.0", "method": "VideoLibrary.Scan", "id": "videoScan"}""" )

        ScanMusicLibrary ->
            -- todo
            ( model, sendAction """{ "jsonrpc": "2.0", "method": "AudioLibrary.Scan", "id": "audioScan"}""" )

        VolumeSliderChange newValue ->
            let
                newSlider =
                    SingleSlider.update newValue model.volumeSlider
            in
            ( { model | volumeSlider = newSlider }, sendAction ("""{"jsonrpc":"2.0","method":"Application.SetVolume","id":1,"params":{"volume":""" ++ String.fromFloat newValue ++ """}}""") )

        ProgressSliderChange newValue ->
            let
                newSlider =
                    SingleSlider.update newValue model.progressSlider
            in
            ( { model | progressSlider = newSlider }, sendAction ("""{"jsonrpc":"2.0", "method":"Player.Seek", "id":1, "params": { "playerid":0, "value":""" ++ String.fromFloat newValue ++ """}}""") )

        SearchChanged searchString ->
            ( { model | searchString = searchString }, Cmd.none )

        AttemptReconnectionDialog ->
            ( { model | showDialog = None }, Browser.Navigation.reload )

        CloseDialog ->
            let
                playlistObj =
                    { name = model.playlistName, songs = [] }
            in
            ( { model
                | showDialog = None
                , playlists = { localPlaylists = model.playlists.localPlaylists ++ [ playlistObj ] } --sets localPlaylist field
                , playlistName = ""
              }
            , setStorage (localPlaylistEncoder model.playlists)
            )

        --saves playlistName before its reset
        NewPlaylist name ->
            ( { model | showDialog = TextInputDialog, playlistName = name }, Cmd.none )



-- SUBSCRIPTIONS


decodeWS message =
    case D.decodeString paramsResponseDecoder message of
        Ok paramsMessage ->
            ReceiveParamsResponse paramsMessage

        Err _ ->
            case D.decodeString resultResponseDecoder message of
                Ok resultMessage ->
                    ReceiveResultResponse resultMessage

                Err _ ->
                    Recv message


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ responseReceiver decodeWS
        , connection decodeWS
        , Time.every 1000 QueryPlayers
        ]



-- VIEW


view :
    { page : Document msg, toMsg : Msg -> msg }
    -> Model
    -> { body : Document msg, header : Element msg, playerBar : Element msg, rightSidebar : Element msg, leftSidebar : Element msg, dialogBox : Element msg }
view { page, toMsg } model =
    Components.Frame.layout
        { page = page
        , controlMenu =
            { controlMenu = model.controlMenu
            , controlMenuMsg = toMsg ToggleControlMenu
            , sendTextToKodiMsg = toMsg SendTextToKodi
            , scanMusicLibraryMsg = toMsg ScanMusicLibrary
            , scanVideoLibraryMsg = toMsg ScanVideoLibrary
            }
        , leftSidebarControl =
            { leftSidebarMenuHover = model.leftSidebarMenuHover
            , leftSidebarMusicHoverMsg = toMsg ToggleLeftSidebarMusicHover
            , leftSidebarMusicTranslation = Translations.music model.translations
            , leftSidebarMoviesHoverMsg = toMsg ToggleLeftSidebarMoviesHover
            , leftSidebarMoviesTranslation = Translations.movies model.translations
            , leftSidebarTVShowHoverMsg = toMsg ToggleLeftSidebarTVShowsHover
            , leftSidebarTVShowTranslation = Translations.tvShows model.translations
            , leftSidebarAddonsHoverMsg = toMsg ToggleLeftSidebarAddonsHover
            , leftSidebarAddonsTranslation = Translations.addOns model.translations
            , leftSidebarPlaylistHoverMsg = toMsg ToggleLeftSidebarPlaylistHover
            , leftSidebarPlaylistTranslation = Translations.playlists model.translations
            , leftSidebarBrowserHoverMsg = toMsg ToggleLeftSidebarBrowserHover
            , leftSidebarBrowserTranslation = Translations.browser model.translations
            , leftSidebarSettingsHoverMsg = toMsg ToggleLeftSidebarSettingsHover
            , leftSidebarSettingsTranslation = Translations.settings model.translations
            , leftSidebarHelpHoverMsg = toMsg ToggleLeftSidebarHelpHover
            , leftSidebarHelpTranslation = Translations.help model.translations
            , leftSidebarThumbsUpHoverMsg = toMsg ToggleLeftSidebarThumbsUpHover
            , leftSidebarThumbsUpTranslation = Translations.thumbsUp model.translations
            , leftSidebarNotHoverMsg = toMsg ToggleLeftSidebarNotHover
            }
        , showRightSidebarMenu =
            { showRightSidebarMenu = model.showRightSidebarMenu
            , showRightSidebarMenuMsg = toMsg ToggleShowRightSidebarMenu
            , clearPlaylistMsg = toMsg ClearPlaylistMsg
            , refreshPlaylistMsg = toMsg RefreshPlaylistMsg
            , isPartyMode = model.isPartyMode
            , partyModeToggleMsg = toMsg PartyModeToggleMsg
            }
        , playerControl =
            { playPauseMsg = toMsg PlayPause
            , skipMsg = toMsg SkipForward
            , reverseMsg = toMsg SkipPrevious
            , playing = model.playing
            }
        , currentlyPlaying =
            { currentlyPlaying = model.currentlyPlaying
            , progressSlider = Element.map toMsg (slider model.progressSlider)
            }
        , volumeAndControls =
            { muteMsg = toMsg ToggleMute
            , repeatMsg = toMsg ToggleRepeat
            , shuffleMsg = toMsg ToggleShuffle
            , volumeSlider = Element.map toMsg (slider model.volumeSlider)
            , shuffle = model.shuffle
            , mute = model.mute
            , repeat = model.repeat
            }
        , rightSidebarExtended = model.rightSidebarExtended
        , rightSidebarMsg = toMsg ToggleRightSidebar
        , clearPlaylistMsg = toMsg ClearPlaylistMsg
        , connection = model.connection
        , windowHeight = model.windowHeight
        , searchChanged = SearchChanged >> toMsg
        , dialogBox =
            { showDialog = model.showDialog
            , attemptReconnectionMsg = toMsg AttemptReconnectionDialog
            , closeDialogMsg = toMsg CloseDialog
            , textChangeMsg = NewPlaylist >> toMsg
            , playlistName = model.playlistName
            }
        }


slider : SingleSlider msg -> Element msg
slider singleSliderMsg =
    SingleSlider.view singleSliderMsg |> Element.html
