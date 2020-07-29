module Components.RightSidebar exposing (view)

import Colors exposing (greyIcon)
import Element exposing (Element, alignRight, centerX, column, el, fill, height, padding, paddingXY, px, rgb, row, spacing, text, width)
import Element.Background as Background
import Element.Input as Input
import Material.Icons as Filled
import Material.Icons.Types as MITypes


view : Bool -> msg -> Int -> Element msg
view rightSidebarExtended rightSidebarMsg panelHeight =
    if rightSidebarExtended then
        column
            [ height (px panelHeight), width (px 400), Background.color Colors.playlistHeaderBackground, alignRight ]
            [ row [ width fill ]
                [ Input.button [ Background.color Colors.backgroundKodi, height (px 50), width (px 100), padding 8 ] { onPress = Just rightSidebarMsg, label = Element.text "Kodi" }
                , Input.button [ Background.color Colors.backgroundLocal, height (px 50), width (px 100), padding 8 ] { onPress = Just rightSidebarMsg, label = Element.text "Local" }
                , Input.button [ Background.color Colors.playlistHeaderBackground, height (px 50), width (px 50), centerX, alignRight ]
                    { onPress = Just rightSidebarMsg
                    , label =
                        Element.html
                            (Filled.more_vert 32 (MITypes.Color <| greyIcon))
                    }
                , Input.button [ Background.color Colors.playlistHeaderBackground, height (px 50), width (px 50), centerX, alignRight ] { onPress = Just rightSidebarMsg, label = Element.text ">" }
                ]
            , el [ width fill, height fill, Background.color Colors.playlistBackground, padding 8 ] (text "Test")
            ]

    else
        column
            [ height (px panelHeight), width (px 50), Background.color Colors.playlistBackground, alignRight ]
            [ Input.button [ centerX, height (px 50) ] { onPress = Just rightSidebarMsg, label = Element.text "<" }
            ]
