module Components.LeftSidebar exposing (view)

import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Events as Events
import Html.Attributes
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Spa.Generated.Route as Route exposing (Route)
import Components.LayoutType exposing (LeftSidebarControl)


view : LeftSidebarControl msg -> Element msg
view  leftSidebarControl =
    column [ height fill, centerX, alignLeft, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
        [ el [height (px 20)] (text "" )
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


materialIconLink : Bool -> msg -> msg -> String -> Icon msg -> Route -> Element msg
materialIconLink  elementHover elementHoverMsg elementLeaveMsg name icon route =
    let
      leftSidebarIcon =
        case elementHover of
            True ->
                row[]
                [el [paddingXY 7 0] (Element.html (icon 20 Inherit))
                , el [paddingXY 5 0, Font.size 14] (text name)
                ]

            False ->
                el [paddingXY 7 0] (Element.html (icon 20 Inherit))

      leftSidebarIconStyle =
        case elementHover of
          True ->
            [Background.color Colors.brandPrimary, Font.color (rgb255 255 255 255), padding 8]

          False ->
            [Font.color (rgb255 0 0 0), padding 8]
    in
    el []

        (Element.link (Events.onMouseEnter elementHoverMsg
              :: Events.onMouseLeave elementLeaveMsg
              :: leftSidebarIconStyle)
            { url = Route.toString route
            , label = leftSidebarIcon
            }
        )



-- buttons


musicButton : LeftSidebarControl msg -> Element msg
musicButton leftSidebarControl =
    materialIconLink leftSidebarControl.musicHover leftSidebarControl.musicHoverMsg leftSidebarControl.musicLeaveMsg "Music" Filled.library_music Route.Music


movieButton : LeftSidebarControl msg -> Element msg
movieButton leftSidebarControl =
    materialIconLink leftSidebarControl.moviesHover leftSidebarControl.moviesHoverMsg leftSidebarControl.moviesLeaveMsg "Movies" Filled.movie Route.Movies__Recent


tvshowButton : LeftSidebarControl msg -> Element msg
tvshowButton leftSidebarControl =
    materialIconLink leftSidebarControl.tvshowHover leftSidebarControl.tvshowHoverMsg leftSidebarControl.tvshowLeaveMsg "TV shows" Filled.tv Route.Tvshows__Recent


browserButton : LeftSidebarControl msg -> Element msg
browserButton leftSidebarControl =
    materialIconLink leftSidebarControl.browserHover leftSidebarControl.browserHoverMsg leftSidebarControl.browserLeaveMsg "Browser" Filled.list Route.Browser


addonsButton : LeftSidebarControl msg -> Element msg
addonsButton leftSidebarControl =
    materialIconLink leftSidebarControl.addonsHover leftSidebarControl.addonsHoverMsg leftSidebarControl.addonsLeaveMsg "Add-ons" Filled.extension Route.Addons


thumbsupButton : LeftSidebarControl msg -> Element msg
thumbsupButton leftSidebarControl =
    materialIconLink leftSidebarControl.thumbsupHover leftSidebarControl.thumbsupHoverMsg leftSidebarControl.thumbsupLeaveMsg "Thumbs up" Filled.thumb_up Route.Thumbsup


playlistButton : LeftSidebarControl msg -> Element msg
playlistButton leftSidebarControl =
    materialIconLink leftSidebarControl.playlistHover leftSidebarControl.playlistHoverMsg leftSidebarControl.playlistLeaveMsg "Playlists" Filled.assignment Route.Playlists


settingsButton : LeftSidebarControl msg -> Element msg
settingsButton leftSidebarControl =
    materialIconLink leftSidebarControl.settingsHover leftSidebarControl.settingsHoverMsg leftSidebarControl.settingsLeaveMsg "Settings" Filled.settings Route.Settings__Web


helpButton : LeftSidebarControl msg -> Element msg
helpButton leftSidebarControl =
    materialIconLink leftSidebarControl.helpHover leftSidebarControl.helpHoverMsg leftSidebarControl.helpLeaveMsg "Help" Filled.help Route.Help
