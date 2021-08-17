module Components.LayoutType exposing (ControlMenu, CurrentlyPlaying, DialogType(..), LayoutType, LeftSidebarControl, PlayerControl, ShowRightSidebarMenu, VolumeAndControls)

import Element exposing (Element)
import Spa.Document exposing (Document)
import WSDecoder exposing (Connection, ItemDetails, LeftSidebarMenuHover)


type alias LayoutType msg =
    { page : Document msg
    , controlMenu : ControlMenu msg
    , leftSidebarControl : LeftSidebarControl msg
    , showRightSidebarMenu : ShowRightSidebarMenu msg
    , playerControl : PlayerControl msg
    , currentlyPlaying : CurrentlyPlaying msg
    , volumeAndControls : VolumeAndControls msg
    , rightSidebarExtended : Bool
    , rightSidebarMsg : msg
    , connection : Connection
    , windowHeight : Int
    , searchChanged : String -> msg
    , dialogBox : DialogBox msg
    }


type alias PlayerControl msg =
    { playPauseMsg : msg
    , skipMsg : msg
    , reverseMsg : msg
    , playing : Bool
    }


type alias CurrentlyPlaying msg =
    { currentlyPlaying : Maybe ItemDetails
    , progressSlider : Element msg
    }


type alias VolumeAndControls msg =
    { muteMsg : msg
    , repeatMsg : msg
    , shuffleMsg : msg
    , volumeSlider : Element msg
    }


type alias LeftSidebarControl msg =
    { leftSidebarMenuHover : LeftSidebarMenuHover
    , leftSidebarMusicHoverMsg : msg
    , leftSidebarMoviesHoverMsg : msg
    , leftSidebarTVShowHoverMsg : msg
    , leftSidebarAddonsHoverMsg : msg
    , leftSidebarPlaylistHoverMsg : msg
    , leftSidebarBrowserHoverMsg : msg
    , leftSidebarSettingsHoverMsg : msg
    , leftSidebarThumbsUpHoverMsg : msg
    , leftSidebarHelpHoverMsg : msg
    , leftSidebarNotHoverMsg : msg
    }


type alias ControlMenu msg =
    { controlMenu : Bool
    , controlMenuMsg : msg
    , sendTextToKodiMsg : msg
    , scanVideoLibraryMsg : msg
    , scanMusicLibraryMsg : msg
    }


type alias ShowRightSidebarMenu msg =
    { showRightSidebarMenu : Bool
    , showRightSidebarMenuMsg : msg
    }


type alias DialogBox msg =
    { showDialog : DialogType
    , attemptReconnectionMsg : msg
    , closeDialogMsg : msg
    , textChangeMsg : String -> msg
    , playlistName : String
    }


type DialogType
    = ConnectionDialog
    | TextInputDialog
    | None
