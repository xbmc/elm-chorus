module Components.SettingsBlockLayout exposing (..)

import Color
import Dropdown exposing (OutMsg(..), Placement(..))
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Material.Icons.Types exposing (Coloring(..))
import WSDecoder exposing (LocalSettings, Option, SettingDefault(..), SettingsObj, stringInDefaultElementToString)
import Widget
import Widget.Material as Material


type alias Options =
    { name : String
    }


settingsInputBlock : String -> (String -> msg) -> String -> String -> Element msg
settingsInputBlock val msg title description =
    column [ paddingEach { top = 0, bottom = 30, left = 20, right = 20 } ]
        [ row [ paddingEach { top = 0, bottom = 20, left = 0, right = 0 } ]
            [ paragraph [ width (px 300), Font.size 14, Font.color (rgb255 3 3 3), Font.medium ] [ text title ]
            , Input.text [ width (px 400), Font.size 14, Font.color (rgb255 3 3 3), Border.widthEach { top = 0, bottom = 1, left = 0, right = 0 }, Border.rounded 0, Font.medium, Border.color (rgb255 3 3 3), Font.size 13 ]
                { onChange = msg
                , text = val
                , placeholder = Nothing
                , label = Input.labelHidden ""
                }
            ]
        , row []
            [ el [ width (px 300) ] (text "")
            , paragraph [ width (px 400), Font.size 12, Font.color (rgb255 142 142 142) ] [ text description ]
            ]
        ]


settingsToggleBlock : Bool -> msg -> String -> String -> Element msg
settingsToggleBlock isToggleActive toggleMsg title description =
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
                , onPress = Just toggleMsg
                , active = isToggleActive
                }
            ]
        , descriptionBlock
        ]


stringToBoolValue : String -> Bool
stringToBoolValue textValue =
    if textValue == "false" then
        False

    else
        True


boolToStringValue : Bool -> String
boolToStringValue boolValue =
    if boolValue then
        "true"

    else
        "false"


boolToStringOppositeValue : Bool -> String
boolToStringOppositeValue boolValue =
    if boolValue then
        "false"

    else
        "true"


getVal : Int -> LocalSettings -> String
getVal nth list =
    case list.localSettingsList of
        [] ->
            ""

        _ ->
            let
                x =
                    list.localSettingsList
                        |> List.drop (nth - 1)
                        |> List.head
            in
            case x of
                Just val ->
                    val.value

                _ ->
                    ""


setVal : String -> String -> LocalSettings -> LocalSettings
setVal name text list =
    { localSettingsList =
        list.localSettingsList
            |> List.map
                (\item ->
                    if item.name == name then
                        { item | value = text }

                    else
                        item
                )
    }


getBoolVal : Int -> List SettingsObj -> Bool
getBoolVal nth list =
    let
        x =
            list
                |> List.drop (nth - 1)
                |> List.head
    in
    case x of
        Nothing ->
            True

        Just val ->
            case val.value of
                Just (BoolInSettingDefault bool) ->
                    bool

                _ ->
                    True


getTextFieldVal : Int -> List SettingsObj -> String
getTextFieldVal nth list =
    let
        x =
            list
                |> List.drop (nth - 1)
                |> List.head
    in
    case x of
        Nothing ->
            " "

        Just val ->
            case val.value of
                Just (StringInSettingDefault stringVal) ->
                    stringVal

                Just (IntegerInSettingDefault intVal) ->
                    String.fromInt intVal

                -- Just (UnionArrayInSettingDefault listVal) ->
                --     "abcd"
                _ ->
                    " "


getOptionList : Int -> List SettingsObj -> List Option
getOptionList nth list =
    let
        x =
            list
                |> List.drop (nth - 1)
                |> List.head
    in
    case x of
        Nothing ->
            []

        Just val ->
            case val.options of
                Just optionList ->
                    optionList

                _ ->
                    []


getSelectedOptionFromList : Int -> List SettingsObj -> Maybe Option
getSelectedOptionFromList nth list =
    let
        x =
            list
                |> List.drop (nth - 1)
                |> List.head

        selectedDefault =
            Maybe.andThen
                (\val ->
                    case val.value of
                        Just (StringInSettingDefault stringVal) ->
                            stringVal |> Just

                        Just (IntegerInSettingDefault intVal) ->
                            String.fromInt intVal |> Just

                        -- Just (UnionArrayInSettingDefault listVal) ->
                        --     "abcd"
                        _ ->
                            Nothing
                )
                x
    in
    Maybe.andThen
        (\val ->
            case val.options of
                Just optionList ->
                    optionList |> List.filter (\option -> stringInDefaultElementToString option.value == Maybe.withDefault "" selectedDefault) |> List.head

                _ ->
                    Nothing
        )
        x


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
