module Components.SettingsBlockLayout exposing (..)

import Colors
import Color exposing (Color)
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Dropdown exposing (Dropdown, OutMsg(..), Placement(..))
import Element.Border as Border
import Element.Font as Font
import Element.Events as Events
import Element.Input as Input
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Widget.Material as Material
import Widget


settingsInputBlock : String -> String -> Element msg
settingsInputBlock title description =
    column [ paddingEach { top = 0, bottom = 30, left = 20, right = 20 } ]
        [ row [ paddingEach { top = 0, bottom = 20, left = 0, right = 0 } ]
            [ paragraph [ width (px 275), Font.size 14, Font.color (rgb255 3 3 3), Font.medium ] [ text title ]
            -- , Input.text [width (px 400), Font.size 14] {
            --   onChange = Nothing
            -- , text =
            -- , placeholder = Nothing
            -- , label = Nothing
            --  }
            ]
        , row []
            [ el [ width (px 300) ] (text "")
            , paragraph [ width (px 400), Font.size 12, Font.color (rgb255 142 142 142) ] [ text description ]
            ]
        ]

type alias Options =
    { name : String
    }


settingsToggleBlock : String -> String -> Element msg
settingsToggleBlock title description =
    let
        descriptionBlock =
            if description == "" then
                Element.none

            else
                row []
                    [ el [ width (px 300) ] (text "")
                    , paragraph [ width (px 400), Font.size 12, Font.color (rgb255 142 142 142) ] [ text description ]
                    ]
    in
    column [ paddingEach { top = 0, bottom = 30, left = 20, right = 20 } ]
        [ row [ paddingEach { top = 0, bottom = 0, left = 0, right = 0 } ]
            [ paragraph [ width (px 300), Font.size 14, Font.color (rgb255 3 3 3), Font.medium ] [ text title ]
            , Widget.switch (Material.switch customPalette)
                { description = ""
                , onPress = Nothing
                , active = True
                }
            ]
        , descriptionBlock
        ]

customPalette : Material.Palette
customPalette =
    { primary = Color.rgb255 18 178 231
    , secondary = Color.rgb255 18 178 231
    , background = Color.rgb255 0xFF 0xFF 0xFF
    , surface = Color.rgb255 0xFF 0xFF 0xFF
    , error = Color.rgb255 0xB0 0x00 0x20
    , on =
        { primary = Color.rgb255 0xFF 0xFF 0xFF
        , secondary = Color.rgb255 0x00 0x00 0x00
        , background = Color.rgb255 0x00 0x00 0x00
        , surface = Color.rgb255 0x00 0x00 0x00
        , error = Color.rgb255 0xFF 0xFF 0xFF
        }
    }
