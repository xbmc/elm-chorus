module Components exposing (layout)

import Colors exposing (greyIcon, lightBlack)
import Document exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (center)
import Element.Input as Input
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Spa.Generated.Route as Route exposing (Route)
import Svg.Attributes
import Url exposing (percentEncode)
import Url.Builder exposing (absolute, crossOrigin)
import WSDecoder exposing (ItemDetails)


type alias LayoutType msg =
    { page : Document msg
    , controlMenu : ControlMenu msg
    , playerControl : PlayerControl msg
    , currentlyPlaying : CurrentlyPlaying msg
    , volumeAndControls : VolumeAndControls msg
    , rightSidebarExtended : Bool
    , rightSidebarMsg : msg
    }


type alias PlayerControl msg =
    { playPauseMsg : msg
    , skipMsg : msg
    , reverseMsg : msg
    }


type alias CurrentlyPlaying msg =
    { currentlyPlaying : ItemDetails
    , progressSlider : Element msg
    }


type alias VolumeAndControls msg =
    { muteMsg : msg
    , repeatMsg : msg
    , shuffleMsg : msg
    , volumeSlider : Element msg
    }


type alias ControlMenu msg =
    { controlMenu : Bool
    , controlMenuMsg : msg
    , sendTextToKodiMsg : msg
    , scanVideoLibraryMsg : msg
    , scanMusicLibraryMsg : msg
    }


layout : LayoutType msg -> Document msg
layout layoutType =
    { title = layoutType.page.title
    , body =
        [ column [ width fill, height fill, clip ]
            [ header
            , row [ width fill, height fill ]
                [ el [ width (fillPortion 1), height fill ] leftSidebar
                , column [ width (fillPortion 20), height fill, paddingXY 0 25 ] layoutType.page.body
                , el [ width (fillPortion 1), height fill ] (rightSidebar layoutType.rightSidebarExtended layoutType.rightSidebarMsg)
                ]
            , player layoutType
            ]
        ]
    }


header : Element msg
header =
    row [ width fill, Background.color (rgb 0.1 0.1 0.1), spacing 10, padding 0 ]
        [ Element.link []
            { label =
                image [ width (px 50) ]
                    { description = ""
                    , src = "https://kodi.wiki/images/8/8e/Thumbnail-symbol-transparent.png"
                    }
            , url = Route.Top |> Route.toString
            }
        , el [ Font.color (Element.rgb 1 1 1) ] (text "Kodi")
        ]



-- left sidebar stuff


leftSidebar : Element msg
leftSidebar =
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


materialLink : ( Icon msg, Route ) -> Element msg
materialLink ( icon, route ) =
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


musicButton =
    materialLink ( Filled.library_music, Route.Music )


movieButton =
    materialLink ( Filled.movie, Route.Movies )


tvshowButton =
    materialLink ( Filled.tv, Route.Tvshows )


browserButton =
    materialLink ( Filled.menu, Route.Browser )


addonsButton =
    materialLink ( Filled.extension, Route.Addons )


thumbsupButton =
    materialLink ( Filled.thumb_up, Route.Top )


playlistButton =
    materialLink ( Filled.assignment, Route.Top )


settingsButton =
    materialLink ( Filled.settings, Route.Top )


helpButton =
    materialLink ( Filled.help, Route.Top )



-- Player


player : LayoutType msg -> Element msg
player layoutType =
    row [ height (px 70), width fill, alignBottom ]
        [ playControlRow layoutType.playerControl
        , column [ width (px 70) ]
            [ image [ alignLeft, width fill, height fill ]
                (if String.isEmpty layoutType.currentlyPlaying.currentlyPlaying.thumbnail then
                    { src = "https://via.placeholder.com/70"
                    , description = "Hero Image"
                    }

                 else
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode layoutType.currentlyPlaying.currentlyPlaying.thumbnail ] []
                    , description = "Hero Image"
                    }
                )
            ]
        , currentlyPlayingColumn layoutType.currentlyPlaying
        , volumesAndControlsColumn layoutType.volumeAndControls layoutType.controlMenu
        ]


playControlRow : PlayerControl msg -> Element msg
playControlRow { reverseMsg, playPauseMsg, skipMsg } =
    row [ height fill, width (px 300), Background.color (rgb 0.2 0.2 0.2), alignBottom, center, spaceEvenly ]
        [ el [ padding 10 ] (reverseButton { reverseMsg = reverseMsg })
        , el [] (playButton { playPauseMsg = playPauseMsg })
        , el [ padding 10 ] (skipButton { skipMsg = skipMsg })
        ]


currentlyPlayingColumn : CurrentlyPlaying msg -> Element msg
currentlyPlayingColumn { currentlyPlaying, progressSlider } =
    column [ height fill, width fill ]
        [ row [ width fill, height (px 20) ]
            [ progressSlider ]
        , row
            [ height fill, width fill, Background.color Colors.black, alignBottom ]
            [ el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text currentlyPlaying.title)
            , el [ alignRight, Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text (String.fromInt currentlyPlaying.duration))
            ]
        ]


volumesAndControlsColumn : VolumeAndControls msg -> ControlMenu msg -> Element msg
volumesAndControlsColumn { muteMsg, repeatMsg, shuffleMsg, volumeSlider } { controlMenu, controlMenuMsg, sendTextToKodiMsg, scanVideoLibraryMsg, scanMusicLibraryMsg } =
    column [ height fill, width (px 300) ]
        [ row (controlMenuDropUp controlMenu sendTextToKodiMsg scanVideoLibraryMsg scanMusicLibraryMsg ++ [ width fill, height (px 20) ]) [ volumeSlider ]
        , row [ width fill, height fill, Background.color (rgb 0.2 0.2 0.2), alignBottom, paddingXY 10 0, spacing 30 ]
            [ el [ centerX ] (volumeButton { muteMsg = muteMsg })
            , el [ centerX ] (repeatButton { repeatMsg = repeatMsg })
            , el [ centerX ] (shuffleButton { shuffleMsg = shuffleMsg })
            , el [ centerX ] (controlButton { controlMenuMsg = controlMenuMsg })
            ]
        ]


controlMenuDropUp : Bool -> msg -> msg -> msg -> List (Attribute msg)
controlMenuDropUp controlMenu sendTextToKodiMsg scanVideoLibraryMsg scanMusicLibraryMsg =
    if controlMenu then
        [ Element.above
            (Element.column []
                [ Input.button [] { onPress = Just sendTextToKodiMsg, label = Element.text "Scan video library" }
                , Input.button [] { onPress = Just scanVideoLibraryMsg, label = Element.text "Scan audio library" }
                , Input.button [] { onPress = Just scanMusicLibraryMsg, label = Element.text "Send text to Kodi" }
                , link ( "The lab", Route.Lab )
                , link ( "About Chorus", Route.Help )
                ]
            )
        ]

    else
        []


rightSidebar : Bool -> msg -> Element msg
rightSidebar rightSidebarExtended rightSidebarMsg =
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


materialButtonBig : ( Icon msg, msg ) -> Element msg
materialButtonBig ( icon, action ) =
    Input.button []
        { onPress = Just action
        , label = Element.html (icon 62 (MITypes.Color <| greyIcon))
        }


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button []
        { onPress = Just action
        , label =
            Element.html
                (icon 32 (MITypes.Color <| greyIcon))
        }


reverseButton : { reverseMsg : msg } -> Element msg
reverseButton { reverseMsg } =
    materialButtonBig ( Filled.skip_previous, reverseMsg )


playButton : { playPauseMsg : msg } -> Element msg
playButton { playPauseMsg } =
    materialButtonBig ( Filled.play_arrow, playPauseMsg )


skipButton : { skipMsg : msg } -> Element msg
skipButton { skipMsg } =
    materialButtonBig ( Filled.skip_next, skipMsg )



{- Secondary controls
   includes:
   | volume
   | repeat
   | shuffle
   | controls
-}


volumeButton : { muteMsg : msg } -> Element msg
volumeButton { muteMsg } =
    materialButton ( Filled.volume_up, muteMsg )


repeatButton : { repeatMsg : msg } -> Element msg
repeatButton { repeatMsg } =
    materialButton ( Filled.repeat, repeatMsg )


shuffleButton : { shuffleMsg : msg } -> Element msg
shuffleButton { shuffleMsg } =
    materialButton ( Filled.shuffle, shuffleMsg )


controlButton : { controlMenuMsg : msg } -> Element msg
controlButton { controlMenuMsg } =
    materialButton ( Filled.more_vert, controlMenuMsg )



--


link : ( String, Route ) -> Element msg
link ( label, route ) =
    Element.link styles.link
        { label = text label
        , url = Route.toString route
        }


externalButtonLink : ( String, String ) -> Element msg
externalButtonLink ( label, url ) =
    Element.newTabLink styles.button
        { label = text label
        , url = url
        }



-- STYLES


colors : { blue : Color, white : Color, red : Color }
colors =
    { white = rgb 1 1 1
    , red = rgb255 204 85 68
    , blue = rgb255 50 100 150
    }


styles :
    { link : List (Element.Attribute msg)
    , button : List (Element.Attribute msg)
    }
styles =
    { link =
        [ Font.underline
        , Font.color colors.blue
        , mouseOver [ alpha 0.6 ]
        ]
    , button =
        [ Font.color colors.white
        , Background.color colors.red
        , Border.rounded 4
        , paddingXY 24 10
        , mouseOver [ alpha 0.6 ]
        ]
    }
