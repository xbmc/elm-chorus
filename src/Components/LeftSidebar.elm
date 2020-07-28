module Components.LeftSidebar exposing (view)

import Element exposing (..)
import Element.Background as Background
import Material.Icons as Filled
import Material.Icons.Types exposing (Coloring(..), Icon)
import Spa.Generated.Route as Route exposing (Route)


view : Element msg
view =
    column [ height fill, Background.color (rgb 0.9 0.9 0.9), spacing 30, paddingXY 10 20, alignLeft ]
        [ musicButton
        , movieButton
        , tvshowButton
        , browserButton
        , addonsButton
        , thumbsupButton
        , playlistButton
        , settingsButton
        , helpButton
        ]


materialIconLink : ( Icon msg, Route ) -> Element msg
materialIconLink ( icon, route ) =
    el
        [ Element.mouseOver
            [ scale 1.1
            , Background.color (rgb255 25 180 228)
            ]
        ]
    <|
        Element.link []
            { url = Route.toString route
            , label = Element.html (icon 24 Inherit)
            }



-- buttons


musicButton : Element msg
musicButton =
    materialIconLink ( Filled.library_music, Route.Music )


movieButton : Element msg
movieButton =
    materialIconLink ( Filled.movie, Route.Movies )


tvshowButton : Element msg
tvshowButton =
    materialIconLink ( Filled.tv, Route.Tvshows )


browserButton : Element msg
browserButton =
    materialIconLink ( Filled.menu, Route.Browser )


addonsButton : Element msg
addonsButton =
    materialIconLink ( Filled.extension, Route.Addons )


thumbsupButton : Element msg
thumbsupButton =
    materialIconLink ( Filled.thumb_up, Route.Top )


playlistButton : Element msg
playlistButton =
    materialIconLink ( Filled.assignment, Route.Top )


settingsButton : Element msg
settingsButton =
    materialIconLink ( Filled.settings, Route.Top )


helpButton : Element msg
helpButton =
    materialIconLink ( Filled.help, Route.Top )
