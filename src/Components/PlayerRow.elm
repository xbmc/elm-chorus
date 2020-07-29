module Components.PlayerRow exposing (playerHeight, view)

import Colors exposing (greyIcon)
import Components.LayoutType exposing (ControlMenu, CurrentlyPlaying, LayoutType, PlayerControl, VolumeAndControls)
import Element exposing (Attribute, Element, alignBottom, alignLeft, alignRight, centerX, column, el, fill, height, image, padding, paddingXY, px, rgb, row, spaceEvenly, spacing, text, width)
import Element.Background as Background
import Element.Font as Font exposing (center)
import Element.Input as Input
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Spa.Generated.Route as Route
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)


playerHeight : Int
playerHeight =
    70


view : LayoutType msg -> Element msg
view layoutType =
    row [ height (px playerHeight), width fill, alignBottom ]
        [ playControlRow layoutType.playerControl
        , column [ width (px playerHeight) ]
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
    row [ height fill, width (px 300), Background.color Colors.greyscaleShark, alignBottom, center, spaceEvenly ]
        [ el [ padding 10 ] (reverseButton reverseMsg)
        , el [] (playButton playPauseMsg)
        , el [ padding 10 ] (skipButton skipMsg)
        ]


currentlyPlayingColumn : CurrentlyPlaying msg -> Element msg
currentlyPlayingColumn { currentlyPlaying, progressSlider } =
    column [ height fill, width fill ]
        [ row [ width fill, height (px 20) ]
            [ progressSlider ]
        , row
            [ height (px 25), width fill, Background.color Colors.greyscaleOuterSpace, alignBottom, padding 8 ]
            [ el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text currentlyPlaying.title)
            , el [ alignRight, Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text (String.fromInt currentlyPlaying.duration))
            ]
        , row
            [ height (px 25), width fill, Background.color Colors.greyscaleOuterSpace, alignBottom, padding 8 ]
            [ el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 13, Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] (text currentlyPlaying.title)
            ]
        ]


volumesAndControlsColumn : VolumeAndControls msg -> ControlMenu msg -> Element msg
volumesAndControlsColumn { muteMsg, repeatMsg, shuffleMsg, volumeSlider } { controlMenu, controlMenuMsg, sendTextToKodiMsg, scanVideoLibraryMsg, scanMusicLibraryMsg } =
    column [ height fill, width (px 300) ]
        [ row (controlMenuDropUp controlMenu sendTextToKodiMsg scanVideoLibraryMsg scanMusicLibraryMsg ++ [ width fill, height (px 20) ]) [ volumeSlider ]
        , row [ width fill, height fill, Background.color Colors.greyscaleShark ]
            [ el [ centerX ] (volumeButton muteMsg)
            , el [ centerX ] (repeatButton repeatMsg)
            , el [ centerX ] (shuffleButton shuffleMsg)
            , el [ centerX ] (controlButton controlMenuMsg)
            ]
        ]


controlMenuDropUp : Bool -> msg -> msg -> msg -> List (Attribute msg)
controlMenuDropUp controlMenu sendTextToKodiMsg scanVideoLibraryMsg scanMusicLibraryMsg =
    if controlMenu then
        [ Element.above
            (Element.column [ width fill, Background.color Colors.white ]
                [ controlMenuRow (Just scanVideoLibraryMsg) "Scan video library"
                , controlMenuRow (Just scanMusicLibraryMsg) "Scan audio library"
                , controlMenuRow (Just sendTextToKodiMsg) "Send text to Kodi"
                , Element.link [ width fill ]
                    { url = Route.toString Route.Lab
                    , label = controlMenuRow Nothing "The lab"
                    }
                , Element.link [ width fill ]
                    { url = Route.toString Route.Help
                    , label = controlMenuRow Nothing "About Chorus"
                    }
                ]
            )
        ]

    else
        []


controlMenuRow : Maybe msg -> String -> Element msg
controlMenuRow onPress label =
    Input.button [ width fill, Element.mouseOver [ Background.color Colors.playerControl ], Element.padding 7 ] { onPress = onPress, label = Element.text label }


materialButtonBig : ( Icon msg, msg ) -> Element msg
materialButtonBig ( icon, action ) =
    Input.button []
        { onPress = Just action
        , label = Element.html (icon 62 (MITypes.Color <| greyIcon))
        }


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ width (px 75) ]
        { onPress = Just action
        , label =
            Element.html
                (icon 32 (MITypes.Color <| greyIcon))
        }


reverseButton : msg -> Element msg
reverseButton reverseMsg =
    materialButtonBig ( Filled.skip_previous, reverseMsg )


playButton : msg -> Element msg
playButton playPauseMsg =
    materialButtonBig ( Filled.play_arrow, playPauseMsg )


skipButton : msg -> Element msg
skipButton skipMsg =
    materialButtonBig ( Filled.skip_next, skipMsg )



{- Secondary controls
   includes:
   | volume
   | repeat
   | shuffle
   | controls
-}


volumeButton : msg -> Element msg
volumeButton muteMsg =
    materialButton ( Filled.volume_up, muteMsg )


repeatButton : msg -> Element msg
repeatButton repeatMsg =
    materialButton ( Filled.repeat, repeatMsg )


shuffleButton : msg -> Element msg
shuffleButton shuffleMsg =
    materialButton ( Filled.shuffle, shuffleMsg )


controlButton : msg -> Element msg
controlButton controlMenuMsg =
    materialButton ( Filled.more_vert, controlMenuMsg )
