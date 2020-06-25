{- Action stuff -}


module Action exposing (Namespace(..), Method(..), Param(..))

type alias Optional =
    { null : Bool
    , bool : Bool
    , int : Int
    , str : String
    }

type alias Array =
    { string : List String
    , int : List Int
    }

type alias Time =
    { hours : Int
    , minutes : Int 
    , seconds : Int 
    , milliseconds : Int
    }

type Weekday 
    = Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday

type IncrementDecrement
    = Increment 
    | Decrement

type alias Global =
    { time : Time
    , weekday : Weekday
    , incrementDecrement : IncrementDecrement
    , toggle : Bool
    }

type MediaType
    = Video 
    | Music 
    | Pictures 
    | Files 
    | Programs
    
type alias Files =
    { media : MediaType }

-------- old stuff
type Filter
    = GenreID 
    | Genre 
    | ArtistID
    | RoleID
    | Role

type alias Limits =
    { start : Int 
    , end : Int 
    }

type Addon_Content
    = Unknown
    | Video
    | Audio 
    | Image 
    | Executable

type alias Addon_Details =
    { addonid : String
    , author : String
    , dependencies : List String
    }
    

type alias Action =
    { namespace : Namespace
    , method : Method
    , params : List Param
    , properties : List String
    , limits : Limits
    , sort: List String
    , filter: List String }

type Param
    = Analogfastforward
    | Analogmove
    | Analogmovexleft
    | Analogmovexright
    | Analogmoveydown
    | Analogmoveyup
    | Analogrewind
    | Analogseekback
    | Analogseekforward
    | Aspectratio
    | Audiodelay
    | Audiodelayminus
    | Audiodelayplus
    | Audionextlanguage
    | Audiotoggledigital
    | Back_ -- renamed for method
    | Backspace
    | Bigstepback
    | Bigstepforward
    | Blue
    | Browsesubtitle
    | Channeldown
    | Channelnumberseparator
    | Channelup
    | Chapterorbigstepback
    | Chapterorbigstepforward
    | Close
    | Codecinfo
    | Contextmenu
    | Copy
    | Createbookmark
    | Createepisodebookmark
    | Cursorleft
    | Cursorright
    | Cyclesubtitle
    | Decreasepar
    | Decreaserating
    | Decreasevisrating
    | Delete
    | Doubleclick
    | Down_ -- renamed for method
    | Enter
    | Error
    | Fastforward
    | Filter
    | Filterclear
    | Filtersms2
    | Filtersms3
    | Filtersms4
    | Filtersms5
    | Filtersms6
    | Filtersms7
    | Filtersms8
    | Filtersms9
    | Firstpage
    | Fullscreen
    | Green
    | Guiprofile
    | Highlight
    | Increasepar
    | Increaserating
    | Increasevisrating
    | Info_ -- renamed for method
    | Jumpsms2
    | Jumpsms3
    | Jumpsms4
    | Jumpsms5
    | Jumpsms6
    | Jumpsms7
    | Jumpsms8
    | Jumpsms9
    | Lastpage
    | Left_ -- renamed for method
    | Leftclick
    | Lockpreset
    | Longclick
    | Longpress
    | Menu
    | Middleclick
    | Mousedrag
    | Mousedragend
    | Mousemove
    | Move_ -- renamed for method
    | Moveitemdown
    | Moveitemup
    | Mute
    | Nextcalibration
    | Nextchannelgroup
    | Nextletter
    | Nextpicture
    | Nextpreset
    | Nextresolution
    | Nextscene
    | Nextstereomode
    | Nextsubtitle
    | Noop
    | Number0
    | Number1
    | Number2
    | Number3
    | Number4
    | Number5
    | Number6
    | Number7
    | Number8
    | Number9
    | Osd
    | Pagedown
    | Pageup
    | Pangesture
    | Parentdir
    | Parentfolder
    | Pause
    | Play
    | Playerdebug
    | Playerprocessinfo
    | Playerprogramselect
    | Playerresolutionselect
    | Playlist_ -- renamed Playlist to avoid collision with namespace
    | Playnext
    | Playpause
    | Playpvr
    | Playpvrradio
    | Playpvrtv
    | Previouschannelgroup
    | Previousmenu
    | Previouspicture
    | Previouspreset
    | Previousscene
    | Previousstereomode
    | Prevletter
    | Queue
    | Randompreset
    | Record_ -- renamed for method
    | Red
    | Reloadkeymaps
    | Rename
    | Resetcalibration
    | Rewind
    | Right_ -- renamed for method
    | Rightclick
    | Rotate_ -- renamed for method
    | Rotateccw
    | Rotategesture
    | Scanitem
    | Screenshot
    | Scrolldown
    | Scrollup
    | Select_ -- renamed for method 
    | Setrating
    | Settingslevelchange
    | Settingsreset
    | Shift
    | Showpreset
    | Showsubtitles
    | Showtime
    | Showtimerrule
    | Showvideomenu
    | Skipnext
    | Skipprevious
    | Smallstepback
    | Stepback
    | Stepforward
    | Stereomode
    | Stereomodetomono
    | Stop_ -- renamed for method
    | Subtitlealign
    | Subtitledelay
    | Subtitledelayminus
    | Subtitledelayplus
    | Subtitleshiftdown
    | Subtitleshiftup
    | Swipedown
    | Swipeleft
    | Swiperight
    | Swipeup
    | Switchplayer
    | Symbols
    | Tap
    | Togglecommskip
    | Togglefont
    | Togglefullscreen
    | Togglestereomode
    | Togglewatched
    | Up_ -- renamed for method
    | Verticalshiftdown
    | Verticalshiftup
    | Videonextstream
    | Voicerecognizer
    | Volampdown
    | Volampup
    | Volumeamplification
    | Volumedown
    | Volumeup
    | Wheeldown
    | Wheelup
    | Yellow
    | Zoomgesture
    | Zoomin
    | Zoomlevel1
    | Zoomlevel2
    | Zoomlevel3
    | Zoomlevel4
    | Zoomlevel5
    | Zoomlevel6
    | Zoomlevel7
    | Zoomlevel8
    | Zoomlevel9
    | Zoomnormal
    | Zoomout
    -- Player params
    | Shuffle
    | Cycle
    | One
    -- Application Properties
    | Volume 
    | Muted
    | Name
    | Version_
    | Sorttokens
    | Language

type Method
    = ExecuteAddon -- Addons
    | GetAddonDetails
    | GetAddons 
    | SetAddonEnabled
    | GetProperties -- Application
    | Quit
    | SetMute
    | SetVolume
    | Clean -- Audio Library
    | Export
    | GetAlbumDetails
    | GetAlbums 
    | GetArtistDetails
    | GetArtists 
    | GetGenres
    | GetRecentlyAddedAlbums
    | GetRecentlyAddedSongs
    | GetRecentlyPlayedAlbums
    | GetRecentlyPlayedSongs
    | GetRoles
    | GetSongDetails
    | GetSongs 
    | GetSources
    | Scan
    | SetAlbumDetails
    | SetArtistDetails
    | SetSongDetails
    | AddFavourite -- Favourites
    | GetFavourites
    | Download -- Files
    | GetDirectory
    | GetFileDetails
    | PrepareDownload
    | SetFileDetails
    | ActivateWindow -- GUI
    | GetStereoscopicModes
    | SetFullscreen
    | SetStereoscopicMode
    | ShowNotification
    | Back -- Input
    | ButtonEvent
    | ContextMenu
    | Down
    | ExecuteAction
    | Home
    | Info
    | Left
    | Right
    | Select
    | SendText
    | ShowCodec
    | ShowOSD
    | ShowPlayerProcessInfo
    | Up
    | GetConfiguration -- JSONRPC
    | Introspect
    | NotifyAll
    | Permission
    | Ping
    | SetConfiguration
    | Version 
    | AddTimer -- PVR
    | DeleteTimer
    | GetBroadcastDetails
    | GetBroadcasts 
    | GetChannelDetails
    | GetChannelGroupDetails
    | GetChannelGroups 
    | GetChannels 
    | GetRecordingDetails
    | GetRecordings 
    | GetTimerDetails
    | GetTimers 
    | Record
    | ToggleTimer
    | GetActivePlayers -- Player
    | GetItem
    | GetPlayers 
    | GetViewMode
    | GoTo
    | Move
    | Open
    | PlayPause
    | Rotate
    | Seek
    | SetAudioStream
    | SetPartyMode
    | SetRepeat
    | SetShuffle
    | SetSpeed
    | SetSubtitle
    | SetVideoStream
    | SetViewMode
    | Stop
    | Zoom 
    | Add -- Playlist
    | Clear 
    | GetItems
    | GetPlaylists
    | Insert 
    | Remove 
    | Swap 
    | GetCurrentProfile -- Profiles
    | GetProfiles
    | LoadProfile
    | GetCategories -- Settings
    | GetSections
    | GetSettingValue
    | GetSettings
    | ResetSettingValue
    | SetSettingValue
    | EjectOpticalDrive -- System
    | Hibernate
    | Reboot
    | Shutdown 
    | Suspend
    | GetTextures -- Textures
    | RemoveTexture
    | GetEpisodeDetails -- VideoLibrary
    | GetEpisodes 
    | GetInProgressTVShows
    | GetMovieDetails
    | GetMovieSetDetails
    | GetMovieSets 
    | GetMovies 
    | GetMusicVideoDetails
    | GetMusicVideos 
    | GetRecentlyAddedEpisodes
    | GetRecentlyAddedMovies
    | GetRecentlyAddedMusicVideos
    | GetSeasonDetails
    | GetSeasons 
    | GetTVShowDetails
    | GetTVShows 
    | GetTags 
    | RefreshEpisode
    | RefreshMovie
    | RefreshMusicVideo
    | RefreshTVShow
    | RemoveEpisode
    | RemoveMovie
    | RemoveMusicVideo
    | RemoveTVShow
    | SetEpisodeDetails
    | SetMovieDetails
    | SetMovieSetDetails
    | SetMusicVideoDetails
    | SetSeasonDetails
    | SetTVShowDetails
    | GetInfoBooleans -- XBMC
    | GetInfoLabels

type Namespace
    = Addons
    | Application
    | AudioLibrary
    | Favourites
    | Files
    | GUI
    | Input
    | JSONRPC
    | PVR
    | Player
    | Playlist
    | Profiles
    | Settings
    | System
    | Textures
    | VideoLibrary
    | XBMC
