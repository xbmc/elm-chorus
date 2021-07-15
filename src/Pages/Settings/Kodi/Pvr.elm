module Pages.Settings.Kodi.Pvr exposing (Model, Msg, Params, page)

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
    , defaultActionDropdown : Dropdown Options
    , defaultActionSelected : String
    , fullScreenDropdown : Dropdown Options
    , fullScreenSelected : String
    , framerateDropdown : Dropdown Options
    , framerateSelected : String
    , recordingActionDropdown : Dropdown Options
    , recordingActionSelected : String
  }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route
      , defaultActionDropdown =
            Dropdown.init
                |> Dropdown.id "defaultAction"
                |> Dropdown.optionsBy .name defaultActionList
      , defaultActionSelected = ""
      , fullScreenDropdown =
            Dropdown.init
                |> Dropdown.id "fullScreen"
                |> Dropdown.optionsBy .name fullScreenList
      , fullScreenSelected = ""
      , framerateDropdown =
            Dropdown.init
                |> Dropdown.id "framerate"
                |> Dropdown.optionsBy .name framerateList
      , framerateSelected = ""
      , recordingActionDropdown =
            Dropdown.init
                |> Dropdown.id "recordingAction"
                |> Dropdown.optionsBy .name recordingActionList
      , recordingActionSelected = ""
    }, Cmd.none )


defaultActionList : List Options
defaultActionList =
  [ Options "Show context menu"
  , Options "Switch to channel"
  , Options "Show information"
  , Options "Record"
  , Options "\"Smart select\""
  ]

fullScreenList : List Options
fullScreenList =
  [ Options "Never"
  , Options "TV channels"
  , Options "Radio channels"
  , Options "TV and radio channels"
  ]

framerateList : List Options
framerateList =
  [ Options "Off"
  , Options "50 Hz"
  , Options "59.94 Hz"
  ]

recordingActionList : List Options
recordingActionList =
  [ Options "Record current show (if guide data available)"
  , Options "Record for a fixed period of time (Instant reco duration)"
  , Options "Ask what to do"
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
                |> Dropdown.inputAttributes [width (px 400), Font.alignLeft, Border.widthEach { top = 0, bottom = 1, left = 0, right = 0}, Border.rounded 0,Font.medium, Font.size 13]
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
    | DefaultActionDropdownMsg (Dropdown.Msg Options)
    | FramerateDropdownMsg (Dropdown.Msg Options)
    | FullScreenDropdownMsg (Dropdown.Msg Options)
    | RecordingActionDropdownMsg (Dropdown.Msg Options)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        DefaultActionDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.defaultActionDropdown
            in
            ( { model
                | defaultActionDropdown = dropdown
                , defaultActionSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.defaultActionSelected
              }
            , Cmd.map DefaultActionDropdownMsg cmd
            )

        FullScreenDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.fullScreenDropdown
            in
            ( { model
                | fullScreenDropdown = dropdown
                , fullScreenSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.fullScreenSelected
              }
            , Cmd.map FullScreenDropdownMsg cmd
            )

        FramerateDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.framerateDropdown
            in
            ( { model
                | framerateDropdown = dropdown
                , framerateSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.framerateSelected
              }
            , Cmd.map FramerateDropdownMsg cmd
            )

        RecordingActionDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.recordingActionDropdown
            in
            ( { model
                | recordingActionDropdown = dropdown
                , recordingActionSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.recordingActionSelected
              }
            , Cmd.map RecordingActionDropdownMsg cmd
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Kodi.Pvr"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General")
                , settingsToggleBlock "Preselect playing channels in lists" "Preselect the playing channel in windows and dialogs containing channel lists. If enabled and there is a playing channel, the playing channel will be selected when opening a window or dialog containing a channel list. If disabled, the channel previously selected in a window or dialog will be selected when opening a window containing a channel list. "
                , settingsToggleBlock "Syncronize channel groups with backend(s)" "Import channel groups from the PVR backend (if supported). Will delete user created groups if they're not found on the backend."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Guide")
                , settingsDropdownBlock model.defaultActionDropdown DefaultActionDropdownMsg "Default select action" "Select what will happen when an item is selected in the guide: [Show context menu] Will trigger the context menu from where you can choose further actions; [Switch to channel] Will instantly tune to the related channel; [Show information] Will display a detailed information with plot and further options; [Record] Will create a recording timer for the selected item. [\"Smart select\"] The action is choosen dynamically, depending on whether the event is in the past, now or in the future."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Playback")
                , settingsDropdownBlock model.fullScreenDropdown FullScreenDropdownMsg "Switch to full screen" "Switch to full screen display when starting playback of channels."
                , settingsToggleBlock "Confirm channel switches by pressing \"OK\"" "When flipping through channels using channel up/down buttons, channel switches must be confirmed using the OK button."
                , settingsDropdownBlock model.framerateDropdown FramerateDropdownMsg "Fallback framerate" "If enabled, this framerate is used for streams we were not able to detect fps."
                , settingsToggleBlock "Enable RDS for radio channels" "RDS data can be used if present."
                , settingsToggleBlock "Message traffic advisory" "RDS informs you about traffic advisory messages."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Recording")
                , settingsDropdownBlock model.recordingActionDropdown RecordingActionDropdownMsg "Instant recording action" "Action to perform when pressing the record button. [Record current show] will record the current show from \"now\" to the end of the show. If no TV guide data is currently available a fixed length recording starting \"now\", with the value set for \"Instant recording duration\" will be scheduled. [Record for a fixed period of time] will schedule a fixed length recording starting \"now\", with the value set for \"Instant recording duration\". [Ask what to do] will open a dialogue containing different recording actions to choose from, like \"Record current show\", \"Record next show\" and some fixed duration recordings."
                , settingsInputBlock "Instant recording duration" "Duration of instant recordings when pressing the record button. This value will be taken into account if \"Instant recording action\" is set to \"Record for a fixed period of time\""
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Reminders")
                , settingsInputBlock "Automatically close remander popup after" "Choose a time in seconds after which PVR reminder popups will be automatically cloised."
                , settingsToggleBlock "Schedule recording when auto-closing the reminder popup" "If enabled, a recording for the programme to remind will be scheduled when auto-closing the reminder popup, if supported by the PVR add-on and backend."
                , settingsToggleBlock "Switch to channel when auto-closing the reminder popup" "If enabled, switch to the channel with the programme to remind when auto-closing the reminder popup."
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
