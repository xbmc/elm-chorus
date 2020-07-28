module Components.RightSidebar exposing (view)

import Colors
import Element exposing (Element, alignRight, centerX, column, el, fill, height, paddingXY, px, rgb, row, spacing, text, width)
import Element.Background as Background
import Element.Input as Input


view : Bool -> msg -> Element msg
view rightSidebarExtended rightSidebarMsg =
    if rightSidebarExtended then
        column
            [ height fill, width (px 400), Background.color Colors.black ]
            [ row []
                [ Input.button [ Background.color Colors.lightBlack, height (px 50), width (px 50) ] { onPress = Just rightSidebarMsg, label = Element.text "Kodi" }
                , Input.button [ Background.color Colors.lightBlack, height (px 50), width (px 50) ] { onPress = Just rightSidebarMsg, label = Element.text "Local" }
                , Input.button [ Background.color Colors.lightBlack, height (px 50), width (px 50), alignRight ] { onPress = Just rightSidebarMsg, label = Element.text ">" }
                ]
            , el [] (text "Test")
            ]

    else
        column
            [ height fill, width (px 50), Background.color Colors.black, alignRight ]
            [ Input.button [ centerX, height (px 50) ] { onPress = Just rightSidebarMsg, label = Element.text "<" }
            ]
