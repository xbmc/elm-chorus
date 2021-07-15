module Components.LeftSidebar exposing (view)

import Colors
import Components.LayoutType exposing (LeftSidebarControl)
import Element exposing (..)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Html.Attributes
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Spa.Generated.Route as Route exposing (Route)
import WSDecoder exposing (LeftSidebarMenuHover(..))


view : LeftSidebarControl msg -> Element msg
view leftSidebarControl =
    column [ height fill, centerX, alignLeft, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
        [ el [ height (px 20) ] (text "")
        , musicButton leftSidebarControl
        , movieButton leftSidebarControl
        , tvshowButton leftSidebarControl
        , browserButton leftSidebarControl
        , addonsButton leftSidebarControl
        , thumbsupButton leftSidebarControl
        , playlistButton leftSidebarControl
        , settingsButton leftSidebarControl
        , helpButton leftSidebarControl
        ]


materialIconLink : LeftSidebarMenuHover -> msg -> msg -> LeftSidebarMenuHover -> String -> Icon msg -> Route -> Element msg
materialIconLink elementHover elementHoverMsg elementLeaveMsg iconHoverName name icon route =
    let
        leftSidebarIcon =
            if elementHover == iconHoverName then
                row []
                    [ el [ paddingXY 7 0 ] (Element.html (icon 20 Inherit))
                    , el [ paddingXY 5 0, Font.size 14 ] (text name)
                    ]

            else
                el [ paddingXY 7 0 ] (Element.html (icon 20 Inherit))

        leftSidebarIconStyle =
            if elementHover == iconHoverName then
                [ Background.color Colors.brandPrimary, Font.color (rgb255 255 255 255), padding 8 ]

            else
                [ Font.color (rgb255 0 0 0), padding 8 ]
    in
    el []
        (Element.link
            (Events.onMouseEnter elementHoverMsg
                :: Events.onMouseLeave elementLeaveMsg
                :: leftSidebarIconStyle
            )
            { url = Route.toString route
            , label = leftSidebarIcon
            }
        )



-- buttons


musicButton : LeftSidebarControl msg -> Element msg
musicButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarMusicHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Music "Music" Filled.library_music Route.Music


movieButton : LeftSidebarControl msg -> Element msg
movieButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarMoviesHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Movies "Movies" Filled.movie Route.Movies__Recent


tvshowButton : LeftSidebarControl msg -> Element msg
tvshowButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarTVShowHoverMsg leftSidebarControl.leftSidebarNotHoverMsg TVShow "TV shows" Filled.tv Route.Tvshows__Recent


browserButton : LeftSidebarControl msg -> Element msg
browserButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarBrowserHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Browser "Browser" Filled.list Route.Browser


addonsButton : LeftSidebarControl msg -> Element msg
addonsButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarAddonsHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Addons "Add-ons" Filled.extension Route.Addons


thumbsupButton : LeftSidebarControl msg -> Element msg
thumbsupButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarThumbsUpHoverMsg leftSidebarControl.leftSidebarNotHoverMsg ThumbsUp "Thumbs up" Filled.thumb_up Route.Thumbsup


playlistButton : LeftSidebarControl msg -> Element msg
playlistButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarPlaylistHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Playlist "Playlists" Filled.assignment Route.Playlists


settingsButton : LeftSidebarControl msg -> Element msg
settingsButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarSettingsHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Settings "Settings" Filled.settings Route.Settings__Web


helpButton : LeftSidebarControl msg -> Element msg
helpButton leftSidebarControl =
    materialIconLink leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarHelpHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Help "Help" Filled.help Route.Help
