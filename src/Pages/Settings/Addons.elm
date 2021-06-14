module Pages.Settings.Addons exposing (Model, Msg, Params, page)

import Colors
import Components.SettingsBlockLayout exposing (..)
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Shared exposing (storeAddonSettings)
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import WSDecoder exposing (LocalSettings, encodeLocalSettings)
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


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


type alias Model =
    { route : Route
    , localSettingsList : LocalSettings
    , aacToggle : Bool
    , wmaToggle : Bool
    , defaultToggle : Bool
    , sensToggle : Bool
    , inputToggle : Bool
    , rtmpToggle : Bool
    , universalAlbumToggle : Bool
    , genericAlbumToggle : Bool
    , localToggle : Bool
    , universalArtistToggle : Bool
    , genericArtistToggle : Bool
    , musicToggle : Bool
    , fanartToggle : Bool
    , imdbToggle : Bool
    , musicBrainzToggle : Bool
    , audioToggle : Bool
    , movieScraperToggle : Bool
    , movieDatabaseToggle : Bool
    , movieDatabsePythonToggle : Bool
    , movieDatabseTVToggle : Bool
    , tmdbToggle : Bool
    , joystickToggle : Bool
    , youtubeToggle : Bool
    , addonToggle : Bool
    , weatherToggle : Bool
    , englishToggle : Bool
    , uiToggle : Bool
    , blackToggle : Bool
    , dimToggle : Bool
    , certifiToggle : Bool
    , chardetToggle : Bool
    , idnaToggle : Bool
    , pythonImageToggle : Bool
    , pythonCryptoToggle : Bool
    , requestsToggle : Bool
    , sixToggle : Bool
    , urllibToggle : Bool
    , versionToggle : Bool
    , estouchyToggle : Bool
    , estuaryToggle : Bool
    , chorusToggle : Bool
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , localSettingsList = shared.addonLocalSettings
      , aacToggle =
            if getVal 1 shared.addonLocalSettings == "" then
                True

            else if getVal 1 shared.addonLocalSettings == "true" then
                True

            else
                False
      , wmaToggle =
            if getVal 2 shared.addonLocalSettings == "" then
                True

            else if getVal 2 shared.addonLocalSettings == "true" then
                True

            else
                False
      , defaultToggle =
            if getVal 3 shared.addonLocalSettings == "" then
                True

            else if getVal 3 shared.addonLocalSettings == "true" then
                True

            else
                False
      , sensToggle =
            if getVal 4 shared.addonLocalSettings == "" then
                True

            else if getVal 4 shared.addonLocalSettings == "true" then
                True

            else
                False
      , inputToggle =
            if getVal 5 shared.addonLocalSettings == "" then
                True

            else if getVal 5 shared.addonLocalSettings == "true" then
                True

            else
                False
      , rtmpToggle =
            if getVal 6 shared.addonLocalSettings == "" then
                True

            else if getVal 6 shared.addonLocalSettings == "true" then
                True

            else
                False
      , universalAlbumToggle =
            if getVal 7 shared.addonLocalSettings == "" then
                True

            else if getVal 7 shared.addonLocalSettings == "true" then
                True

            else
                False
      , genericAlbumToggle =
            if getVal 8 shared.addonLocalSettings == "" then
                True

            else if getVal 8 shared.addonLocalSettings == "true" then
                True

            else
                False
      , localToggle =
            if getVal 9 shared.addonLocalSettings == "" then
                True

            else if getVal 9 shared.addonLocalSettings == "true" then
                True

            else
                False
      , universalArtistToggle =
            if getVal 10 shared.addonLocalSettings == "" then
                True

            else if getVal 10 shared.addonLocalSettings == "true" then
                True

            else
                False
      , genericArtistToggle =
            if getVal 11 shared.addonLocalSettings == "" then
                True

            else if getVal 11 shared.addonLocalSettings == "true" then
                True

            else
                False
      , musicToggle =
            if getVal 12 shared.addonLocalSettings == "" then
                True

            else if getVal 12 shared.addonLocalSettings == "true" then
                True

            else
                False
      , fanartToggle =
            if getVal 13 shared.addonLocalSettings == "" then
                True

            else if getVal 13 shared.addonLocalSettings == "true" then
                True

            else
                False
      , imdbToggle =
            if getVal 14 shared.addonLocalSettings == "" then
                True

            else if getVal 14 shared.addonLocalSettings == "true" then
                True

            else
                False
      , musicBrainzToggle =
            if getVal 15 shared.addonLocalSettings == "" then
                True

            else if getVal 15 shared.addonLocalSettings == "true" then
                True

            else
                False
      , audioToggle =
            if getVal 16 shared.addonLocalSettings == "" then
                True

            else if getVal 16 shared.addonLocalSettings == "true" then
                True

            else
                False
      , movieScraperToggle =
            if getVal 17 shared.addonLocalSettings == "" then
                True

            else if getVal 17 shared.addonLocalSettings == "true" then
                True

            else
                False
      , movieDatabaseToggle =
            if getVal 18 shared.addonLocalSettings == "" then
                True

            else if getVal 18 shared.addonLocalSettings == "true" then
                True

            else
                False
      , movieDatabsePythonToggle =
            if getVal 19 shared.addonLocalSettings == "" then
                True

            else if getVal 19 shared.addonLocalSettings == "true" then
                True

            else
                False
      , movieDatabseTVToggle =
            if getVal 20 shared.addonLocalSettings == "" then
                True

            else if getVal 20 shared.addonLocalSettings == "true" then
                True

            else
                False
      , tmdbToggle =
            if getVal 21 shared.addonLocalSettings == "" then
                True

            else if getVal 21 shared.addonLocalSettings == "true" then
                True

            else
                False
      , joystickToggle =
            if getVal 22 shared.addonLocalSettings == "" then
                True

            else if getVal 22 shared.addonLocalSettings == "true" then
                True

            else
                False
      , youtubeToggle =
            if getVal 23 shared.addonLocalSettings == "" then
                True

            else if getVal 23 shared.addonLocalSettings == "true" then
                True

            else
                False
      , addonToggle =
            if getVal 24 shared.addonLocalSettings == "" then
                True

            else if getVal 24 shared.addonLocalSettings == "true" then
                True

            else
                False
      , weatherToggle =
            if getVal 25 shared.addonLocalSettings == "" then
                True

            else if getVal 25 shared.addonLocalSettings == "true" then
                True

            else
                False
      , englishToggle =
            if getVal 26 shared.addonLocalSettings == "" then
                True

            else if getVal 26 shared.addonLocalSettings == "true" then
                True

            else
                False
      , uiToggle =
            if getVal 27 shared.addonLocalSettings == "" then
                True

            else if getVal 27 shared.addonLocalSettings == "true" then
                True

            else
                False
      , blackToggle =
            if getVal 28 shared.addonLocalSettings == "" then
                True

            else if getVal 28 shared.addonLocalSettings == "true" then
                True

            else
                False
      , dimToggle =
            if getVal 29 shared.addonLocalSettings == "" then
                True

            else if getVal 29 shared.addonLocalSettings == "true" then
                True

            else
                False
      , certifiToggle =
            if getVal 30 shared.addonLocalSettings == "" then
                True

            else if getVal 30 shared.addonLocalSettings == "true" then
                True

            else
                False
      , chardetToggle =
            if getVal 31 shared.addonLocalSettings == "" then
                True

            else if getVal 31 shared.addonLocalSettings == "true" then
                True

            else
                False
      , idnaToggle =
            if getVal 32 shared.addonLocalSettings == "" then
                True

            else if getVal 32 shared.addonLocalSettings == "true" then
                True

            else
                False
      , pythonImageToggle =
            if getVal 33 shared.addonLocalSettings == "" then
                True

            else if getVal 33 shared.addonLocalSettings == "true" then
                True

            else
                False
      , pythonCryptoToggle =
            if getVal 34 shared.addonLocalSettings == "" then
                True

            else if getVal 34 shared.addonLocalSettings == "true" then
                True

            else
                False
      , requestsToggle =
            if getVal 35 shared.addonLocalSettings == "" then
                True

            else if getVal 35 shared.addonLocalSettings == "true" then
                True

            else
                False
      , sixToggle =
            if getVal 36 shared.addonLocalSettings == "" then
                True

            else if getVal 36 shared.addonLocalSettings == "true" then
                True

            else
                False
      , urllibToggle =
            if getVal 37 shared.addonLocalSettings == "" then
                True

            else if getVal 37 shared.addonLocalSettings == "true" then
                True

            else
                False
      , versionToggle =
            if getVal 38 shared.addonLocalSettings == "" then
                True

            else if getVal 38 shared.addonLocalSettings == "true" then
                True

            else
                False
      , estouchyToggle =
            if getVal 39 shared.addonLocalSettings == "" then
                True

            else if getVal 39 shared.addonLocalSettings == "true" then
                True

            else
                False
      , estuaryToggle =
            if getVal 40 shared.addonLocalSettings == "" then
                True

            else if getVal 40 shared.addonLocalSettings == "true" then
                True

            else
                False
      , chorusToggle =
            if getVal 41 shared.addonLocalSettings == "" then
                True

            else if getVal 41 shared.addonLocalSettings == "true" then
                True

            else
                False
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = ReplaceMe
    | AACToggleMsg
    | WMAToggleMsg
    | DefaultToggleMsg
    | SensToggleMsg
    | InputToggleMsg
    | RtmpToggleMsg
    | UniversalAlbumToggleMsg
    | GenericAlbumToggleMsg
    | LocalToggleMsg
    | UniversalArtistToggleMsg
    | GenericArtistToggleMsg
    | MusicToggleMsg
    | FanartToggleMsg
    | ImdbToggleMsg
    | MusicBrainzToggleMsg
    | AudioToggleMsg
    | MovieScraperToggleMsg
    | MovieDatabaseToggleMsg
    | MovieDatabsePythonToggleMsg
    | MovieDatabseTVToggleMsg
    | TmdbToggleMsg
    | JoystickToggleMsg
    | YoutubeToggleMsg
    | AddonToggleMsg
    | WeatherToggleMsg
    | EnglishToggleMsg
    | UiToggleMsg
    | BlackToggleMsg
    | DimToggleMsg
    | CertifiToggleMsg
    | ChardetToggleMsg
    | IdnaToggleMsg
    | PythonImageToggleMsg
    | PythonCryptoToggleMsg
    | RequestsToggleMsg
    | SixToggleMsg
    | UrllibToggleMsg
    | VersionToggleMsg
    | EstouchyToggleMsg
    | EstuaryToggleMsg
    | ChorusToggleMsg
    | SaveSettingsMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveSettingsMsg ->
            ( model, storeAddonSettings (encodeLocalSettings model.localSettingsList) )

        AACToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "aac"
                        (if model.aacToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , aacToggle = not model.aacToggle
              }
            , Cmd.none
            )

        WMAToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "wma"
                        (if model.wmaToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , wmaToggle = not model.wmaToggle
              }
            , Cmd.none
            )

        DefaultToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "default"
                        (if model.defaultToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , defaultToggle = not model.defaultToggle
              }
            , Cmd.none
            )

        SensToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "sens"
                        (if model.sensToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , sensToggle = not model.sensToggle
              }
            , Cmd.none
            )

        InputToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "input"
                        (if model.inputToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , inputToggle = not model.inputToggle
              }
            , Cmd.none
            )

        RtmpToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "rtmp"
                        (if model.rtmpToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , rtmpToggle = not model.rtmpToggle
              }
            , Cmd.none
            )

        UniversalAlbumToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "universal album"
                        (if model.universalAlbumToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , universalAlbumToggle = not model.universalAlbumToggle
              }
            , Cmd.none
            )

        GenericAlbumToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "generic album"
                        (if model.genericAlbumToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , genericAlbumToggle = not model.genericAlbumToggle
              }
            , Cmd.none
            )

        LocalToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "local"
                        (if model.localToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , localToggle = not model.localToggle
              }
            , Cmd.none
            )

        UniversalArtistToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "universal artist"
                        (if model.universalArtistToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , universalArtistToggle = not model.universalArtistToggle
              }
            , Cmd.none
            )

        GenericArtistToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "generic artist"
                        (if model.genericArtistToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , genericArtistToggle = not model.genericArtistToggle
              }
            , Cmd.none
            )

        MusicToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "music"
                        (if model.musicToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , musicToggle = not model.musicToggle
              }
            , Cmd.none
            )

        FanartToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "fanart"
                        (if model.fanartToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , fanartToggle = not model.fanartToggle
              }
            , Cmd.none
            )

        ImdbToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "imdb"
                        (if model.imdbToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , imdbToggle = not model.imdbToggle
              }
            , Cmd.none
            )

        MusicBrainzToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "music brainz"
                        (if model.musicBrainzToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , musicBrainzToggle = not model.musicBrainzToggle
              }
            , Cmd.none
            )

        AudioToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "audio"
                        (if model.audioToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , audioToggle = not model.audioToggle
              }
            , Cmd.none
            )

        MovieScraperToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie scraper"
                        (if model.movieScraperToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , movieScraperToggle = not model.movieScraperToggle
              }
            , Cmd.none
            )

        MovieDatabaseToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie database"
                        (if model.movieDatabaseToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , movieDatabaseToggle = not model.movieDatabaseToggle
              }
            , Cmd.none
            )

        MovieDatabsePythonToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie database python"
                        (if model.movieDatabsePythonToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , movieDatabsePythonToggle = not model.movieDatabsePythonToggle
              }
            , Cmd.none
            )

        MovieDatabseTVToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie database tv"
                        (if model.movieDatabseTVToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , movieDatabseTVToggle = not model.movieDatabseTVToggle
              }
            , Cmd.none
            )

        TmdbToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "tmdb"
                        (if model.tmdbToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , tmdbToggle = not model.tmdbToggle
              }
            , Cmd.none
            )

        JoystickToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "joystick"
                        (if model.joystickToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , joystickToggle = not model.joystickToggle
              }
            , Cmd.none
            )

        YoutubeToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "youtube"
                        (if model.youtubeToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , youtubeToggle = not model.youtubeToggle
              }
            , Cmd.none
            )

        AddonToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "addon"
                        (if model.addonToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , addonToggle = not model.addonToggle
              }
            , Cmd.none
            )

        WeatherToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "weather"
                        (if model.weatherToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , weatherToggle = not model.weatherToggle
              }
            , Cmd.none
            )

        EnglishToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "english"
                        (if model.englishToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , englishToggle = not model.englishToggle
              }
            , Cmd.none
            )

        UiToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "ui"
                        (if model.uiToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , uiToggle = not model.uiToggle
              }
            , Cmd.none
            )

        BlackToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "black"
                        (if model.blackToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , blackToggle = not model.blackToggle
              }
            , Cmd.none
            )

        DimToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "dim"
                        (if model.dimToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , dimToggle = not model.dimToggle
              }
            , Cmd.none
            )

        CertifiToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "certifi"
                        (if model.certifiToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , certifiToggle = not model.certifiToggle
              }
            , Cmd.none
            )

        ChardetToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "chardet"
                        (if model.chardetToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , chardetToggle = not model.chardetToggle
              }
            , Cmd.none
            )

        IdnaToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "idna"
                        (if model.idnaToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , idnaToggle = not model.idnaToggle
              }
            , Cmd.none
            )

        PythonImageToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "python image"
                        (if model.pythonImageToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , pythonImageToggle = not model.pythonImageToggle
              }
            , Cmd.none
            )

        PythonCryptoToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "python crypto"
                        (if model.pythonCryptoToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , pythonCryptoToggle = not model.pythonCryptoToggle
              }
            , Cmd.none
            )

        RequestsToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "requests"
                        (if model.requestsToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , requestsToggle = not model.requestsToggle
              }
            , Cmd.none
            )

        SixToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "six"
                        (if model.sixToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , sixToggle = not model.sixToggle
              }
            , Cmd.none
            )

        UrllibToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "url lib"
                        (if model.urllibToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , urllibToggle = not model.urllibToggle
              }
            , Cmd.none
            )

        VersionToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "version"
                        (if model.versionToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , versionToggle = not model.versionToggle
              }
            , Cmd.none
            )

        EstouchyToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "estouchy"
                        (if model.estouchyToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , estouchyToggle = not model.estouchyToggle
              }
            , Cmd.none
            )

        EstuaryToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "estuary"
                        (if model.estuaryToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , estuaryToggle = not model.estuaryToggle
              }
            , Cmd.none
            )

        ChorusToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "chorus"
                        (if model.chorusToggle then
                            "false"

                         else
                            "true"
                        )
                        model.localSettingsList
                , chorusToggle = not model.chorusToggle
              }
            , Cmd.none
            )

        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


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



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Addons"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "kodi.audioencoder")
                , settingsToggleBlock model.aacToggle AACToggleMsg "AAC encoder" "AAC is a set of codecs designed to provide better compression than MP3s, and are improved versions of MPEG audio."
                , settingsToggleBlock model.wmaToggle WMAToggleMsg "WMA encoder" "Windows Media Audio, Microsoft’s lossy audio format."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "kodi.game.controller")
                , settingsToggleBlock model.defaultToggle DefaultToggleMsg "Default Controller" "The default media center controller is based on the Xbox 360 controller."
                , settingsToggleBlock model.sensToggle SensToggleMsg "SENS Controller" "The SNES (akso known as Super NES or Super Nintendo) is a 16-bit console released in 1990. The controller design served as inspiration for the PlayStation, Dreamcast, Xbox and Wii Classic controllers."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "kodi.inputstream")
                , settingsToggleBlock model.inputToggle InputToggleMsg "InputStream Adaptive" "InputStream client for adaptive streams"
                , settingsToggleBlock model.rtmpToggle RtmpToggleMsg "RTMP Input" "The Real Time Messaging Protocol (RTMP) is a proprietary network protocol developed by Adobe Inc. to transmit audio, video and other data over the Internet from a media server to a flash player. This addon implements RTMP streaming support for Kodi and installed add-ons."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.metadata.scraper.albums")
                , settingsToggleBlock model.universalAlbumToggle UniversalAlbumToggleMsg "Universal Album Scraper" "This scraper collects information from the following supported sites: MusicBrainz, last.fm, allmusic.com and amazon.de, while grabs artwork from: fanart.tv, last.fm and allmusic.com. It can be set field by field that from which site you want that specific information. The initial search is always done on MusicBrainz. In case allmusic and/or amazon.de links are not added on the MusicBrainz site, fields from allmusic.com and/or amazon.de cannot be fetched (very easy to add those missing links though)."
                , settingsToggleBlock model.genericAlbumToggle GenericAlbumToggleMsg "Generic Album Scraper" "Searches for album information and artwork across multiple websites."
                , settingsToggleBlock model.localToggle LocalToggleMsg "Local Information Only" "Use local information only"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.metadata.scraper.artists")
                , settingsToggleBlock model.universalArtistToggle UniversalArtistToggleMsg "Universal Artist Scraper" "This scraper collects information from the following supported sites: TheAudioDb.com, MusicBrainz, last.fm, and allmusic.com, while grabs artwork from: fanart.tv, htbackdrops.com, last.fm and allmusic.com. It can be set field by field that from which site you want that specific information. The initial search is always done on MusicBrainz. In case allmusic link is not added on the MusicBrainz site fields from allmusic.com cannot be fetched (very easy to add those missing links though)."
                , settingsToggleBlock model.genericArtistToggle GenericArtistToggleMsg "Generic Artist Scraper" "Searches for artist information and artwork across multiple websites."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.metadata.scraper.library")
                , settingsToggleBlock model.musicToggle MusicToggleMsg "AllMusic Scraper Library" "Download Music information form www.allmusic.com"
                , settingsToggleBlock model.fanartToggle FanartToggleMsg "fanart.tv Scraper Libraray" "Download backdrops from www.fanart.tv.com"
                , settingsToggleBlock model.imdbToggle ImdbToggleMsg "IMDB Scraper Library" "Download Movie Information from www.imdb.com"
                , settingsToggleBlock model.musicBrainzToggle MusicBrainzToggleMsg "MusicBrainz Scraper Library" "Download Music Information from www.musicbrainz.org"
                , settingsToggleBlock model.audioToggle AudioToggleMsg "TheAudioDb Scraper Library" "Download Music Information from www.theaudiodb.com"
                , settingsToggleBlock model.movieScraperToggle MovieScraperToggleMsg "The Movie Database Scraper Library" "Download thumbs and fanarts from www.themoviedb.org"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.metadata.scraper.movies")
                , settingsToggleBlock model.movieDatabaseToggle MovieDatabaseToggleMsg "The Movie Database" "themoviedb.org is a free and open movie database. It's completely user driven by people like you. TMDb is currently used by millions of people every month and with their powerful API, it is also used by many popular media centers like Kodi to retrieve Movie Metadata, Posters and Fanart to enrich the user's experience."
                , settingsToggleBlock model.movieDatabsePythonToggle MovieDatabsePythonToggleMsg "The Movie Database Python" "themoviedb.org is a free and open movie database. It's completely user driven by people like you. TMDb is currently used by millions of people every month and with their powerful API, it is also used by many popular media centers like Kodi to retrieve Movie Metadata, Posters and Fanart to enrich the user's experience."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.metadata.scraper.tvshows")
                , settingsToggleBlock model.movieDatabseTVToggle MovieDatabseTVToggleMsg "The Movie Database" "themoviedb.org is a free and open movie database. It's completely user driven by people like you. TMDb is currently used by millions of people every month and with their powerful API, it is also used by many popular media centers like Kodi to retrieve Movie Metadata, Posters and Fanart to enrich the user's experience."
                , settingsToggleBlock model.tmdbToggle TmdbToggleMsg "TMDb TV Shows" "The Movie Database (TMDb) is a community built movie and TV database. Every piece of data has been added by our amazing community dating back to 2008. TMDb's strong international focus and breadth of data is largely unmatched and something we're incredibly proud of. Put simply, we live and breathe community and that's precisely what makes us different."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "kodi.peripheral")
                , settingsToggleBlock model.joystickToggle JoystickToggleMsg "Joystick Support" "This library provides joystick drivers and button maps. Multiple joystick APIs are supported, including DirectX, XInput, SDL and the Linux Joystick API."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.python.pluginsource")
                , settingsToggleBlock model.youtubeToggle YoutubeToggleMsg "YouTube" "YouTube is one of the biggest video-sharing websites of the world."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.addon.repository")
                , settingsToggleBlock model.addonToggle AddonToggleMsg "Kodi Add-on repository" "Download and install add-ons from the Official Kodi.tv add-on repository.[CR]  By using the official Repository you will be able to take advantage of our extensive file mirror service to help get you faster downloads from a region close to you.[CR]  All add-ons on this repository have under gone basic testing, if you find a broken or not working add-on please report it to Team Kodi so we can take any action needed."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "kodi.resource.images")
                , settingsToggleBlock model.weatherToggle WeatherToggleMsg "Weather Icons - Default" "Default set of Weather Icons shipped with Kodi"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "kodi.resource.language")
                , settingsToggleBlock model.englishToggle EnglishToggleMsg "English" "English version of all texts used in Kodi"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "kodi.resource.uisounds")
                , settingsToggleBlock model.uiToggle UiToggleMsg "Kodi UI Sounds" "Kodi GUI Sounds"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.ui.screensaver")
                , settingsToggleBlock model.blackToggle BlackToggleMsg "Black" "Black is a simple screensaver that will turn your screen black."
                , settingsToggleBlock model.dimToggle DimToggleMsg "Dim" "The Dim screensaver is a simple screensaver that will dim (fade out) your screen to a setable value between 20 and 100% ."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.python.module")
                , settingsToggleBlock model.certifiToggle CertifiToggleMsg "certifi" "Certifi is a carefully curated collection of Root Certificates for validating the trustworthiness of SSL certificates while verifying the identity of TLS hosts. It has been extracted from the Requests project."
                , settingsToggleBlock model.chardetToggle ChardetToggleMsg "chardet" "The Universal Character Encoding Detector"
                , settingsToggleBlock model.idnaToggle IdnaToggleMsg "idna" "Internationalized Domain Names for Python"
                , settingsToggleBlock model.pythonImageToggle PythonImageToggleMsg "Python Image Library" ""
                , settingsToggleBlock model.pythonCryptoToggle PythonCryptoToggleMsg "Python Crypto Library" ""
                , settingsToggleBlock model.requestsToggle RequestsToggleMsg "requests" "Requests is an elegant and simple HTTP library for Python, built for human beings."
                , settingsToggleBlock model.sixToggle SixToggleMsg "six" "Six is a Python 2 and 3 compatibility library. It provides utility functions for smoothing over the differences between the Python versions with the goal of writing Python code that is compatible on both Python versions. See the documentation for more information on what is provided."
                , settingsToggleBlock model.urllibToggle UrllibToggleMsg "urllib3" "urllib3 is a powerful, user-friendly HTTP client for Python. Much of the Python ecosystem already uses urllib3 and you should too. urllib3 brings many critical features that are missing from the Python standard libraries"
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.service")
                , settingsToggleBlock model.versionToggle VersionToggleMsg "Version Check" "Kodi Version Check only supports a number of platforms/distros as releases may differ between them. For more information visit the kodi.tv website."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.gui.skin")
                , settingsToggleBlock model.estouchyToggle EstouchyToggleMsg "Estouchy" "Skin designed to be used on touchscreen devices like tablets and smartphones"
                , settingsToggleBlock model.estuaryToggle EstuaryToggleMsg "Estuary" "Estuary is the default skin for Kodi 17.0 and above. It attempts to be easy for first time Kodi users to understand and use."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "xbmc.webinterface")
                , settingsToggleBlock model.chorusToggle ChorusToggleMsg "Kodi web interface - Chorus2" "Browse and interact with your Music, Movies, TV Shows and more via a web browser. Stream music and videos on your browser. Edit and manage your Kodi media library."
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
