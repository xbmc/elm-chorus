module Pages.Settings.Kodi.System exposing (Model, Msg, Params, page)

import Colors
import Components.SettingsBlockLayout exposing (..)
import Components.VerticalNavSettings
import Element exposing (..)
import Dropdown exposing (Dropdown, OutMsg(..), Placement(..))
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route
    , monitorDropdown : Dropdown Options
    , monitorSelected : String
    , displayDropdown : Dropdown Options
    , displaySelected : String
    , resolutionDropdown : Dropdown Options
    , resolutionSelected : String
    , audioOutputDropdown : Dropdown Options
    , audioOutputSelected : String
    , channelNumberDropdown : Dropdown Options
    , channelNumberSelected : String
    , playGUIDropdown : Dropdown Options
    , playGUISelected : String
    , proxyDropdown : Dropdown Options
    , proxySelected : String
    , updateDropdown : Dropdown Options
    , updateSelected : String
    , officialDropdown : Dropdown Options
    , officialSelected : String
  }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route
      , monitorDropdown =
            Dropdown.init
                |> Dropdown.id "monitor"
                |> Dropdown.optionsBy .name monitorList
      , monitorSelected = ""
      , displayDropdown =
            Dropdown.init
                |> Dropdown.id "display"
                |> Dropdown.optionsBy .name displayList
      , displaySelected = ""
      , resolutionDropdown =
            Dropdown.init
                |> Dropdown.id "resolution"
                |> Dropdown.optionsBy .name resolutionList
      , resolutionSelected = ""
      , audioOutputDropdown =
            Dropdown.init
                |> Dropdown.id "audioOutput"
                |> Dropdown.optionsBy .name audioOutputList
      , audioOutputSelected = ""
      , channelNumberDropdown =
            Dropdown.init
                |> Dropdown.id "channelName"
                |> Dropdown.optionsBy .name channelNumberList
      , channelNumberSelected = ""
      , playGUIDropdown =
            Dropdown.init
                |> Dropdown.id "playGUI"
                |> Dropdown.optionsBy .name playGUIList
      , playGUISelected = ""
      , proxyDropdown =
            Dropdown.init
                |> Dropdown.id "proxy"
                |> Dropdown.optionsBy .name proxyList
      , proxySelected = ""
      , updateDropdown =
            Dropdown.init
                |> Dropdown.id "update"
                |> Dropdown.optionsBy .name updateList
      , updateSelected = ""
      , officialDropdown =
            Dropdown.init
                |> Dropdown.id "official"
                |> Dropdown.optionsBy .name officialList
      , officialSelected = ""
    }, Cmd.none )

monitorList : List Options
monitorList =
  [ Options "Default"
  , Options "eDP"
  ]

displayList : List Options
displayList =
  [ Options "Full screen"
  , Options "Windowed"
  ]

resolutionList : List Options
resolutionList =
  [ Options "1920x1080p"
  , Options "1680x1050p"
  , Options "1280x1024p"
  , Options "1440x900p"
  , Options "1280x800p"
  , Options "1280x720p"
  , Options "1024x768p"
  , Options "800x600p"
  , Options "640x480p"
  ]

audioOutputList : List Options
audioOutputList =
  [ Options "Default, Default Output Device (PULSEAUDIO)"
  , Options "Family 17h (Models 10h-1fh) HD Audio Controller Analog Stereo, Speakers (PULSEAUDIO)"
  ]

channelNumberList : List Options
channelNumberList =
  [ Options "2.0"
  , Options "2.1"
  , Options "3.0"
  , Options "3.1"
  , Options "4.0"
  , Options "4.1"
  , Options "5.0"
  , Options "5.1"
  , Options "7.0"
  , Options "7.1"
  ]

playGUIList : List Options
playGUIList =
  [ Options "Never"
  , Options "Only when playback stopped"
  , Options "Always"
  ]

proxyList : List Options
proxyList =
  [ Options "HTTP"
  , Options "SOCKS4"
  , Options "SOCKS4A"
  , Options "SOCKS5"
  , Options "SOCKS5 with remote DNS resolving"
  ]

updateList : List Options
updateList =
  [ Options "Install updates automatically"
  , Options "Notify but don't install updates"
  , Options "Never check for updates"
  ]

officialList : List Options
officialList =
  [ Options "Official repositories only (default)"
  , Options "Any repositories"
  ]

settingsDropdownBlock : Dropdown Options -> (Dropdown.Msg Options -> Msg) -> String -> String -> Element Msg
settingsDropdownBlock dropdown msg title description =
    column [ paddingEach { top = 0, bottom = 30, left = 20, right = 20 } ]
        [ row [ paddingEach { top = 0, bottom = 20, left = 0, right = 0 } ]
            [ paragraph [ width (px 300), Font.size 14, Font.color (rgb255 3 3 3), Font.medium ] [ text title ]
            , row [width (px 400), Font.size 14, Font.color (rgb255 3 3 3), Font.light, paddingXY 0 5] [
              Dropdown.labelHidden (True, "nolabel") dropdown
                |> Dropdown.menuAttributes [Background.color (rgb255 85 85 85), Font.color (rgb255 255 255 255),Font.medium, Font.size 13]
                |> Dropdown.optionSelectedAttributes [Background.color (rgb255 117 117 117)]
                |> Dropdown.maxHeight 300
                |> Dropdown.inputAttributes [scrollbarX ,width (px 400), Font.alignLeft, Border.widthEach { top = 0, bottom = 1, left = 0, right = 0}, Border.rounded 0,Font.medium, Font.size 13]
                |> Dropdown.view msg
            , el [alignRight] (Element.html (Filled.expand_more 18 Inherit))
            ]
            ]
        , row []
            [ el [ width (px 300) ] (text "")
            , paragraph [ width (px 400), Font.size 12, Font.color (rgb255 142 142 142) ] [ text description ]
            ]
        ]

-- UPDATE


type Msg
    = ReplaceMe
    | MonitorDropdownMsg (Dropdown.Msg Options)
    | DisplayDropdownMsg (Dropdown.Msg Options)
    | ResolutionDropdownMsg (Dropdown.Msg Options)
    | AudioOutputDropdownMsg (Dropdown.Msg Options)
    | ChannelNumberDropdownMsg (Dropdown.Msg Options)
    | PlayGUIDropdownMsg (Dropdown.Msg Options)
    | UpdateDropdownMsg (Dropdown.Msg Options)
    | OfficialDropdownMsg (Dropdown.Msg Options)
    | ProxyDropdownMsg (Dropdown.Msg Options)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
                , settingsToggleBlock "Blanck other displays" "In a multi-screen configuration, the screens not displaying this application are blacked out."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Audio")
                , settingsDropdownBlock model.audioOutputDropdown AudioOutputDropdownMsg "Audio output device" "Select the device to be used for playback of audio that has been decoded such as mp3."
                , settingsDropdownBlock model.channelNumberDropdown ChannelNumberDropdownMsg "Number of channels" ""
                , settingsInputBlock "Volume control steps" "Set the number of volume control steps."
                , settingsDropdownBlock model.playGUIDropdown PlayGUIDropdownMsg "Play GUI sounds" "Configure how interface sounds are handled, such as menu navigation and important notifications."
                , settingsInputBlock "GUI sounds" "Select or disable the sounds used in the user interface."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Internet access")
                , settingsToggleBlock "User proxy server" "If your Internet connection uses a proxy server, configure it here."
                , settingsDropdownBlock model.proxyDropdown ProxyDropdownMsg "Proxy type" "Configure which proxy type is used."
                , settingsInputBlock "Server" "Configure the proxy server address."
                , settingsInputBlock "Port" "Configure the proxy server port"
                , settingsInputBlock "Username" "Configure the proxy server username."
                , settingsInputBlock "Password" "Configure the proxy server passoword."
                , settingsInputBlock "Internet connection bandwidth limitation" "If your Internet connection has limited bandwidth available, use this setting to keep bandwidth usage by this application within defined limits."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Power saving")
                , settingsInputBlock "Put display to sleep when idle" "Turn off display when idle. Useful for TVs that turn off when there is no display signal detected"
                , settingsToggleBlock "Try to wakeup remote servers on access" "Automatically send Wake-on-LAN to server(s) right before trying to access shared files or services."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Add-ons")
                , settingsDropdownBlock model.updateDropdown UpdateDropdownMsg "Updates" "Change how auto updating of add-ons are handled."
                , settingsToggleBlock "Show notifications" "Show notification when an add-ons have been updated."
                , settingsToggleBlock "Unknown sources" "Allow installation of add-ons unknown sources."
                , settingsDropdownBlock model.officialDropdown OfficialDropdownMsg "Update official add-ons from" "By default, add-ons from official repositories will be prevented from being auto-updated from private repositories. For cases such as updating from an add-ons beta repository this option can be switched to [Any repositories] (bear in mind this is a less secure option and enabling it could cause incompatibility and crashes)."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Logging")
                , settingsToggleBlock "Enable debug logging" "Turn debug logging on or off. Useful for troubleshooting."
                , settingsToggleBlock "Enable component-specific logging" "Enable verbose messages from additional libraries to be included in the debug log."
                , settingsInputBlock "Screenshot folder" "Select the folder where screenshots should be saved in."
                , settingsToggleBlock "Enable event logging" "Event logging allows to keep track of what has happened."
                , settingsToggleBlock "Enable notification event logging" "Notification event describe regular processes and actions performed by the system or the user."
                , row [ width (px 800), Background.color Colors.headerBackground, paddingXY 20 25 ]
                    [ Input.button [ Background.color Colors.cerulean, Font.color Colors.white, paddingXY 30 8, Font.size 14, Border.rounded 2 ]
                        { onPress = Nothing
                        , label = text "SAVE"
                        }
                    ]
                , el [ height (px 100) ] (text "")
                ]
            ]
        ]
    }
