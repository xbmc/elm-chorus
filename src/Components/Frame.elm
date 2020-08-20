module Components.Frame exposing (layout)

import Components.Header as Header
import Components.LayoutType exposing (LayoutType)
import Components.LeftSidebar as LeftSidebar
import Components.PlayerRow as PlayerRow exposing (view)
import Components.RightSidebar as RightSidebar
import Element exposing (..)
import Material.Icons.Types exposing (Coloring(..))
import Spa.Document exposing (Document)


layout : LayoutType msg -> { body : Document msg, header : Element msg, playerBar : Element msg, rightSidebar : Element msg, leftSidebar : Element msg }
layout layoutType =
    { body =
        { title = layoutType.page.title
        , body =
            [ column [ width fill, height fill ]
                [ el [ height (px Header.headerHeight) ] Element.none
                , row
                    [ width fill, height fill, paddingEach { top = 0, right = 0, bottom = 0, left = 50 } ]
                    [ column [ width fill, height fill ] layoutType.page.body
                    ]
                ]
            ]
        }
    , header = Header.view layoutType.searchChanged
    , playerBar = PlayerRow.view layoutType
    , rightSidebar = RightSidebar.view layoutType.rightSidebarExtended layoutType.rightSidebarMsg (layoutType.windowHeight - PlayerRow.playerHeight) layoutType.connection
    , leftSidebar = LeftSidebar.view
    }
