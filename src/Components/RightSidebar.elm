module Components.RightSidebar exposing (view)

import Colors exposing (greyIcon)
import Components.LayoutType exposing (ShowRightSidebarMenu)
import Element exposing (Attribute, Element, alignRight, centerX, centerY, column, el, fill, height, htmlAttribute, padding, paddingXY, px, rgb, row, spacing, text, width)
import Element.Background as Background
import Element.Input as Input
import Html.Attributes
import Material.Icons as Filled
import Material.Icons.Types as MITypes
import WSDecoder exposing (Connection(..))


view : ShowRightSidebarMenu msg -> msg -> Bool -> msg -> Int -> Connection -> Element msg
view { showRightSidebarMenu, showRightSidebarMenuMsg} clearPlaylistMsg rightSidebarExtended rightSidebarMsg panelHeight connection =
    if rightSidebarExtended then
        column
            [ height (px panelHeight), width (px 400), Background.color Colors.playlistHeaderBackground, alignRight, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
            [ row [ width fill ]
                [ Input.button [ Background.color Colors.backgroundKodi, height (px 50), width (px 100), padding 8 ] { onPress = Just rightSidebarMsg, label = Element.text "Kodi" }
                , Input.button [ Background.color Colors.backgroundLocal, height (px 50), width (px 100), padding 8 ] { onPress = Just rightSidebarMsg, label = Element.text "Local" }
                , el (rightSidebarMenuDropDown showRightSidebarMenu clearPlaylistMsg)
                    (case connection of
                        Connected ->
                            Element.text "Connected"

                        Disconnected ->
                            Element.text "Disconnected"

                        NotAsked ->
                            Element.text "Not asked"
                    )
                , Input.button [ Background.color Colors.playlistHeaderBackground, height (px 50), width (px 50), centerX, alignRight, centerY ]
                    { onPress = Just showRightSidebarMenuMsg
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
            [ height (px panelHeight), width (px 50), Background.color Colors.playlistBackground, alignRight, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
            [ Input.button [ centerX, height (px 50) ] { onPress = Just rightSidebarMsg, label = Element.text "<" }
            ]


rightSidebarMenuDropDown : Bool -> msg -> List (Attribute msg)
rightSidebarMenuDropDown showRightSidebarMenu clearPlaylistMsg =
    if showRightSidebarMenu then
        [ Element.below
            (Element.column [ width (px 150), Background.color Colors.white ]
                [ Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Current playlist") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Just clearPlaylistMsg, label = el [] (text "Clear playlist") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Refresh playlist") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Party mode") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Kodi") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Save Kodi playlist") }
                ]
            )
        ]

    else
        []
