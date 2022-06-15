module Components.PlayerRow exposing (playerHeight, view)

import Colors exposing (greyIcon)
import Components.LayoutType exposing (ControlMenu, CurrentlyPlaying, LayoutType, PlayerControl, ShowRightSidebarMenu, VolumeAndControls)
import Element exposing (Attribute, Element, alignBottom, alignLeft, alignRight, centerX, column, el, fill, height, htmlAttribute, image, padding, paddingXY, px, rgb, row, spaceEvenly, spacing, text, width)
import Element.Background as Background
import Element.Font as Font exposing (center)
import Element.Input as Input
import Helper exposing (durationToString)
import Html.Attributes
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import SharedType exposing (..)
import Spa.Generated.Route as Route
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)


playerHeight : Int
playerHeight =
    70


view : LayoutType msg -> Element msg
view layoutType =
    row [ height (px playerHeight), width fill, alignBottom, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
        [ playControlRow layoutType.showRightSidebarMenu layoutType.playerControl
        , column [ width (px playerHeight) ]
            [ case layoutType.currentlyPlaying.currentlyPlaying of
                Nothing ->
                    image [ alignLeft, width fill, height fill ]
                        { src = "https://via.placeholder.com/70"
                        , description = "Hero Image"
                        }

                Just item ->
                    image [ alignLeft, width fill, height fill ]
                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode item.thumbnail ] []
                        , description = "Thumbnail"
                        }
            ]
        , currentlyPlayingColumn layoutType.showRightSidebarMenu layoutType.currentlyPlaying
        , volumesAndControlsColumn layoutType.showRightSidebarMenu layoutType.volumeAndControls layoutType.controlMenu
        ]


playControlRow : ShowRightSidebarMenu msg -> PlayerControl msg -> Element msg
playControlRow { tabSwitch } { reverseMsg, playPauseMsg, skipMsg, playing } =
    row
        [ height fill
        , width (px 300)
        , case tabSwitch of
            Kodi ->
                Background.color Colors.darkGrey

            Local ->
                Background.color Colors.greyscaleShark
        , alignBottom
        , center
        , spaceEvenly
        ]
        [ el [ padding 10 ] (reverseButton reverseMsg)
        , el [] (playButton playing playPauseMsg)
        , el [ padding 10 ] (skipButton skipMsg)
        ]


currentlyPlayingColumn : ShowRightSidebarMenu msg -> CurrentlyPlaying msg -> Element msg
currentlyPlayingColumn { tabSwitch } { currentlyPlaying, progressSlider } =
    column [ height fill, width fill ]
        [ row [ width fill, height (px 20) ]
            [ progressSlider ]
        , row
            [ height (px 25)
            , width fill
            , case tabSwitch of
                Kodi ->
                    Background.color Colors.playerBackground

                Local ->
                    Background.color Colors.greyscaleOuterSpace
            , alignBottom
            , padding 8
            ]
            (case currentlyPlaying of
                Nothing ->
                    [ el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18 ] (text "Nothing playing")
                    , el [ alignRight, Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18 ] (text "0")
                    ]

                Just item ->
                    [ el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18 ] (text item.title)
                    , el [ alignRight, Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18 ] (item.duration |> durationToString |> text)
                    ]
            )
        , row
            [ height (px 25)
            , width fill
            , case tabSwitch of
                Kodi ->
                    Background.color Colors.playerBackground

                Local ->
                    Background.color Colors.greyscaleOuterSpace
            , alignBottom
            , padding 8
            ]
            (case currentlyPlaying of
                Nothing ->
                    [ el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 13 ] (text "Nothing playing")
                    ]

                Just item ->
                    List.map
                        (\artist ->
                            el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 13 ] (text artist)
                        )
                        item.artist
            )
        ]


volumesAndControlsColumn : ShowRightSidebarMenu msg -> VolumeAndControls msg -> ControlMenu msg -> Element msg
volumesAndControlsColumn { tabSwitch } { muteMsg, mute, repeat, repeatMsg, shuffleMsg, shuffle, volumeSlider } { controlMenu, controlMenuMsg, sendTextToKodiMsg, scanVideoLibraryMsg, scanMusicLibraryMsg } =
    column [ height fill, width (px 300) ]
        [ row (controlMenuDropUp controlMenu sendTextToKodiMsg scanVideoLibraryMsg scanMusicLibraryMsg ++ [ width fill, height (px 20) ]) [ volumeSlider ]
        , row
            [ width fill
            , height fill
            , case tabSwitch of
                Kodi ->
                    Background.color Colors.darkGrey

                Local ->
                    Background.color Colors.greyscaleShark
            ]
            [ el [ centerX ] (volumeButton mute muteMsg)
            , el [ centerX ] (repeatButton repeat repeatMsg)
            , el [ centerX ] (shuffleButton shuffle shuffleMsg)
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
                    { url = Route.toString Route.Help__About
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


playButton : Bool -> msg -> Element msg
playButton playing playPauseMsg =
    case playing of
        False ->
            materialButtonBig ( Filled.play_arrow, playPauseMsg )

        True ->
            materialButtonBig ( Filled.pause, playPauseMsg )


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


volumeButton : Bool -> msg -> Element msg
volumeButton mute muteMsg =
    case mute of
        False ->
            materialButton ( Filled.volume_up, muteMsg )

        True ->
            materialButton ( Filled.volume_off, muteMsg )


repeatButton : RepeatType -> msg -> Element msg
repeatButton repeat repeatMsg =
    case repeat of
        Off ->
            materialButton ( Filled.repeat, repeatMsg )

        One ->
            materialButton ( Filled.repeat_one, repeatMsg )

        All ->
            materialButton ( Filled.repeat_one_on, repeatMsg )


shuffleButton : Bool -> msg -> Element msg
shuffleButton shuffle shuffleMsg =
    case shuffle of
        False ->
            materialButton ( Filled.shuffle, shuffleMsg )

        True ->
            materialButton ( Filled.shuffle_on, shuffleMsg )


controlButton : msg -> Element msg
controlButton controlMenuMsg =
    materialButton ( Filled.more_vert, controlMenuMsg )
