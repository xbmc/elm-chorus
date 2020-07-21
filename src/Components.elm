module Components exposing (layout)

import Document exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import FeatherIcons
import Html exposing (Html)
import Html.Attributes
import Spa.Generated.Route as Route exposing (Route)
import Svg.Attributes
import WSDecoder exposing (ItemDetails)


layout :
    { page : Document msg
    , currentlyPlaying : ItemDetails
    , playPauseMsg : msg
    , skipMsg : msg
    , reverseMsg : msg
    , muteMsg : msg
    , repeatMsg : msg
    , shuffleMsg : msg
    , rightMenu : Bool
    , rightMenuMsg : msg
    , controlMenu : Bool
    , controlMenuMsg : msg
    , sendTextToKodiMsg : msg
    , scanVideoLibraryMsg : msg
    , scanMusicLibraryMsg : msg
    }
    -> Document msg
layout { page, currentlyPlaying, playPauseMsg, skipMsg, reverseMsg, muteMsg, repeatMsg, shuffleMsg, rightMenu, rightMenuMsg, controlMenu, controlMenuMsg, sendTextToKodiMsg, scanVideoLibraryMsg, scanMusicLibraryMsg } =
    { title = page.title
    , body =
        [ column [ width fill, height fill ]
            [ header
            , row [ width fill, height fill ]
                [ el [ width (fillPortion 1), height fill ] leftSidebar
                , column [ width (fillPortion 20), height fill, paddingXY 0 25, scrollbars] page.body
                , el [ width (fillPortion 1), height fill ] (rightSidebar rightMenu rightMenuMsg)
                ]
            , player
                { currentlyPlaying = currentlyPlaying
                , playPauseMsg = playPauseMsg
                , skipMsg = skipMsg
                , reverseMsg = reverseMsg
                , muteMsg = muteMsg
                , repeatMsg = repeatMsg
                , shuffleMsg = shuffleMsg
                , controlMenu = controlMenu
                , controlMenuMsg = controlMenuMsg
                , sendTextToKodiMsg = sendTextToKodiMsg
                , scanVideoLibraryMsg = scanVideoLibraryMsg
                , scanMusicLibraryMsg = scanMusicLibraryMsg
                }
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
        , likesButton
        , playlistButton
        , settingsButton
        , helpButton
        ]


featherLink : ( FeatherIcons.Icon, Route ) -> Element msg
featherLink ( icon, route ) =
    el
        [ Element.mouseOver
            [ scale 1.1
            , Background.color (rgb255 25 180 228)
            ]
        ]
    <|
        Element.link []
            { url = Route.toString route
            , label = Element.html (icon |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
            }



-- buttons


musicButton =
    featherLink ( FeatherIcons.music, Route.Music )


movieButton =
    featherLink ( FeatherIcons.video, Route.Movies )


tvshowButton =
    featherLink ( FeatherIcons.tv, Route.TVShows )


browserButton =
    featherLink ( FeatherIcons.menu, Route.Browser )


addonsButton =
    featherLink ( FeatherIcons.package, Route.Addons )


likesButton =
    featherLink ( FeatherIcons.thumbsUp, Route.Top )


playlistButton =
    featherLink ( FeatherIcons.clipboard, Route.Top )


settingsButton =
    featherLink ( FeatherIcons.settings, Route.Top )


helpButton =
    featherLink ( FeatherIcons.helpCircle, Route.Top )



-- Player


player :
    { currentlyPlaying : ItemDetails
    , playPauseMsg : msg
    , skipMsg : msg
    , reverseMsg : msg
    , muteMsg : msg
    , repeatMsg : msg
    , shuffleMsg : msg
    , controlMenu : Bool
    , controlMenuMsg : msg
    , sendTextToKodiMsg : msg
    , scanVideoLibraryMsg : msg
    , scanMusicLibraryMsg : msg
    }
    -> Element msg
player { currentlyPlaying, playPauseMsg, skipMsg, reverseMsg, muteMsg, repeatMsg, shuffleMsg, controlMenu, controlMenuMsg, sendTextToKodiMsg, scanVideoLibraryMsg, scanMusicLibraryMsg } =
    row [ height (px 70), width fill, alignBottom ]
        [ row [ height fill, width (fillPortion 1), Background.color (rgb 0.2 0.2 0.2), alignBottom, padding 10, spacing 30 ]
            [ el [ centerX ] (reverseButton { reverseMsg = reverseMsg })
            , el [ centerX ] (playButton { playPauseMsg = playPauseMsg })
            , el [ centerX ] (skipButton { skipMsg = skipMsg })
            ]
        , column [ height fill, width (fillPortion 2) ]
            [ row [ height (px 70), width fill, Background.color (rgb 0.2 0.2 0.2), alignBottom, padding 10, spacing 30 ]
                [ image [ alignLeft ]
                    { src = "https://via.placeholder.com/70"
                    , description = "Hero Image"
                    }
                , el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text currentlyPlaying.title)
                , el [ alignRight, Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text (String.fromInt currentlyPlaying.duration))
                ]
            ]
        , column [ height fill, width (fillPortion 1) ]
            [ el (dropUp controlMenu sendTextToKodiMsg scanVideoLibraryMsg scanMusicLibraryMsg) (text "Volume")
            , row [ width fill, Background.color (rgb 0.2 0.2 0.2), alignBottom, paddingXY 10 0, spacing 30 ]
                [ el [ centerX ] (volumeButton { muteMsg = muteMsg })
                , el [ centerX ] (repeatButton { repeatMsg = repeatMsg })
                , el [ centerX ] (shuffleButton { shuffleMsg = shuffleMsg })
                , el [ centerX ] (controlButton { controlMenuMsg = controlMenuMsg })
                ]
            ]
        ]


dropUp : Bool -> msg -> msg -> msg -> List (Attribute msg)
dropUp controlMenu sendTextToKodiMsg scanVideoLibraryMsg scanMusicLibraryMsg =
    if controlMenu then
        [ Element.above
            (Element.column []
                [ Input.button [] { onPress = Just sendTextToKodiMsg, label = Element.text "Scan video library" }
                , Input.button [] { onPress = Just scanVideoLibraryMsg, label = Element.text "Scan audio library" }
                , Input.button [] { onPress = Just scanMusicLibraryMsg, label = Element.text "Send text to Kodi" }
                , Element.link [] { url = "lab", label = Element.text "The lab" }
                , Element.link [] { url = "help", label = Element.text "About Chorus" }
                ]
            )
        ]
    else
        []

rightSidebar : Bool -> msg -> Element msg
rightSidebar rightMenu rightMenuMsg =
    if rightMenu then
        column 
            [ height fill, Background.color (rgb 0.3 0.3 0.3), spacing 30, paddingXY 10 20, alignRight ] 
                [ Input.button [centerX] { onPress = Just rightMenuMsg, label = Element.text ">" }
                ]
        
    else
        column 
            [ height fill, Background.color (rgb 0.3 0.3 0.3), spacing 30, paddingXY 10 20, alignRight ] 
                [ Input.button [centerX] { onPress = Just rightMenuMsg, label = Element.text "<" }
                ]


featherButton : ( FeatherIcons.Icon, msg ) -> Element msg
featherButton ( icon, action ) =
    Input.button []
        { onPress = Just action
        , label = Element.html (icon |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [ Svg.Attributes.color "lightgrey" ])
        }


reverseButton : { reverseMsg : msg } -> Element msg
reverseButton { reverseMsg } =
    featherButton ( FeatherIcons.skipBack, reverseMsg )


playButton : { playPauseMsg : msg } -> Element msg
playButton { playPauseMsg } =
    featherButton ( FeatherIcons.play, playPauseMsg )


skipButton : { skipMsg : msg } -> Element msg
skipButton { skipMsg } =
    featherButton ( FeatherIcons.skipForward, skipMsg )



{- Secondary controls
   includes:
   | volume
   | repeat
   | shuffle
   | controls
-}


volumeButton : { muteMsg : msg } -> Element msg
volumeButton { muteMsg } =
    featherButton ( FeatherIcons.volume2, muteMsg )


repeatButton : { repeatMsg : msg } -> Element msg
repeatButton { repeatMsg } =
    featherButton ( FeatherIcons.repeat, repeatMsg )


shuffleButton : { shuffleMsg : msg } -> Element msg
shuffleButton { shuffleMsg } =
    featherButton ( FeatherIcons.shuffle, shuffleMsg )


controlButton : { controlMenuMsg : msg } -> Element msg
controlButton { controlMenuMsg } =
    featherButton ( FeatherIcons.moreVertical, controlMenuMsg )



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
