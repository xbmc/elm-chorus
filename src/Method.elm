module Method exposing (Method(..), methodToStr, strToMethod)


type Method
    = JSONRPC_Introspect
    | JSONRPC_Version
    | JSONRPC_Permission
    | JSONRPC_Ping
    | JSONRPC_GetConfiguration
    | JSONRPC_SetConfiguration
    | JSONRPC_NotifyAll
    | Player_Open
    | Player_GetActivePlayers
    | Player_GetPlayers
    | Player_GetProperties
    | Player_GetItem
    | Player_PlayPause
    | Player_Stop
    | Player_SetSpeed
    | Player_Seek
    | Player_Move
    | Player_Zoom
    | Player_SetViewMode
    | Player_GetViewMode
    | Player_Rotate
    | Player_GoTo
    | Player_SetShuffle
    | Player_SetRepeat
    | Player_SetPartymode
    | Player_SetAudioStream
    | Player_SetVideoStream
    | Player_SetSubtitle
    | Playlist_GetPlaylists
    | Playlist_GetProperties
    | Playlist_GetItems
    | Playlist_Add
    | Playlist_Insert
    | Playlist_Remove
    | Playlist_Clear
    | Playlist_Swap
    | Files_GetSources
    | Files_PrepareDownload
    | Files_Download
    | Files_GetDirectory
    | Files_GetFileDetails
    | Files_SetFileDetails
    | AudioLibrary_GetProperties
    | AudioLibrary_GetArtists
    | AudioLibrary_GetArtistDetails
    | AudioLibrary_GetAlbums
    | AudioLibrary_GetAlbumDetails
    | AudioLibrary_GetSongs
    | AudioLibrary_GetSongDetails
    | AudioLibrary_GetRecentlyAddedAlbums
    | AudioLibrary_GetRecentlyAddedSongs
    | AudioLibrary_GetRecentlyPlayedAlbums
    | AudioLibrary_GetRecentlyPlayedSongs
    | AudioLibrary_GetGenres
    | AudioLibrary_GetSources
    | AudioLibrary_GetRoles
    | AudioLibrary_SetArtistDetails
    | AudioLibrary_SetAlbumDetails
    | AudioLibrary_SetSongDetails
    | AudioLibrary_Scan
    | AudioLibrary_Export
    | AudioLibrary_Clean
    | VideoLibrary_GetMovies
    | VideoLibrary_GetMovieDetails
    | VideoLibrary_GetMovieSets
    | VideoLibrary_GetMovieSetDetails
    | VideoLibrary_GetTVShows
    | VideoLibrary_GetTVShowDetails
    | VideoLibrary_GetSeasons
    | VideoLibrary_GetSeasonDetails
    | VideoLibrary_GetEpisodes
    | VideoLibrary_GetEpisodeDetails
    | VideoLibrary_GetMusicVideos
    | VideoLibrary_GetMusicVideoDetails
    | VideoLibrary_GetRecentlyAddedMovies
    | VideoLibrary_GetRecentlyAddedEpisodes
    | VideoLibrary_GetRecentlyAddedMusicVideos
    | VideoLibrary_GetInProgressTVShows
    | VideoLibrary_GetGenres
    | VideoLibrary_GetTags
    | VideoLibrary_SetMovieDetails
    | VideoLibrary_SetMovieSetDetails
    | VideoLibrary_SetTVShowDetails
    | VideoLibrary_SetSeasonDetails
    | VideoLibrary_SetEpisodeDetails
    | VideoLibrary_SetMusicVideoDetails
    | VideoLibrary_RefreshMovie
    | VideoLibrary_RefreshTVShow
    | VideoLibrary_RefreshEpisode
    | VideoLibrary_RefreshMusicVideo
    | VideoLibrary_RemoveMovie
    | VideoLibrary_RemoveTVShow
    | VideoLibrary_RemoveEpisode
    | VideoLibrary_RemoveMusicVideo
    | VideoLibrary_Scan
    | VideoLibrary_Export
    | VideoLibrary_Clean
    | GUI_ActivateWindow
    | GUI_ShowNotification
    | GUI_GetProperties
    | GUI_SetFullscreen
    | GUI_SetStereoscopicMode
    | GUI_GetStereoscopicModes
    | Addons_GetAddons
    | Addons_GetAddonDetails
    | Addons_SetAddonEnabled
    | Addons_ExecuteAddon
    | PVR_GetProperties
    | PVR_GetChannelGroups
    | PVR_GetChannelGroupDetails
    | PVR_GetChannels
    | PVR_GetChannelDetails
    | PVR_GetBroadcasts
    | PVR_GetBroadcastDetails
    | PVR_GetTimers
    | PVR_GetTimerDetails
    | PVR_AddTimer
    | PVR_DeleteTimer
    | PVR_ToggleTimer
    | PVR_GetRecordings
    | PVR_GetRecordingDetails
    | PVR_Record
    | PVR_Scan
    | Textures_GetTextures
    | Textures_RemoveTexture
    | Profiles_GetProfiles
    | Profiles_GetCurrentProfile
    | Profiles_LoadProfile
    | System_GetProperties
    | System_EjectOpticalDrive
    | System_Shutdown
    | System_Suspend
    | System_Hibernate
    | System_Reboot
    | Input_SendText
    | Input_ExecuteAction
    | Input_ButtonEvent
    | Input_Left
    | Input_Right
    | Input_Down
    | Input_Up
    | Input_Select
    | Input_Back
    | Input_ContextMenu
    | Input_Info
    | Input_Home
    | Input_ShowCodec
    | Input_ShowOSD
    | Input_ShowPlayerProcessInfo
    | Application_GetProperties
    | Application_SetVolume
    | Application_SetMute
    | Application_Quit
    | XBMC_GetInfoLabels
    | XBMC_GetInfoBooleans
    | Favourites_GetFavourites
    | Favourites_AddFavourite
    | Settings_GetSections
    | Settings_GetCategories
    | Settings_GetSettings
    | Settings_GetSettingValue
    | Settings_SetSettingValue
    | Settings_ResetSettingValue


methodToStr : Method -> String
methodToStr method =
    case method of
        JSONRPC_Introspect ->
            "JSONRPC.Introspect"

        JSONRPC_Version ->
            "JSONRPC.Version"

        JSONRPC_Permission ->
            "JSONRPC.Permission"

        JSONRPC_Ping ->
            "JSONRPC.Ping"

        JSONRPC_GetConfiguration ->
            "JSONRPC.GetConfiguration"

        JSONRPC_SetConfiguration ->
            "JSONRPC.SetConfiguration"

        JSONRPC_NotifyAll ->
            "JSONRPC.NotifyAll"

        Player_Open ->
            "Player.Open"

        Player_GetActivePlayers ->
            "Player.GetActivePlayers"

        Player_GetPlayers ->
            "Player.GetPlayers"

        Player_GetProperties ->
            "Player.GetProperties"

        Player_GetItem ->
            "Player.GetItem"

        Player_PlayPause ->
            "Player.PlayPause"

        Player_Stop ->
            "Player.Stop"

        Player_SetSpeed ->
            "Player.SetSpeed"

        Player_Seek ->
            "Player.Seek"

        Player_Move ->
            "Player.Move"

        Player_Zoom ->
            "Player.Zoom"

        Player_SetViewMode ->
            "Player.SetViewMode"

        Player_GetViewMode ->
            "Player.GetViewMode"

        Player_Rotate ->
            "Player.Rotate"

        Player_GoTo ->
            "Player.GoTo"

        Player_SetShuffle ->
            "Player.SetShuffle"

        Player_SetRepeat ->
            "Player.SetRepeat"

        Player_SetPartymode ->
            "Player.SetPartymode"

        Player_SetAudioStream ->
            "Player.SetAudioStream"

        Player_SetVideoStream ->
            "Player.SetVideoStream"

        Player_SetSubtitle ->
            "Player.SetSubtitle"

        Playlist_GetPlaylists ->
            "Playlist.GetPlaylists"

        Playlist_GetProperties ->
            "Playlist.GetProperties"

        Playlist_GetItems ->
            "Playlist.GetItems"

        Playlist_Add ->
            "Playlist.Add"

        Playlist_Insert ->
            "Playlist.Insert"

        Playlist_Remove ->
            "Playlist.Remove"

        Playlist_Clear ->
            "Playlist.Clear"

        Playlist_Swap ->
            "Playlist.Swap"

        Files_GetSources ->
            "Files.GetSources"

        Files_PrepareDownload ->
            "Files.PrepareDownload"

        Files_Download ->
            "Files.Download"

        Files_GetDirectory ->
            "Files.GetDirectory"

        Files_GetFileDetails ->
            "Files.GetFileDetails"

        Files_SetFileDetails ->
            "Files.SetFileDetails"

        AudioLibrary_GetProperties ->
            "AudioLibrary.GetProperties"

        AudioLibrary_GetArtists ->
            "AudioLibrary.GetArtists"

        AudioLibrary_GetArtistDetails ->
            "AudioLibrary.GetArtistDetails"

        AudioLibrary_GetAlbums ->
            "AudioLibrary.GetAlbums"

        AudioLibrary_GetAlbumDetails ->
            "AudioLibrary.GetAlbumDetails"

        AudioLibrary_GetSongs ->
            "AudioLibrary.GetSongs"

        AudioLibrary_GetSongDetails ->
            "AudioLibrary.GetSongDetails"

        AudioLibrary_GetRecentlyAddedAlbums ->
            "AudioLibrary.GetRecentlyAddedAlbums"

        AudioLibrary_GetRecentlyAddedSongs ->
            "AudioLibrary.GetRecentlyAddedSongs"

        AudioLibrary_GetRecentlyPlayedAlbums ->
            "AudioLibrary.GetRecentlyPlayedAlbums"

        AudioLibrary_GetRecentlyPlayedSongs ->
            "AudioLibrary.GetRecentlyPlayedSongs"

        AudioLibrary_GetGenres ->
            "AudioLibrary.GetGenres"

        AudioLibrary_GetSources ->
            "AudioLibrary.GetSources"

        AudioLibrary_GetRoles ->
            "AudioLibrary.GetRoles"

        AudioLibrary_SetArtistDetails ->
            "AudioLibrary.SetArtistDetails"

        AudioLibrary_SetAlbumDetails ->
            "AudioLibrary.SetAlbumDetails"

        AudioLibrary_SetSongDetails ->
            "AudioLibrary.SetSongDetails"

        AudioLibrary_Scan ->
            "AudioLibrary.Scan"

        AudioLibrary_Export ->
            "AudioLibrary.Export"

        AudioLibrary_Clean ->
            "AudioLibrary.Clean"

        VideoLibrary_GetMovies ->
            "VideoLibrary.GetMovies"

        VideoLibrary_GetMovieDetails ->
            "VideoLibrary.GetMovieDetails"

        VideoLibrary_GetMovieSets ->
            "VideoLibrary.GetMovieSets"

        VideoLibrary_GetMovieSetDetails ->
            "VideoLibrary.GetMovieSetDetails"

        VideoLibrary_GetTVShows ->
            "VideoLibrary.GetTVShows"

        VideoLibrary_GetTVShowDetails ->
            "VideoLibrary.GetTVShowDetails"

        VideoLibrary_GetSeasons ->
            "VideoLibrary.GetSeasons"

        VideoLibrary_GetSeasonDetails ->
            "VideoLibrary.GetSeasonDetails"

        VideoLibrary_GetEpisodes ->
            "VideoLibrary.GetEpisodes"

        VideoLibrary_GetEpisodeDetails ->
            "VideoLibrary.GetEpisodeDetails"

        VideoLibrary_GetMusicVideos ->
            "VideoLibrary.GetMusicVideos"

        VideoLibrary_GetMusicVideoDetails ->
            "VideoLibrary.GetMusicVideoDetails"

        VideoLibrary_GetRecentlyAddedMovies ->
            "VideoLibrary.GetRecentlyAddedMovies"

        VideoLibrary_GetRecentlyAddedEpisodes ->
            "VideoLibrary.GetRecentlyAddedEpisodes"

        VideoLibrary_GetRecentlyAddedMusicVideos ->
            "VideoLibrary.GetRecentlyAddedMusicVideos"

        VideoLibrary_GetInProgressTVShows ->
            "VideoLibrary.GetInProgressTVShows"

        VideoLibrary_GetGenres ->
            "VideoLibrary.GetGenres"

        VideoLibrary_GetTags ->
            "VideoLibrary.GetTags"

        VideoLibrary_SetMovieDetails ->
            "VideoLibrary.SetMovieDetails"

        VideoLibrary_SetMovieSetDetails ->
            "VideoLibrary.SetMovieSetDetails"

        VideoLibrary_SetTVShowDetails ->
            "VideoLibrary.SetTVShowDetails"

        VideoLibrary_SetSeasonDetails ->
            "VideoLibrary.SetSeasonDetails"

        VideoLibrary_SetEpisodeDetails ->
            "VideoLibrary.SetEpisodeDetails"

        VideoLibrary_SetMusicVideoDetails ->
            "VideoLibrary.SetMusicVideoDetails"

        VideoLibrary_RefreshMovie ->
            "VideoLibrary.RefreshMovie"

        VideoLibrary_RefreshTVShow ->
            "VideoLibrary.RefreshTVShow"

        VideoLibrary_RefreshEpisode ->
            "VideoLibrary.RefreshEpisode"

        VideoLibrary_RefreshMusicVideo ->
            "VideoLibrary.RefreshMusicVideo"

        VideoLibrary_RemoveMovie ->
            "VideoLibrary.RemoveMovie"

        VideoLibrary_RemoveTVShow ->
            "VideoLibrary.RemoveTVShow"

        VideoLibrary_RemoveEpisode ->
            "VideoLibrary.RemoveEpisode"

        VideoLibrary_RemoveMusicVideo ->
            "VideoLibrary.RemoveMusicVideo"

        VideoLibrary_Scan ->
            "VideoLibrary.Scan"

        VideoLibrary_Export ->
            "VideoLibrary.Export"

        VideoLibrary_Clean ->
            "VideoLibrary.Clean"

        GUI_ActivateWindow ->
            "GUI.ActivateWindow"

        GUI_ShowNotification ->
            "GUI.ShowNotification"

        GUI_GetProperties ->
            "GUI.GetProperties"

        GUI_SetFullscreen ->
            "GUI.SetFullscreen"

        GUI_SetStereoscopicMode ->
            "GUI.SetStereoscopicMode"

        GUI_GetStereoscopicModes ->
            "GUI.GetStereoscopicModes"

        Addons_GetAddons ->
            "Addons.GetAddons"

        Addons_GetAddonDetails ->
            "Addons.GetAddonDetails"

        Addons_SetAddonEnabled ->
            "Addons.SetAddonEnabled"

        Addons_ExecuteAddon ->
            "Addons.ExecuteAddon"

        PVR_GetProperties ->
            "PVR.GetProperties"

        PVR_GetChannelGroups ->
            "PVR.GetChannelGroups"

        PVR_GetChannelGroupDetails ->
            "PVR.GetChannelGroupDetails"

        PVR_GetChannels ->
            "PVR.GetChannels"

        PVR_GetChannelDetails ->
            "PVR.GetChannelDetails"

        PVR_GetBroadcasts ->
            "PVR.GetBroadcasts"

        PVR_GetBroadcastDetails ->
            "PVR.GetBroadcastDetails"

        PVR_GetTimers ->
            "PVR.GetTimers"

        PVR_GetTimerDetails ->
            "PVR.GetTimerDetails"

        PVR_AddTimer ->
            "PVR.AddTimer"

        PVR_DeleteTimer ->
            "PVR.DeleteTimer"

        PVR_ToggleTimer ->
            "PVR.ToggleTimer"

        PVR_GetRecordings ->
            "PVR.GetRecordings"

        PVR_GetRecordingDetails ->
            "PVR.GetRecordingDetails"

        PVR_Record ->
            "PVR.Record"

        PVR_Scan ->
            "PVR.Scan"

        Textures_GetTextures ->
            "Textures.GetTextures"

        Textures_RemoveTexture ->
            "Textures.RemoveTexture"

        Profiles_GetProfiles ->
            "Profiles.GetProfiles"

        Profiles_GetCurrentProfile ->
            "Profiles.GetCurrentProfile"

        Profiles_LoadProfile ->
            "Profiles.LoadProfile"

        System_GetProperties ->
            "System.GetProperties"

        System_EjectOpticalDrive ->
            "System.EjectOpticalDrive"

        System_Shutdown ->
            "System.Shutdown"

        System_Suspend ->
            "System.Suspend"

        System_Hibernate ->
            "System.Hibernate"

        System_Reboot ->
            "System.Reboot"

        Input_SendText ->
            "Input.SendText"

        Input_ExecuteAction ->
            "Input.ExecuteAction"

        Input_ButtonEvent ->
            "Input.ButtonEvent"

        Input_Left ->
            "Input.Left"

        Input_Right ->
            "Input.Right"

        Input_Down ->
            "Input.Down"

        Input_Up ->
            "Input.Up"

        Input_Select ->
            "Input.Select"

        Input_Back ->
            "Input.Back"

        Input_ContextMenu ->
            "Input.ContextMenu"

        Input_Info ->
            "Input.Info"

        Input_Home ->
            "Input.Home"

        Input_ShowCodec ->
            "Input.ShowCodec"

        Input_ShowOSD ->
            "Input.ShowOSD"

        Input_ShowPlayerProcessInfo ->
            "Input.ShowPlayerProcessInfo"

        Application_GetProperties ->
            "Application.GetProperties"

        Application_SetVolume ->
            "Application.SetVolume"

        Application_SetMute ->
            "Application.SetMute"

        Application_Quit ->
            "Application.Quit"

        XBMC_GetInfoLabels ->
            "XBMC.GetInfoLabels"

        XBMC_GetInfoBooleans ->
            "XBMC.GetInfoBooleans"

        Favourites_GetFavourites ->
            "Favourites.GetFavourites"

        Favourites_AddFavourite ->
            "Favourites.AddFavourite"

        Settings_GetSections ->
            "Settings.GetSections"

        Settings_GetCategories ->
            "Settings.GetCategories"

        Settings_GetSettings ->
            "Settings.GetSettings"

        Settings_GetSettingValue ->
            "Settings.GetSettingValue"

        Settings_SetSettingValue ->
            "Settings.SetSettingValue"

        Settings_ResetSettingValue ->
            "Settings.ResetSettingValue"


strToMethod : String -> Method
strToMethod str =
    case str of
        "JSONRPC.Introspect" ->
            JSONRPC_Introspect

        "JSONRPC.Version" ->
            JSONRPC_Version

        "JSONRPC.Permission" ->
            JSONRPC_Permission

        "JSONRPC.Ping" ->
            JSONRPC_Ping

        "JSONRPC.GetConfiguration" ->
            JSONRPC_GetConfiguration

        "JSONRPC.SetConfiguration" ->
            JSONRPC_SetConfiguration

        "JSONRPC.NotifyAll" ->
            JSONRPC_NotifyAll

        "Player.Open" ->
            Player_Open

        "Player.GetActivePlayers" ->
            Player_GetActivePlayers

        "Player.GetPlayers" ->
            Player_GetPlayers

        "Player.GetProperties" ->
            Player_GetProperties

        "Player.GetItem" ->
            Player_GetItem

        "Player.PlayPause" ->
            Player_PlayPause

        "Player.Stop" ->
            Player_Stop

        "Player.SetSpeed" ->
            Player_SetSpeed

        "Player.Seek" ->
            Player_Seek

        "Player.Move" ->
            Player_Move

        "Player.Zoom" ->
            Player_Zoom

        "Player.SetViewMode" ->
            Player_SetViewMode

        "Player.GetViewMode" ->
            Player_GetViewMode

        "Player.Rotate" ->
            Player_Rotate

        "Player.GoTo" ->
            Player_GoTo

        "Player.SetShuffle" ->
            Player_SetShuffle

        "Player.SetRepeat" ->
            Player_SetRepeat

        "Player.SetPartymode" ->
            Player_SetPartymode

        "Player.SetAudioStream" ->
            Player_SetAudioStream

        "Player.SetVideoStream" ->
            Player_SetVideoStream

        "Player.SetSubtitle" ->
            Player_SetSubtitle

        "Playlist.GetPlaylists" ->
            Playlist_GetPlaylists

        "Playlist.GetProperties" ->
            Playlist_GetProperties

        "Playlist.GetItems" ->
            Playlist_GetItems

        "Playlist.Add" ->
            Playlist_Add

        "Playlist.Insert" ->
            Playlist_Insert

        "Playlist.Remove" ->
            Playlist_Remove

        "Playlist.Clear" ->
            Playlist_Clear

        "Playlist.Swap" ->
            Playlist_Swap

        "Files.GetSources" ->
            Files_GetSources

        "Files.PrepareDownload" ->
            Files_PrepareDownload

        "Files.Download" ->
            Files_Download

        "Files.GetDirectory" ->
            Files_GetDirectory

        "Files.GetFileDetails" ->
            Files_GetFileDetails

        "Files.SetFileDetails" ->
            Files_SetFileDetails

        "AudioLibrary.GetProperties" ->
            AudioLibrary_GetProperties

        "AudioLibrary.GetArtists" ->
            AudioLibrary_GetArtists

        "AudioLibrary.GetArtistDetails" ->
            AudioLibrary_GetArtistDetails

        "AudioLibrary.GetAlbums" ->
            AudioLibrary_GetAlbums

        "AudioLibrary.GetAlbumDetails" ->
            AudioLibrary_GetAlbumDetails

        "AudioLibrary.GetSongs" ->
            AudioLibrary_GetSongs

        "AudioLibrary.GetSongDetails" ->
            AudioLibrary_GetSongDetails

        "AudioLibrary.GetRecentlyAddedAlbums" ->
            AudioLibrary_GetRecentlyAddedAlbums

        "AudioLibrary.GetRecentlyAddedSongs" ->
            AudioLibrary_GetRecentlyAddedSongs

        "AudioLibrary.GetRecentlyPlayedAlbums" ->
            AudioLibrary_GetRecentlyPlayedAlbums

        "AudioLibrary.GetRecentlyPlayedSongs" ->
            AudioLibrary_GetRecentlyPlayedSongs

        "AudioLibrary.GetGenres" ->
            AudioLibrary_GetGenres

        "AudioLibrary.GetSources" ->
            AudioLibrary_GetSources

        "AudioLibrary.GetRoles" ->
            AudioLibrary_GetRoles

        "AudioLibrary.SetArtistDetails" ->
            AudioLibrary_SetArtistDetails

        "AudioLibrary.SetAlbumDetails" ->
            AudioLibrary_SetAlbumDetails

        "AudioLibrary.SetSongDetails" ->
            AudioLibrary_SetSongDetails

        "AudioLibrary.Scan" ->
            AudioLibrary_Scan

        "AudioLibrary.Export" ->
            AudioLibrary_Export

        "AudioLibrary.Clean" ->
            AudioLibrary_Clean

        "VideoLibrary.GetMovies" ->
            VideoLibrary_GetMovies

        "VideoLibrary.GetMovieDetails" ->
            VideoLibrary_GetMovieDetails

        "VideoLibrary.GetMovieSets" ->
            VideoLibrary_GetMovieSets

        "VideoLibrary.GetMovieSetDetails" ->
            VideoLibrary_GetMovieSetDetails

        "VideoLibrary.GetTVShows" ->
            VideoLibrary_GetTVShows

        "VideoLibrary.GetTVShowDetails" ->
            VideoLibrary_GetTVShowDetails

        "VideoLibrary.GetSeasons" ->
            VideoLibrary_GetSeasons

        "VideoLibrary.GetSeasonDetails" ->
            VideoLibrary_GetSeasonDetails

        "VideoLibrary.GetEpisodes" ->
            VideoLibrary_GetEpisodes

        "VideoLibrary.GetEpisodeDetails" ->
            VideoLibrary_GetEpisodeDetails

        "VideoLibrary.GetMusicVideos" ->
            VideoLibrary_GetMusicVideos

        "VideoLibrary.GetMusicVideoDetails" ->
            VideoLibrary_GetMusicVideoDetails

        "VideoLibrary.GetRecentlyAddedMovies" ->
            VideoLibrary_GetRecentlyAddedMovies

        "VideoLibrary.GetRecentlyAddedEpisodes" ->
            VideoLibrary_GetRecentlyAddedEpisodes

        "VideoLibrary.GetRecentlyAddedMusicVideos" ->
            VideoLibrary_GetRecentlyAddedMusicVideos

        "VideoLibrary.GetInProgressTVShows" ->
            VideoLibrary_GetInProgressTVShows

        "VideoLibrary.GetGenres" ->
            VideoLibrary_GetGenres

        "VideoLibrary.GetTags" ->
            VideoLibrary_GetTags

        "VideoLibrary.SetMovieDetails" ->
            VideoLibrary_SetMovieDetails

        "VideoLibrary.SetMovieSetDetails" ->
            VideoLibrary_SetMovieSetDetails

        "VideoLibrary.SetTVShowDetails" ->
            VideoLibrary_SetTVShowDetails

        "VideoLibrary.SetSeasonDetails" ->
            VideoLibrary_SetSeasonDetails

        "VideoLibrary.SetEpisodeDetails" ->
            VideoLibrary_SetEpisodeDetails

        "VideoLibrary.SetMusicVideoDetails" ->
            VideoLibrary_SetMusicVideoDetails

        "VideoLibrary.RefreshMovie" ->
            VideoLibrary_RefreshMovie

        "VideoLibrary.RefreshTVShow" ->
            VideoLibrary_RefreshTVShow

        "VideoLibrary.RefreshEpisode" ->
            VideoLibrary_RefreshEpisode

        "VideoLibrary.RefreshMusicVideo" ->
            VideoLibrary_RefreshMusicVideo

        "VideoLibrary.RemoveMovie" ->
            VideoLibrary_RemoveMovie

        "VideoLibrary.RemoveTVShow" ->
            VideoLibrary_RemoveTVShow

        "VideoLibrary.RemoveEpisode" ->
            VideoLibrary_RemoveEpisode

        "VideoLibrary.RemoveMusicVideo" ->
            VideoLibrary_RemoveMusicVideo

        "VideoLibrary.Scan" ->
            VideoLibrary_Scan

        "VideoLibrary.Export" ->
            VideoLibrary_Export

        "VideoLibrary.Clean" ->
            VideoLibrary_Clean

        "GUI.ActivateWindow" ->
            GUI_ActivateWindow

        "GUI.ShowNotification" ->
            GUI_ShowNotification

        "GUI.GetProperties" ->
            GUI_GetProperties

        "GUI.SetFullscreen" ->
            GUI_SetFullscreen

        "GUI.SetStereoscopicMode" ->
            GUI_SetStereoscopicMode

        "GUI.GetStereoscopicModes" ->
            GUI_GetStereoscopicModes

        "Addons.GetAddons" ->
            Addons_GetAddons

        "Addons.GetAddonDetails" ->
            Addons_GetAddonDetails

        "Addons.SetAddonEnabled" ->
            Addons_SetAddonEnabled

        "Addons.ExecuteAddon" ->
            Addons_ExecuteAddon

        "PVR.GetProperties" ->
            PVR_GetProperties

        "PVR.GetChannelGroups" ->
            PVR_GetChannelGroups

        "PVR.GetChannelGroupDetails" ->
            PVR_GetChannelGroupDetails

        "PVR.GetChannels" ->
            PVR_GetChannels

        "PVR.GetChannelDetails" ->
            PVR_GetChannelDetails

        "PVR.GetBroadcasts" ->
            PVR_GetBroadcasts

        "PVR.GetBroadcastDetails" ->
            PVR_GetBroadcastDetails

        "PVR.GetTimers" ->
            PVR_GetTimers

        "PVR.GetTimerDetails" ->
            PVR_GetTimerDetails

        "PVR.AddTimer" ->
            PVR_AddTimer

        "PVR.DeleteTimer" ->
            PVR_DeleteTimer

        "PVR.ToggleTimer" ->
            PVR_ToggleTimer

        "PVR.GetRecordings" ->
            PVR_GetRecordings

        "PVR.GetRecordingDetails" ->
            PVR_GetRecordingDetails

        "PVR.Record" ->
            PVR_Record

        "PVR.Scan" ->
            PVR_Scan

        "Textures.GetTextures" ->
            Textures_GetTextures

        "Textures.RemoveTexture" ->
            Textures_RemoveTexture

        "Profiles.GetProfiles" ->
            Profiles_GetProfiles

        "Profiles.GetCurrentProfile" ->
            Profiles_GetCurrentProfile

        "Profiles.LoadProfile" ->
            Profiles_LoadProfile

        "System.GetProperties" ->
            System_GetProperties

        "System.EjectOpticalDrive" ->
            System_EjectOpticalDrive

        "System.Shutdown" ->
            System_Shutdown

        "System.Suspend" ->
            System_Suspend

        "System.Hibernate" ->
            System_Hibernate

        "System.Reboot" ->
            System_Reboot

        "Input.SendText" ->
            Input_SendText

        "Input.ExecuteAction" ->
            Input_ExecuteAction

        "Input.ButtonEvent" ->
            Input_ButtonEvent

        "Input.Left" ->
            Input_Left

        "Input.Right" ->
            Input_Right

        "Input.Down" ->
            Input_Down

        "Input.Up" ->
            Input_Up

        "Input.Select" ->
            Input_Select

        "Input.Back" ->
            Input_Back

        "Input.ContextMenu" ->
            Input_ContextMenu

        "Input.Info" ->
            Input_Info

        "Input.Home" ->
            Input_Home

        "Input.ShowCodec" ->
            Input_ShowCodec

        "Input.ShowOSD" ->
            Input_ShowOSD

        "Input.ShowPlayerProcessInfo" ->
            Input_ShowPlayerProcessInfo

        "Application.GetProperties" ->
            Application_GetProperties

        "Application.SetVolume" ->
            Application_SetVolume

        "Application.SetMute" ->
            Application_SetMute

        "Application.Quit" ->
            Application_Quit

        "XBMC.GetInfoLabels" ->
            XBMC_GetInfoLabels

        "XBMC.GetInfoBooleans" ->
            XBMC_GetInfoBooleans

        "Favourites.GetFavourites" ->
            Favourites_GetFavourites

        "Favourites.AddFavourite" ->
            Favourites_AddFavourite

        "Settings.GetSections" ->
            Settings_GetSections

        "Settings.GetCategories" ->
            Settings_GetCategories

        "Settings.GetSettings" ->
            Settings_GetSettings

        "Settings.GetSettingValue" ->
            Settings_GetSettingValue

        "Settings.SetSettingValue" ->
            Settings_SetSettingValue

        "Settings.ResetSettingValue" ->
            Settings_ResetSettingValue

        _ ->
            JSONRPC_Introspect
