module Pages.Settings.Kodi.Interface exposing (Model, Msg, Params, page)

import Colors
import Components.SettingsBlockLayout exposing (..)
import Components.VerticalNavSettings
import Dropdown exposing (Dropdown, OutMsg(..), Placement(..))
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Material.Icons as Filled
import Material.Icons.Types exposing (Coloring(..))
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import WSDecoder exposing (Option, SettingDefault(..), SettingsObj)
import Widget
import Widget.Material as Material


page : Page Params Model Msg
page =
    Page.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , save = save
        , load = load
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route
    , settingsList : List SettingsObj
    , skinDropdown : Dropdown Option
    , skinSelected : String
    , themeDropdown : Dropdown Option
    , themeSelected : String
    , colorDropdown : Dropdown Option
    , colorSelected : String
    , fontDropdown : Dropdown Option
    , fontSelected : String
    , languageDropdown : Dropdown Option
    , languageSelected : String
    , characterDropdown : Dropdown Option
    , characterSelected : String
    , regionDropdown : Dropdown Option
    , regionSelected : String
    , countryTimezoneDropdown : Dropdown Option
    , countryTimezoneSelected : String
    , timezoneDropdown : Dropdown Option
    , timezoneSelected : String
    , screensaverDropdown : Dropdown Option
    , screensaverSelected : String
    , performDropdown : Dropdown Option
    , performSelected : String
    , startupDropdown : Dropdown Option
    , startupSelected : String
    , rssToggle : Bool
    , visualToggle : Bool
    , videoToggle : Bool
    , startupToggle : Bool
    , zoomTextField : String
    , editTextField : String
    , waitTextField : String
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , settingsList = shared.settings_list
      , skinDropdown =
            Dropdown.init
                |> Dropdown.id "skin"
                |> Dropdown.optionsBy .label (getOptionList 3 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 3 shared.settings_list)
      , skinSelected = getTextFieldVal 3 shared.settings_list
      , themeDropdown =
            Dropdown.init
                |> Dropdown.id "theme"
                |> Dropdown.optionsBy .label (getOptionList 5 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 5 shared.settings_list)
      , themeSelected = getTextFieldVal 5 shared.settings_list
      , colorDropdown =
            Dropdown.init
                |> Dropdown.id "color"
                |> Dropdown.optionsBy .label (getOptionList 6 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 6 shared.settings_list)
      , colorSelected = getTextFieldVal 6 shared.settings_list
      , fontDropdown =
            Dropdown.init
                |> Dropdown.id "font"
                |> Dropdown.optionsBy .label (getOptionList 7 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 7 shared.settings_list)
      , fontSelected = getTextFieldVal 7 shared.settings_list
      , languageDropdown =
            Dropdown.init
                |> Dropdown.id "language"
                |> Dropdown.optionsBy .label (getOptionList 11 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 11 shared.settings_list)
      , languageSelected = getTextFieldVal 11 shared.settings_list
      , characterDropdown =
            Dropdown.init
                |> Dropdown.id "character"
                |> Dropdown.optionsBy .label (getOptionList 12 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 12 shared.settings_list)
      , characterSelected = getTextFieldVal 12 shared.settings_list
      , regionDropdown =
            Dropdown.init
                |> Dropdown.id "region"
                |> Dropdown.optionsBy .label (getOptionList 14 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 14 shared.settings_list)
      , regionSelected = getTextFieldVal 14 shared.settings_list
      , countryTimezoneDropdown =
            Dropdown.init
                |> Dropdown.id "countryTimezone"
                |> Dropdown.optionsBy .label (getOptionList 15 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 15 shared.settings_list)
      , countryTimezoneSelected = getTextFieldVal 15 shared.settings_list
      , timezoneDropdown =
            Dropdown.init
                |> Dropdown.id "timezone"
                |> Dropdown.optionsBy .label (getOptionList 16 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 16 shared.settings_list)
      , timezoneSelected = getTextFieldVal 16 shared.settings_list
      , screensaverDropdown =
            Dropdown.init
                |> Dropdown.id "screensaver"
                |> Dropdown.optionsBy .label (getOptionList 17 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 17 shared.settings_list)
      , screensaverSelected = getTextFieldVal 17 shared.settings_list
      , performDropdown =
            Dropdown.init
                |> Dropdown.id "perform"
                |> Dropdown.optionsBy .label (getOptionList 25 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 25 shared.settings_list)
      , performSelected = getTextFieldVal 25 shared.settings_list
      , startupDropdown =
            Dropdown.init
                |> Dropdown.id "startup"
                |> Dropdown.optionsBy .label (getOptionList 26 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 26 shared.settings_list)
      , startupSelected = getTextFieldVal 26 shared.settings_list
      , rssToggle = getBoolVal 9 shared.settings_list
      , visualToggle = getBoolVal 21 shared.settings_list
      , videoToggle = getBoolVal 22 shared.settings_list
      , startupToggle = getBoolVal 24 shared.settings_list
      , zoomTextField = getTextFieldVal 8 shared.settings_list
      , editTextField = getTextFieldVal 10 shared.settings_list
      , waitTextField = getTextFieldVal 20 shared.settings_list
      }
    , sendAction """{"jsonrpc": "2.0", "method": "Settings.GetSettings", "params": {}, "id": 1 }"""
    )



-- UPDATE


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


settingsDropdownBlock : Dropdown Option -> (Dropdown.Msg Option -> Msg) -> String -> String -> Element Msg
settingsDropdownBlock dropdown msg title description =
    column [ paddingEach { top = 0, bottom = 30, left = 20, right = 20 } ]
        [ row [ paddingEach { top = 0, bottom = 20, left = 0, right = 0 } ]
            [ paragraph [ width (px 300), Font.size 14, Font.color (rgb255 3 3 3), Font.medium ] [ text title ]
            , row [ width (px 400), Font.size 14, Font.color (rgb255 3 3 3), Font.light, paddingXY 0 5 ]
                [ Dropdown.labelHidden ( True, "nolabel" ) dropdown
                    |> Dropdown.menuAttributes [ Background.color (rgb255 85 85 85), Font.color (rgb255 255 255 255), Font.medium, Font.size 13 ]
                    |> Dropdown.optionSelectedAttributes [ Background.color (rgb255 117 117 117) ]
                    |> Dropdown.maxHeight 300
                    |> Dropdown.inputAttributes [ width (px 400), Font.alignLeft, Border.widthEach { top = 0, bottom = 1, left = 0, right = 0 }, Border.rounded 0, Font.medium, Font.size 13 ]
                    |> Dropdown.view msg
                , el [ alignRight ] (Element.html (Filled.expand_more 18 Inherit))
                ]
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


type Msg
    = ReplaceMe
    | SkinDropdownMsg (Dropdown.Msg Option)
    | ThemeDropdownMsg (Dropdown.Msg Option)
    | ColorDropdownMsg (Dropdown.Msg Option)
    | FontDropdownMsg (Dropdown.Msg Option)
    | LanguageDropdownMsg (Dropdown.Msg Option)
    | CharacterDropdownMsg (Dropdown.Msg Option)
    | RegionDropdownMsg (Dropdown.Msg Option)
    | CountryTimezoneDropdownMsg (Dropdown.Msg Option)
    | TimezoneDropdownMsg (Dropdown.Msg Option)
    | ScreensaverDropdownMsg (Dropdown.Msg Option)
    | PerformDropdownMsg (Dropdown.Msg Option)
    | StartupDropdownMsg (Dropdown.Msg Option)
    | RssToggleMsg
    | VisualToggleMsg
    | VideoToggleMsg
    | StartupToggleMsg
    | ZoomTextFieldMsg String
    | EditTextFieldMsg String
    | WaitTextFieldMsg String
    | SaveSettingsMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveSettingsMsg ->
            ( model
            , sendActions
                [ """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.skin", "value" :\"""" ++ model.skinSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.skintheme", "value" : \"""" ++ model.themeSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.skincolors", "value" :\"""" ++ model.colorSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.font", "value" :\"""" ++ model.fontSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.skinzoom", "value" :""" ++ model.zoomTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.enablerssfeeds", "value" :"""
                    ++ (if model.rssToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.rssedit", "value" :\"""" ++ model.editTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "locale.language", "value" :\"""" ++ model.languageSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "locale.charset", "value" :\"""" ++ model.characterSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "locale.country", "value" :\"""" ++ model.regionSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "locale.timezonecountry", "value" :\"""" ++ model.countryTimezoneSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "locale.timezone", "value" :\"""" ++ model.timezoneSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "screensaver.mode", "value" :\"""" ++ model.screensaverSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "screensaver.time", "value" :\"""" ++ model.waitTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "screensaver.usemusicvisinstead", "value" :"""
                    ++ (if model.visualToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "screensaver.usedimonpause", "value" :"""
                    ++ (if model.videoToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "masterlock.startuplock", "value" :"""
                    ++ (if model.startupToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.startupaction", "value" :\"""" ++ model.performSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.startupwindow", "value" :\"""" ++ model.startupSelected ++ """" }, "id": 1 }"""
                ]
            )

        ZoomTextFieldMsg changeText ->
            ( { model | zoomTextField = changeText }, Cmd.none )

        EditTextFieldMsg changeText ->
            ( { model | editTextField = changeText }, Cmd.none )

        WaitTextFieldMsg changeText ->
            ( { model | waitTextField = changeText }, Cmd.none )

        RssToggleMsg ->
            ( { model | rssToggle = not model.rssToggle }, Cmd.none )

        VisualToggleMsg ->
            ( { model | visualToggle = not model.visualToggle }, Cmd.none )

        VideoToggleMsg ->
            ( { model | videoToggle = not model.videoToggle }, Cmd.none )

        StartupToggleMsg ->
            ( { model | startupToggle = not model.startupToggle }, Cmd.none )

        ReplaceMe ->
            ( model, Cmd.none )

        SkinDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.skinDropdown
            in
            ( { model
                | skinDropdown = dropdown
                , skinSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.skinSelected
              }
            , Cmd.map SkinDropdownMsg cmd
            )

        ThemeDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.themeDropdown
            in
            ( { model
                | themeDropdown = dropdown
                , themeSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.themeSelected
              }
            , Cmd.map ThemeDropdownMsg cmd
            )

        ColorDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.colorDropdown
            in
            ( { model
                | colorDropdown = dropdown
                , colorSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.colorSelected
              }
            , Cmd.map ColorDropdownMsg cmd
            )

        FontDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.fontDropdown
            in
            ( { model
                | fontDropdown = dropdown
                , fontSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.fontSelected
              }
            , Cmd.map FontDropdownMsg cmd
            )

        LanguageDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.languageDropdown
            in
            ( { model
                | languageDropdown = dropdown
                , languageSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.languageSelected
              }
            , Cmd.map LanguageDropdownMsg cmd
            )

        CharacterDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.characterDropdown
            in
            ( { model
                | characterDropdown = dropdown
                , characterSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.characterSelected
              }
            , Cmd.map CharacterDropdownMsg cmd
            )

        RegionDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.regionDropdown
            in
            ( { model
                | regionDropdown = dropdown
                , regionSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.regionSelected
              }
            , Cmd.map RegionDropdownMsg cmd
            )

        CountryTimezoneDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.countryTimezoneDropdown
            in
            ( { model
                | countryTimezoneDropdown = dropdown
                , countryTimezoneSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.countryTimezoneSelected
              }
            , Cmd.map CountryTimezoneDropdownMsg cmd
            )

        TimezoneDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.timezoneDropdown
            in
            ( { model
                | timezoneDropdown = dropdown
                , timezoneSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.timezoneSelected
              }
            , Cmd.map TimezoneDropdownMsg cmd
            )

        ScreensaverDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.screensaverDropdown
            in
            ( { model
                | screensaverDropdown = dropdown
                , screensaverSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.screensaverSelected
              }
            , Cmd.map ScreensaverDropdownMsg cmd
            )

        PerformDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.performDropdown
            in
            ( { model
                | performDropdown = dropdown
                , performSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.performSelected
              }
            , Cmd.map PerformDropdownMsg cmd
            )

        StartupDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.startupDropdown
            in
            ( { model
                | startupDropdown = dropdown
                , startupSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.startupSelected
              }
            , Cmd.map StartupDropdownMsg cmd
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | settings_list = model.settingsList }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | settingsList = shared.settings_list }, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Kodi.Interface"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Skin")

                -- , text (Debug.toString model.settingsList)
                , settingsDropdownBlock model.skinDropdown SkinDropdownMsg "Skin" "Select the skin for the user interface. This will define the look and feel of the application."
                , settingsDropdownBlock model.themeDropdown ThemeDropdownMsg "Theme" "Change the theme associated with your selected skin."
                , settingsDropdownBlock model.colorDropdown ColorDropdownMsg "Colors" "Change the colours of your selected skin."
                , settingsDropdownBlock model.fontDropdown FontDropdownMsg "Fonts" "Choose the fonts displayed in the user interface. The font sets are configured by your skin."
                , settingsInputBlock model.zoomTextField ZoomTextFieldMsg "Zoom" "Resize the view of the user interface."
                , settingsToggleBlock model.rssToggle RssToggleMsg "Show RSS news feeds" "Turn this off to remove the scrolling RSS news ticker."
                , settingsInputBlock model.editTextField EditTextFieldMsg "Edit" "Edit the RSS feeds."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Regional")
                , settingsDropdownBlock model.languageDropdown LanguageDropdownMsg "Language" "Chooses the language of the user interface."
                , settingsDropdownBlock model.characterDropdown CharacterDropdownMsg "Character set" "Choose which character set is used for displaying text in the user interface. This doesn't change the character set used for subtitles, for that go to Player &gt; Language."
                , settingsDropdownBlock model.regionDropdown RegionDropdownMsg "Region default format" "Select the formats for temperature, time and date. The available options depend on the selected language."
                , settingsDropdownBlock model.countryTimezoneDropdown CountryTimezoneDropdownMsg "Timezone country" "Select country location."
                , settingsDropdownBlock model.timezoneDropdown TimezoneDropdownMsg "Timezone" "Select your current timezone."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Screensaver")
                , settingsDropdownBlock model.screensaverDropdown ScreensaverDropdownMsg "Screensaver mode" "Select the screensaver. The \"Dim\" screensaver will be forced when fullscreen video playback is paused or a dialogue box is active."
                , settingsInputBlock model.waitTextField WaitTextFieldMsg "Wait time" "Set the time to wait for any activity to occur before displaying the screensaver."
                , settingsToggleBlock model.visualToggle VisualToggleMsg "Use visualisation if playing audio" "If music is being played, the selected visualisation will be started instead of displaying the screensaver."
                , settingsToggleBlock model.videoToggle VideoToggleMsg "Use dim if paused during video playback" "Dim the display when media is paused. Not valid for the \"Dim\" screensaver mode."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Master lock")
                , settingsToggleBlock model.startupToggle StartupToggleMsg "Ask for master lock code on startup" "If enabled, the master lock code is required to unlock this application on startup."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Startup")
                , settingsDropdownBlock model.performDropdown PerformDropdownMsg "Perform on startup" "Select an action Kodi will perform on startup."
                , settingsDropdownBlock model.startupDropdown StartupDropdownMsg "Startup window" "Select the media window to display on startup."
                , row [ width (px 800), Background.color Colors.headerBackground, paddingXY 20 25 ]
                    [ Input.button [ Background.color Colors.cerulean, Font.color Colors.white, paddingXY 30 8, Font.size 14, Border.rounded 2 ]
                        { onPress = Just SaveSettingsMsg
                        , label = text "SAVE"
                        }
                    ]
                , el [ height (px 100) ] (text "")
                ]
            ]
        ]
    }
