module Pages.Settings.Kodi.Player exposing (Model, Msg, Params, page)

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
    , displayDropdown : Dropdown Option
    , displaySelected : String
    , visualisationDropdown : Dropdown Option
    , visualisationSelected : String
    , regionCodeDropdown : Dropdown Option
    , regionCodeSelected : String
    , playbackDropdown : Dropdown Option
    , playbackSelected : String
    , insertDropdown : Dropdown Option
    , insertSelected : String
    , audioDropdown : Dropdown Option
    , audioSelected : String
    , subtitleDropdown : Dropdown Option
    , subtitleSelected : String
    , fontDropdown : Dropdown Option
    , fontSelected : String
    , characterDropdown : Dropdown Option
    , characterSelected : String
    , tvShowDropdown : Dropdown Option
    , tvShowSelected : String
    , movieDropdown : Dropdown Option
    , movieSelected : String
    , playbackToggle : Bool
    , nextSongToggle : Bool
    , queueSongToggle : Bool
    , crossfadeToggle : Bool
    , dvdToggle : Bool
    , audioCDToggle : Bool
    , zoomToggle : Bool
    , randomiseToggle : Bool
    , downscalingToggle : Bool
    , defaultToggle : Bool
    , parsingToggle : Bool
    , audioVisualToggle : Bool
    , audioHearToggle : Bool
    , subtitleHearToggle : Bool
    , skipDelayVideoTextField : String
    , skipDelayMusicTextField : String
    , crossfadeTextField : String
    , dvdTextField : String
    , displayImageTextField : String
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , settingsList = shared.settings_list
      , displayDropdown =
            Dropdown.init
                |> Dropdown.id "display"
                |> Dropdown.optionsBy .label (getOptionList 65 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 65 shared.settings_list)
      , displaySelected = getTextFieldVal 65 shared.settings_list
      , visualisationDropdown =
            Dropdown.init
                |> Dropdown.id "visualisation"
                |> Dropdown.optionsBy .label (getOptionList 73 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 73 shared.settings_list)
      , visualisationSelected = getTextFieldVal 73 shared.settings_list
      , regionCodeDropdown =
            Dropdown.init
                |> Dropdown.id "regionCode"
                |> Dropdown.optionsBy .label (getOptionList 76 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 76 shared.settings_list)
      , regionCodeSelected = getTextFieldVal 76 shared.settings_list
      , playbackDropdown =
            Dropdown.init
                |> Dropdown.id "playback"
                |> Dropdown.optionsBy .label (getOptionList 77 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 77 shared.settings_list)
      , playbackSelected = getTextFieldVal 77 shared.settings_list
      , insertDropdown =
            Dropdown.init
                |> Dropdown.id "insert"
                |> Dropdown.optionsBy .label (getOptionList 78 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 78 shared.settings_list)
      , insertSelected = getTextFieldVal 78 shared.settings_list
      , audioDropdown =
            Dropdown.init
                |> Dropdown.id "audio"
                |> Dropdown.optionsBy .label (getOptionList 84 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 84 shared.settings_list)
      , audioSelected = getTextFieldVal 84 shared.settings_list
      , subtitleDropdown =
            Dropdown.init
                |> Dropdown.id "subtitle"
                |> Dropdown.optionsBy .label (getOptionList 86 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 86 shared.settings_list)
      , subtitleSelected = getTextFieldVal 86 shared.settings_list
      , fontDropdown =
            Dropdown.init
                |> Dropdown.id "font"
                |> Dropdown.optionsBy .label (getOptionList 88 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 88 shared.settings_list)
      , fontSelected = getTextFieldVal 88 shared.settings_list
      , characterDropdown =
            Dropdown.init
                |> Dropdown.id "character"
                |> Dropdown.optionsBy .label (getOptionList 89 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 89 shared.settings_list)
      , characterSelected = getTextFieldVal 89 shared.settings_list
      , tvShowDropdown =
            Dropdown.init
                |> Dropdown.id "tvShow"
                |> Dropdown.optionsBy .label (getOptionList 91 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 91 shared.settings_list)
      , tvShowSelected = getTextFieldVal 91 shared.settings_list
      , movieDropdown =
            Dropdown.init
                |> Dropdown.id "movie"
                |> Dropdown.optionsBy .label (getOptionList 92 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 92 shared.settings_list)
      , movieSelected = getTextFieldVal 92 shared.settings_list
      , playbackToggle = getBoolVal 66 shared.settings_list
      , nextSongToggle = getBoolVal 67 shared.settings_list
      , queueSongToggle = getBoolVal 68 shared.settings_list
      , crossfadeToggle = getBoolVal 72 shared.settings_list
      , dvdToggle = getBoolVal 74 shared.settings_list
      , audioCDToggle = getBoolVal 79 shared.settings_list
      , zoomToggle = getBoolVal 81 shared.settings_list
      , randomiseToggle = getBoolVal 82 shared.settings_list
      , downscalingToggle = getBoolVal 83 shared.settings_list
      , defaultToggle = getBoolVal 85 shared.settings_list
      , parsingToggle = getBoolVal 87 shared.settings_list
      , audioVisualToggle = getBoolVal 93 shared.settings_list
      , audioHearToggle = getBoolVal 94 shared.settings_list
      , subtitleHearToggle = getBoolVal 95 shared.settings_list
      , skipDelayVideoTextField = getTextFieldVal 64 shared.settings_list
      , skipDelayMusicTextField = getTextFieldVal 70 shared.settings_list
      , crossfadeTextField = getTextFieldVal 71 shared.settings_list
      , dvdTextField = getTextFieldVal 75 shared.settings_list
      , displayImageTextField = getTextFieldVal 80 shared.settings_list
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



-- UPDATE


type Msg
    = ReplaceMe
    | DisplayDropdownMsg (Dropdown.Msg Option)
    | VisualisationDropdownMsg (Dropdown.Msg Option)
    | RegionCodeDropdownMsg (Dropdown.Msg Option)
    | PlaybackDropdownMsg (Dropdown.Msg Option)
    | InsertDropdownMsg (Dropdown.Msg Option)
    | AudioDropdownMsg (Dropdown.Msg Option)
    | SubtitleDropdownMsg (Dropdown.Msg Option)
    | FontDropdownMsg (Dropdown.Msg Option)
    | CharacterDropdownMsg (Dropdown.Msg Option)
    | TvShowDropdownMsg (Dropdown.Msg Option)
    | MovieDropdownMsg (Dropdown.Msg Option)
    | PlaybackToggleMsg
    | NextSongToggleMsg
    | QueueSongToggleMsg
    | CrossfadeToggleMsg
    | DvdToggleMsg
    | AudioCDToggleMsg
    | ZoomToggleMsg
    | RandomiseToggleMsg
    | DownscalingToggleMsg
    | DefaultToggleMsg
    | ParsingToggleMsg
    | AudioVisualToggleMsg
    | AudioHearToggleMsg
    | SubtitleHearToggleMsg
    | SkipDelayVideoTextFieldMsg String
    | SkipDelayMusicTextFieldMsg String
    | CrossfadeTextFieldMsg String
    | DvdTextFieldMsg String
    | DisplayImageTextFieldMsg String
    | SaveSettingsMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveSettingsMsg ->
            ( model
            , sendActions
                [ """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoplayer.seekdelay", "value" :""" ++ model.skipDelayVideoTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoplayer.adjustrefreshrate", "value" :\"""" ++ model.displaySelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoplayer.usedisplayasclock", "value" :"""
                    ++ (if model.playbackToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicplayer.autoplaynextitem", "value" :"""
                    ++ (if model.nextSongToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicplayer.queuebydefault", "value" :"""
                    ++ (if model.queueSongToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicplayer.seekdelay", "value" :""" ++ model.skipDelayMusicTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicplayer.crossfade", "value" :""" ++ model.crossfadeTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicplayer.crossfadealbumtracks", "value" :"""
                    ++ (if model.crossfadeToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicplayer.visualisation", "value" :\"""" ++ model.visualisationSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "dvds.autorun", "value" :"""
                    ++ (if model.dvdToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "dvds.playerregion", "value" :""" ++ model.dvdTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "bluray.playerregion", "value" :\"""" ++ model.regionCodeSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "disc.playback", "value" :\"""" ++ model.playbackSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "audiocds.autoaction", "value" :\"""" ++ model.insertSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "audiocds.usecddb", "value" :"""
                    ++ (if model.audioCDToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "slideshow.staytime", "value" :""" ++ model.displayImageTextField ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "slideshow.displayeffects", "value" :"""
                    ++ (if model.zoomToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "slideshow.shuffle", "value" :"""
                    ++ (if model.randomiseToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "slideshow.highqualitydownscaling", "value" :"""
                    ++ (if model.downscalingToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "locale.audiolanguage", "value" :\"""" ++ model.audioSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videoplayer.preferdefaultflag", "value" :"""
                    ++ (if model.defaultToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "locale.subtitlelanguage", "value" :\"""" ++ model.subtitleSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "subtitles.parsecaptions", "value" :"""
                    ++ (if model.parsingToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "subtitles.font", "value" :\"""" ++ model.fontSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "subtitles.charset", "value" :\"""" ++ model.characterSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "subtitles.tv", "value" :\"""" ++ model.tvShowSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "subtitles.movie", "value" :\"""" ++ model.movieSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "accessibility.audiovisual", "value" :"""
                    ++ (if model.audioVisualToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "accessibility.audiohearing", "value" :"""
                    ++ (if model.audioHearToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "accessibility.subhearing", "value" :"""
                    ++ (if model.subtitleHearToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                ]
            )

        ReplaceMe ->
            ( model, Cmd.none )

        SkipDelayVideoTextFieldMsg changeText ->
            ( { model | skipDelayVideoTextField = changeText }, Cmd.none )

        SkipDelayMusicTextFieldMsg changeText ->
            ( { model | skipDelayMusicTextField = changeText }, Cmd.none )

        CrossfadeTextFieldMsg changeText ->
            ( { model | crossfadeTextField = changeText }, Cmd.none )

        DvdTextFieldMsg changeText ->
            ( { model | dvdTextField = changeText }, Cmd.none )

        DisplayImageTextFieldMsg changeText ->
            ( { model | displayImageTextField = changeText }, Cmd.none )

        PlaybackToggleMsg ->
            ( { model | playbackToggle = not model.playbackToggle }, Cmd.none )

        NextSongToggleMsg ->
            ( { model | nextSongToggle = not model.nextSongToggle }, Cmd.none )

        QueueSongToggleMsg ->
            ( { model | queueSongToggle = not model.queueSongToggle }, Cmd.none )

        CrossfadeToggleMsg ->
            ( { model | crossfadeToggle = not model.crossfadeToggle }, Cmd.none )

        DvdToggleMsg ->
            ( { model | dvdToggle = not model.dvdToggle }, Cmd.none )

        AudioCDToggleMsg ->
            ( { model | audioCDToggle = not model.audioCDToggle }, Cmd.none )

        ZoomToggleMsg ->
            ( { model | zoomToggle = not model.zoomToggle }, Cmd.none )

        RandomiseToggleMsg ->
            ( { model | randomiseToggle = not model.randomiseToggle }, Cmd.none )

        DownscalingToggleMsg ->
            ( { model | downscalingToggle = not model.downscalingToggle }, Cmd.none )

        DefaultToggleMsg ->
            ( { model | defaultToggle = not model.defaultToggle }, Cmd.none )

        ParsingToggleMsg ->
            ( { model | parsingToggle = not model.parsingToggle }, Cmd.none )

        AudioVisualToggleMsg ->
            ( { model | audioVisualToggle = not model.audioVisualToggle }, Cmd.none )

        AudioHearToggleMsg ->
            ( { model | audioHearToggle = not model.audioHearToggle }, Cmd.none )

        SubtitleHearToggleMsg ->
            ( { model | subtitleHearToggle = not model.subtitleHearToggle }, Cmd.none )

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


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | settings_list = model.settingsList }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | settingsList = shared.settings_list }, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Kodi.Player"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Videos")
                , settingsInputBlock model.skipDelayVideoTextField SkipDelayVideoTextFieldMsg "Skip delay" "Defines the time to wait for subsequent key presses before performing the skip. Only applies when using smart skipping (when using more than one skip step for a direction)."
                , settingsDropdownBlock model.displayDropdown DisplayDropdownMsg "Adjust display refresh rate" "Allow the refresh rate of the display to be changed so that it best matches the video frame rate. This may yield smoother video playback."
                , settingsToggleBlock model.playbackToggle PlaybackToggleMsg "Sync playback to display" "Synchronise video and audio to the refresh rate of the monitor. VideoPlayer won't use passthrough audio in this case because resampling may be required."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Music")
                , settingsToggleBlock model.nextSongToggle NextSongToggleMsg "Play next song automatically" "Automatically plays the next item in the current folder, for example in \"Files\" view after a track has been played, the next track in the same folder will automatically play."
                , settingsToggleBlock model.queueSongToggle QueueSongToggleMsg "Queue songs on selection" "When songs are selected they are queued instead of playback starting immediately."
                , settingsInputBlock model.skipDelayMusicTextField SkipDelayMusicTextFieldMsg "Skip delay" "Defines the time to wait for subsequent key presses before performing the skip. Only applies when using smart skipping (when using more than one skip step for a direction)."
                , settingsInputBlock model.crossfadeTextField CrossfadeTextFieldMsg "Crossfade between songs" "Smoothly fade from one audio track to the next. You can set the amount of overlap from 1-15 seconds."
                , settingsToggleBlock model.crossfadeToggle CrossfadeToggleMsg "Crossfade between songs on the same album" "Allow crossfading to occur when both tracks are from the same album."
                , settingsDropdownBlock model.visualisationDropdown VisualisationDropdownMsg "Visualisation" "Select the visualisation that will be displayed while listening to music."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Discs")
                , settingsToggleBlock model.dvdToggle DvdToggleMsg "Play DVDs automaticaly" "Autorun DVD video when inserted in drive."
                , settingsInputBlock model.dvdTextField DvdTextFieldMsg "Forced DVD player region" "Force a region for DVD playback."
                , settingsDropdownBlock model.regionCodeDropdown RegionCodeDropdownMsg "Blu-ray region Code" "Region A - Americas, East Asia and Southeast Asia. Region B - Africa, Middle East, Southwest Asia, Europe, Australia, New Zealand. Region C - Central Asia, mainland China, Mongolia, South Asia, Belarus, Russia, Ukraine, Kazakhstan."
                , settingsDropdownBlock model.playbackDropdown PlaybackDropdownMsg "Blu-ray playback mode" "Specifies how Blu-rays should be opened / played back. Note: Some disc menus are not fully supported and may cause problems."
                , settingsDropdownBlock model.insertDropdown InsertDropdownMsg "Audio CD insert action" "Autorun CDs when inserted in drive."
                , settingsToggleBlock model.audioCDToggle AudioCDToggleMsg "Load audio CD information from online service" "Read the information belonging to an audio CD, like song title and artist, from the Internet database freedb.org."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Pictures")
                , settingsInputBlock model.displayImageTextField DisplayImageTextFieldMsg "Amount of time to display each image" "Select the amount of time that each image is displayed in a slideshow."
                , settingsToggleBlock model.zoomToggle ZoomToggleMsg "Use pan and zoom effects" "Images in a slideshow will pan and zoom while displayed."
                , settingsToggleBlock model.randomiseToggle RandomiseToggleMsg "Randomise" "View slideshow images in a random order."
                , settingsToggleBlock model.downscalingToggle DownscalingToggleMsg "High quality downscaling" "Enable high quality downscaling of pictures (uses more memory and has moderate performance impact)."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Language")
                , settingsDropdownBlock model.audioDropdown AudioDropdownMsg "Preffered audio language" "defaults to the selected audio language if more than one language is available."
                , settingsToggleBlock model.defaultToggle DefaultToggleMsg "Prefer default audio streams" "If enabled, audio streams that are flagged as default (and match the preferred language) are preferred over audio streams with higher quality (number of channels, codec, ...)."
                , settingsDropdownBlock model.subtitleDropdown SubtitleDropdownMsg "Preffered subtitle language" "Defaults to the selected subtitle language if more than one language is available."
                , settingsToggleBlock model.parsingToggle ParsingToggleMsg "Enable parsing for closed captions" "Enable to parse for CC in video stream. Puts slightly more load on the CPU"
                , settingsDropdownBlock model.fontDropdown FontDropdownMsg "Font to use for text subtitles" "Set the font type to be used for text based (usually downloaded) subtitles."
                , settingsDropdownBlock model.characterDropdown CharacterDropdownMsg "Character set" "Set the font character set to be used for subtitles."
                , settingsDropdownBlock model.tvShowDropdown TvShowDropdownMsg "Default TV show service" "Select the service that will be used as default to search for TV show subtitles."
                , settingsDropdownBlock model.movieDropdown MovieDropdownMsg "Default movie service" "Select the service that will be used as default to search for movies subtitles."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Accessibility")
                , settingsToggleBlock model.audioVisualToggle AudioVisualToggleMsg "Prefer audio stream for the visually impaired" "Prefer the audio stream for the visually impaired to other audio streams of the same language"
                , settingsToggleBlock model.audioHearToggle AudioHearToggleMsg "Prefer audio stream for the hearing impaired" "Prefer the audio stream for the hearing impaired to other audio streams of the same language"
                , settingsToggleBlock model.subtitleHearToggle SubtitleHearToggleMsg "Prefer subtitles for the visually impaired" "Prefer the subtitle stream for the hearing impaired to other subtitle streams of the same language"
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
