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
      , aacToggle = stringToBoolValue (getVal 1 shared.addonLocalSettings)
      , wmaToggle = stringToBoolValue (getVal 2 shared.addonLocalSettings)
      , defaultToggle = stringToBoolValue (getVal 3 shared.addonLocalSettings)
      , sensToggle = stringToBoolValue (getVal 4 shared.addonLocalSettings)
      , inputToggle = stringToBoolValue (getVal 5 shared.addonLocalSettings)
      , rtmpToggle = stringToBoolValue (getVal 6 shared.addonLocalSettings)
      , universalAlbumToggle = stringToBoolValue (getVal 7 shared.addonLocalSettings)
      , genericAlbumToggle = stringToBoolValue (getVal 8 shared.addonLocalSettings)
      , localToggle = stringToBoolValue (getVal 9 shared.addonLocalSettings)
      , universalArtistToggle = stringToBoolValue (getVal 10 shared.addonLocalSettings)
      , genericArtistToggle = stringToBoolValue (getVal 11 shared.addonLocalSettings)
      , musicToggle = stringToBoolValue (getVal 12 shared.addonLocalSettings)
      , fanartToggle = stringToBoolValue (getVal 13 shared.addonLocalSettings)
      , imdbToggle = stringToBoolValue (getVal 14 shared.addonLocalSettings)
      , musicBrainzToggle = stringToBoolValue (getVal 15 shared.addonLocalSettings)
      , audioToggle = stringToBoolValue (getVal 16 shared.addonLocalSettings)
      , movieScraperToggle = stringToBoolValue (getVal 17 shared.addonLocalSettings)
      , movieDatabaseToggle = stringToBoolValue (getVal 18 shared.addonLocalSettings)
      , movieDatabsePythonToggle = stringToBoolValue (getVal 19 shared.addonLocalSettings)
      , movieDatabseTVToggle = stringToBoolValue (getVal 20 shared.addonLocalSettings)
      , tmdbToggle = stringToBoolValue (getVal 21 shared.addonLocalSettings)
      , joystickToggle = stringToBoolValue (getVal 22 shared.addonLocalSettings)
      , youtubeToggle = stringToBoolValue (getVal 23 shared.addonLocalSettings)
      , addonToggle = stringToBoolValue (getVal 24 shared.addonLocalSettings)
      , weatherToggle = stringToBoolValue (getVal 25 shared.addonLocalSettings)
      , englishToggle = stringToBoolValue (getVal 26 shared.addonLocalSettings)
      , uiToggle = stringToBoolValue (getVal 27 shared.addonLocalSettings)
      , blackToggle = stringToBoolValue (getVal 28 shared.addonLocalSettings)
      , dimToggle = stringToBoolValue (getVal 29 shared.addonLocalSettings)
      , certifiToggle = stringToBoolValue (getVal 30 shared.addonLocalSettings)
      , chardetToggle = stringToBoolValue (getVal 31 shared.addonLocalSettings)
      , idnaToggle = stringToBoolValue (getVal 32 shared.addonLocalSettings)
      , pythonImageToggle = stringToBoolValue (getVal 33 shared.addonLocalSettings)
      , pythonCryptoToggle = stringToBoolValue (getVal 34 shared.addonLocalSettings)
      , requestsToggle = stringToBoolValue (getVal 35 shared.addonLocalSettings)
      , sixToggle = stringToBoolValue (getVal 36 shared.addonLocalSettings)
      , urllibToggle = stringToBoolValue (getVal 37 shared.addonLocalSettings)
      , versionToggle = stringToBoolValue (getVal 38 shared.addonLocalSettings)
      , estouchyToggle = stringToBoolValue (getVal 39 shared.addonLocalSettings)
      , estuaryToggle = stringToBoolValue (getVal 40 shared.addonLocalSettings)
      , chorusToggle = stringToBoolValue (getVal 41 shared.addonLocalSettings)
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = AACToggleMsg
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
                        (boolToStringOppositeValue model.aacToggle)
                        model.localSettingsList
                , aacToggle = not model.aacToggle
              }
            , Cmd.none
            )

        WMAToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "wma"
                        (boolToStringOppositeValue model.wmaToggle)
                        model.localSettingsList
                , wmaToggle = not model.wmaToggle
              }
            , Cmd.none
            )

        DefaultToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "default"
                        (boolToStringOppositeValue model.defaultToggle)
                        model.localSettingsList
                , defaultToggle = not model.defaultToggle
              }
            , Cmd.none
            )

        SensToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "sens"
                        (boolToStringOppositeValue model.sensToggle)
                        model.localSettingsList
                , sensToggle = not model.sensToggle
              }
            , Cmd.none
            )

        InputToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "input"
                        (boolToStringOppositeValue model.inputToggle)
                        model.localSettingsList
                , inputToggle = not model.inputToggle
              }
            , Cmd.none
            )

        RtmpToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "rtmp"
                        (boolToStringOppositeValue model.rtmpToggle)
                        model.localSettingsList
                , rtmpToggle = not model.rtmpToggle
              }
            , Cmd.none
            )

        UniversalAlbumToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "universal album"
                        (boolToStringOppositeValue model.universalAlbumToggle)
                        model.localSettingsList
                , universalAlbumToggle = not model.universalAlbumToggle
              }
            , Cmd.none
            )

        GenericAlbumToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "generic album"
                        (boolToStringOppositeValue model.genericAlbumToggle)
                        model.localSettingsList
                , genericAlbumToggle = not model.genericAlbumToggle
              }
            , Cmd.none
            )

        LocalToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "local"
                        (boolToStringOppositeValue model.localToggle)
                        model.localSettingsList
                , localToggle = not model.localToggle
              }
            , Cmd.none
            )

        UniversalArtistToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "universal artist"
                        (boolToStringOppositeValue model.universalArtistToggle)
                        model.localSettingsList
                , universalArtistToggle = not model.universalArtistToggle
              }
            , Cmd.none
            )

        GenericArtistToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "generic artist"
                        (boolToStringOppositeValue model.genericArtistToggle)
                        model.localSettingsList
                , genericArtistToggle = not model.genericArtistToggle
              }
            , Cmd.none
            )

        MusicToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "music"
                        (boolToStringOppositeValue model.musicToggle)
                        model.localSettingsList
                , musicToggle = not model.musicToggle
              }
            , Cmd.none
            )

        FanartToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "fanart"
                        (boolToStringOppositeValue model.fanartToggle)
                        model.localSettingsList
                , fanartToggle = not model.fanartToggle
              }
            , Cmd.none
            )

        ImdbToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "imdb"
                        (boolToStringOppositeValue model.imdbToggle)
                        model.localSettingsList
                , imdbToggle = not model.imdbToggle
              }
            , Cmd.none
            )

        MusicBrainzToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "music brainz"
                        (boolToStringOppositeValue model.musicBrainzToggle)
                        model.localSettingsList
                , musicBrainzToggle = not model.musicBrainzToggle
              }
            , Cmd.none
            )

        AudioToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "audio"
                        (boolToStringOppositeValue model.audioToggle)
                        model.localSettingsList
                , audioToggle = not model.audioToggle
              }
            , Cmd.none
            )

        MovieScraperToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie scraper"
                        (boolToStringOppositeValue model.movieScraperToggle)
                        model.localSettingsList
                , movieScraperToggle = not model.movieScraperToggle
              }
            , Cmd.none
            )

        MovieDatabaseToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie database"
                        (boolToStringOppositeValue model.movieDatabaseToggle)
                        model.localSettingsList
                , movieDatabaseToggle = not model.movieDatabaseToggle
              }
            , Cmd.none
            )

        MovieDatabsePythonToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie database python"
                        (boolToStringOppositeValue model.movieDatabsePythonToggle)
                        model.localSettingsList
                , movieDatabsePythonToggle = not model.movieDatabsePythonToggle
              }
            , Cmd.none
            )

        MovieDatabseTVToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "movie database tv"
                        (boolToStringOppositeValue model.movieDatabseTVToggle)
                        model.localSettingsList
                , movieDatabseTVToggle = not model.movieDatabseTVToggle
              }
            , Cmd.none
            )

        TmdbToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "tmdb"
                        (boolToStringOppositeValue model.tmdbToggle)
                        model.localSettingsList
                , tmdbToggle = not model.tmdbToggle
              }
            , Cmd.none
            )

        JoystickToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "joystick"
                        (boolToStringOppositeValue model.joystickToggle)
                        model.localSettingsList
                , joystickToggle = not model.joystickToggle
              }
            , Cmd.none
            )

        YoutubeToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "youtube"
                        (boolToStringOppositeValue model.youtubeToggle)
                        model.localSettingsList
                , youtubeToggle = not model.youtubeToggle
              }
            , Cmd.none
            )

        AddonToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "addon"
                        (boolToStringOppositeValue model.addonToggle)
                        model.localSettingsList
                , addonToggle = not model.addonToggle
              }
            , Cmd.none
            )

        WeatherToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "weather"
                        (boolToStringOppositeValue model.weatherToggle)
                        model.localSettingsList
                , weatherToggle = not model.weatherToggle
              }
            , Cmd.none
            )

        EnglishToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "english"
                        (boolToStringOppositeValue model.englishToggle)
                        model.localSettingsList
                , englishToggle = not model.englishToggle
              }
            , Cmd.none
            )

        UiToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "ui"
                        (boolToStringOppositeValue model.uiToggle)
                        model.localSettingsList
                , uiToggle = not model.uiToggle
              }
            , Cmd.none
            )

        BlackToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "black"
                        (boolToStringOppositeValue model.blackToggle)
                        model.localSettingsList
                , blackToggle = not model.blackToggle
              }
            , Cmd.none
            )

        DimToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "dim"
                        (boolToStringOppositeValue model.dimToggle)
                        model.localSettingsList
                , dimToggle = not model.dimToggle
              }
            , Cmd.none
            )

        CertifiToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "certifi"
                        (boolToStringOppositeValue model.certifiToggle)
                        model.localSettingsList
                , certifiToggle = not model.certifiToggle
              }
            , Cmd.none
            )

        ChardetToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "chardet"
                        (boolToStringOppositeValue model.chardetToggle)
                        model.localSettingsList
                , chardetToggle = not model.chardetToggle
              }
            , Cmd.none
            )

        IdnaToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "idna"
                        (boolToStringOppositeValue model.idnaToggle)
                        model.localSettingsList
                , idnaToggle = not model.idnaToggle
              }
            , Cmd.none
            )

        PythonImageToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "python image"
                        (boolToStringOppositeValue model.pythonImageToggle)
                        model.localSettingsList
                , pythonImageToggle = not model.pythonImageToggle
              }
            , Cmd.none
            )

        PythonCryptoToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "python crypto"
                        (boolToStringOppositeValue model.pythonCryptoToggle)
                        model.localSettingsList
                , pythonCryptoToggle = not model.pythonCryptoToggle
              }
            , Cmd.none
            )

        RequestsToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "requests"
                        (boolToStringOppositeValue model.requestsToggle)
                        model.localSettingsList
                , requestsToggle = not model.requestsToggle
              }
            , Cmd.none
            )

        SixToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "six"
                        (boolToStringOppositeValue model.sixToggle)
                        model.localSettingsList
                , sixToggle = not model.sixToggle
              }
            , Cmd.none
            )

        UrllibToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "url lib"
                        (boolToStringOppositeValue model.urllibToggle)
                        model.localSettingsList
                , urllibToggle = not model.urllibToggle
              }
            , Cmd.none
            )

        VersionToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "version"
                        (boolToStringOppositeValue model.versionToggle)
                        model.localSettingsList
                , versionToggle = not model.versionToggle
              }
            , Cmd.none
            )

        EstouchyToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "estouchy"
                        (boolToStringOppositeValue model.estouchyToggle)
                        model.localSettingsList
                , estouchyToggle = not model.estouchyToggle
              }
            , Cmd.none
            )

        EstuaryToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "estuary"
                        (boolToStringOppositeValue model.estuaryToggle)
                        model.localSettingsList
                , estuaryToggle = not model.estuaryToggle
              }
            , Cmd.none
            )

        ChorusToggleMsg ->
            ( { model
                | localSettingsList =
                    setVal "chorus"
                        (boolToStringOppositeValue model.chorusToggle)
                        model.localSettingsList
                , chorusToggle = not model.chorusToggle
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



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
