module Components.DialogView exposing (config, textInputConfig)

import Colors
import Dialog exposing (Config)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input



-- DIALOG BOX


config : msg -> Config msg
config closeDialogMsg =
    { closeMessage = Just closeDialogMsg
    , maskAttributes = []
    , containerAttributes =
        [ Background.color Colors.white
        , Border.rounded 5
        , centerX
        , centerY
        , padding 10
        , spacing 20
        , width (px 400)
        ]
    , headerAttributes = [ Font.size 24, Font.color Colors.red, padding 5 ]
    , bodyAttributes = [ padding 20, Font.size 24, Font.color Colors.grey ]
    , footerAttributes = []
    , header = Just (text "")
    , body = Just body
    , footer = Just (footerButtons closeDialogMsg)
    }


body : Element msg
body =
    column [ width fill ] [ el [ centerX ] (text "Lost connection to Kodi") ]


footerButtons : msg -> Element msg
footerButtons closeDialogMsg =
    row [ width fill, padding 2, spacing 5 ]
        [ Input.button
            [ Background.color Colors.cerulean
            , Font.color Colors.white
            , Font.bold
            , Border.rounded 3
            , paddingXY 30 12
            , centerX
            , mouseOver
                [ Background.color Colors.cerulean
                , Font.color Colors.grey
                ]
            ]
            { onPress = Just closeDialogMsg
            , label = text "ATTEMPT TO RECONNECT"
            }
        ]


textInputConfig : String -> msg -> (String -> msg) -> Config msg
textInputConfig playlistName closeDialogMsg textChangeMsg =
    { closeMessage = Just closeDialogMsg
    , maskAttributes = []
    , containerAttributes =
        [ Background.color Colors.white

        -- , Border.rounded 5
        , centerX

        -- , centerY
        -- , padding 10
        , spacing 20
        , width (px 600)
        ]
    , headerAttributes = [ Background.color Colors.greyscaleShark, Font.size 14, Font.color Colors.white, paddingXY 15 20 ]
    , bodyAttributes = [ paddingXY 15 0, Font.size 14, Font.color Colors.grey ]
    , footerAttributes = [ Background.color Colors.navHoverBackground, paddingXY 15 10 ]
    , header = Just (text "Add a new playlist")
    , body = Just (textInputBody playlistName textChangeMsg)
    , footer = Just (textInputFooterButtons closeDialogMsg)
    }


textInputBody : String -> (String -> msg) -> Element msg
textInputBody playlistName textChangeMsg =
    column [ width fill ]
        [ Input.text
            [ centerX ]
            { onChange = textChangeMsg
            , text = playlistName
            , placeholder = Nothing
            , label = Input.labelAbove [] (text "Give your playlist a name")
            }
        ]


textInputFooterButtons : msg -> Element msg
textInputFooterButtons closeDialogMsg =
    row [ width fill, padding 2, spacing 5 ]
        [ Input.button
            [ Background.color Colors.white
            , Font.color Colors.black
            , Border.rounded 3
            , paddingXY 30 12
            , alignRight
            , mouseOver
                [ Border.shadow
                    { offset = ( 4, 4 )
                    , size = 5
                    , blur = 10
                    , color = color.lightGrey
                    }
                ]
            ]
            { onPress = Just closeDialogMsg
            , label = text "CLOSE"
            }
        , Input.button
            [ Background.color Colors.cerulean
            , Font.color Colors.white
            , Border.rounded 3
            , paddingXY 30 12
            , alignRight
            , mouseOver
                [ Border.shadow
                    { offset = ( 4, 4 )
                    , size = 5
                    , blur = 10
                    , color = color.lightGrey
                    }
                , Background.color Colors.greyCerulean
                ]
            ]
            { onPress = Just closeDialogMsg
            , label = text "OK"
            }
        ]


color =
    { lightGrey = rgb255 0xE0 0xE0 0xE0
    }
