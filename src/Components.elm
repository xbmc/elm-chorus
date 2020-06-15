module Components exposing (layout)

import Action exposing (Method(..), Param(..))
import Document exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import FeatherIcons
import Generated.Route as Route exposing (Route)
import Html exposing (Html)
import Html.Attributes
import Svg.Attributes

layout : 
    { page : Document msg
    , playPauseMsg : msg
    , skipMsg : msg 
    , reverseMsg : msg
    , muteMsg : msg
    , repeatMsg : msg
    , shuffleMsg : msg
    } 
    -> Document msg
layout { page, playPauseMsg, skipMsg, reverseMsg, muteMsg, repeatMsg, shuffleMsg } =
    { title = page.title
    , body =
        [ column [ width fill, height fill ]
            [ header
            , row [ width fill, height fill ]
                [ el [ width (fillPortion 1), height fill ] leftSidebar
                , column [ width (fillPortion 20), height fill, paddingXY 0 25 ] page.body
                ]
            , player 
                    { playPauseMsg = playPauseMsg
                    , skipMsg = skipMsg
                    , reverseMsg = reverseMsg
                    , muteMsg = muteMsg
                    , repeatMsg = repeatMsg
                    , shuffleMsg = shuffleMsg
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
            , url = Route.Top |> Route.toHref
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
    el [ Element.mouseOver [
            scale 1.2
        ]
    ] <|
        Element.link []
            { url = Route.toHref route
            , label = Element.html (icon |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
            }

-- buttons
musicButton = 
    featherLink (FeatherIcons.music, Route.Music)

movieButton = 
    featherLink (FeatherIcons.video, Route.Movies)

tvshowButton = 
    featherLink (FeatherIcons.tv, Route.TVshows)

browserButton = 
    featherLink (FeatherIcons.menu, Route.Browser)

addonsButton = 
    featherLink (FeatherIcons.package, Route.Addons)

likesButton = 
    featherLink (FeatherIcons.thumbsUp, Route.Thumbups)

playlistButton = 
    featherLink (FeatherIcons.clipboard, Route.Top)

settingsButton = 
    featherLink (FeatherIcons.settings, Route.Top)

helpButton = 
    featherLink (FeatherIcons.helpCircle, Route.Top)

-- Player

player : 
    { playPauseMsg : msg
    , skipMsg : msg 
    , reverseMsg : msg
    , muteMsg : msg
    , repeatMsg : msg
    , shuffleMsg : msg 
    } 
    -> Element msg
player { playPauseMsg, skipMsg, reverseMsg, muteMsg, repeatMsg, shuffleMsg } =
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
                , el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text "Nothing playing")
                , el [ alignRight, Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text "0")
                ]
            ]
        , column [ height fill, width (fillPortion 1) ]
            [ el [] (text "Volume")
            , row [ width fill, Background.color (rgb 0.2 0.2 0.2), alignBottom, paddingXY 10 0, spacing 30 ]
                [ el [ centerX ] (volumeButton { muteMsg = muteMsg })
                , el [ centerX ] (repeatButton { repeatMsg = repeatMsg })
                , el [ centerX ] (shuffleButton { shuffleMsg = shuffleMsg })
                , el [ centerX ] controlButton
                ]
            ]
        ]


-- Player controls

featherButton : ( FeatherIcons.Icon, msg ) -> Element msg
featherButton ( icon, action ) =
    Input.button []
        { onPress = Just action
        , label = Element.html (icon |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [ Svg.Attributes.color "lightgrey" ])
        }
        
reverseButton : { reverseMsg : msg } -> Element msg
reverseButton { reverseMsg } =
    featherButton(FeatherIcons.skipBack, reverseMsg)


playButton : { playPauseMsg : msg } -> Element msg
playButton { playPauseMsg } =
    featherButton(FeatherIcons.play, playPauseMsg)

skipButton : { skipMsg : msg } -> Element msg
skipButton { skipMsg } =
    featherButton(FeatherIcons.skipForward, skipMsg)


{- Secondary controls
   includes:
   | volume
   | repeat
   | shuffle
   | controls
-}

volumeButton : { muteMsg : msg } -> Element msg
volumeButton { muteMsg } =
    featherButton(FeatherIcons.volume2, muteMsg)

repeatButton : { repeatMsg : msg } -> Element msg
repeatButton { repeatMsg } =
    featherButton(FeatherIcons.repeat, repeatMsg)

shuffleButton : { shuffleMsg : msg } -> Element msg
shuffleButton { shuffleMsg } =
    featherButton(FeatherIcons.shuffle, shuffleMsg)

controlButton =
    Input.button []
        { onPress = Nothing
        , label = Element.html (FeatherIcons.moreVertical |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [ Svg.Attributes.color "lightgrey" ])
        }

--

link : ( String, Route ) -> Element msg
link ( label, route ) =
    Element.link styles.link
        { label = text label
        , url = Route.toHref route
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
