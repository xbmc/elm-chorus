module Pages.Settings.Kodi.Interface exposing (Model, Msg, Params, page)

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
    , skinDropdown : Dropdown Options
    , skinSelected : String
    , themeDropdown : Dropdown Options
    , themeSelected : String
    , colorDropdown : Dropdown Options
    , colorSelected : String
    , fontDropdown : Dropdown Options
    , fontSelected : String
    , languageDropdown : Dropdown Options
    , languageSelected : String
    , characterDropdown : Dropdown Options
    , characterSelected : String
    , regionDropdown : Dropdown Options
    , regionSelected : String
    , countryTimezoneDropdown : Dropdown Options
    , countryTimezoneSelected : String
    , timezoneDropdown : Dropdown Options
    , timezoneSelected : String
    , screensaverDropdown : Dropdown Options
    , screensaverSelected : String
    , performDropdown : Dropdown Options
    , performSelected : String
    , startupDropdown : Dropdown Options
    , startupSelected : String
  }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route
      , skinDropdown =
            Dropdown.init
                |> Dropdown.id "skin"
                |> Dropdown.optionsBy .name skinList
      , skinSelected = ""
      , themeDropdown =
            Dropdown.init
                |> Dropdown.id "theme"
                |> Dropdown.optionsBy .name themeList
      , themeSelected = ""
      , colorDropdown =
            Dropdown.init
                |> Dropdown.id "color"
                |> Dropdown.optionsBy .name colorList
      , colorSelected = ""
      , fontDropdown =
            Dropdown.init
                |> Dropdown.id "font"
                |> Dropdown.optionsBy .name fontList
      , fontSelected = ""
      , languageDropdown =
            Dropdown.init
                |> Dropdown.id "language"
                |> Dropdown.optionsBy .name languageList
      , languageSelected = ""
      , characterDropdown =
            Dropdown.init
                |> Dropdown.id "character"
                |> Dropdown.optionsBy .name characterList
      , characterSelected = ""
      , regionDropdown =
            Dropdown.init
                |> Dropdown.id "region"
                |> Dropdown.optionsBy .name regionList
      , regionSelected = ""
      , countryTimezoneDropdown =
            Dropdown.init
                |> Dropdown.id "countryTimezone"
                |> Dropdown.optionsBy .name countryTimezoneList
      , countryTimezoneSelected = ""
      , timezoneDropdown =
            Dropdown.init
                |> Dropdown.id "timezone"
                |> Dropdown.optionsBy .name timezoneList
      , timezoneSelected = ""
      , screensaverDropdown =
            Dropdown.init
                |> Dropdown.id "screensaver"
                |> Dropdown.optionsBy .name screensaverList
      , screensaverSelected = ""
      , performDropdown =
            Dropdown.init
                |> Dropdown.id "perform"
                |> Dropdown.optionsBy .name performList
      , performSelected = ""
      , startupDropdown =
            Dropdown.init
                |> Dropdown.id "startup"
                |> Dropdown.optionsBy .name startupList
      , startupSelected = ""
    }, Cmd.none )

skinList : List Options
skinList =
  [ Options "Estouchy"
  , Options "Estuary"
  ]

colorList : List Options
colorList =
  [ Options "Skin default"
  , Options "brown"
  , Options "charcoal"
  , Options "chartreuse"
  , Options "concrete"
  , Options "gold"
  , Options "green"
  , Options "maroon"
  , Options "midnight"
  , Options "orange"
  , Options "pink"
  , Options "rose"
  , Options "teal"
  , Options "violet"
  ]


themeList : List Options
themeList =
  [ Options "Skin default"
  , Options "curial"
  , Options "flat"
  ]

fontList : List Options
fontList =
  [ Options "Skin default"
  , Options "Arial based"
  ]

languageList : List Options
languageList =
  [ Options "English"
  ]

characterList : List Options
characterList =
  [ Options "Default"
  , Options "Arabic (ISO)"
  , Options "Arabic (Windows)"
  , Options "Baltic (ISO)"
  , Options "Baltic (Windows)"
  , Options "Central Europe (ISO)"
  , Options "Central Europe (Windows)"
  , Options "Chinese Simplified (GBK)"
  , Options "Chinese Traditional (Big5)"
  , Options "Cyrillic (ISO)"
  , Options "Cyrillic (Windows)"
  , Options "Greek (ISO)"
  , Options "Greek (Windows)"
  , Options "Hebrew (ISO)"
  , Options "Hebrew (Windows)"
  , Options "Hong Kong (Big5-HKSCS)"
  , Options "Japanese (Shift-JIS)"
  , Options "Korean"
  , Options "South Europe (ISO)"
  , Options "Thai (Windows)"
  , Options "Turkish (ISO)"
  , Options "Turkish (Windows)"
  , Options "Vietnamese (Windows)"
  , Options "Western Europe (ISO)"
  , Options "Western Europe (Windows)"
  ]

regionList : List Options
regionList =
  [ Options "Australia (12h)"
  , Options "Australia (24h)"
  , Options "Canada"
  , Options "Central Europe"
  , Options "India (12h)"
  , Options "India (24h)"
  , Options "UK (12h)"
  , Options "UK (24h)"
  , Options "USA (12h)"
  , Options "USA (24h)"
  ]

countryTimezoneList : List Options
countryTimezoneList =
  [ Options "Afghanistan"
  , Options "Albania"
  , Options "Algeria"
  , Options "Andorra"
  , Options "Angola"
  , Options "Anguilla"
  , Options "Antartica"
  , Options "Antigua & Barbuda"
  , Options "Argentina"
  , Options "Armenia"
  , Options "Aruba"
  , Options "Australia"
  , Options "Austria"
  , Options "Azerbijan"
  , Options "Bahamas"
  , Options "Bahrain"
  , Options "Bangladesh"
  , Options "Barbados"
  , Options "Belarus"
  , Options "Belgium"
  , Options "Belize"
  , Options "Benin"
  , Options "Bermuda"
  , Options "Bhutan"
  , Options "Bolivia"
  , Options "Bosnia & Herzegovina"
  , Options "Botswana"
  , Options "BouvetIsland"
  , Options "Brazil"
  , Options "Britain (UK)"
  , Options "British Indian Ocean Teritory"
  , Options "Brunei"
  , Options "Bulgaria"
  , Options "Burkina Faso"
  , Options "Burundi"
  , Options "Combodia"
  , Options "Cameroon"
  , Options "Canada"
  , Options "Cape Verde"
  , Options "Caribbean NL"
  , Options "Cayman Islands"
  , Options "Central African Rep."
  , Options "Chad"
  , Options "Chile"
  , Options "China"
  , Options "Christmas Island"
  , Options "Cocos (Keeling) Islands"
  , Options "Colombia"
  , Options "Comoros"
  , Options "Congo (Dem. Rep.)"
  , Options "Congo (Rep.)"
  , Options "Cook Islands"
  , Options "Costa Rica"
  , Options "Croatia"
  , Options "Cuba"
  , Options "Curaçao"
  , Options "Cyprus"
  , Options "Czech Republic"
  , Options "Côte d'Ivoire"
  , Options "Denmark"
  , Options "Djibouti"
  , Options "Dominica"
  , Options "Dominican Republic"
  , Options "East Timor"
  , Options "Ecudor"
  , Options "Egypt"
  , Options "El Salvador"
  , Options "Equatorial Guinea"
  , Options "Eritrea"
  , Options "Estonia"
  , Options "Eswatini (Swaziland)"
  , Options "Ethiopia"
  , Options "Falkland Islands"
  , Options "Faroe Islands"
  , Options "Fiji"
  , Options "Finland"
  , Options "France"
  , Options "French Guiana"
  , Options "French Polynesia"
  , Options "French Southern & Antartica Lands"
  , Options "Gabon"
  , Options "Gambia"
  , Options "Georgia"
  , Options "Germany"
  , Options "Ghana"
  , Options "Gibraltar"
  , Options "Greece"
  , Options "Greenland"
  , Options "Grenada"
  , Options "Guadeloupe"
  , Options "Guam"
  , Options "Guatemala"
  , Options "Guernsey"
  , Options "Guinea"
  , Options "Guinea-Bissau"
  , Options "Guyana"
  , Options "Haiti"
  , Options "Heard Island and McDonald Islands"
  , Options "Honduras"
  , Options "Hong Kong"
  , Options "Hungary"
  , Options "Iceland"
  , Options "India"
  , Options "Indoneshia"
  , Options "Iran"
  , Options "Iraq"
  , Options "Ireland"
  , Options "Isle of Man"
  , Options "Israel"
  , Options "Italy"
  , Options "Jamaica"
  , Options "Japan"
  , Options "Jersey"
  , Options "Jordan"
  , Options "Kazakhstan"
  , Options "Kenya"
  , Options "Kiribati"
  , Options "Korea (North)"
  , Options "Korea (South)"
  , Options "Kuwait"
  , Options "Kyrgyztan"
  , Options "Laos"
  , Options "Latvia"
  , Options "Lebanon"
  , Options "Lesotho"
  , Options "Liberia"
  , Options "Libya"
  , Options "Liechtenstien"
  , Options "lithuania"
  , Options "Luxembourg"
  , Options "Macau"
  , Options "Madagascar"
  , Options "Malawi"
  , Options "Malaysia"
  , Options "Maldives"
  , Options "Mali"
  , Options "Malta"
  , Options "Marshall Islands"
  , Options "Martinique"
  , Options "Mauritania"
  , Options "Mauritius"
  , Options "Mayotte"
  , Options "Mexico"
  , Options "Micronesia"
  , Options "Moldova"
  , Options "Monaco"
  , Options "Mangolia"
  , Options "Montenegro"
  , Options "Montserrat"
  , Options "Morocco"
  , Options "Mozambique"
  , Options "Myanmar (Burma)"
  , Options "Namibia"
  , Options "Nauru"
  , Options "Nepal"
  , Options "Netherlands"
  , Options "New Calendonia"
  , Options "New Zealand"
  , Options "Nicaragua"
  , Options "Niger"
  , Options "Nigeria"
  , Options "Niue"
  , Options "Norfolk Island"
  , Options "North Macedonia"
  , Options "Northern Mariana Islands"
  , Options "Norway"
  , Options "Oman"
  , Options "Pakistan"
  , Options "Palau"
  , Options "Palestine"
  , Options "Panama"
  , Options "Papua New Guinea"
  , Options "Paraguay"
  , Options "Peru"
  , Options "Philippens"
  , Options "pitcairn"
  , Options "Poland"
  , Options "Portugal"
  , Options "Puerto Rico"
  , Options "Qatar"
  , Options "Romania"
  , Options "Russia"
  , Options "Rwanda"
  , Options "Réunion"
  , Options "Samoa (American)"
  , Options "Samoa (Western)"
  , Options "San Marino"
  , Options "Sao Tome & Principe"
  , Options "Saudi Arabia"
  , Options "Senegal"
  , Options "Serbia"
  , Options "Seychellas"
  , Options "Sierra Leone"
  , Options "Singapore"
  , Options "Slovakia"
  , Options "Slovenia"
  , Options "Solomon Islands"
  , Options "Somalia"
  , Options "South Africa"
  , Options "South Georgia & South Snadwich Islands"
  , Options "South Sudan"
  , Options "Spain"
  , Options "Sri Lanka"
  , Options "St Barthelemy"
  , Options "St Helena"
  , Options "St kitts & Nevis"
  , Options "St Lucia"
  , Options "St Maarten (Dutch)"
  , Options "St Martin (French)"
  , Options "St Pierre & Miquelon"
  , Options "St Vincent"
  , Options "Sudan"
  , Options "Suriname"
  , Options "Svalbard & Jay Mayen"
  , Options "Sweden"
  , Options "Switzerland"
  , Options "Syria"
  , Options "Taiwan"
  , Options "Tajikistan"
  , Options "Tanzania"
  , Options "Thailand"
  , Options "Togo"
  , Options "Tokelau"
  , Options "Tonga"
  , Options "Trinidad and Tobago"
  , Options "Tunisia"
  , Options "Turkey"
  , Options "Turkmenistan"
  , Options "Turks & Caicos Is"
  , Options "Tuvalu"
  , Options "Uganda"
  , Options "Ukraine"
  , Options "United Arab Emirates"
  , Options "United States"
  , Options "Uruguay"
  , Options "US minor outlying islands"
  , Options "Uzbekistan"
  , Options "Vanuata"
  , Options "Vatican City"
  , Options "Venezuela"
  , Options "Vietnam"
  , Options "Virgin Islands (UK)"
  , Options "Viirgin Islands (US)"
  , Options "Wallis & Fututna"
  , Options "Western Sahara"
  , Options "Yemen"
  , Options "Zambia"
  , Options "Zimbabwe"
  , Options "Åland Islands"
  ]

timezoneList : List Options
timezoneList =
  [ Options "Asia/kolkata"
  ]

screensaverList : List Options
screensaverList =
  [ Options "Black"
  , Options "Dim"
  , Options ""
  ]

performList : List Options
performList =
  [ Options "None"
  , Options "Play TV"
  , Options "Play Radio"
  ]

startupList : List Options
startupList =
  [ Options "Home Windows"
  , Options "Programs"
  , Options "Pictures"
  , Options "File manager"
  , Options "Settings"
  , Options "Video"
  , Options "Music"
  , Options "TV Channels"
  , Options "TV guide"
  , Options "Radio channels"
  , Options "Radio guide"
  , Options "Weather"
  ]

-- UPDATE

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


type Msg
    = ReplaceMe
    | SkinDropdownMsg (Dropdown.Msg Options)
    | ThemeDropdownMsg (Dropdown.Msg Options)
    | ColorDropdownMsg (Dropdown.Msg Options)
    | FontDropdownMsg (Dropdown.Msg Options)
    | LanguageDropdownMsg (Dropdown.Msg Options)
    | CharacterDropdownMsg (Dropdown.Msg Options)
    | RegionDropdownMsg (Dropdown.Msg Options)
    | CountryTimezoneDropdownMsg (Dropdown.Msg Options)
    | TimezoneDropdownMsg (Dropdown.Msg Options)
    | ScreensaverDropdownMsg (Dropdown.Msg Options)
    | PerformDropdownMsg (Dropdown.Msg Options)
    | StartupDropdownMsg (Dropdown.Msg Options)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Kodi.Interface"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Skin")
                , settingsDropdownBlock model.skinDropdown SkinDropdownMsg "Skin" "Select the skin for the user interface. This will define the look and feel of the application."
                , settingsDropdownBlock model.themeDropdown ThemeDropdownMsg "Theme" "Change the theme associated with your selected skin."
                , settingsDropdownBlock model.colorDropdown ColorDropdownMsg "Colors" "Change the colours of your selected skin."
                , settingsDropdownBlock model.fontDropdown FontDropdownMsg "Fonts" "Choose the fonts displayed in the user interface. The font sets are configured by your skin."
                , settingsInputBlock "Zoom" "Resize the view of the user interface."
                , settingsToggleBlock "Show RSS news feeds" "Turn this off to remove the scrolling RSS news ticker."
                , settingsInputBlock "Edit" "Edit the RSS feeds."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Regional")
                , settingsDropdownBlock model.languageDropdown LanguageDropdownMsg "Language" "Chooses the language of the user interface."
                , settingsDropdownBlock model.characterDropdown CharacterDropdownMsg "Character set" "Choose which character set is used for displaying text in the user interface. This doesn't change the character set used for subtitles, for that go to Player &gt; Language."
                , settingsDropdownBlock model.regionDropdown RegionDropdownMsg "Region default format" "Select the formats for temperature, time and date. The available options depend on the selected language."
                , settingsDropdownBlock model.countryTimezoneDropdown CountryTimezoneDropdownMsg "Timezone country" "Select country location."
                , settingsDropdownBlock model.timezoneDropdown TimezoneDropdownMsg "Timezone" "Select your current timezone."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Screensaver")
                , settingsDropdownBlock model.screensaverDropdown ScreensaverDropdownMsg "Screensaver mode" "Select the screensaver. The \"Dim\" screensaver will be forced when fullscreen video playback is paused or a dialogue box is active."
                , settingsInputBlock "Wait time" "Set the time to wait for any activity to occur before displaying the screensaver."
                , settingsToggleBlock "Use visualisation if playing audio" "If music is being played, the selected visualisation will be started instead of displaying the screensaver."
                , settingsToggleBlock "Use dim if paused during video playback" "Dim the display when media is paused. Not valid for the \"Dim\" screensaver mode."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Master lock")
                , settingsToggleBlock "Ask for master lock code on startup" "If enabled, the master lock code is required to unlock this application on startup."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Startup")
                , settingsDropdownBlock model.performDropdown PerformDropdownMsg "Perform on startup" "Select an action Kodi will perform on startup."
                , settingsDropdownBlock model.startupDropdown StartupDropdownMsg "Startup window" "Select the media window to display on startup."
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
