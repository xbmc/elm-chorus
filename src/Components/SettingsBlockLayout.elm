module Components.SettingsBlockLayout exposing (..)

import Color
import Dropdown exposing (OutMsg(..), Placement(..))
import Element exposing (..)
import Material.Icons.Types exposing (Coloring(..))
import WSDecoder exposing (LocalSettings, Option, SettingDefault(..), SettingsObj, stringInDefaultElementToString)
import Widget.Material as Material


type alias Options =
    { name : String
    }


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


getAddonList : Int -> List SettingsObj -> List Option
getAddonList nth list =
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
            case val.definition of
                Nothing ->
                    []

                Just def ->
                    def.options


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
