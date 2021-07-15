module Pages.Settings.Web exposing (..)

import Colors
import Components.SettingsBlockLayout exposing (..)
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Dropdown exposing (Dropdown, OutMsg(..), Placement(..))
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import WSDecoder exposing (SettingsObj)


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
    , settingsList :  List SettingsObj
    , languageDropdown : Dropdown Options
    , languageSelected : String
    , defaultPlayerDropdown : Dropdown Options
    , defaultPlayerSelected : String
    , controlDropdown : Dropdown Options
    , controlSelected : String
    , pollDropdown : Dropdown Options
    , pollSelected : String
    , settingsLevelDropdown : Dropdown Options
    , settingsLevelSelected : String
   }

save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | settings_list = model.settingsList }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | settingsList = shared.settings_list }, Cmd.none )

init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , settingsList = shared.settings_list
      , languageDropdown =
            Dropdown.init
                |> Dropdown.id "language"
                |> Dropdown.optionsBy .name languageList
      , languageSelected = ""
      , defaultPlayerDropdown =
            Dropdown.init
                |> Dropdown.id "defaultPlayer"
                |> Dropdown.optionsBy .name defaultPlayerList
      , defaultPlayerSelected = ""
      , controlDropdown =
            Dropdown.init
                |> Dropdown.id "control"
                |> Dropdown.optionsBy .name controlList
      , controlSelected = ""
      , pollDropdown =
            Dropdown.init
                |> Dropdown.id "poll"
                |> Dropdown.optionsBy .name pollList
      , pollSelected = ""
      , settingsLevelDropdown =
            Dropdown.init
                |> Dropdown.id "settingsLevel"
                |> Dropdown.optionsBy .name settingsLevelList
      , settingsLevelSelected = ""
     }
     , sendAction  """{"jsonrpc": "2.0", "method": "Settings.GetSettings", "params": {}, "id": 1 }"""
      )



languageList : List Options
languageList =
  [ Options "English"
  , Options "Czech"
  , Options "German"
  , Options "Spanish"
  , Options "French"
  , Options "Hungarian"
  , Options "Luthiunian"
  , Options "Dutch"
  , Options "Polish"
  , Options "Portuguese"
  , Options "Slovak"
  , Options "Chinease, Simplified"
  ]

defaultPlayerList : List Options
defaultPlayerList =
  [ Options "Auto"
  , Options "Kodi"
  , Options "Local"
  ]

controlList : List Options
controlList =
  [ Options "Kodi"
  , Options "Browser"
  , Options "Both"
  ]

pollList : List Options
pollList =
  [ Options "5 sec"
  , Options "10 sec"
  , Options "30 sec"
  , Options "60 sec"
  ]

settingsLevelList : List Options
settingsLevelList =
  [ Options "Standard"
  , Options "Advanced"
  , Options "Expert"
  ]

-- UPDATE

type Msg
    = ReplaceMe
    | LanguageDropdownMsg (Dropdown.Msg Options)
    | DefaultPlayerDropdownMsg (Dropdown.Msg Options)
    | ControlDropdownMsg (Dropdown.Msg Options)
    | PollDropdownMsg (Dropdown.Msg Options)
    | SettingsLevelDropdownMsg (Dropdown.Msg Options)



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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

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

        DefaultPlayerDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.defaultPlayerDropdown
            in
            ( { model
                | defaultPlayerDropdown = dropdown
                , defaultPlayerSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.defaultPlayerSelected
              }
            , Cmd.map DefaultPlayerDropdownMsg cmd
            )

        ControlDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.controlDropdown
            in
            ( { model
                | controlDropdown = dropdown
                , controlSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.controlSelected
              }
            , Cmd.map ControlDropdownMsg cmd
            )

        PollDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.pollDropdown
            in
            ( { model
                | pollDropdown = dropdown
                , pollSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.pollSelected
              }
            , Cmd.map PollDropdownMsg cmd
            )

        SettingsLevelDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.settingsLevelDropdown
            in
            ( { model
                | settingsLevelDropdown = dropdown
                , settingsLevelSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.settingsLevelSelected
              }
            , Cmd.map SettingsLevelDropdownMsg cmd
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Web"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General options")
                -- , el [] (text (Debug.toString model.settingsList))
                , settingsDropdownBlock model.languageDropdown LanguageDropdownMsg "Language" "Preffered language, need to refresh browser to take effect"
                , settingsDropdownBlock model.defaultPlayerDropdown DefaultPlayerDropdownMsg "Default Player" "Which player to start with"
                , settingsDropdownBlock  model.controlDropdown ControlDropdownMsg "Keyboard controls" "In Chorus, will your keyboard control Kodi, the browser or both."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "List options")
                , settingsToggleBlock "Ignore article" "Ignore articles (terms such as 'The' and 'A') when sorting lists"
                , settingsToggleBlock "Album artists only" "When listing artists should we only see artists with albums or all artists found. Warning: turning this off can impact performance with large libraries"
                , settingsToggleBlock "Focus playlist on playing" "Automatically scroll the playlist to the current playing item. This happens whenever the playing item is changed"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Appearance")
                , settingsToggleBlock "Vibrant headers" "Use colourful headers for media pages"
                , settingsToggleBlock "Disable Thumbs Up" "Remove the thumbs up button from media. Note: you may also want to remove the menu item from the Main Nav"
                , settingsToggleBlock "Show device name" "Show the Kodi device name in the header of Chorus"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Advanced options")
                , settingsInputBlock "Websockets port" "9090 is the default"
                , settingsInputBlock "Websockets host" "The hostname used for websockets connection. Set to 'auto' to use the current hostname."
                , settingsDropdownBlock model.pollDropdown PollDropdownMsg "Poll interval" "How often do I poll for updates from Kodi (Only applies when websocket inactive)"
                , settingsDropdownBlock model.settingsLevelDropdown SettingsLevelDropdownMsg "Kodi settings level" "Advanced settings level is recommmended for those who know what they are doing."
                , settingsToggleBlock "Reverse proxy support" "Enable support of reverse proxying."
                , settingsToggleBlock "RefreshIgnore NFO" "Ignore local NFO files when manually refreshing media."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "API Keys")
                , settingsInputBlock "The Movie DB" "Set your personal API key"
                , settingsInputBlock "FanartTV" "Set your personal API key"
                , settingsInputBlock "YouTube" "Set your personal API key"
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
