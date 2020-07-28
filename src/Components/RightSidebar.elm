module Components.RightSidebar exposing (view)

import Element exposing (Element, alignRight, centerX, column, fill, height, paddingXY, rgb, spacing, text)
import Element.Background as Background
import Element.Input as Input


view : Bool -> msg -> Element msg
view rightSidebarExtended rightSidebarMsg =
    if rightSidebarExtended then
        column
            [ height fill, Background.color (rgb 0.3 0.3 0.3), spacing 30, paddingXY 10 20, alignRight ]
            [ Input.button [ centerX ] { onPress = Just rightSidebarMsg, label = Element.text ">" }
            ]

    else
        column
            [ height fill, Background.color (rgb 0.3 0.3 0.3), spacing 30, paddingXY 10 20, alignRight ]
            [ Input.button [ centerX ] { onPress = Just rightSidebarMsg, label = Element.text "<" }
            ]
