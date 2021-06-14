module Pages.Settings.Kodi.Media exposing (Model, Msg, Params, page)

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
    , actionDropdown : Dropdown Option
    , actionSelected : String
    , videoArtworkDropdown : Dropdown Option
    , videoArtworkSelected : String
    , albumInfoDropdown : Dropdown Option
    , albumInfoSelected : String
    , artistInfoDropdown : Dropdown Option
    , artistInfoSelected : String
    , musicArtworkDropdown : Dropdown Option
    , musicArtworkSelected : String
    , startupVideoToggle : Bool
    , hideProgressVideoToggle : Bool
    , startupMusicToggle : Bool
    , hideProgressMusicToggle : Bool
    , parentFolderToggle : Bool
    , ignoreArticleToggle : Bool
    , showFileToggle : Bool
    , showButtonsToggle : Bool
    , splitVideoToggle : Bool
    , replaceFileToggle : Bool
    , showSetVideoToggle : Bool
    , includeSingleVideoToggle : Bool
    , showVideoToggle : Bool
    , extractToggle : Bool
    , showArtistMusicToggle : Bool
    , splitAlbumMusicToggle : Bool
    , sortnameMusicToggle : Bool
    , onlineInfoMusicToggle : Bool
    , onlineAlbumMusicToggle : Bool
    , visualToggle : Bool
    , tagReadingToggle : Bool
    , exifToggle : Bool
    , autoThumbnailToggle : Bool
    , videoListingToggle : Bool
    , setInfoVideoTextField : String
    , artistInfoMusicTextField : String
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , settingsList = shared.settings_list
      , actionDropdown =
            Dropdown.init
                |> Dropdown.id "action"
                |> Dropdown.optionsBy .label (getOptionList 38 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 38 shared.settings_list)
      , actionSelected = getTextFieldVal 38 shared.settings_list
      , videoArtworkDropdown =
            Dropdown.init
                |> Dropdown.id "videoArtwork"
                |> Dropdown.optionsBy .label (getOptionList 46 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 46 shared.settings_list)
      , videoArtworkSelected = getTextFieldVal 46 shared.settings_list
      , albumInfoDropdown =
            Dropdown.init
                |> Dropdown.id "albumInfo"
                |> Dropdown.optionsBy .label (getOptionList 52 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 52 shared.settings_list)
      , albumInfoSelected = getTextFieldVal 52 shared.settings_list
      , artistInfoDropdown =
            Dropdown.init
                |> Dropdown.id "artistInfo"
                |> Dropdown.optionsBy .label (getOptionList 53 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 53 shared.settings_list)
      , artistInfoSelected = getTextFieldVal 53 shared.settings_list
      , musicArtworkDropdown =
            Dropdown.init
                |> Dropdown.id "musicArtwork"
                |> Dropdown.optionsBy .label (getOptionList 55 shared.settings_list)
                |> Dropdown.setSelected (getSelectedOptionFromList 55 shared.settings_list)
      , musicArtworkSelected = getTextFieldVal 55 shared.settings_list
      , startupVideoToggle = getBoolVal 30 shared.settings_list
      , hideProgressVideoToggle = getBoolVal 31 shared.settings_list
      , startupMusicToggle = getBoolVal 32 shared.settings_list
      , hideProgressMusicToggle = getBoolVal 33 shared.settings_list
      , parentFolderToggle = getBoolVal 34 shared.settings_list
      , ignoreArticleToggle = getBoolVal 35 shared.settings_list
      , showFileToggle = getBoolVal 36 shared.settings_list
      , showButtonsToggle = getBoolVal 37 shared.settings_list
      , splitVideoToggle = getBoolVal 39 shared.settings_list
      , replaceFileToggle = getBoolVal 40 shared.settings_list
      , showSetVideoToggle = getBoolVal 42 shared.settings_list
      , includeSingleVideoToggle = getBoolVal 43 shared.settings_list
      , showVideoToggle = getBoolVal 45 shared.settings_list
      , extractToggle = getBoolVal 47 shared.settings_list
      , showArtistMusicToggle = getBoolVal 48 shared.settings_list
      , splitAlbumMusicToggle = getBoolVal 49 shared.settings_list
      , sortnameMusicToggle = getBoolVal 50 shared.settings_list
      , onlineInfoMusicToggle = getBoolVal 54 shared.settings_list
      , onlineAlbumMusicToggle = getBoolVal 56 shared.settings_list
      , visualToggle = getBoolVal 57 shared.settings_list
      , tagReadingToggle = getBoolVal 58 shared.settings_list
      , exifToggle = getBoolVal 59 shared.settings_list
      , autoThumbnailToggle = getBoolVal 60 shared.settings_list
      , videoListingToggle = getBoolVal 61 shared.settings_list
      , setInfoVideoTextField = getTextFieldVal 44 shared.settings_list
      , artistInfoMusicTextField = getTextFieldVal 51 shared.settings_list
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
    | ActionDropdownMsg (Dropdown.Msg Option)
    | VideoArtworkDropdownMsg (Dropdown.Msg Option)
    | AlbumInfoDropdownMsg (Dropdown.Msg Option)
    | ArtistInfoDropdownMsg (Dropdown.Msg Option)
    | MusicArtworkDropdownMsg (Dropdown.Msg Option)
    | StartupVideoToggleMsg
    | HideProgressVideoToggleMsg
    | StartupMusicToggleMsg
    | HideProgressMusicToggleMsg
    | ParentFolderToggleMsg
    | IgnoreArticleToggleMsg
    | ShowFileToggleMsg
    | ShowButtonsToggleMsg
    | SplitVideoToggleMsg
    | ReplaceFileToggleMsg
    | ShowSetVideoToggleMsg
    | IncludeSingleVideoToggleMsg
    | ShowVideoToggleMsg
    | ExtractToggleMsg
    | ShowArtistMusicToggleMsg
    | SplitAlbumMusicToggleMsg
    | SortnameMusicToggleMsg
    | OnlineInfoMusicToggleMsg
    | OnlineAlbumMusicToggleMsg
    | VisualToggleMsg
    | TagReadingToggleMsg
    | ExifToggleMsg
    | AutoThumbnailToggleMsg
    | VideoListingToggleMsg
    | SetInfoVideoTextFieldMsg String
    | ArtistInfoMusicTextFieldMsg String
    | SaveSettingMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveSettingMsg ->
            ( model
            , sendActions
                [ """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videolibrary.updateonstartup", "value" :"""
                    ++ (if model.startupVideoToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videolibrary.backgroundupdate", "value" :"""
                    ++ (if model.hideProgressVideoToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.updateonstartup", "value" :"""
                    ++ (if model.startupMusicToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.backgroundupdate", "value" :"""
                    ++ (if model.hideProgressMusicToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "filelists.showparentdiritems", "value" :"""
                    ++ (if model.parentFolderToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "filelists.ignorethewhensorting", "value" :"""
                    ++ (if model.ignoreArticleToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "filelists.showextensions", "value" :"""
                    ++ (if model.showFileToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "filelists.showaddsourcebuttons", "value" :"""
                    ++ (if model.showButtonsToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "myvideos.selectaction", "value" :\"""" ++ model.actionSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "myvideos.stackvideos", "value" :"""
                    ++ (if model.splitVideoToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "myvideos.replacelabels", "value" :"""
                    ++ (if model.replaceFileToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videolibrary.groupmoviesets", "value" :"""
                    ++ (if model.showSetVideoToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videolibrary.groupsingleitemsets", "value" :"""
                    ++ (if model.includeSingleVideoToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videolibrary.moviesetsfolder", "value" :\"""" ++ model.setInfoVideoTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videolibrary.musicvideosallperformers", "value" :"""
                    ++ (if model.showVideoToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "videolibrary.artworklevel", "value" :\"""" ++ model.videoArtworkSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "myvideos.extractthumb", "value" :"""
                    ++ (if model.extractToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.showcompilationartists", "value" :"""
                    ++ (if model.showArtistMusicToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.showdiscs", "value" :"""
                    ++ (if model.splitAlbumMusicToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.useartistsortname", "value" :"""
                    ++ (if model.sortnameMusicToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.artistsfolder", "value" :\"""" ++ model.artistInfoMusicTextField ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.albumsscraper", "value" :\"""" ++ model.albumInfoSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.artistsscraper", "value" :\"""" ++ model.artistInfoSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.overridetags", "value" :"""
                    ++ (if model.onlineInfoMusicToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.artworklevel", "value" :\"""" ++ model.musicArtworkSelected ++ """" }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musiclibrary.preferonlinealbumart", "value" :"""
                    ++ (if model.onlineAlbumMusicToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicfiles.selectaction", "value" :"""
                    ++ (if model.visualToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "musicfiles.usetags", "value" :"""
                    ++ (if model.tagReadingToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "pictures.usetags", "value" :"""
                    ++ (if model.exifToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "picture.generatethumbs", "value" :"""
                    ++ (if model.autoThumbnailToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                , """{"jsonrpc": "2.0", "method": "Settings.SetSettingValue", "params": { "setting" : "pictures.showvideos", "value" :"""
                    ++ (if model.videoListingToggle then
                            "true"

                        else
                            "false"
                       )
                    ++ """ }, "id": 1 }"""
                ]
            )

        SetInfoVideoTextFieldMsg changeText ->
            ( { model | setInfoVideoTextField = changeText }, Cmd.none )

        ArtistInfoMusicTextFieldMsg changeText ->
            ( { model | artistInfoMusicTextField = changeText }, Cmd.none )

        StartupVideoToggleMsg ->
            ( { model | startupVideoToggle = not model.startupVideoToggle }, Cmd.none )

        HideProgressVideoToggleMsg ->
            ( { model | hideProgressVideoToggle = not model.hideProgressVideoToggle }, Cmd.none )

        StartupMusicToggleMsg ->
            ( { model | startupMusicToggle = not model.startupMusicToggle }, Cmd.none )

        HideProgressMusicToggleMsg ->
            ( { model | hideProgressMusicToggle = not model.hideProgressMusicToggle }, Cmd.none )

        ParentFolderToggleMsg ->
            ( { model | parentFolderToggle = not model.parentFolderToggle }, Cmd.none )

        IgnoreArticleToggleMsg ->
            ( { model | ignoreArticleToggle = not model.ignoreArticleToggle }, Cmd.none )

        ShowFileToggleMsg ->
            ( { model | showFileToggle = not model.showFileToggle }, Cmd.none )

        ShowButtonsToggleMsg ->
            ( { model | showButtonsToggle = not model.showButtonsToggle }, Cmd.none )

        SplitVideoToggleMsg ->
            ( { model | splitVideoToggle = not model.splitVideoToggle }, Cmd.none )

        ReplaceFileToggleMsg ->
            ( { model | replaceFileToggle = not model.replaceFileToggle }, Cmd.none )

        ShowSetVideoToggleMsg ->
            ( { model | showSetVideoToggle = not model.showSetVideoToggle }, Cmd.none )

        IncludeSingleVideoToggleMsg ->
            ( { model | includeSingleVideoToggle = not model.includeSingleVideoToggle }, Cmd.none )

        ShowVideoToggleMsg ->
            ( { model | showVideoToggle = not model.showVideoToggle }, Cmd.none )

        ExtractToggleMsg ->
            ( { model | extractToggle = not model.extractToggle }, Cmd.none )

        ShowArtistMusicToggleMsg ->
            ( { model | showArtistMusicToggle = not model.showArtistMusicToggle }, Cmd.none )

        SplitAlbumMusicToggleMsg ->
            ( { model | splitAlbumMusicToggle = not model.splitAlbumMusicToggle }, Cmd.none )

        SortnameMusicToggleMsg ->
            ( { model | sortnameMusicToggle = not model.sortnameMusicToggle }, Cmd.none )

        OnlineInfoMusicToggleMsg ->
            ( { model | onlineInfoMusicToggle = not model.onlineInfoMusicToggle }, Cmd.none )

        OnlineAlbumMusicToggleMsg ->
            ( { model | onlineAlbumMusicToggle = not model.onlineAlbumMusicToggle }, Cmd.none )

        VisualToggleMsg ->
            ( { model | visualToggle = not model.visualToggle }, Cmd.none )

        TagReadingToggleMsg ->
            ( { model | tagReadingToggle = not model.tagReadingToggle }, Cmd.none )

        ExifToggleMsg ->
            ( { model | exifToggle = not model.exifToggle }, Cmd.none )

        AutoThumbnailToggleMsg ->
            ( { model | autoThumbnailToggle = not model.autoThumbnailToggle }, Cmd.none )

        VideoListingToggleMsg ->
            ( { model | videoListingToggle = not model.videoListingToggle }, Cmd.none )

        ReplaceMe ->
            ( model, Cmd.none )

        ActionDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.actionDropdown
            in
            ( { model
                | actionDropdown = dropdown
                , actionSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.actionSelected
              }
            , Cmd.map ActionDropdownMsg cmd
            )

        VideoArtworkDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.videoArtworkDropdown
            in
            ( { model
                | videoArtworkDropdown = dropdown
                , videoArtworkSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.videoArtworkSelected
              }
            , Cmd.map VideoArtworkDropdownMsg cmd
            )

        AlbumInfoDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.albumInfoDropdown
            in
            ( { model
                | albumInfoDropdown = dropdown
                , albumInfoSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.albumInfoSelected
              }
            , Cmd.map AlbumInfoDropdownMsg cmd
            )

        ArtistInfoDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.artistInfoDropdown
            in
            ( { model
                | artistInfoDropdown = dropdown
                , artistInfoSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.artistInfoSelected
              }
            , Cmd.map ArtistInfoDropdownMsg cmd
            )

        MusicArtworkDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.musicArtworkDropdown
            in
            ( { model
                | musicArtworkDropdown = dropdown
                , musicArtworkSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.musicArtworkSelected
              }
            , Cmd.map MusicArtworkDropdownMsg cmd
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
    { title = "Settings.Kodi.Media"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Library")

                -- , text (Debug.toString model.settingsList)
                , settingsToggleBlock model.startupVideoToggle StartupVideoToggleMsg "Update library on startup (video)" "Check for new media files on startup."
                , settingsToggleBlock model.hideProgressVideoToggle HideProgressVideoToggleMsg "Hide progress of library updates (video)" "Hide the library scanning progress bar during scans."
                , settingsToggleBlock model.startupMusicToggle StartupMusicToggleMsg "Update library on startup (music)" "Check for new and removed media files on startup."
                , settingsToggleBlock model.hideProgressMusicToggle HideProgressMusicToggleMsg "Hide progress of library updates (music)" "Hide the library scanning progress bar during scans."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General")
                , settingsToggleBlock model.parentFolderToggle ParentFolderToggleMsg "Show parent folder items" "Display the (..) item in lists for visiting the parent folders."
                , settingsToggleBlock model.ignoreArticleToggle IgnoreArticleToggleMsg "Ignore articles when sorting" "Ignore certain tokens, e.g. \"The\", during sort operations. \"The Simpsons\" would for example be sorted as \"Simpsons\"."
                , settingsToggleBlock model.showFileToggle ShowFileToggleMsg "Show file extensions" "Show file extensions on media files, for example \"You Enjoy Myself\" would be shown as \"You Enjoy Myself.mp3\"."
                , settingsToggleBlock model.showButtonsToggle ShowButtonsToggleMsg "Show \"Add source\" buttons" "Show the add source button in root sections of the user interface."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Video")
                , settingsDropdownBlock model.actionDropdown ActionDropdownMsg "Default select action" "Toggle between [Choose], [Play] (default), [Resume] and [Show information].[CR][Choose] Will select an item, e.g. open a directory in files mode.[CR][Resume] Will automatically resume videos from the last position that you were viewing them, even after restarting the system."
                , settingsToggleBlock model.splitVideoToggle SplitVideoToggleMsg "Combine split video items" "Combines multi-part video files, DVD folders or movie folders, down to a single item in non-library views."
                , settingsToggleBlock model.replaceFileToggle ReplaceFileToggleMsg "Replace file names with library titles" "When a file is scanned into the library it will display the metadata title instead of the file name."
                , settingsToggleBlock model.showSetVideoToggle ShowSetVideoToggleMsg "Show movies sets (video)" "When enabled, movies belonging to a \"Movie set\" are grouped together under one entry for the set in the movie library, this entry can then be opened to display the individual movies. When disabled, each movie will have its own entry in the movie library even if it belongs to a set."
                , settingsToggleBlock model.includeSingleVideoToggle IncludeSingleVideoToggleMsg "Include sets containing a single movie (video)" "When enabled, a \"Movie set\" entry is used even if the movie library contains only a single movie from that set. When disabled, a \"Movie set\" entry is used only if the movie library contains more than one movie from that set."
                , settingsInputBlock model.setInfoVideoTextField SetInfoVideoTextFieldMsg "Movie set information folder (video)" "Select the folder where movie set information (images) are saved locally."
                , settingsToggleBlock model.showVideoToggle ShowVideoToggleMsg "Show all performances for music videos (video)" "When enabled, shows all performers in the artist list for music videos, not just the main artist"
                , settingsDropdownBlock model.videoArtworkDropdown VideoArtworkDropdownMsg "Artwork level (video)" "The amount of artwork automatically selected - [Maximum] all local images and remote art; [Basic] save space on limited devices or when using a simple skin; [Custom] configured by user for detailed control; [None] no art"
                , settingsToggleBlock model.extractToggle ExtractToggleMsg "Extract thumbnails from video files" "Extract thumbnails to display in library mode."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Music")
                , settingsToggleBlock model.showArtistMusicToggle ShowArtistMusicToggleMsg "Show song and album artists (music)" "When enabled, both song and album artists are shown. When disabled, only album artists are shown and artists that appear only on individual songs from an album are excluded."
                , settingsToggleBlock model.splitAlbumMusicToggle SplitAlbumMusicToggleMsg "Split albums into individual discs (music)" "When enabled, opening a multi-disc album shows the discs as individual items instead of all the songs. Opening a disc then shows the songs on that disc."
                , settingsToggleBlock model.sortnameMusicToggle SortnameMusicToggleMsg "Use artist sortname when sorting by artist (music)" "When sorting music items by artist use sortname e.g. Parton, Dolly rather than name."
                , settingsInputBlock model.artistInfoMusicTextField ArtistInfoMusicTextFieldMsg "Artist information folder (music)" "Select the folder where artist information (info files and images) should be saved in."
                , settingsDropdownBlock model.albumInfoDropdown AlbumInfoDropdownMsg "Default provider for album information (music)" "Select the default album information provider."
                , settingsDropdownBlock model.artistInfoDropdown ArtistInfoDropdownMsg "Default provider for artist information (music)" "Select the default artist information provider."
                , settingsToggleBlock model.onlineInfoMusicToggle OnlineInfoMusicToggleMsg "Prefer online information (music)" "With this enabled, any information that is downloaded for albums and artists will override anything you have set in your song tags, such as genres, year, song artists etc. Useful if you have MusicBrainz identifiers in your song tags."
                , settingsDropdownBlock model.musicArtworkDropdown MusicArtworkDropdownMsg "Artwork level (music)" "The amount of artwork automatically selected - [Maximum] all local images and remote art; [Basic] save space on limited devices or when using a simple skin; [Custom] configured by user for detailed control; [None] no art"
                , settingsToggleBlock model.onlineAlbumMusicToggle OnlineAlbumMusicToggleMsg "Prefer online album art (music)" "Where no local album cover exists, online art will be used. Where neither is available, cover images embedded in music files will be used"
                , settingsToggleBlock model.visualToggle VisualToggleMsg "Switch to visualisation on playback" "Automatically go to the visualisation window when audio playback starts"
                , settingsToggleBlock model.tagReadingToggle TagReadingToggleMsg "Enable tag reading in file view" "When browsing music files in file view read the tags of those not in the music library as you go. This can make large directories slow to display, especially over a network."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Pictures")
                , settingsToggleBlock model.exifToggle ExifToggleMsg "Show EXIF picture information" "If EXIF information exists (date, time, camera used, etc.). It will be displayed."
                , settingsToggleBlock model.autoThumbnailToggle AutoThumbnailToggleMsg "Automatically generate thumbnails" "Automatically generate picture thumbnails when entering picture folder."
                , settingsToggleBlock model.showFileToggle ShowFileToggleMsg "Show video files in listings" "Show videos in picture file lists."
                , row [ width (px 800), Background.color Colors.headerBackground, paddingXY 20 25 ]
                    [ Input.button [ Background.color Colors.cerulean, Font.color Colors.white, paddingXY 30 8, Font.size 14, Border.rounded 2 ]
                        { onPress = Just SaveSettingMsg
                        , label = text "SAVE"
                        }
                    ]
                , el [ height (px 100) ] (text "")
                ]
            ]
        ]
    }
