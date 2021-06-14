module Pages.Settings.Kodi.Services exposing (Model, Msg, Params, page)

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
    , webInterfaceDropdown : Dropdown Option
    , webInterfaceSelected : String
    , servicesToggle : Bool
    , remoteHTTPToggle : Bool
    , authToggle : Bool
    , sslToggle : Bool
    , remoteThisSystemToggle : Bool
    , remoteOtherSystemToggle : Bool
    , upnpToggle : Bool
    , shareLibToggle : Bool
    , remoteUPNPToggle : Bool
    , airplayToggle : Bool
    , passwordToggle : Bool
    , deviceNameTextField : String
    , portTextField : String
    , usernameTextField : String
    , passwordTextField : String
    , airplayPasswordTextField : String
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , settingsList = shared.settings_list
      , webInterfaceDropdown =
            Dropdown.init
                |> Dropdown.id "webInterface"
                |> Dropdown.optionsBy .label (getOptionList 124 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 124 shared.settings_list)
      , webInterfaceSelected = getTextFieldVal 124 shared.settings_list
      , servicesToggle = getBoolVal 117 shared.settings_list
      , remoteHTTPToggle = getBoolVal 118 shared.settings_list
      , authToggle = getBoolVal 120 shared.settings_list
      , sslToggle = getBoolVal 123 shared.settings_list
      , remoteThisSystemToggle = getBoolVal 125 shared.settings_list
      , remoteOtherSystemToggle = getBoolVal 126 shared.settings_list
      , upnpToggle = getBoolVal 127 shared.settings_list
      , shareLibToggle = getBoolVal 128 shared.settings_list
      , remoteUPNPToggle = getBoolVal 129 shared.settings_list
      , airplayToggle = getBoolVal 130 shared.settings_list
      , passwordToggle = getBoolVal 131 shared.settings_list
      , deviceNameTextField = getTextFieldVal 116 shared.settings_list
      , portTextField = getTextFieldVal 119 shared.settings_list
      , usernameTextField = getTextFieldVal 121 shared.settings_list
      , passwordTextField = getTextFieldVal 122 shared.settings_list
      , airplayPasswordTextField = getTextFieldVal 132 shared.settings_list
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
    | WebInterfaceDropdownMsg (Dropdown.Msg Option)
    | ServicesToggleMsg
    | RemoteHTTPToggleMsg
    | AuthToggleMsg
    | SslToggleMsg
    | RemoteThisSystemToggleMsg
    | RemoteOtherSystemToggleMsg
    | UpnpToggleMsg
    | ShareLibToggleMsg
    | RemoteUPNPToggleMsg
    | AirplayToggleMsg
    | PasswordToggleMsg
    | DeviceNameTextField String
    | PortTextField String
    | UsernameTextField String
    | PasswordTextField String
    | AirplayPasswordTextField String
    | SaveSettingsMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveSettingsMsg ->
            ( model
            , sendActions
                [ """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.devicename", "value" :\"""" ++ model.deviceNameTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.zeroconf", "value" :"""
                    ++ (if model.servicesToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "servecis.webserver", "value" :"""
                    ++ (if model.remoteHTTPToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.webserverport", "value" :""" ++ model.portTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.webserverauthentication", "value" :"""
                    ++ (if model.authToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.webserverusername", "value" :\"""" ++ model.usernameTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.webserverpassword", "value" :\"""" ++ model.passwordTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.webserverssl", "value" :"""
                    ++ (if model.sslToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.webskin", "value" :\"""" ++ model.webInterfaceSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.esenabled", "value" :"""
                    ++ (if model.remoteThisSystemToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.esallinterfaces", "value" :"""
                    ++ (if model.remoteOtherSystemToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.upnp", "value" :"""
                    ++ (if model.upnpToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.upnpserver", "value" :"""
                    ++ (if model.shareLibToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.upnprenderer", "value" :"""
                    ++ (if model.remoteUPNPToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.airplay", "value" :"""
                    ++ (if model.airplayToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.useairplaypassword", "value" :"""
                    ++ (if model.passwordToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "services.airplaypassword", "value" :\"""" ++ model.airplayPasswordTextField ++ """" }, "id": 1 }"""
                ]
            )

        DeviceNameTextField changeText ->
            ( { model | deviceNameTextField = changeText }, Cmd.none )

        PortTextField changeText ->
            ( { model | portTextField = changeText }, Cmd.none )

        UsernameTextField changeText ->
            ( { model | usernameTextField = changeText }, Cmd.none )

        PasswordTextField changeText ->
            ( { model | passwordTextField = changeText }, Cmd.none )

        AirplayPasswordTextField changeText ->
            ( { model | airplayPasswordTextField = changeText }, Cmd.none )

        ServicesToggleMsg ->
            ( { model | servicesToggle = not model.servicesToggle }, Cmd.none )

        RemoteHTTPToggleMsg ->
            ( { model | remoteHTTPToggle = not model.remoteHTTPToggle }, Cmd.none )

        AuthToggleMsg ->
            ( { model | authToggle = not model.authToggle }, Cmd.none )

        SslToggleMsg ->
            ( { model | sslToggle = not model.sslToggle }, Cmd.none )

        RemoteThisSystemToggleMsg ->
            ( { model | remoteThisSystemToggle = not model.remoteThisSystemToggle }, Cmd.none )

        RemoteOtherSystemToggleMsg ->
            ( { model | remoteOtherSystemToggle = not model.remoteOtherSystemToggle }, Cmd.none )

        UpnpToggleMsg ->
            ( { model | upnpToggle = not model.upnpToggle }, Cmd.none )

        ShareLibToggleMsg ->
            ( { model | shareLibToggle = not model.shareLibToggle }, Cmd.none )

        RemoteUPNPToggleMsg ->
            ( { model | remoteUPNPToggle = not model.remoteUPNPToggle }, Cmd.none )

        AirplayToggleMsg ->
            ( { model | airplayToggle = not model.airplayToggle }, Cmd.none )

        PasswordToggleMsg ->
            ( { model | passwordToggle = not model.passwordToggle }, Cmd.none )

        ReplaceMe ->
            ( model, Cmd.none )

        WebInterfaceDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.webInterfaceDropdown
            in
            ( { model
                | webInterfaceDropdown = dropdown
                , webInterfaceSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.webInterfaceSelected
              }
            , Cmd.map WebInterfaceDropdownMsg cmd
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
    { title = "Settings.Kodi.Services"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General")
                , settingsInputBlock model.deviceNameTextField DeviceNameTextField "Device name" "The name to display for the device when using various network services."
                , settingsToggleBlock model.servicesToggle ServicesToggleMsg "Announce services to other systems" "Allows applications on the network to discover enabled services via Zeroconf."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Control")
                , settingsToggleBlock model.remoteHTTPToggle RemoteHTTPToggleMsg "Allow remote control via HTTP" "Enable remote users to control this application through the built-in web server. Never expose the web server port to the Internet."
                , settingsInputBlock model.portTextField PortTextField "Port" "Define the web server port."
                , settingsToggleBlock model.authToggle AuthToggleMsg "Require authentication" "Choose whether requests to the web server require a username and a password, which must be set below if enabled. It is recommended to always leave this setting enabled."
                , settingsInputBlock model.usernameTextField UsernameTextField "Username" "Define the web server username. Must be set when authentication is enabled."
                , settingsInputBlock model.passwordTextField PasswordTextField "Password" "Define the web server password. Must be set when authentication is enabled."
                , settingsToggleBlock model.sslToggle SslToggleMsg "Enable SSL" "Select between web interfaces installed via the add-on manager."
                , settingsDropdownBlock model.webInterfaceDropdown WebInterfaceDropdownMsg "Web interface" "Select between web interfaces installed via the add-on manager."
                , settingsToggleBlock model.remoteThisSystemToggle RemoteThisSystemToggleMsg "Allow remote control from applications on this system" "Allow programs on this device to control this application via the JSON-RPC over WebSocket, JSON-RPC over TCP, or EventServer protocol, without authentication."
                , settingsToggleBlock model.remoteOtherSystemToggle RemoteOtherSystemToggleMsg "Allow remote control from applications on other systems" "Allow programs on the network to control this application via the JSON-RPC over WebSocket, JSON-RPC over TCP, or EventServer protocol, without authentication. It allows anyone with access to the network to completely control this application and, therefore, this device. Never expose these interfaces to the Internet."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "UPnP / DLNA")
                , settingsToggleBlock model.upnpToggle UpnpToggleMsg "Enable UPnP support" "Enables UPnP. This allows you to stream media in your libraries to a UPnP client and to detect remote UPnP servers."
                , settingsToggleBlock model.shareLibToggle ShareLibToggleMsg "Share my libraries" "Enables the UPnP server. This allows you to stream media in your libraries to a UPnP client."
                , settingsToggleBlock model.remoteUPNPToggle RemoteUPNPToggleMsg "Allow remote control via UPnP" "Enable the UPnP client. This allows you to stream media from any UPnP server with a control point and control playback from that server."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "AirPlay")
                , settingsToggleBlock model.airplayToggle AirplayToggleMsg "Enable AirPlay support" "If enabled, the content from other AirPlay devices or applications can be received."
                , settingsToggleBlock model.passwordToggle PasswordToggleMsg "Use password protection" "Enable AirPlay password protection."
                , settingsInputBlock model.airplayPasswordTextField AirplayPasswordTextField "Password" "Sets the AirPlay password."
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
