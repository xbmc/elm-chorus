module Components.DialogView exposing (config)

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

