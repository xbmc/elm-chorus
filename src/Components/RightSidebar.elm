module Components.RightSidebar exposing (view)

import Colors exposing (..)
import Components.LayoutType exposing (ShowRightSidebarMenu)
import Element exposing (Attribute, Element, alignLeft, alignRight, centerX, centerY, column, el, fill, height, htmlAttribute, image, padding, paddingXY, px, rgb, row, spacing, text, width)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Material.Icons as Filled
import Material.Icons.Types as MITypes
import SharedType exposing (..)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (Connection(..), ItemDetails)


view : ShowRightSidebarMenu msg -> Bool -> msg -> Int -> Connection -> Element msg
view { showRightSidebarMenu, showRightSidebarMenuMsg, clearPlaylistMsg, refreshPlaylistMsg, partyModeToggleMsg, kodiMsg, localMsg, audioMsg, videoMsg, tabSwitch, currentlyPlaying, playing } rightSidebarExtended rightSidebarMsg panelHeight connection =
    if rightSidebarExtended then
        column
            [ height (px panelHeight), width (px 400), Background.color Colors.playlistHeaderBackground, alignRight, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
            [ row [ width fill ]
                [ Input.button
                    [ case tabSwitch of
                        Kodi _ ->
                            Background.color Colors.backgroundKodi

                        Local ->
                            Background.color Colors.backgroundLocal
                    , height (px 50)
                    , width (px 100)
                    , padding 8
                    ]
                    { onPress = Just kodiMsg
                    , label =
                        Element.row []
                            [ image [ width (px 15), height (px 15), paddingXY 15 0 ]
                                { description = ""
                                , src =
                                    case tabSwitch of
                                        Kodi _ ->
                                            "logo.png"

                                        Local ->
                                            "greylogo.png"
                                }
                            , el
                                (case tabSwitch of
                                    Kodi _ ->
                                        [ Font.color Colors.kodi ]

                                    Local ->
                                        []
                                )
                                (text " Kodi")
                            ]
                    }
                , Input.button
                    [ case tabSwitch of
                        Kodi _ ->
                            Background.color Colors.backgroundLocal

                        Local ->
                            Background.color Colors.backgroundKodi
                    , height (px 50)
                    , width (px 100)
                    , padding 8
                    ]
                    { onPress = Just localMsg
                    , label =
                        Element.row []
                            [ Element.html
                                (Filled.headphones 14
                                    (MITypes.Color <|
                                        case tabSwitch of
                                            Kodi _ ->
                                                greyIcon

                                            Local ->
                                                ceriseIcon
                                    )
                                )
                            , el
                                (case tabSwitch of
                                    Kodi _ ->
                                        []

                                    Local ->
                                        [ Font.color Colors.local ]
                                )
                                (text " Local")
                            ]
                    }
                , el (rightSidebarMenuDropDown showRightSidebarMenu clearPlaylistMsg refreshPlaylistMsg partyModeToggleMsg)
                    (case connection of
                        Connected ->
                            Element.text " Connected"

                        Disconnected ->
                            Element.text " Disconnected"

                        NotAsked ->
                            Element.text "Not asked"
                    )
                , Input.button [ Background.color Colors.playlistHeaderBackground, height (px 50), width (px 50), centerX, alignRight, centerY, paddingXY 5 12 ]
                    { onPress = Just showRightSidebarMenuMsg
                    , label =
                        Element.html
                            (Filled.more_vert 22 (MITypes.Color <| greyIcon))
                    }
                , Input.button [ Background.color Colors.playlistHeaderBackground, height (px 50), width (px 50), centerX, alignRight, paddingXY 5 12 ]
                    { onPress = Just rightSidebarMsg
                    , label =
                        Element.html
                            (Filled.chevron_right 22 (MITypes.Color <| greyIcon))
                    }
                ]
            , case tabSwitch of
                Kodi kodiTabs ->
                    kodiTab kodiTabs currentlyPlaying playing audioMsg videoMsg

                Local ->
                    localTab
            ]

    else
        column
            [ height (px panelHeight), width (px 50), Background.color Colors.playlistBackground, alignRight, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
            [ Input.button [ centerX, height (px 50), paddingXY 5 12 ]
                { onPress = Just rightSidebarMsg
                , label =
                    Element.html
                        (Filled.chevron_left 22 (MITypes.Color <| greyIcon))
                }
            ]


kodiTab : KodiTabs -> Maybe ItemDetails -> Bool -> msg -> msg -> Element msg
kodiTab kodiTabs currentlyPlaying playing audioMsg videoMsg =
    el [ width fill, height fill, Background.color Colors.playlistBackground, padding 10 ] <|
        column [ width fill, spacing 10 ]
            [ row [ width fill, height (px 30), Background.color Colors.backgroundLocal ]
                [ Input.button
                    [ case kodiTabs of
                        Audio ->
                            Background.color Colors.innertab

                        Video ->
                            Background.color Colors.backgroundLocal
                    , padding 8
                    ]
                    { onPress = Just audioMsg
                    , label =
                        el
                            (case kodiTabs of
                                Audio ->
                                    [ Font.color Colors.white ]

                                Video ->
                                    []
                            )
                            (text " Audio")
                    }
                , Input.button
                    [ case kodiTabs of
                        Audio ->
                            Background.color Colors.backgroundLocal

                        Video ->
                            Background.color Colors.innertab
                    , padding 8
                    ]
                    { onPress = Just videoMsg
                    , label =
                        el
                            (case kodiTabs of
                                Audio ->
                                    []

                                Video ->
                                    [ Font.color Colors.white ]
                            )
                            (text " Video")
                    }
                ]
            , case kodiTabs of
                Audio ->
                    audioTab currentlyPlaying playing

                Video ->
                    videoTab currentlyPlaying playing
            ]


localTab : Element msg
localTab =
    el [ width fill, height fill, Background.color Colors.playlistBackground, padding 8 ] (text "Local Tab")


audioTab : Maybe ItemDetails -> Bool -> Element msg
audioTab currentlyPlaying playing =
    case currentlyPlaying of
        Nothing ->
            Element.none

        Just item ->
            case item.mediatype of
                WSDecoder.Audio ->
                    row [ width fill, height (px 80), Background.color Colors.black ]
                        [ case playing of
                            True ->
                                Element.image [ alignRight, height (px 30), width (px 30), alignLeft, paddingXY 20 0 ]
                                    { description = ""
                                    , src = "wave.gif"
                                    }

                            False ->
                                el [ alignRight, height (px 30), width (px 30), alignLeft, paddingXY 20 0, Font.color white, Font.size 20 ] (text "---")
                        , column [ padding 20, spacing 10 ]
                            [ row [] [ el [ Font.color white ] (text item.title) ]
                            , row []
                                (List.map
                                    (\artist ->
                                        el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 13 ] (text artist)
                                    )
                                    item.artist
                                )
                            ]
                        , Element.image [ alignRight, height (px 70), width (px 70) ]
                            { description = ""
                            , src = crossOrigin "http://localhost:8080" [ "image", percentEncode item.thumbnail ] []
                            }
                        ]

                WSDecoder.Video ->
                    Element.none


videoTab : Maybe ItemDetails -> Bool -> Element msg
videoTab currentlyPlaying playing =
    case currentlyPlaying of
        Nothing ->
            Element.none

        Just item ->
            case item.mediatype of
                WSDecoder.Audio ->
                    Element.none

                WSDecoder.Video ->
                    row [ width fill, height (px 80), Background.color Colors.black ]
                        [ case playing of
                            True ->
                                Element.image [ alignRight, height (px 30), width (px 30), alignLeft, paddingXY 20 0 ]
                                    { description = ""
                                    , src = "wave.gif"
                                    }

                            False ->
                                el [ alignRight, height (px 30), width (px 30), alignLeft, paddingXY 20 0, Font.color white, Font.size 20 ] (text "---")
                        , column [ padding 20, spacing 10 ]
                            [ row [] [ el [ Font.color white ] (text item.title) ]
                            , row []
                                (List.map
                                    (\artist ->
                                        el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 13 ] (text artist)
                                    )
                                    item.artist
                                )
                            ]
                        , Element.image [ alignRight, height (px 70), width (px 70) ]
                            { description = ""
                            , src = crossOrigin "http://localhost:8080" [ "image", percentEncode item.thumbnail ] []
                            }
                        ]


rightSidebarMenuDropDown : Bool -> msg -> msg -> msg -> List (Attribute msg)
rightSidebarMenuDropDown showRightSidebarMenu clearPlaylistMsg refreshPlaylistMsg partyModeToggleMsg =
    if showRightSidebarMenu then
        [ Element.below
            (Element.column [ width (px 150), Background.color Colors.white ]
                [ Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Current playlist") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Just clearPlaylistMsg, label = el [] (text "Clear playlist") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Just refreshPlaylistMsg, label = el [] (text "Refresh playlist") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Just partyModeToggleMsg, label = el [] (text "Party mode") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Kodi") }
                , Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = Nothing, label = el [] (text "Save Kodi playlist") }
                ]
            )
        ]

    else
        []
