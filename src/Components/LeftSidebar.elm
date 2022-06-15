module Components.LeftSidebar exposing (view)

import Colors
import Components.LayoutType exposing (LeftSidebarControl, ShowRightSidebarMenu)
import Element exposing (..)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Html.Attributes
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import SharedType exposing (..)
import Spa.Generated.Route as Route exposing (Route)
import WSDecoder exposing (LeftSidebarMenuHover(..))


view : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
view showRightSidebarMenu leftSidebarControl =
    column [ height fill, centerX, alignLeft, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
        [ el [ height (px 20) ] (text "")
        , musicButton showRightSidebarMenu leftSidebarControl
        , movieButton showRightSidebarMenu leftSidebarControl
        , tvshowButton showRightSidebarMenu leftSidebarControl
        , browserButton showRightSidebarMenu leftSidebarControl
        , addonsButton showRightSidebarMenu leftSidebarControl
        , thumbsupButton showRightSidebarMenu leftSidebarControl
        , playlistButton showRightSidebarMenu leftSidebarControl
        , settingsButton showRightSidebarMenu leftSidebarControl
        , helpButton showRightSidebarMenu leftSidebarControl
        ]


materialIconLink : ShowRightSidebarMenu msg -> LeftSidebarMenuHover -> msg -> msg -> LeftSidebarMenuHover -> String -> Icon msg -> Route -> Element msg
materialIconLink { tabSwitch } elementHover elementHoverMsg elementLeaveMsg iconHoverName name icon route =
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
                [ case tabSwitch of
                    Kodi ->
                        Background.color Colors.brandPrimary

                    Local ->
                        Background.color Colors.ceriseRed
                , Font.color (rgb255 255 255 255)
                , padding 8
                ]

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


musicButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
musicButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarMusicHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Music leftSidebarControl.leftSidebarMusicTranslation Filled.library_music Route.Music


movieButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
movieButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarMoviesHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Movies leftSidebarControl.leftSidebarMoviesTranslation Filled.movie Route.Movies__Recent


tvshowButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
tvshowButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarTVShowHoverMsg leftSidebarControl.leftSidebarNotHoverMsg TVShow leftSidebarControl.leftSidebarTVShowTranslation Filled.tv Route.Tvshows__Recent


browserButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
browserButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarBrowserHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Browser leftSidebarControl.leftSidebarBrowserTranslation Filled.list Route.Browser


addonsButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
addonsButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarAddonsHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Addons leftSidebarControl.leftSidebarAddonsTranslation Filled.extension Route.Addons


thumbsupButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
thumbsupButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarThumbsUpHoverMsg leftSidebarControl.leftSidebarNotHoverMsg ThumbsUp leftSidebarControl.leftSidebarThumbsUpTranslation Filled.thumb_up Route.Thumbsup


playlistButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
playlistButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarPlaylistHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Playlist leftSidebarControl.leftSidebarPlaylistTranslation Filled.assignment Route.Playlists


settingsButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
settingsButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarSettingsHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Settings leftSidebarControl.leftSidebarSettingsTranslation Filled.settings Route.Settings__Web


helpButton : ShowRightSidebarMenu msg -> LeftSidebarControl msg -> Element msg
helpButton showRightSidebarMenu leftSidebarControl =
    materialIconLink showRightSidebarMenu leftSidebarControl.leftSidebarMenuHover leftSidebarControl.leftSidebarHelpHoverMsg leftSidebarControl.leftSidebarNotHoverMsg Help leftSidebarControl.leftSidebarHelpTranslation Filled.help Route.Help__About
