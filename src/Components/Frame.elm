module Components.Frame exposing (layout)

import Components.Header as Header
import Components.LayoutType exposing (LayoutType)
import Components.LeftSidebar as LeftSidebar
import Components.PlayerRow as PlayerRow exposing (view)
import Components.RightSidebar as RightSidebar
import Element exposing (..)
import Material.Icons.Types exposing (Coloring(..))
import Spa.Document exposing (Document)


layout : LayoutType msg -> { body : Document msg, header : Element msg, playerBar : Element msg }
layout layoutType =
    { body =
        { title = layoutType.page.title
        , body =
            [ column [ width fill, height fill ]
                [ el [ height (px Header.headerHeight) ] Element.none
                , row
                    [ width fill, height fill ]
                    [ el [ width (fillPortion 1), height fill ] LeftSidebar.view
                    , column [ width (fillPortion 20), height fill, paddingXY 0 25 ] layoutType.page.body
                    , el [ width (fillPortion 1), height fill ] (RightSidebar.view layoutType.rightSidebarExtended layoutType.rightSidebarMsg)
                    ]
                ]
            ]
        }
    , header = Header.view layoutType.searchChanged
    , playerBar = PlayerRow.view layoutType
    }
