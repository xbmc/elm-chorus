module Pages.Settings.Kodi.Player exposing (Model, Msg, Params, page)

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
    , displayDropdown : Dropdown Options
    , displaySelected : String
    , visualisationDropdown : Dropdown Options
    , visualisationSelected : String
    , regionCodeDropdown : Dropdown Options
    , regionCodeSelected : String
    , playbackDropdown : Dropdown Options
    , playbackSelected : String
    , insertDropdown : Dropdown Options
    , insertSelected : String
    , audioDropdown : Dropdown Options
    , audioSelected : String
    , subtitleDropdown : Dropdown Options
    , subtitleSelected : String
    , fontDropdown : Dropdown Options
    , fontSelected : String
    , characterDropdown : Dropdown Options
    , characterSelected : String
    , tvShowDropdown : Dropdown Options
    , tvShowSelected : String
    , movieDropdown : Dropdown Options
    , movieSelected : String
  }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route
      , displayDropdown =
            Dropdown.init
                |> Dropdown.id "display"
                |> Dropdown.optionsBy .name displayList
      , displaySelected = ""
      , visualisationDropdown =
            Dropdown.init
                |> Dropdown.id "visualisation"
                |> Dropdown.optionsBy .name visualisationList
      , visualisationSelected = ""
      , regionCodeDropdown =
            Dropdown.init
                |> Dropdown.id "regionCode"
                |> Dropdown.optionsBy .name regionCodeList
      , regionCodeSelected = ""
      , playbackDropdown =
            Dropdown.init
                |> Dropdown.id "playback"
                |> Dropdown.optionsBy .name playbackList
      , playbackSelected = ""
      , insertDropdown =
            Dropdown.init
                |> Dropdown.id "insert"
                |> Dropdown.optionsBy .name insertList
      , insertSelected = ""
      , audioDropdown =
            Dropdown.init
                |> Dropdown.id "audio"
                |> Dropdown.optionsBy .name audioList
      , audioSelected = ""
      , subtitleDropdown =
            Dropdown.init
                |> Dropdown.id "subtitle"
                |> Dropdown.optionsBy .name subtitleList
      , subtitleSelected = ""
      , fontDropdown =
            Dropdown.init
                |> Dropdown.id "font"
                |> Dropdown.optionsBy .name fontList
      , fontSelected = ""
      , characterDropdown =
            Dropdown.init
                |> Dropdown.id "character"
                |> Dropdown.optionsBy .name characterList
      , characterSelected = ""
      , tvShowDropdown =
            Dropdown.init
                |> Dropdown.id "tvShow"
                |> Dropdown.optionsBy .name tvShowList
      , tvShowSelected = ""
      , movieDropdown =
            Dropdown.init
                |> Dropdown.id "movie"
                |> Dropdown.optionsBy .name movieList
      , movieSelected = ""

    }, Cmd.none )

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

displayList : List Options
displayList =
  [ Options "Off"
  , Options "Always"
  , Options "On start/stop"
  , Options "On start"
  ]

visualisationList : List Options
visualisationList =
  [ Options ""
  ]

regionCodeList : List Options
regionCodeList =
  [ Options "Region A"
  , Options "Region B"
  , Options "Region C"
  ]

playbackList : List Options
playbackList =
  [ Options "Show simplified menu"
  , Options "Show Blu-ray menu"
  , Options "Play main movie"
  ]

insertList : List Options
insertList =
  [ Options "None"
  , Options "Play"
  , Options "Rip"
  ]

audioList : List Options
audioList =
  [ Options "Media default"
  , Options "Original language"
  , Options "User interface language"
  , Options "Abkhazian"
  , Options "Afar"
  , Options "Afrikaans"
  , Options "Akan"
  , Options "Albanian"
  , Options "Amharic"
  , Options "Arabic"
  , Options "Aragonese"
  , Options "Armenian"
  , Options "Assamese"
  , Options "Avaric"
  , Options "Avestan"
  , Options "Aymara"
  , Options "Azerbaijani"
  , Options "Bambara"
  , Options "Bashkir"
  , Options "Basque"
  , Options "Belarusian"
  , Options "Bengali; Bangla"
  , Options "Bihari"
  , Options "Bislama"
  , Options "Bosnian"
  , Options "Breton"
  , Options "Bulgarian"
  , Options "Burmese"
  , Options "Catalan"
  , Options "Chamorro"
  , Options "Chechen"
  , Options "Chichewa"
  , Options "Chinese"
  , Options "Church Slavic"
  , Options "Chuvash"
  , Options "Cornish"
  , Options "Corsican"
  , Options "Cree"
  , Options "Croatian"
  , Options "Czech"
  , Options "Danish"
  , Options "Dhivehi"
  , Options "Dutch"
  , Options "Dzongkha"
  , Options "English"
  , Options "Esperanto"
  , Options "Estonian"
  , Options "Ewe"
  , Options "Faroese"
  , Options "Fijian"
  , Options "Finnish"
  , Options "French"
  , Options "Fulah"
  , Options "Galician"
  , Options "Ganda"
  , Options "Georgian"
  , Options "German"
  , Options "Greek"
  , Options "Guarani"
  , Options "Gujarati"
  , Options "Haitian"
  , Options "Hausa"
  , Options "Hebrew"
  , Options "Herero"
  , Options "Hindi"
  , Options "Hiri Motu"
  , Options "Hungarian"
  , Options "Icelandic"
  , Options "Ido"
  , Options "Igbo"
  , Options "Indonesian"
  , Options "Interlingua"
  , Options "Interlingue"
  , Options "Inuktitut"
  , Options "Inupiat"
  , Options "Irish"
  , Options "Italian"
  , Options "Japanese"
  , Options "Javanese"
  , Options "Kalaallisut"
  , Options "Kannada"
  , Options "Kanuri"
  , Options "Kashmiri"
  , Options "Kazakh"
  , Options "Khmer"
  , Options "Kikuyu"
  , Options "Kinyarwanda"
  , Options "Kirghiz"
  , Options "Kirundi"
  , Options "Komi"
  , Options "Kongo"
  , Options "Korean"
  , Options "Kuanyama"
  , Options "Kurdish"
  , Options "Lao"
  , Options "Latin"
  , Options "Latvian, Lettish"
  , Options "Limburgan"
  , Options "Lingala"
  , Options "Lithuanian"
  , Options "Luba-Katanga"
  , Options "Luxembourgish"
  , Options "Macedonian"
  , Options "Malagasy"
  , Options "Malay"
  , Options "Malayalam"
  , Options "Maltese"
  , Options "Manx"
  , Options "Maori"
  , Options "Marathi"
  , Options "Marshallese"
  , Options "Mongolian"
  , Options "Nauru"
  , Options "Navajo"
  , Options "Ndebele, North"
  , Options "Ndebele, South"
  , Options "Ndonga"
  , Options "Nepali"
  , Options "Northern Sami"
  , Options "Norwegian"
  , Options "Norwegian Bokmål"
  , Options "Norwegian Nynorsk"
  , Options "Occitan"
  , Options "Ojibwa"
  , Options "Oriya"
  , Options "Oromo"
  , Options "Ossetic"
  , Options "Pali"
  , Options "Pashto, Pushto"
  , Options "Persian"
  , Options "Polish"
  , Options "Portuguese"
  , Options "Portuguese (Brazil)"
  , Options "Punjabi"
  , Options "Quechua"
  , Options "Romanian"
  , Options "Romansh"
  , Options "Russian"
  , Options "Samoan"
  , Options "Sangho"
  , Options "Sanskrit"
  , Options "Sardinian"
  , Options "Scottish Gaelic"
  , Options "Serbian"
  , Options "Serbo-Croatian"
  , Options "Sesotho"
  , Options "Shona"
  , Options "Sichuan Yi"
  , Options "Sindhi"
  , Options "Sinhalese"
  , Options "Slovak"
  , Options "Slovenian"
  , Options "Somali"
  , Options "Spanish"
  , Options "Sundanese"
  , Options "Swahili"
  , Options "Swati"
  , Options "Swedish"
  , Options "Tagalog"
  , Options "Tahitian"
  , Options "Tajik"
  , Options "Tamil"
  , Options "Tatar"
  , Options "Telugu"
  , Options "Thai"
  , Options "Tibetan"
  , Options "Tigrinya"
  , Options "Tonga"
  , Options "Tsonga"
  , Options "Tswana"
  , Options "Turkish"
  , Options "Turkmen"
  , Options "Twi"
  , Options "Uighur"
  , Options "Ukrainian"
  , Options "Urdu"
  , Options "Uzbek"
  , Options "Venda"
  , Options "Vietnamese"
  , Options "Volapuk"
  , Options "Walloon"
  , Options "Welsh"
  , Options "Western Frisian"
  , Options "Wolof"
  , Options "Xhosa"
  , Options "Yiddish"
  , Options "Yoruba"
  , Options "Zhuang"
  , Options "Zulu"
  ]

subtitleList : List Options
subtitleList =
  [ Options ""
  ]

fontList : List Options
fontList =
  [ Options "arial.ttf"
  , Options "tealtext.ttf"
  ]

characterList : List Options
characterList =
  [ Options ""
  ]

tvShowList : List Options
tvShowList =
  [ Options ""
  ]

movieList : List Options
movieList =
  [ Options ""
  ]


-- UPDATE


type Msg
    = ReplaceMe
    | DisplayDropdownMsg (Dropdown.Msg Options)
    | VisualisationDropdownMsg (Dropdown.Msg Options)
    | RegionCodeDropdownMsg (Dropdown.Msg Options)
    | PlaybackDropdownMsg (Dropdown.Msg Options)
    | InsertDropdownMsg (Dropdown.Msg Options)
    | AudioDropdownMsg (Dropdown.Msg Options)
    | SubtitleDropdownMsg (Dropdown.Msg Options)
    | FontDropdownMsg (Dropdown.Msg Options)
    | CharacterDropdownMsg (Dropdown.Msg Options)
    | TvShowDropdownMsg (Dropdown.Msg Options)
    | MovieDropdownMsg (Dropdown.Msg Options)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

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

        VisualisationDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.visualisationDropdown
            in
            ( { model
                | visualisationDropdown = dropdown
                , visualisationSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.visualisationSelected
              }
            , Cmd.map VisualisationDropdownMsg cmd
            )

        RegionCodeDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.regionCodeDropdown
            in
            ( { model
                | regionCodeDropdown = dropdown
                , regionCodeSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.regionCodeSelected
              }
            , Cmd.map RegionCodeDropdownMsg cmd
            )

        PlaybackDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.playbackDropdown
            in
            ( { model
                | playbackDropdown = dropdown
                , playbackSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.playbackSelected
              }
            , Cmd.map PlaybackDropdownMsg cmd
            )

        InsertDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.insertDropdown
            in
            ( { model
                | insertDropdown = dropdown
                , insertSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.insertSelected
              }
            , Cmd.map InsertDropdownMsg cmd
            )

        AudioDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.audioDropdown
            in
            ( { model
                | audioDropdown = dropdown
                , audioSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.audioSelected
              }
            , Cmd.map AudioDropdownMsg cmd
            )

        SubtitleDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.subtitleDropdown
            in
            ( { model
                | subtitleDropdown = dropdown
                , subtitleSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.subtitleSelected
              }
            , Cmd.map SubtitleDropdownMsg cmd
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

        TvShowDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.tvShowDropdown
            in
            ( { model
                | tvShowDropdown = dropdown
                , tvShowSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.tvShowSelected
              }
            , Cmd.map TvShowDropdownMsg cmd
            )

        MovieDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.movieDropdown
            in
            ( { model
                | movieDropdown = dropdown
                , movieSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.movieSelected
              }
            , Cmd.map MovieDropdownMsg cmd
            )



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Kodi.Player"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Videos")
                , settingsInputBlock "Skip delay" "Defines the time to wait for subsequent key presses before performing the skip. Only applies when using smart skipping (when using more than one skip step for a direction)."
                , settingsDropdownBlock model.displayDropdown DisplayDropdownMsg "Adjust display refresh rate" "Allow the refresh rate of the display to be changed so that it best matches the video frame rate. This may yield smoother video playback."
                , settingsToggleBlock "Sync playback to display" "Synchronise video and audio to the refresh rate of the monitor. VideoPlayer won't use passthrough audio in this case because resampling may be required."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Music")
                , settingsToggleBlock "Play next song automatically" "Automatically plays the next item in the current folder, for example in \"Files\" view after a track has been played, the next track in the same folder will automatically play."
                , settingsToggleBlock "Queue songs on selection" "When songs are selected they are queued instead of playback starting immediately."
                , settingsInputBlock "Skip delay" "Defines the time to wait for subsequent key presses before performing the skip. Only applies when using smart skipping (when using more than one skip step for a direction)."
                , settingsInputBlock "Crossfade between songs" "Smoothly fade from one audio track to the next. You can set the amount of overlap from 1-15 seconds."
                , settingsToggleBlock "Crossfade between songs on the same album" "Allow crossfading to occur when both tracks are from the same album."
                , settingsDropdownBlock model.visualisationDropdown VisualisationDropdownMsg "Visualisation" "Select the visualisation that will be displayed while listening to music."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Discs")
                , settingsToggleBlock "Play DVDs automaticaly" "Autorun DVD video when inserted in drive."
                , settingsInputBlock "Forced DVD player region" "Force a region for DVD playback."
                , settingsDropdownBlock model.regionCodeDropdown RegionCodeDropdownMsg "Blu-ray region Code" "Region A - Americas, East Asia and Southeast Asia. Region B - Africa, Middle East, Southwest Asia, Europe, Australia, New Zealand. Region C - Central Asia, mainland China, Mongolia, South Asia, Belarus, Russia, Ukraine, Kazakhstan."
                , settingsDropdownBlock model.playbackDropdown PlaybackDropdownMsg "Blu-ray playback mode" "Specifies how Blu-rays should be opened / played back. Note: Some disc menus are not fully supported and may cause problems."
                , settingsDropdownBlock model.insertDropdown InsertDropdownMsg "Audio CD insert action" "Autorun CDs when inserted in drive."
                , settingsToggleBlock "Load audio CD information from online service" "Read the information belonging to an audio CD, like song title and artist, from the Internet database freedb.org."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Pictures")
                , settingsInputBlock "Amount of time to display each image" "Select the amount of time that each image is displayed in a slideshow."
                , settingsToggleBlock "Use pan and zoom effects" "Images in a slideshow will pan and zoom while displayed."
                , settingsToggleBlock "Randomise" "View slideshow images in a random order."
                , settingsToggleBlock "High quality downscaling" "Enable high quality downscaling of pictures (uses more memory and has moderate performance impact)."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Language")
                , settingsDropdownBlock model.audioDropdown AudioDropdownMsg "Preffered audio language" "defaults to the selected audio language if more than one language is available."
                , settingsToggleBlock "Prefer default audio streams" "If enabled, audio streams that are flagged as default (and match the preferred language) are preferred over audio streams with higher quality (number of channels, codec, ...)."
                , settingsDropdownBlock model.subtitleDropdown SubtitleDropdownMsg "Preffered subtitle language" "Defaults to the selected subtitle language if more than one language is available."
                , settingsToggleBlock "Enable parsing for closed captions" "Enable to parse for CC in video stream. Puts slightly more load on the CPU"
                , settingsDropdownBlock model.fontDropdown FontDropdownMsg "Font to use for text subtitles" "Set the font type to be used for text based (usually downloaded) subtitles."
                , settingsDropdownBlock model.characterDropdown CharacterDropdownMsg "Character set" "Set the font character set to be used for subtitles."
                , settingsDropdownBlock model.tvShowDropdown TvShowDropdownMsg "Default TV show service" "Select the service that will be used as default to search for TV show subtitles."
                , settingsDropdownBlock model.movieDropdown MovieDropdownMsg "Default movie service" "Select the service that will be used as default to search for movies subtitles."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Accessibility")
                , settingsToggleBlock "Prefer audio stream for the visually impaired" "Prefer the audio stream for the visually impaired to other audio streams of the same language"
                , settingsToggleBlock "Prefer audio stream for the hearing impaired" "Prefer the audio stream for the hearing impaired to other audio streams of the same language"
                , settingsToggleBlock "Prefer subtitles for the visually impaired" "Prefer the subtitle stream for the hearing impaired to other subtitle streams of the same language"
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
