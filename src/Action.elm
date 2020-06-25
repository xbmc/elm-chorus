{- Action stuff -}


module Action exposing (Method(..), methodToStr)


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
