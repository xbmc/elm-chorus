module Pages.Settings.Kodi.System exposing (Model, Msg, Params, page)

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
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
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
    , monitorDropdown : Dropdown Option
    , monitorSelected : String
    , displayDropdown : Dropdown Option
    , displaySelected : String
    , resolutionDropdown : Dropdown Option
    , resolutionSelected : String
    , audioOutputDropdown : Dropdown Option
    , audioOutputSelected : String
    , channelNumberDropdown : Dropdown Option
    , channelNumberSelected : String
    , playGUIDropdown : Dropdown Option
    , playGUISelected : String
    , proxyDropdown : Dropdown Option
    , proxySelected : String
    , updateDropdown : Dropdown Option
    , updateSelected : String
    , officialDropdown : Dropdown Option
    , officialSelected : String
    , blankToggle : Bool
    , proxyToggle : Bool
    , wakeupToggle : Bool
    , notifToggle : Bool
    , sourcesToggle : Bool
    , debugToggle : Bool
    , componentToggle : Bool
    , eventToggle : Bool
    , notifLoggingToggle : Bool
    , volumeTextField : String
    , guiTextField : String
    , serverTextField : String
    , portTextField : String
    , usernameTextField : String
    , passwordTextField : String
    , internetTextField : String
    , displayTextField : String
    , screenshotTextField : String
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , settingsList = shared.settings_list
      , monitorDropdown =
            Dropdown.init
                |> Dropdown.id "monitor"
                |> Dropdown.optionsBy .label (getOptionList 135 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 135 shared.settings_list)
      , monitorSelected = getTextFieldVal 135 shared.settings_list
      , displayDropdown =
            Dropdown.init
                |> Dropdown.id "display"
                |> Dropdown.optionsBy .label (getOptionList 136 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 136 shared.settings_list)
      , displaySelected = getTextFieldVal 136 shared.settings_list
      , resolutionDropdown =
            Dropdown.init
                |> Dropdown.id "resolution"
                |> Dropdown.optionsBy .label (getOptionList 137 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 137 shared.settings_list)
      , resolutionSelected = getTextFieldVal 137 shared.settings_list
      , audioOutputDropdown =
            Dropdown.init
                |> Dropdown.id "audioOutput"
                |> Dropdown.optionsBy .label (getOptionList 139 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 139 shared.settings_list)
      , audioOutputSelected = getTextFieldVal 139 shared.settings_list
      , channelNumberDropdown =
            Dropdown.init
                |> Dropdown.id "channelName"
                |> Dropdown.optionsBy .label (getOptionList 140 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 140 shared.settings_list)
      , channelNumberSelected = getTextFieldVal 140 shared.settings_list
      , playGUIDropdown =
            Dropdown.init
                |> Dropdown.id "playGUI"
                |> Dropdown.optionsBy .label (getOptionList 142 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 142 shared.settings_list)
      , playGUISelected = getTextFieldVal 142 shared.settings_list
      , proxyDropdown =
            Dropdown.init
                |> Dropdown.id "proxy"
                |> Dropdown.optionsBy .label (getOptionList 148 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 148 shared.settings_list)
      , proxySelected = getTextFieldVal 148 shared.settings_list
      , updateDropdown =
            Dropdown.init
                |> Dropdown.id "update"
                |> Dropdown.optionsBy .label (getOptionList 156 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 156 shared.settings_list)
      , updateSelected = getTextFieldVal 156 shared.settings_list
      , officialDropdown =
            Dropdown.init
                |> Dropdown.id "official"
                |> Dropdown.optionsBy .label (getOptionList 159 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 159 shared.settings_list)
      , officialSelected = getTextFieldVal 159 shared.settings_list
      , blankToggle = getBoolVal 138 shared.settings_list
      , proxyToggle = getBoolVal 147 shared.settings_list
      , wakeupToggle = getBoolVal 155 shared.settings_list
      , notifToggle = getBoolVal 157 shared.settings_list
      , sourcesToggle = getBoolVal 158 shared.settings_list
      , debugToggle = getBoolVal 160 shared.settings_list
      , componentToggle = getBoolVal 161 shared.settings_list
      , eventToggle = getBoolVal 164 shared.settings_list
      , notifLoggingToggle = getBoolVal 165 shared.settings_list
      , volumeTextField = getTextFieldVal 141 shared.settings_list
      , guiTextField = getTextFieldVal 143 shared.settings_list
      , serverTextField = getTextFieldVal 149 shared.settings_list
      , portTextField = getTextFieldVal 150 shared.settings_list
      , usernameTextField = getTextFieldVal 151 shared.settings_list
      , passwordTextField = getTextFieldVal 152 shared.settings_list
      , internetTextField = getTextFieldVal 153 shared.settings_list
      , displayTextField = getTextFieldVal 154 shared.settings_list
      , screenshotTextField = getTextFieldVal 163 shared.settings_list
      }
    , sendAction """{"jsonrpc": "2.0", "method": "Settings.GetSettings", "params": {}, "id": 1 }"""
    )


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
                    |> Dropdown.inputAttributes [ scrollbarX, width (px 400), Font.alignLeft, Border.widthEach { top = 0, bottom = 1, left = 0, right = 0 }, Border.rounded 0, Font.medium, Font.size 13 ]
                    |> Dropdown.view msg
                , el [ alignRight ] (Element.html (Filled.expand_more 18 Inherit))
                ]
            ]
        , row []
            [ el [ width (px 300) ] (text "")
            , paragraph [ width (px 400), Font.size 12, Font.color (rgb255 142 142 142) ] [ text description ]
            ]
        ]



-- UPDATE


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
    | MonitorDropdownMsg (Dropdown.Msg Option)
    | DisplayDropdownMsg (Dropdown.Msg Option)
    | ResolutionDropdownMsg (Dropdown.Msg Option)
    | AudioOutputDropdownMsg (Dropdown.Msg Option)
    | ChannelNumberDropdownMsg (Dropdown.Msg Option)
    | PlayGUIDropdownMsg (Dropdown.Msg Option)
    | UpdateDropdownMsg (Dropdown.Msg Option)
    | OfficialDropdownMsg (Dropdown.Msg Option)
    | ProxyDropdownMsg (Dropdown.Msg Option)
    | BlankToggleMsg
    | ProxyToggleMsg
    | WakeupToggleMsg
    | NotifToggleMsg
    | SourcesToggleMsg
    | DebugToggleMsg
    | ComponentToggleMsg
    | EventToggleMsg
    | NotifLoggingToggleMsg
    | VolumeTextField String
    | GuiTextField String
    | ServerTextField String
    | PortTextField String
    | UsernameTextField String
    | PasswordTextField String
    | InternetTextField String
    | DisplayTextField String
    | ScreenshotTextField String
    | SaveSettingsMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveSettingsMsg ->
            ( model
            , sendActions
                [ """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoscreen.monitor", "value" :\"""" ++ model.monitorSelected ++ """" }, " id ": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoscreen.screen", "value" :\"""" ++ model.displaySelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoscreen.resolution", "value" :\"""" ++ model.resolutionSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoscreen.blankdisplays", "value" :"""
                    ++ (if model.blankToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "audiooutput.audiodevice", "value" :\"""" ++ model.audioOutputSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "audiooutput.channels", "value" :\"""" ++ model.channelNumberSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "audiooutput.volumesteps", "value" :""" ++ model.volumeTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "audiooutput.guisoundmode", "value" :\"""" ++ model.playGUISelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "lookandfeel.soundskin", "value" :""" ++ model.guiTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "network.usehttpproxy", "value" :"""
                    ++ (if model.proxyToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "network.httpproxytype", "value" :\"""" ++ model.proxySelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "network.httpproxyserver", "value" :""" ++ model.serverTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "network.httpproxyport", "value" :""" ++ model.portTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "network.httpproxyusername", "value" :\"""" ++ model.usernameTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "network.httpproxypassword", "value" :\"""" ++ model.passwordTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "network.bandwidth", "value" :\"""" ++ model.internetTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "powermanagement.displaysoff", "value" :""" ++ model.displayTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "powermanagement.wakeonaccess", "value" :"""
                    ++ (if model.wakeupToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "general.addonupdates", "value" :\"""" ++ model.updateSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "general.addonnotifications", "value" :"""
                    ++ (if model.notifToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "addons.unknownsources", "value" :"""
                    ++ (if model.sourcesToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "addons.updatemode", "value" :\"""" ++ model.officialSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "debug.showloginfo", "value" :"""
                    ++ (if model.debugToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "debug.extralogging", "value" :"""
                    ++ (if model.componentToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "debug.screenshotpath", "value" :\"""" ++ model.screenshotTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "eventlog.enabled", "value" :"""
                    ++ (if model.eventToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "eventlog.enablednotifications", "value" :"""
                    ++ (if model.notifLoggingToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                ]
            )

        VolumeTextField changeText ->
            ( { model | volumeTextField = changeText }, Cmd.none )

        GuiTextField changeText ->
            ( { model | guiTextField = changeText }, Cmd.none )

        ServerTextField changeText ->
            ( { model | serverTextField = changeText }, Cmd.none )

        PortTextField changeText ->
            ( { model | portTextField = changeText }, Cmd.none )

        UsernameTextField changeText ->
            ( { model | usernameTextField = changeText }, Cmd.none )

        PasswordTextField changeText ->
            ( { model | passwordTextField = changeText }, Cmd.none )

        InternetTextField changeText ->
            ( { model | internetTextField = changeText }, Cmd.none )

        DisplayTextField changeText ->
            ( { model | displayTextField = changeText }, Cmd.none )

        ScreenshotTextField changeText ->
            ( { model | screenshotTextField = changeText }, Cmd.none )

        BlankToggleMsg ->
            ( { model | blankToggle = not model.blankToggle }, Cmd.none )

        ProxyToggleMsg ->
            ( { model | proxyToggle = not model.proxyToggle }, Cmd.none )

        WakeupToggleMsg ->
            ( { model | wakeupToggle = not model.wakeupToggle }, Cmd.none )

        NotifToggleMsg ->
            ( { model | notifToggle = not model.notifToggle }, Cmd.none )

        SourcesToggleMsg ->
            ( { model | sourcesToggle = not model.sourcesToggle }, Cmd.none )

        DebugToggleMsg ->
            ( { model | debugToggle = not model.debugToggle }, Cmd.none )

        ComponentToggleMsg ->
            ( { model | componentToggle = not model.componentToggle }, Cmd.none )

        EventToggleMsg ->
            ( { model | eventToggle = not model.eventToggle }, Cmd.none )

        NotifLoggingToggleMsg ->
            ( { model | notifLoggingToggle = not model.notifLoggingToggle }, Cmd.none )

        ReplaceMe ->
            ( model, Cmd.none )

        MonitorDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.monitorDropdown
            in
            ( { model
                | monitorDropdown = dropdown
                , monitorSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.monitorSelected
              }
            , Cmd.map MonitorDropdownMsg cmd
            )

        DisplayDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.displayDropdown
            in
            ( { model
                | displayDropdown = dropdown
                , displaySelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.displaySelected
              }
            , Cmd.map DisplayDropdownMsg cmd
            )

        ResolutionDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.resolutionDropdown
            in
            ( { model
                | resolutionDropdown = dropdown
                , resolutionSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.resolutionSelected
              }
            , Cmd.map ResolutionDropdownMsg cmd
            )

        AudioOutputDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.audioOutputDropdown
            in
            ( { model
                | audioOutputDropdown = dropdown
                , audioOutputSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.audioOutputSelected
              }
            , Cmd.map AudioOutputDropdownMsg cmd
            )

        ChannelNumberDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.channelNumberDropdown
            in
            ( { model
                | channelNumberDropdown = dropdown
                , channelNumberSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.channelNumberSelected
              }
            , Cmd.map ChannelNumberDropdownMsg cmd
            )

        PlayGUIDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.playGUIDropdown
            in
            ( { model
                | playGUIDropdown = dropdown
                , playGUISelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.playGUISelected
              }
            , Cmd.map PlayGUIDropdownMsg cmd
            )

        ProxyDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.proxyDropdown
            in
            ( { model
                | proxyDropdown = dropdown
                , proxySelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.proxySelected
              }
            , Cmd.map ProxyDropdownMsg cmd
            )

        UpdateDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.updateDropdown
            in
            ( { model
                | updateDropdown = dropdown
                , updateSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.updateSelected
              }
            , Cmd.map UpdateDropdownMsg cmd
            )

        OfficialDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.officialDropdown
            in
            ( { model
                | officialDropdown = dropdown
                , officialSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.officialSelected
              }
            , Cmd.map OfficialDropdownMsg cmd
            )


subscriptions : Model -> Sub Msg
subscriptions model =
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
    { title = "Settings.Kodi.System"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Display")
                , settingsDropdownBlock model.monitorDropdown MonitorDropdownMsg "Monitor" ""
                , settingsDropdownBlock model.displayDropdown DisplayDropdownMsg "Display mode" "Changes the way this application is displayed on the selected screen. Either in a window or fullscreen."
                , settingsDropdownBlock model.resolutionDropdown ResolutionDropdownMsg "Resolution" "Changes the resolution that the user interface is displayed in."
                , settingsToggleBlock model.blankToggle BlankToggleMsg "Blank other displays" "In a multi-screen configuration, the screens not displaying this application are blacked out."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Audio")
                , settingsDropdownBlock model.audioOutputDropdown AudioOutputDropdownMsg "Audio output device" "Select the device to be used for playback of audio that has been decoded such as mp3."
                , settingsDropdownBlock model.channelNumberDropdown ChannelNumberDropdownMsg "Number of channels" ""
                , settingsInputBlock model.volumeTextField VolumeTextField "Volume control steps" "Set the number of volume control steps."
                , settingsDropdownBlock model.playGUIDropdown PlayGUIDropdownMsg "Play GUI sounds" "Configure how interface sounds are handled, such as menu navigation and important notifications."
                , settingsInputBlock model.guiTextField GuiTextField "GUI sounds" "Select or disable the sounds used in the user interface."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Internet access")
                , settingsToggleBlock model.proxyToggle ProxyToggleMsg "User proxy server" "If your Internet connection uses a proxy server, configure it here."
                , settingsDropdownBlock model.proxyDropdown ProxyDropdownMsg "Proxy type" "Configure which proxy type is used."
                , settingsInputBlock model.serverTextField ServerTextField "Server" "Configure the proxy server address."
                , settingsInputBlock model.portTextField PortTextField "Port" "Configure the proxy server port"
                , settingsInputBlock model.usernameTextField UsernameTextField "Username" "Configure the proxy server username."
                , settingsInputBlock model.passwordTextField PasswordTextField "Password" "Configure the proxy server passoword."
                , settingsInputBlock model.internetTextField InternetTextField "Internet connection bandwidth limitation" "If your Internet connection has limited bandwidth available, use this setting to keep bandwidth usage by this application within defined limits."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Power saving")
                , settingsInputBlock model.displayTextField DisplayTextField "Put display to sleep when idle" "Turn off display when idle. Useful for TVs that turn off when there is no display signal detected"
                , settingsToggleBlock model.wakeupToggle WakeupToggleMsg "Try to wakeup remote servers on access" "Automatically send Wake-on-LAN to server(s) right before trying to access shared files or services."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Add-ons")
                , settingsDropdownBlock model.updateDropdown UpdateDropdownMsg "Updates" "Change how auto updating of add-ons are handled."
                , settingsToggleBlock model.notifToggle NotifToggleMsg "Show notifications" "Show notification when an add-ons have been updated."
                , settingsToggleBlock model.sourcesToggle SourcesToggleMsg "Unknown sources" "Allow installation of add-ons unknown sources."
                , settingsDropdownBlock model.officialDropdown OfficialDropdownMsg "Update official add-ons from" "By default, add-ons from official repositories will be prevented from being auto-updated from private repositories. For cases such as updating from an add-ons beta repository this option can be switched to [Any repositories] (bear in mind this is a less secure option and enabling it could cause incompatibility and crashes)."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Logging")
                , settingsToggleBlock model.debugToggle DebugToggleMsg "Enable debug logging" "Turn debug logging on or off. Useful for troubleshooting."
                , settingsToggleBlock model.componentToggle ComponentToggleMsg "Enable component-specific logging" "Enable verbose messages from additional libraries to be included in the debug log."
                , settingsInputBlock model.screenshotTextField ScreenshotTextField "Screenshot folder" "Select the folder where screenshots should be saved in."
                , settingsToggleBlock model.eventToggle EventToggleMsg "Enable event logging" "Event logging allows to keep track of what has happened."
                , settingsToggleBlock model.notifLoggingToggle NotifLoggingToggleMsg "Enable notification event logging" "Notification event describe regular processes and actions performed by the system or the user."
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
