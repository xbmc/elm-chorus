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

import Action exposing (Namespace(..), Method(..), Param(..))
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



-- PORTS


port sendAction : String -> Cmd msg


port responseReceiver : (String -> msg) -> Sub msg



-- UPDATE


type Msg
    = Navigate Route
    | Send Namespace Method Param Int



{- convert method param int to json action
format ->
    { "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id":0}
 -}
toStr : Namespace -> Method -> Param -> Int -> String
toStr namespace method param int =
    Encode.encode 0
        <| Encode.object
            [ ( "jsonrpc", Encode.string "2.0" )
            , ( "method", 
                case namespace of 
                    Addons -> 
                        case method of
                            ExecuteAddon ->
                                Encode.string "Addons.ExecuteAddon"
                            GetAddonDetails ->
                                Encode.string "Addons.GetAddonDetails"
                            GetAddons ->
                                Encode.string "Addons.GetAddons"
                            SetAddonEnabled ->
                                Encode.string "Addons.SetAddonEnabled"
                            _ ->
                                Encode.string "Error, impossible method used with Addons namespace."
                    Application -> 
                        case method of
                            GetProperties ->
                                Encode.string "Application.GetProperties"
                            Quit ->
                                Encode.string "Application.Quit"
                            SetMute ->
                                Encode.string "Application.SetMute"
                            SetVolume ->
                                Encode.string "Application.SetVolume"
                            _ ->
                                Encode.string "Error, impossible method used with Application namespace."
                    AudioLibrary ->
                        case method of
                            Clean ->
                                Encode.string "AudioLibrary.Clean"
                            Export ->
                                Encode.string "AudioLibrary.Export"
                            GetAlbumDetails ->
                                Encode.string "AudioLibrary.GetAlbumDetails"
                            GetAlbums ->
                                Encode.string "AudioLibrary.GetAlbums"
                            GetArtistDetails ->
                                Encode.string "AudioLibrary.GetArtistDetails"
                            GetArtists ->
                                Encode.string "AudioLibrary.GetArtists"
                            GetGenres ->
                                Encode.string "AudioLibrary.GetGenres"
                            GetProperties ->
                                Encode.string "AudioLibrary.GetProperties"
                            GetRecentlyAddedAlbums ->
                                Encode.string "AudioLibrary.GetRecentlyAddedAlbums"
                            GetRecentlyAddedSongs ->
                                Encode.string "AudioLibrary.GetRecentlyAddedSongs"
                            GetRecentlyPlayedAlbums ->
                                Encode.string "AudioLibrary.GetRecentlyPlayedAlbums"
                            GetRecentlyPlayedSongs ->
                                Encode.string "AudioLibrary.GetRecentlyPlayedSongs"
                            GetRoles ->
                                Encode.string "AudioLibrary.GetRoles"
                            GetSongDetails ->
                                Encode.string "AudioLibrary.GetSongDetails"
                            GetSongs ->
                                Encode.string "AudioLibrary.GetSongs"
                            GetSources ->
                                Encode.string "AudioLibrary.GetSources"
                            Scan ->
                                Encode.string "AudioLibrary.Scan"
                            SetAlbumDetails ->
                                Encode.string "AudioLibrary.SetAlbumDetails"
                            SetArtistDetails ->
                                Encode.string "AudioLibrary.SetArtistDetails"
                            SetSongDetails ->
                                Encode.string "AudioLibrary.SetSongDetails"
                            _ ->
                                Encode.string "Error, impossible method used with AudioLibrary namespace."
                    Favourites ->
                        case method of
                            AddFavourite ->
                                Encode.string "Favourites.AddFavourite"
                            GetFavourites ->
                                Encode.string "Favourites.GetFavourites"
                            _ ->
                                Encode.string "Error, impossible method used with Favourites namespace."
                    Files ->
                        case method of
                            Download ->
                                Encode.string "Files.Download"
                            GetDirectory ->
                                Encode.string "Files.GetDirectory"
                            GetFileDetails ->
                                Encode.string "Files.GetFileDetails"
                            GetSources ->
                                Encode.string "Files.GetSources"
                            PrepareDownload ->
                                Encode.string "Files.PrepareDownload"
                            SetFileDetails ->
                                Encode.string "Files.SetFileDetails"
                            _ ->
                                Encode.string "Error, impossible method used with Files namespace."
                    GUI ->
                        case method of
                            ActivateWindow ->
                                Encode.string "GUI.ActivateWindow"
                            GetProperties ->
                                Encode.string "GUI.GetProperties"
                            GetStereoscopicModes ->
                                Encode.string "GUI.GetStereoscopicModes"
                            SetFullscreen ->
                                Encode.string "GUI.SetFullscreen"
                            SetStereoscopicMode ->
                                Encode.string "GUI.SetStereoscopicMode"
                            ShowNotification ->
                                Encode.string "GUI.ShowNotification"
                            _ ->
                                Encode.string "Error, impossible method used with GUI namespace."
                    Input -> 
                        case method of
                            Back ->
                                Encode.string "Input.Back"
                            ButtonEvent ->
                                Encode.string "Input.ButtonEvent"
                            ContextMenu ->
                                Encode.string "Input.ContextMenu"
                            Down ->
                                Encode.string "Input.Down"
                            ExecuteAction ->
                                Encode.string "Input.ExecuteAction"
                            Home ->
                                Encode.string "Input.Home"
                            Info ->
                                Encode.string "Input.Info"
                            Left ->
                                Encode.string "Input.Left"
                            Right ->
                                Encode.string "Input.Right"
                            Select ->
                                Encode.string "Input.Select"
                            SendText ->
                                Encode.string "Input.SendText"
                            ShowCodec ->
                                Encode.string "Input.ShowCodec"
                            ShowOSD ->
                                Encode.string "Input.ShowOSD"
                            ShowPlayerProcessInfo ->
                                Encode.string "Input.ShowPlayerProcessInfo"
                            Up ->
                                Encode.string "Input.Up"
                            _ ->
                                Encode.string "Error, impossible method used with Input namespace."
                    JSONRPC -> 
                        case method of
                            GetConfiguration ->
                                Encode.string "JSONRPC.GetConfiguration"
                            Introspect ->
                                Encode.string "JSONRPC.Introspect"
                            NotifyAll ->
                                Encode.string "JSONRPC.NotifyAll"
                            Permission ->
                                Encode.string "JSONRPC.Permission"
                            Ping ->
                                Encode.string "JSONRPC.Ping"
                            SetConfiguration ->
                                Encode.string "JSONRPC.SetConfiguration"
                            Version ->
                                Encode.string "JSONRPC.Version"
                            _ ->
                                Encode.string "Error, impossible method used with JSONRPC namespace."
                    PVR ->
                        case method of
                            AddTimer ->
                                Encode.string "PVR.AddTimer"
                            DeleteTimer ->
                                Encode.string "PVR.DeleteTimer"
                            GetBroadcastDetails ->
                                Encode.string "PVR.GetBroadcastDetails"
                            GetBroadcasts ->
                                Encode.string "PVR.GetBroadcasts"
                            GetChannelDetails ->
                                Encode.string "PVR.GetChannelDetails"
                            GetChannelGroupDetails ->
                                Encode.string "PVR.GetChannelGroupDetails"
                            GetChannelGroups ->
                                Encode.string "PVR.GetChannelGroups"
                            GetChannels ->
                                Encode.string "PVR.GetChannels"
                            GetProperties ->
                                Encode.string "PVR.GetProperties"
                            GetRecordingDetails ->
                                Encode.string "PVR.GetRecordingDetails"
                            GetRecordings ->
                                Encode.string "PVR.GetRecordings"
                            GetTimerDetails ->
                                Encode.string "PVR.GetTimerDetails"
                            GetTimers ->
                                Encode.string "PVR.GetTimers"
                            Record ->
                                Encode.string "PVR.Record"
                            Scan ->
                                Encode.string "PVR.Scan"
                            ToggleTimer ->
                                Encode.string "PVR.ToggleTimer"
                            _ ->
                                Encode.string "Error, impossible method used with PVR namespace."
                    Player ->
                        case method of
                            GetActivePlayers ->
                                Encode.string "Player.GetActivePlayers"
                            GetItem ->
                                Encode.string "Player.GetItem"
                            GetPlayers ->
                                Encode.string "Player.GetPlayers"
                            GetProperties ->
                                Encode.string "Player.GetProperties"
                            GetViewMode ->
                                Encode.string "Player.GetViewMode"
                            GoTo ->
                                Encode.string "Player.GoTo"
                            Move ->
                                Encode.string "Player.Move"
                            Open ->
                                Encode.string "Player.Open"
                            PlayPause ->
                                Encode.string "Player.PlayPause"
                            Rotate ->
                                Encode.string "Player.Rotate"
                            Seek ->
                                Encode.string "Player.Seek"
                            SetAudioStream ->
                                Encode.string "Player.SetAudioStream"
                            SetPartyMode ->
                                Encode.string "Player.SetPartyMode"
                            SetRepeat ->
                                Encode.string "Player.SetRepeat"
                            SetShuffle ->
                                Encode.string "Player.SetShuffle"
                            SetSpeed ->
                                Encode.string "Player.SetSpeed"
                            SetSubtitle ->
                                Encode.string "Player.SetSubtitle"
                            SetVideoStream ->
                                Encode.string "Player.SetVideoStream"
                            SetViewMode ->
                                Encode.string "Player.SetViewMode"
                            Stop ->
                                Encode.string "Player.Stop"
                            Zoom ->
                                Encode.string "Player.Zoom"
                            _ ->
                                Encode.string "Error, impossible method used with Player namespace."
                    Playlist ->
                        case method of
                            Add ->
                                Encode.string "Playlist.Add"
                            Clear ->
                                Encode.string "Playlist.Clear"
                            GetItems ->
                                Encode.string "Playlist.GetItems"
                            GetPlaylists ->
                                Encode.string "Playlist.GetPlaylists"
                            GetProperties ->
                                Encode.string "Playlist.GetProperties"
                            Insert ->
                                Encode.string "Playlist.Insert"
                            Remove ->
                                Encode.string "Playlist.Remove"
                            Swap ->
                                Encode.string "Playlist.Swap"
                            _ ->
                                Encode.string "Error, impossible method used with Playlist namespace."
                    Profiles ->
                        case method of
                            GetCurrentProfile ->
                                Encode.string "Profiles.GetCurrentProfile"
                            GetProfiles ->
                                Encode.string "Profiles.GetProfiles"
                            LoadProfile ->
                                Encode.string "Profiles.LoadProfile"
                            _ ->
                                Encode.string "Error, impossible method used with Profiles namespace."
                    Settings ->
                        case method of
                            GetCategories ->
                                Encode.string "Settings.GetCategories"
                            GetSections ->
                                Encode.string "Settings.GetSections"
                            GetSettingValue ->
                                Encode.string "Settings.GetSettingValue"
                            GetSettings ->
                                Encode.string "Settings.GetSettings"
                            ResetSettingValue ->
                                Encode.string "Settings.ResetSettingValue"
                            SetSettingValue ->
                                Encode.string "Settings.SetSettingValue"
                            _ ->
                                Encode.string "Error, impossible method used with Settings namespace."
                    System ->
                        case method of
                            EjectOpticalDrive ->
                                Encode.string "System.EjectOpticalDrive"
                            GetProperties ->
                                Encode.string "System.GetProperties"
                            Hibernate ->
                                Encode.string "System.Hibernate"
                            Reboot ->
                                Encode.string "System.Reboot"
                            Shutdown ->
                                Encode.string "System.Shutdown"
                            Suspend ->
                                Encode.string "System.Suspend"
                            _ ->
                                Encode.string "Error, impossible method used with System namespace."
                    Textures ->
                        case method of
                            GetTextures ->
                                Encode.string "Textures.GetTextures"
                            RemoveTexture ->
                                Encode.string "Textures.RemoveTexture"
                            _ ->
                                Encode.string "Error, impossible method used with Textures namespace."
                    VideoLibrary ->
                        case method of
                            Clean ->
                                Encode.string "VideoLibrary.Clean"
                            Export ->
                                Encode.string "VideoLibrary.Export"
                            GetEpisodeDetails ->
                                Encode.string "VideoLibrary.GetEpisodeDetails"
                            GetEpisodes ->
                                Encode.string "VideoLibrary.GetEpisodes"
                            GetGenres ->
                                Encode.string "VideoLibrary.GetGenres"
                            GetInProgressTVShows ->
                                Encode.string "VideoLibrary.GetInProgressTVShows"
                            GetMovieDetails ->
                                Encode.string "VideoLibrary.GetMovieDetails"
                            GetMovieSetDetails ->
                                Encode.string "VideoLibrary.GetMovieSetDetails"
                            GetMovieSets ->
                                Encode.string "VideoLibrary.GetMovieSets"
                            GetMovies ->
                                Encode.string "VideoLibrary.GetMovies"
                            GetMusicVideoDetails ->
                                Encode.string "VideoLibrary.GetMusicVideoDetails"
                            GetMusicVideos ->
                                Encode.string "VideoLibrary.GetMusicVideos"
                            GetRecentlyAddedEpisodes ->
                                Encode.string "VideoLibrary.GetRecentlyAddedEpisodes"
                            GetRecentlyAddedMovies ->
                                Encode.string "VideoLibrary.GetRecentlyAddedMovies"
                            GetRecentlyAddedMusicVideos ->
                                Encode.string "VideoLibrary.GetRecentlyAddedMusicVideos"
                            GetSeasonDetails ->
                                Encode.string "VideoLibrary.GetSeasonDetails"
                            GetSeasons ->
                                Encode.string "VideoLibrary.GetSeasons"
                            GetTVShowDetails ->
                                Encode.string "VideoLibrary.GetTVShowDetails"
                            GetTVShows ->
                                Encode.string "VideoLibrary.GetTVShows"
                            GetTags ->
                                Encode.string "VideoLibrary.GetTags"
                            RefreshEpisode ->
                                Encode.string "VideoLibrary.RefreshEpisode"
                            RefreshMovie ->
                                Encode.string "VideoLibrary.RefreshMovie"
                            RefreshMusicVideo ->
                                Encode.string "VideoLibrary.RefreshMusicVideo"
                            RefreshTVShow ->
                                Encode.string "VideoLibrary.RefreshTVShow"
                            RemoveEpisode ->
                                Encode.string "VideoLibrary.RemoveEpisode"
                            RemoveMovie ->
                                Encode.string "VideoLibrary.RemoveMovie"
                            RemoveMusicVideo ->
                                Encode.string "VideoLibrary.RemoveMusicVideo"
                            RemoveTVShow ->
                                Encode.string "VideoLibrary.RemoveTVShow"
                            Scan ->
                                Encode.string "VideoLibrary.Scan"
                            SetEpisodeDetails ->
                                Encode.string "VideoLibrary.SetEpisodeDetails"
                            SetMovieDetails ->
                                Encode.string "VideoLibrary.SetMovieDetails"
                            SetMovieSetDetails ->
                                Encode.string "VideoLibrary.SetMovieSetDetails"
                            SetMusicVideoDetails ->
                                Encode.string "VideoLibrary.SetMusicVideoDetails"
                            SetSeasonDetails ->
                                Encode.string "VideoLibrary.SetSeasonDetails"
                            SetTVShowDetails ->
                                Encode.string "VideoLibrary.SetTVShowDetails"
                            _ ->
                                Encode.string "Error, impossible method used with VideoLibrary namespace."
                    XBMC ->
                        case method of
                            GetInfoBooleans ->
                                Encode.string "XBMC.GetInfoBooleans"
                            GetInfoLabels ->
                                Encode.string "XBMC.GetInfoLabels"
                            _ ->
                                Encode.string "Error, impossible method used with XBMC namespace."
            )
            , ( "params", 
                case namespace of
                    Addons -> 
                        case method of
                            ExecuteAddon ->
                                Encode.string "Addons.ExecuteAddon"
                            GetAddonDetails ->
                                Encode.string "Addons.GetAddonDetails"
                            GetAddons ->
                                Encode.string "Addons.GetAddons"
                            SetAddonEnabled ->
                                Encode.string "Addons.SetAddonEnabled"
                            _ ->
                                Encode.string "Error, impossible method used with Addons namespace."
                    Application -> 
                        case method of
                            GetProperties ->
                                Encode.object
                                    [ ("properties"
                                        , case param of 
                                            Volume ->
                                                Encode.list Encode.string ["volume"]
                                            Muted ->
                                                Encode.list Encode.string ["muted"]
                                            Name ->
                                                Encode.list Encode.string ["name"]
                                            Version_ ->
                                                Encode.list Encode.string ["version"]
                                            Sorttokens ->
                                                Encode.list Encode.string ["sorttokens"]
                                            Language ->
                                                Encode.list Encode.string ["language"]
                                            _ ->
                                                Encode.string "Error, impossible param used with Application namespace."
                                    )]
                            Quit ->
                                Encode.string ""
                            SetMute ->
                                Encode.list Encode.bool [True] -- format is [ true ]
                            SetVolume ->
                                Encode.object
                                    [ ("volume", Encode.int 50) -- set volume to 50
                                    ]
                            _ ->
                                Encode.string "Error, impossible method used with Application namespace."
                    AudioLibrary ->
                        case method of
                            Clean ->
                                Encode.list Encode.bool [True]
                            Export ->
                                Encode.list Encode.object [[( "path", Encode.string "path"), ( "images", Encode.bool True)]]
                            GetAlbumDetails ->
                                Encode.object 
                                [ ("albumid", Encode.int 1)
                                , ("properties", Encode.list Encode.string ["property"])
                                ]
                            GetAlbums ->
                                Encode.string "AudioLibrary.GetAlbums"
                            GetArtistDetails ->
                                Encode.string "AudioLibrary.GetArtistDetails"
                            GetArtists ->
                                Encode.string "AudioLibrary.GetArtists"
                            GetGenres ->
                                Encode.string "AudioLibrary.GetGenres"
                            GetProperties ->
                                Encode.string "AudioLibrary.GetProperties"
                            GetRecentlyAddedAlbums ->
                                Encode.string "AudioLibrary.GetRecentlyAddedAlbums"
                            GetRecentlyAddedSongs ->
                                Encode.string "AudioLibrary.GetRecentlyAddedSongs"
                            GetRecentlyPlayedAlbums ->
                                Encode.string "AudioLibrary.GetRecentlyPlayedAlbums"
                            GetRecentlyPlayedSongs ->
                                Encode.string "AudioLibrary.GetRecentlyPlayedSongs"
                            GetRoles ->
                                Encode.string "AudioLibrary.GetRoles"
                            GetSongDetails ->
                                Encode.string "AudioLibrary.GetSongDetails"
                            GetSongs ->
                                Encode.string "AudioLibrary.GetSongs"
                            GetSources ->
                                Encode.string "AudioLibrary.GetSources"
                            Scan ->
                                Encode.string "AudioLibrary.Scan"
                            SetAlbumDetails ->
                                Encode.string "AudioLibrary.SetAlbumDetails"
                            SetArtistDetails ->
                                Encode.string "AudioLibrary.SetArtistDetails"
                            SetSongDetails ->
                                Encode.string "AudioLibrary.SetSongDetails"
                            _ ->
                                Encode.string "Error, impossible method used with AudioLibrary namespace."
                    Favourites ->
                        case method of
                            AddFavourite ->
                                Encode.string "Favourites.AddFavourite"
                            GetFavourites ->
                                Encode.string "Favourites.GetFavourites"
                            _ ->
                                Encode.string "Error, impossible method used with Favourites namespace."
                    Files ->
                        case method of
                            Download ->
                                Encode.string "Files.Download"
                            GetDirectory ->
                                Encode.string "Files.GetDirectory"
                            GetFileDetails ->
                                Encode.string "Files.GetFileDetails"
                            GetSources ->
                                Encode.string "Files.GetSources"
                            PrepareDownload ->
                                Encode.string "Files.PrepareDownload"
                            SetFileDetails ->
                                Encode.string "Files.SetFileDetails"
                            _ ->
                                Encode.string "Error, impossible method used with Files namespace."
                    GUI ->
                        case method of
                            ActivateWindow ->
                                Encode.string "GUI.ActivateWindow"
                            GetProperties ->
                                Encode.string "GUI.GetProperties"
                            GetStereoscopicModes ->
                                Encode.string "GUI.GetStereoscopicModes"
                            SetFullscreen ->
                                Encode.string "GUI.SetFullscreen"
                            SetStereoscopicMode ->
                                Encode.string "GUI.SetStereoscopicMode"
                            ShowNotification ->
                                Encode.string "GUI.ShowNotification"
                            _ ->
                                Encode.string "Error, impossible method used with GUI namespace."
                    Input ->
                        case method of
                            Back ->
                                Encode.string "Input.Back"
                            ButtonEvent ->
                                Encode.string "Input.ButtonEvent"
                            ContextMenu ->
                                Encode.string "Input.ContextMenu"
                            Down ->
                                Encode.string "Input.Down"
                            ExecuteAction ->
                                Encode.object
                                    [ ("action"
                                        , case param of 
                                            Analogfastforward ->
                                                Encode.string "analogfastforward"
                                            Analogmove ->
                                                Encode.string "analogmove"
                                            Analogmovexleft ->
                                                Encode.string "analogmovexleft"
                                            Analogmovexright ->
                                                Encode.string "analogmovexright"
                                            Analogmoveydown ->
                                                Encode.string "analogmoveydown"
                                            Analogmoveyup ->
                                                Encode.string "analogmoveyup"
                                            Analogrewind ->
                                                Encode.string "analogrewind"
                                            Analogseekback ->
                                                Encode.string "analogseekback"
                                            Analogseekforward ->
                                                Encode.string "analogseekforward"
                                            Aspectratio ->
                                                Encode.string "aspectratio"
                                            Audiodelay ->
                                                Encode.string "audiodelay"
                                            Audiodelayminus ->
                                                Encode.string "audiodelayminus"
                                            Audiodelayplus ->
                                                Encode.string "audiodelayplus"
                                            Audionextlanguage ->
                                                Encode.string "audionextlanguage"
                                            Audiotoggledigital ->
                                                Encode.string "audiotoggledigital"
                                            Back_ ->
                                                Encode.string "back"
                                            Backspace ->
                                                Encode.string "backspace"
                                            Bigstepback ->
                                                Encode.string "bigstepback"
                                            Bigstepforward ->
                                                Encode.string "bigstepforward"
                                            Blue ->
                                                Encode.string "blue"
                                            Browsesubtitle ->
                                                Encode.string "browsesubtitle"
                                            Channeldown ->
                                                Encode.string "channeldown"
                                            Channelnumberseparator ->
                                                Encode.string "channelnumberseparator"
                                            Channelup ->
                                                Encode.string "channelup"
                                            Chapterorbigstepback ->
                                                Encode.string "chapterorbigstepback"
                                            Chapterorbigstepforward ->
                                                Encode.string "chapterorbigstepforward"
                                            Close ->
                                                Encode.string "close"
                                            Codecinfo ->
                                                Encode.string "codecinfo"
                                            Contextmenu ->
                                                Encode.string "contextmenu"
                                            Copy ->
                                                Encode.string "copy"
                                            Createbookmark ->
                                                Encode.string "createbookmark"
                                            Createepisodebookmark ->
                                                Encode.string "createepisodebookmark"
                                            Cursorleft ->
                                                Encode.string "cursorleft"
                                            Cursorright ->
                                                Encode.string "cursorright"
                                            Cyclesubtitle ->
                                                Encode.string "cyclesubtitle"
                                            Decreasepar ->
                                                Encode.string "decreasepar"
                                            Decreaserating ->
                                                Encode.string "decreaserating"
                                            Decreasevisrating ->
                                                Encode.string "decreasevisrating"
                                            Delete ->
                                                Encode.string "delete"
                                            Doubleclick ->
                                                Encode.string "doubleclick"
                                            Down_ ->
                                                Encode.string "down"
                                            Enter ->
                                                Encode.string "enter"
                                            Error ->
                                                Encode.string "error"
                                            Fastforward ->
                                                Encode.string "fastforward"
                                            Filter ->
                                                Encode.string "filter"
                                            Filterclear ->
                                                Encode.string "filterclear"
                                            Filtersms2 ->
                                                Encode.string "filtersms2"
                                            Filtersms3 ->
                                                Encode.string "filtersms3"
                                            Filtersms4 ->
                                                Encode.string "filtersms4"
                                            Filtersms5 ->
                                                Encode.string "filtersms5"
                                            Filtersms6 ->
                                                Encode.string "filtersms6"
                                            Filtersms7 ->
                                                Encode.string "filtersms7"
                                            Filtersms8 ->
                                                Encode.string "filtersms8"
                                            Filtersms9 ->
                                                Encode.string "filtersms9"
                                            Firstpage ->
                                                Encode.string "firstpage"
                                            Fullscreen ->
                                                Encode.string "fullscreen"
                                            Green ->
                                                Encode.string "green"
                                            Guiprofile ->
                                                Encode.string "guiprofile"
                                            Highlight ->
                                                Encode.string "highlight"
                                            Increasepar ->
                                                Encode.string "increasepar"
                                            Increaserating ->
                                                Encode.string "increaserating"
                                            Increasevisrating ->
                                                Encode.string "increasevisrating"
                                            Info_ ->
                                                Encode.string "info"
                                            Jumpsms2 ->
                                                Encode.string "jumpsms2"
                                            Jumpsms3 ->
                                                Encode.string "jumpsms3"
                                            Jumpsms4 ->
                                                Encode.string "jumpsms4"
                                            Jumpsms5 ->
                                                Encode.string "jumpsms5"
                                            Jumpsms6 ->
                                                Encode.string "jumpsms6"
                                            Jumpsms7 ->
                                                Encode.string "jumpsms7"
                                            Jumpsms8 ->
                                                Encode.string "jumpsms8"
                                            Jumpsms9 ->
                                                Encode.string "jumpsms9"
                                            Lastpage ->
                                                Encode.string "lastpage"
                                            Left_ ->
                                                Encode.string "left"
                                            Leftclick ->
                                                Encode.string "leftclick"
                                            Lockpreset ->
                                                Encode.string "lockpreset"
                                            Longclick ->
                                                Encode.string "longclick"
                                            Longpress ->
                                                Encode.string "longpress"
                                            Menu ->
                                                Encode.string "menu"
                                            Middleclick ->
                                                Encode.string "middleclick"
                                            Mousedrag ->
                                                Encode.string "mousedrag"
                                            Mousedragend ->
                                                Encode.string "mousedragend"
                                            Mousemove ->
                                                Encode.string "mousemove"
                                            Move_ ->
                                                Encode.string "move"
                                            Moveitemdown ->
                                                Encode.string "moveitemdown"
                                            Moveitemup ->
                                                Encode.string "moveitemup"
                                            Mute ->
                                                Encode.string "mute"
                                            Nextcalibration ->
                                                Encode.string "nextcalibration"
                                            Nextchannelgroup ->
                                                Encode.string "nextchannelgroup"
                                            Nextletter ->
                                                Encode.string "nextletter"
                                            Nextpicture ->
                                                Encode.string "nextpicture"
                                            Nextpreset ->
                                                Encode.string "nextpreset"
                                            Nextresolution ->
                                                Encode.string "nextresolution"
                                            Nextscene ->
                                                Encode.string "nextscene"
                                            Nextstereomode ->
                                                Encode.string "nextstereomode"
                                            Nextsubtitle ->
                                                Encode.string "nextsubtitle"
                                            Noop ->
                                                Encode.string "noop"
                                            Number0 ->
                                                Encode.string "number0"
                                            Number1 ->
                                                Encode.string "number1"
                                            Number2 ->
                                                Encode.string "number2"
                                            Number3 ->
                                                Encode.string "number3"
                                            Number4 ->
                                                Encode.string "number4"
                                            Number5 ->
                                                Encode.string "number5"
                                            Number6 ->
                                                Encode.string "number6"
                                            Number7 ->
                                                Encode.string "number7"
                                            Number8 ->
                                                Encode.string "number8"
                                            Number9 ->
                                                Encode.string "number9"
                                            Osd ->
                                                Encode.string "osd"
                                            Pagedown ->
                                                Encode.string "pagedown"
                                            Pageup ->
                                                Encode.string "pageup"
                                            Pangesture ->
                                                Encode.string "pangesture"
                                            Parentdir ->
                                                Encode.string "parentdir"
                                            Parentfolder ->
                                                Encode.string "parentfolder"
                                            Pause ->
                                                Encode.string "pause"
                                            Play ->
                                                Encode.string "play"
                                            Playerdebug ->
                                                Encode.string "playerdebug"
                                            Playerprocessinfo ->
                                                Encode.string "playerprocessinfo"
                                            Playerprogramselect ->
                                                Encode.string "playerprogramselect"
                                            Playerresolutionselect ->
                                                Encode.string "playerresolutionselect"
                                            Playlist_ ->
                                                Encode.string "playlist"
                                            Playnext ->
                                                Encode.string "playnext"
                                            Playpause ->
                                                Encode.string "playpause"
                                            Playpvr ->
                                                Encode.string "playpvr"
                                            Playpvrradio ->
                                                Encode.string "playpvrradio"
                                            Playpvrtv ->
                                                Encode.string "playpvrtv"
                                            Previouschannelgroup ->
                                                Encode.string "previouschannelgroup"
                                            Previousmenu ->
                                                Encode.string "previousmenu"
                                            Previouspicture ->
                                                Encode.string "previouspicture"
                                            Previouspreset ->
                                                Encode.string "previouspreset"
                                            Previousscene ->
                                                Encode.string "previousscene"
                                            Previousstereomode ->
                                                Encode.string "previousstereomode"
                                            Prevletter ->
                                                Encode.string "prevletter"
                                            Queue ->
                                                Encode.string "queue"
                                            Randompreset ->
                                                Encode.string "randompreset"
                                            Record_ ->
                                                Encode.string "record"
                                            Red ->
                                                Encode.string "red"
                                            Reloadkeymaps ->
                                                Encode.string "reloadkeymaps"
                                            Rename ->
                                                Encode.string "rename"
                                            Resetcalibration ->
                                                Encode.string "resetcalibration"
                                            Rewind ->
                                                Encode.string "rewind"
                                            Right_ ->
                                                Encode.string "right"
                                            Rightclick ->
                                                Encode.string "rightclick"
                                            Rotate_ ->
                                                Encode.string "rotate"
                                            Rotateccw ->
                                                Encode.string "rotateccw"
                                            Rotategesture ->
                                                Encode.string "rotategesture"
                                            Scanitem ->
                                                Encode.string "scanitem"
                                            Screenshot ->
                                                Encode.string "screenshot"
                                            Scrolldown ->
                                                Encode.string "scrolldown"
                                            Scrollup ->
                                                Encode.string "scrollup"
                                            Select_ ->
                                                Encode.string "select"
                                            Setrating ->
                                                Encode.string "setrating"
                                            Settingslevelchange ->
                                                Encode.string "settingslevelchange"
                                            Settingsreset ->
                                                Encode.string "settingsreset"
                                            Shift ->
                                                Encode.string "shift"
                                            Showpreset ->
                                                Encode.string "showpreset"
                                            Showsubtitles ->
                                                Encode.string "showsubtitles"
                                            Showtime ->
                                                Encode.string "showtime"
                                            Showtimerrule ->
                                                Encode.string "showtimerrule"
                                            Showvideomenu ->
                                                Encode.string "showvideomenu"
                                            Skipnext ->
                                                Encode.string "skipnext"
                                            Skipprevious ->
                                                Encode.string "skipprevious"
                                            Smallstepback ->
                                                Encode.string "smallstepback"
                                            Stepback ->
                                                Encode.string "stepback"
                                            Stepforward ->
                                                Encode.string "stepforward"
                                            Stereomode ->
                                                Encode.string "stereomode"
                                            Stereomodetomono ->
                                                Encode.string "stereomodetomono"
                                            Stop_ ->
                                                Encode.string "stop"
                                            Subtitlealign ->
                                                Encode.string "subtitlealign"
                                            Subtitledelay ->
                                                Encode.string "subtitledelay"
                                            Subtitledelayminus ->
                                                Encode.string "subtitledelayminus"
                                            Subtitledelayplus ->
                                                Encode.string "subtitledelayplus"
                                            Subtitleshiftdown ->
                                                Encode.string "subtitleshiftdown"
                                            Subtitleshiftup ->
                                                Encode.string "subtitleshiftup"
                                            Swipedown ->
                                                Encode.string "swipedown"
                                            Swipeleft ->
                                                Encode.string "swipeleft"
                                            Swiperight ->
                                                Encode.string "swiperight"
                                            Swipeup ->
                                                Encode.string "swipeup"
                                            Switchplayer ->
                                                Encode.string "switchplayer"
                                            Symbols ->
                                                Encode.string "symbols"
                                            Tap ->
                                                Encode.string "tap"
                                            Togglecommskip ->
                                                Encode.string "togglecommskip"
                                            Togglefont ->
                                                Encode.string "togglefont"
                                            Togglefullscreen ->
                                                Encode.string "togglefullscreen"
                                            Togglestereomode ->
                                                Encode.string "togglestereomode"
                                            Togglewatched ->
                                                Encode.string "togglewatched"
                                            Up_ ->
                                                Encode.string "up"
                                            Verticalshiftdown ->
                                                Encode.string "verticalshiftdown"
                                            Verticalshiftup ->
                                                Encode.string "verticalshiftup"
                                            Videonextstream ->
                                                Encode.string "videonextstream"
                                            Voicerecognizer ->
                                                Encode.string "voicerecognizer"
                                            Volampdown ->
                                                Encode.string "volampdown"
                                            Volampup ->
                                                Encode.string "volampup"
                                            Volumeamplification ->
                                                Encode.string "volumeamplification"
                                            Volumedown ->
                                                Encode.string "volumedown"
                                            Volumeup ->
                                                Encode.string "volumeup"
                                            Wheeldown ->
                                                Encode.string "wheeldown"
                                            Wheelup ->
                                                Encode.string "wheelup"
                                            Yellow ->
                                                Encode.string "yellow"
                                            Zoomgesture ->
                                                Encode.string "zoomgesture"
                                            Zoomin ->
                                                Encode.string "zoomin"
                                            Zoomlevel1 ->
                                                Encode.string "zoomlevel1"
                                            Zoomlevel2 ->
                                                Encode.string "zoomlevel2"
                                            Zoomlevel3 ->
                                                Encode.string "zoomlevel3"
                                            Zoomlevel4 ->
                                                Encode.string "zoomlevel4"
                                            Zoomlevel5 ->
                                                Encode.string "zoomlevel5"
                                            Zoomlevel6 ->
                                                Encode.string "zoomlevel6"
                                            Zoomlevel7 ->
                                                Encode.string "zoomlevel7"
                                            Zoomlevel8 ->
                                                Encode.string "zoomlevel8"
                                            Zoomlevel9 ->
                                                Encode.string "zoomlevel9"
                                            Zoomnormal ->
                                                Encode.string "zoomnormal"
                                            Zoomout ->
                                                Encode.string "zoomout"
                                            _ ->
                                                Encode.string ""
                                            )]
                            Home ->
                                Encode.string "Input.Home"
                            Info ->
                                Encode.string "Input.Info"
                            Left ->
                                Encode.string "Input.Left"
                            Right ->
                                Encode.string "Input.Right"
                            Select ->
                                Encode.string "Input.Select"
                            SendText ->
                                Encode.string "Input.SendText"
                            ShowCodec ->
                                Encode.string "Input.ShowCodec"
                            ShowOSD ->
                                Encode.string "Input.ShowOSD"
                            ShowPlayerProcessInfo ->
                                Encode.string "Input.ShowPlayerProcessInfo"
                            Up ->
                                Encode.string "Input.Up"
                            _ ->
                                Encode.string "Error, impossible method used with Input namespace."
                    JSONRPC -> 
                        case method of
                            GetConfiguration ->
                                Encode.string "JSONRPC.GetConfiguration"
                            Introspect ->
                                Encode.string "JSONRPC.Introspect"
                            NotifyAll ->
                                Encode.string "JSONRPC.NotifyAll"
                            Permission ->
                                Encode.string "JSONRPC.Permission"
                            Ping ->
                                Encode.string "JSONRPC.Ping"
                            SetConfiguration ->
                                Encode.string "JSONRPC.SetConfiguration"
                            Version ->
                                Encode.string "JSONRPC.Version"
                            _ ->
                                Encode.string "Error, impossible method used with JSONRPC namespace."
                    PVR ->
                        case method of
                            AddTimer ->
                                Encode.string "PVR.AddTimer"
                            DeleteTimer ->
                                Encode.string "PVR.DeleteTimer"
                            GetBroadcastDetails ->
                                Encode.string "PVR.GetBroadcastDetails"
                            GetBroadcasts ->
                                Encode.string "PVR.GetBroadcasts"
                            GetChannelDetails ->
                                Encode.string "PVR.GetChannelDetails"
                            GetChannelGroupDetails ->
                                Encode.string "PVR.GetChannelGroupDetails"
                            GetChannelGroups ->
                                Encode.string "PVR.GetChannelGroups"
                            GetChannels ->
                                Encode.string "PVR.GetChannels"
                            GetProperties ->
                                Encode.string "PVR.GetProperties"
                            GetRecordingDetails ->
                                Encode.string "PVR.GetRecordingDetails"
                            GetRecordings ->
                                Encode.string "PVR.GetRecordings"
                            GetTimerDetails ->
                                Encode.string "PVR.GetTimerDetails"
                            GetTimers ->
                                Encode.string "PVR.GetTimers"
                            Record ->
                                Encode.string "PVR.Record"
                            Scan ->
                                Encode.string "PVR.Scan"
                            ToggleTimer ->
                                Encode.string "PVR.ToggleTimer"
                            _ ->
                                Encode.string "Error, impossible method used with PVR namespace."
                    Player ->
                        case method of
                            GetActivePlayers ->
                                Encode.string "Player.GetActivePlayers"
                            GetItem ->
                                Encode.string "Player.GetItem"
                            GetPlayers ->
                                Encode.string "Player.GetPlayers"
                            GetProperties ->
                                Encode.string "Player.GetProperties"
                            GetViewMode ->
                                Encode.string "Player.GetViewMode"
                            GoTo ->
                                Encode.string "Player.GoTo"
                            Move ->
                                Encode.string "Player.Move"
                            Open ->
                                Encode.string "Player.Open"
                            PlayPause ->
                                Encode.string "Player.PlayPause"
                            Rotate ->
                                Encode.string "Player.Rotate"
                            Seek ->
                                Encode.string "Player.Seek"
                            SetAudioStream ->
                                Encode.string "Player.SetAudioStream"
                            SetPartyMode ->
                                Encode.string "Player.SetPartyMode"
                            SetShuffle ->
                                case param of
                                    Shuffle ->
                                        Encode.object
                                            [ ("shuffle"
                                            , Encode.bool True 
                                            )]
                                    _ -> 
                                        Encode.string ""
                            SetRepeat ->
                                case param of
                                    Cycle -> 
                                        Encode.object
                                            [ ("repeat"
                                            , Encode.string "cycle"
                                            )]
                                    One ->
                                        Encode.object
                                            [ ("repeat"
                                            , Encode.string "one"
                                            )]
                                    _ ->
                                        Encode.string ""
                            SetSpeed ->
                                Encode.string "Player.SetSpeed"
                            SetSubtitle ->
                                Encode.string "Player.SetSubtitle"
                            SetVideoStream ->
                                Encode.string "Player.SetVideoStream"
                            SetViewMode ->
                                Encode.string "Player.SetViewMode"
                            Stop ->
                                Encode.string "Player.Stop"
                            Zoom ->
                                Encode.string "Player.Zoom"
                            _ ->
                                Encode.string "Error, impossible method used with Player namespace."
                    Playlist ->
                        case method of
                            Add ->
                                Encode.string "Playlist.Add"
                            Clear ->
                                Encode.string "Playlist.Clear"
                            GetItems ->
                                Encode.string "Playlist.GetItems"
                            GetPlaylists ->
                                Encode.string "Playlist.GetPlaylists"
                            GetProperties ->
                                Encode.string "Playlist.GetProperties"
                            Insert ->
                                Encode.string "Playlist.Insert"
                            Remove ->
                                Encode.string "Playlist.Remove"
                            Swap ->
                                Encode.string "Playlist.Swap"
                            _ ->
                                Encode.string "Error, impossible method used with Playlist namespace."
                    Profiles ->
                        case method of
                            GetCurrentProfile ->
                                Encode.string "Profiles.GetCurrentProfile"
                            GetProfiles ->
                                Encode.string "Profiles.GetProfiles"
                            LoadProfile ->
                                Encode.string "Profiles.LoadProfile"
                            _ ->
                                Encode.string "Error, impossible method used with Profiles namespace."
                    Settings ->
                        case method of
                            GetCategories ->
                                Encode.string "Settings.GetCategories"
                            GetSections ->
                                Encode.string "Settings.GetSections"
                            GetSettingValue ->
                                Encode.string "Settings.GetSettingValue"
                            GetSettings ->
                                Encode.string "Settings.GetSettings"
                            ResetSettingValue ->
                                Encode.string "Settings.ResetSettingValue"
                            SetSettingValue ->
                                Encode.string "Settings.SetSettingValue"
                            _ ->
                                Encode.string "Error, impossible method used with Settings namespace."
                    System ->
                        case method of
                            EjectOpticalDrive ->
                                Encode.string "System.EjectOpticalDrive"
                            GetProperties ->
                                Encode.string "System.GetProperties"
                            Hibernate ->
                                Encode.string "System.Hibernate"
                            Reboot ->
                                Encode.string "System.Reboot"
                            Shutdown ->
                                Encode.string "System.Shutdown"
                            Suspend ->
                                Encode.string "System.Suspend"
                            _ ->
                                Encode.string "Error, impossible method used with System namespace."
                    Textures ->
                        case method of
                            GetTextures ->
                                Encode.string "Textures.GetTextures"
                            RemoveTexture ->
                                Encode.string "Textures.RemoveTexture"
                            _ ->
                                Encode.string "Error, impossible method used with Textures namespace."
                    VideoLibrary ->
                        case method of
                            Clean ->
                                Encode.string "VideoLibrary.Clean"
                            Export ->
                                Encode.string "VideoLibrary.Export"
                            GetEpisodeDetails ->
                                Encode.string "VideoLibrary.GetEpisodeDetails"
                            GetEpisodes ->
                                Encode.string "VideoLibrary.GetEpisodes"
                            GetGenres ->
                                Encode.string "VideoLibrary.GetGenres"
                            GetInProgressTVShows ->
                                Encode.string "VideoLibrary.GetInProgressTVShows"
                            GetMovieDetails ->
                                Encode.string "VideoLibrary.GetMovieDetails"
                            GetMovieSetDetails ->
                                Encode.string "VideoLibrary.GetMovieSetDetails"
                            GetMovieSets ->
                                Encode.string "VideoLibrary.GetMovieSets"
                            GetMovies ->
                                Encode.string "VideoLibrary.GetMovies"
                            GetMusicVideoDetails ->
                                Encode.string "VideoLibrary.GetMusicVideoDetails"
                            GetMusicVideos ->
                                Encode.string "VideoLibrary.GetMusicVideos"
                            GetRecentlyAddedEpisodes ->
                                Encode.string "VideoLibrary.GetRecentlyAddedEpisodes"
                            GetRecentlyAddedMovies ->
                                Encode.string "VideoLibrary.GetRecentlyAddedMovies"
                            GetRecentlyAddedMusicVideos ->
                                Encode.string "VideoLibrary.GetRecentlyAddedMusicVideos"
                            GetSeasonDetails ->
                                Encode.string "VideoLibrary.GetSeasonDetails"
                            GetSeasons ->
                                Encode.string "VideoLibrary.GetSeasons"
                            GetTVShowDetails ->
                                Encode.string "VideoLibrary.GetTVShowDetails"
                            GetTVShows ->
                                Encode.string "VideoLibrary.GetTVShows"
                            GetTags ->
                                Encode.string "VideoLibrary.GetTags"
                            RefreshEpisode ->
                                Encode.string "VideoLibrary.RefreshEpisode"
                            RefreshMovie ->
                                Encode.string "VideoLibrary.RefreshMovie"
                            RefreshMusicVideo ->
                                Encode.string "VideoLibrary.RefreshMusicVideo"
                            RefreshTVShow ->
                                Encode.string "VideoLibrary.RefreshTVShow"
                            RemoveEpisode ->
                                Encode.string "VideoLibrary.RemoveEpisode"
                            RemoveMovie ->
                                Encode.string "VideoLibrary.RemoveMovie"
                            RemoveMusicVideo ->
                                Encode.string "VideoLibrary.RemoveMusicVideo"
                            RemoveTVShow ->
                                Encode.string "VideoLibrary.RemoveTVShow"
                            Scan ->
                                Encode.string "VideoLibrary.Scan"
                            SetEpisodeDetails ->
                                Encode.string "VideoLibrary.SetEpisodeDetails"
                            SetMovieDetails ->
                                Encode.string "VideoLibrary.SetMovieDetails"
                            SetMovieSetDetails ->
                                Encode.string "VideoLibrary.SetMovieSetDetails"
                            SetMusicVideoDetails ->
                                Encode.string "VideoLibrary.SetMusicVideoDetails"
                            SetSeasonDetails ->
                                Encode.string "VideoLibrary.SetSeasonDetails"
                            SetTVShowDetails ->
                                Encode.string "VideoLibrary.SetTVShowDetails"
                            _ ->
                                Encode.string "Error, impossible method used with VideoLibrary namespace."
                    XBMC ->
                        case method of
                            GetInfoBooleans ->
                                Encode.string "XBMC.GetInfoBooleans"
                            GetInfoLabels ->
                                Encode.string "XBMC.GetInfoLabels"
                            _ ->
                                Encode.string "Error, impossible method used with XBMC namespace."
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

        Send namespace method param int ->
            ( model
            , sendAction (toStr namespace method param int)
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
        , playPauseMsg = toMsg (Send Input ExecuteAction Playpause 0)
        , skipMsg = toMsg (Send Input ExecuteAction Skipnext 0)
        , reverseMsg = toMsg (Send Input ExecuteAction Skipprevious 0)
        , muteMsg = toMsg (Send Input ExecuteAction Mute 0)
        , repeatMsg = toMsg (Send Player SetRepeat Cycle 0)
        , shuffleMsg = toMsg (Send Player SetShuffle Shuffle 0)
        }

-- COMMANDS

send : msg -> Cmd msg
send =
    Task.succeed >> Task.perform identity


navigate : Route -> Cmd Msg
navigate route =
    send (Navigate route)
