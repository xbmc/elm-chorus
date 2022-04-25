module Spa.Generated.Pages exposing
    ( Model
    , Msg
    , init
    , load
    , save
    , subscriptions
    , update
    , view
    )

import Pages.Addons
import Pages.Browser
import Pages.Browser.Source_String
import Pages.Help.About
import Pages.Help.Addons
import Pages.Help.Changelog
import Pages.Help.Developers
import Pages.Help.Keyboard
import Pages.Help.License
import Pages.Help.Readme
import Pages.Help.Translations
import Pages.Lab
import Pages.Movies
import Pages.Movies.Recent
import Pages.Music
import Pages.Music.Album.Albumid_Int
import Pages.Music.Albums
import Pages.Music.Artist.Artistid_Int
import Pages.Music.Artists
import Pages.Music.Genre.Genre_String
import Pages.Music.Genres
import Pages.Music.Top.Top
import Pages.Music.Videos
import Pages.Music.Videos.Videoid_Int
import Pages.NotFound
import Pages.Playlists
import Pages.Playlists.Name_String
import Pages.Settings.Addons
import Pages.Settings.Kodi.Games
import Pages.Settings.Kodi.Interface
import Pages.Settings.Kodi.Media
import Pages.Settings.Kodi.Player
import Pages.Settings.Kodi.Pvr
import Pages.Settings.Kodi.Services
import Pages.Settings.Kodi.System
import Pages.Settings.Nav
import Pages.Settings.Search
import Pages.Settings.Web
import Pages.Thumbsup
import Pages.Top
import Pages.Tvshows
import Pages.Tvshows.Recent
import Pages.Videoplayer.Movieid_Int
import Shared
import Spa.Document as Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page exposing (Page)
import Spa.Url as Url



-- TYPES


type Model
    = Top__Model Pages.Top.Model
    | Addons__Model Pages.Addons.Model
    | Browser__Model Pages.Browser.Model
    | Lab__Model Pages.Lab.Model
    | Movies__Model Pages.Movies.Model
    | Music__Model Pages.Music.Model
    | NotFound__Model Pages.NotFound.Model
    | Playlists__Model Pages.Playlists.Model
    | Thumbsup__Model Pages.Thumbsup.Model
    | Tvshows__Model Pages.Tvshows.Model
    | Help__About__Model Pages.Help.About.Model
    | Help__Addons__Model Pages.Help.Addons.Model
    | Help__Changelog__Model Pages.Help.Changelog.Model
    | Help__Developers__Model Pages.Help.Developers.Model
    | Help__Keyboard__Model Pages.Help.Keyboard.Model
    | Help__License__Model Pages.Help.License.Model
    | Help__Readme__Model Pages.Help.Readme.Model
    | Help__Translations__Model Pages.Help.Translations.Model
    | Movies__Recent__Model Pages.Movies.Recent.Model
    | Music__Albums__Model Pages.Music.Albums.Model
    | Music__Artists__Model Pages.Music.Artists.Model
    | Music__Genres__Model Pages.Music.Genres.Model
    | Music__Videos__Model Pages.Music.Videos.Model
    | Settings__Addons__Model Pages.Settings.Addons.Model
    | Settings__Nav__Model Pages.Settings.Nav.Model
    | Settings__Search__Model Pages.Settings.Search.Model
    | Settings__Web__Model Pages.Settings.Web.Model
    | Tvshows__Recent__Model Pages.Tvshows.Recent.Model
    | Browser__Source_String__Model Pages.Browser.Source_String.Model
    | Playlists__Name_String__Model Pages.Playlists.Name_String.Model
    | Videoplayer__Movieid_Int__Model Pages.Videoplayer.Movieid_Int.Model
    | Music__Top__Top__Model Pages.Music.Top.Top.Model
    | Settings__Kodi__Games__Model Pages.Settings.Kodi.Games.Model
    | Settings__Kodi__Interface__Model Pages.Settings.Kodi.Interface.Model
    | Settings__Kodi__Media__Model Pages.Settings.Kodi.Media.Model
    | Settings__Kodi__Player__Model Pages.Settings.Kodi.Player.Model
    | Settings__Kodi__Pvr__Model Pages.Settings.Kodi.Pvr.Model
    | Settings__Kodi__Services__Model Pages.Settings.Kodi.Services.Model
    | Settings__Kodi__System__Model Pages.Settings.Kodi.System.Model
    | Music__Album__Albumid_Int__Model Pages.Music.Album.Albumid_Int.Model
    | Music__Artist__Artistid_Int__Model Pages.Music.Artist.Artistid_Int.Model
    | Music__Videos__Videoid_Int__Model Pages.Music.Videos.Videoid_Int.Model
    | Music__Genre__Genre_String__Model Pages.Music.Genre.Genre_String.Model


type Msg
    = Top__Msg Pages.Top.Msg
    | Addons__Msg Pages.Addons.Msg
    | Browser__Msg Pages.Browser.Msg
    | Lab__Msg Pages.Lab.Msg
    | Movies__Msg Pages.Movies.Msg
    | Music__Msg Pages.Music.Msg
    | NotFound__Msg Pages.NotFound.Msg
    | Playlists__Msg Pages.Playlists.Msg
    | Thumbsup__Msg Pages.Thumbsup.Msg
    | Tvshows__Msg Pages.Tvshows.Msg
    | Help__About__Msg Pages.Help.About.Msg
    | Help__Addons__Msg Pages.Help.Addons.Msg
    | Help__Changelog__Msg Pages.Help.Changelog.Msg
    | Help__Developers__Msg Pages.Help.Developers.Msg
    | Help__Keyboard__Msg Pages.Help.Keyboard.Msg
    | Help__License__Msg Pages.Help.License.Msg
    | Help__Readme__Msg Pages.Help.Readme.Msg
    | Help__Translations__Msg Pages.Help.Translations.Msg
    | Movies__Recent__Msg Pages.Movies.Recent.Msg
    | Music__Albums__Msg Pages.Music.Albums.Msg
    | Music__Artists__Msg Pages.Music.Artists.Msg
    | Music__Genres__Msg Pages.Music.Genres.Msg
    | Music__Videos__Msg Pages.Music.Videos.Msg
    | Settings__Addons__Msg Pages.Settings.Addons.Msg
    | Settings__Nav__Msg Pages.Settings.Nav.Msg
    | Settings__Search__Msg Pages.Settings.Search.Msg
    | Settings__Web__Msg Pages.Settings.Web.Msg
    | Tvshows__Recent__Msg Pages.Tvshows.Recent.Msg
    | Browser__Source_String__Msg Pages.Browser.Source_String.Msg
    | Playlists__Name_String__Msg Pages.Playlists.Name_String.Msg
    | Videoplayer__Movieid_Int__Msg Pages.Videoplayer.Movieid_Int.Msg
    | Music__Top__Top__Msg Pages.Music.Top.Top.Msg
    | Settings__Kodi__Games__Msg Pages.Settings.Kodi.Games.Msg
    | Settings__Kodi__Interface__Msg Pages.Settings.Kodi.Interface.Msg
    | Settings__Kodi__Media__Msg Pages.Settings.Kodi.Media.Msg
    | Settings__Kodi__Player__Msg Pages.Settings.Kodi.Player.Msg
    | Settings__Kodi__Pvr__Msg Pages.Settings.Kodi.Pvr.Msg
    | Settings__Kodi__Services__Msg Pages.Settings.Kodi.Services.Msg
    | Settings__Kodi__System__Msg Pages.Settings.Kodi.System.Msg
    | Music__Album__Albumid_Int__Msg Pages.Music.Album.Albumid_Int.Msg
    | Music__Artist__Artistid_Int__Msg Pages.Music.Artist.Artistid_Int.Msg
    | Music__Videos__Videoid_Int__Msg Pages.Music.Videos.Videoid_Int.Msg
    | Music__Genre__Genre_String__Msg Pages.Music.Genre.Genre_String.Msg



-- INIT


init : Route -> Shared.Model -> ( Model, Cmd Msg )
init route =
    case route of
        Route.Top ->
            pages.top.init ()

        Route.Addons ->
            pages.addons.init ()

        Route.Browser ->
            pages.browser.init ()

        Route.Lab ->
            pages.lab.init ()

        Route.Movies ->
            pages.movies.init ()

        Route.Music ->
            pages.music.init ()

        Route.NotFound ->
            pages.notFound.init ()

        Route.Playlists ->
            pages.playlists.init ()

        Route.Thumbsup ->
            pages.thumbsup.init ()

        Route.Tvshows ->
            pages.tvshows.init ()

        Route.Help__About ->
            pages.help__about.init ()

        Route.Help__Addons ->
            pages.help__addons.init ()

        Route.Help__Changelog ->
            pages.help__changelog.init ()

        Route.Help__Developers ->
            pages.help__developers.init ()

        Route.Help__Keyboard ->
            pages.help__keyboard.init ()

        Route.Help__License ->
            pages.help__license.init ()

        Route.Help__Readme ->
            pages.help__readme.init ()

        Route.Help__Translations ->
            pages.help__translations.init ()

        Route.Movies__Recent ->
            pages.movies__recent.init ()

        Route.Music__Albums ->
            pages.music__albums.init ()

        Route.Music__Artists ->
            pages.music__artists.init ()

        Route.Music__Genres ->
            pages.music__genres.init ()

        Route.Music__Videos ->
            pages.music__videos.init ()

        Route.Settings__Addons ->
            pages.settings__addons.init ()

        Route.Settings__Nav ->
            pages.settings__nav.init ()

        Route.Settings__Search ->
            pages.settings__search.init ()

        Route.Settings__Web ->
            pages.settings__web.init ()

        Route.Tvshows__Recent ->
            pages.tvshows__recent.init ()

        Route.Browser__Source_String params ->
            pages.browser__source_string.init params

        Route.Playlists__Name_String params ->
            pages.playlists__name_string.init params

        Route.Videoplayer__Movieid_Int params ->
            pages.videoplayer__movieid_int.init params

        Route.Music__Top__Top ->
            pages.music__top__top.init ()

        Route.Settings__Kodi__Games ->
            pages.settings__kodi__games.init ()

        Route.Settings__Kodi__Interface ->
            pages.settings__kodi__interface.init ()

        Route.Settings__Kodi__Media ->
            pages.settings__kodi__media.init ()

        Route.Settings__Kodi__Player ->
            pages.settings__kodi__player.init ()

        Route.Settings__Kodi__Pvr ->
            pages.settings__kodi__pvr.init ()

        Route.Settings__Kodi__Services ->
            pages.settings__kodi__services.init ()

        Route.Settings__Kodi__System ->
            pages.settings__kodi__system.init ()

        Route.Music__Album__Albumid_Int params ->
            pages.music__album__albumid_int.init params

        Route.Music__Artist__Artistid_Int params ->
            pages.music__artist__artistid_int.init params

        Route.Music__Videos__Videoid_Int params ->
            pages.music__videos__videoid_int.init params

        Route.Music__Genre__Genre_String params ->
            pages.music__genre__genre_string.init params



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update bigMsg bigModel =
    case ( bigMsg, bigModel ) of
        ( Top__Msg msg, Top__Model model ) ->
            pages.top.update msg model

        ( Addons__Msg msg, Addons__Model model ) ->
            pages.addons.update msg model

        ( Browser__Msg msg, Browser__Model model ) ->
            pages.browser.update msg model

        ( Lab__Msg msg, Lab__Model model ) ->
            pages.lab.update msg model

        ( Movies__Msg msg, Movies__Model model ) ->
            pages.movies.update msg model

        ( Music__Msg msg, Music__Model model ) ->
            pages.music.update msg model

        ( NotFound__Msg msg, NotFound__Model model ) ->
            pages.notFound.update msg model

        ( Playlists__Msg msg, Playlists__Model model ) ->
            pages.playlists.update msg model

        ( Thumbsup__Msg msg, Thumbsup__Model model ) ->
            pages.thumbsup.update msg model

        ( Tvshows__Msg msg, Tvshows__Model model ) ->
            pages.tvshows.update msg model

        ( Help__About__Msg msg, Help__About__Model model ) ->
            pages.help__about.update msg model

        ( Help__Addons__Msg msg, Help__Addons__Model model ) ->
            pages.help__addons.update msg model

        ( Help__Changelog__Msg msg, Help__Changelog__Model model ) ->
            pages.help__changelog.update msg model

        ( Help__Developers__Msg msg, Help__Developers__Model model ) ->
            pages.help__developers.update msg model

        ( Help__Keyboard__Msg msg, Help__Keyboard__Model model ) ->
            pages.help__keyboard.update msg model

        ( Help__License__Msg msg, Help__License__Model model ) ->
            pages.help__license.update msg model

        ( Help__Readme__Msg msg, Help__Readme__Model model ) ->
            pages.help__readme.update msg model

        ( Help__Translations__Msg msg, Help__Translations__Model model ) ->
            pages.help__translations.update msg model

        ( Movies__Recent__Msg msg, Movies__Recent__Model model ) ->
            pages.movies__recent.update msg model

        ( Music__Albums__Msg msg, Music__Albums__Model model ) ->
            pages.music__albums.update msg model

        ( Music__Artists__Msg msg, Music__Artists__Model model ) ->
            pages.music__artists.update msg model

        ( Music__Genres__Msg msg, Music__Genres__Model model ) ->
            pages.music__genres.update msg model

        ( Music__Videos__Msg msg, Music__Videos__Model model ) ->
            pages.music__videos.update msg model

        ( Settings__Addons__Msg msg, Settings__Addons__Model model ) ->
            pages.settings__addons.update msg model

        ( Settings__Nav__Msg msg, Settings__Nav__Model model ) ->
            pages.settings__nav.update msg model

        ( Settings__Search__Msg msg, Settings__Search__Model model ) ->
            pages.settings__search.update msg model

        ( Settings__Web__Msg msg, Settings__Web__Model model ) ->
            pages.settings__web.update msg model

        ( Tvshows__Recent__Msg msg, Tvshows__Recent__Model model ) ->
            pages.tvshows__recent.update msg model

        ( Browser__Source_String__Msg msg, Browser__Source_String__Model model ) ->
            pages.browser__source_string.update msg model

        ( Playlists__Name_String__Msg msg, Playlists__Name_String__Model model ) ->
            pages.playlists__name_string.update msg model

        ( Videoplayer__Movieid_Int__Msg msg, Videoplayer__Movieid_Int__Model model ) ->
            pages.videoplayer__movieid_int.update msg model

        ( Music__Top__Top__Msg msg, Music__Top__Top__Model model ) ->
            pages.music__top__top.update msg model

        ( Settings__Kodi__Games__Msg msg, Settings__Kodi__Games__Model model ) ->
            pages.settings__kodi__games.update msg model

        ( Settings__Kodi__Interface__Msg msg, Settings__Kodi__Interface__Model model ) ->
            pages.settings__kodi__interface.update msg model

        ( Settings__Kodi__Media__Msg msg, Settings__Kodi__Media__Model model ) ->
            pages.settings__kodi__media.update msg model

        ( Settings__Kodi__Player__Msg msg, Settings__Kodi__Player__Model model ) ->
            pages.settings__kodi__player.update msg model

        ( Settings__Kodi__Pvr__Msg msg, Settings__Kodi__Pvr__Model model ) ->
            pages.settings__kodi__pvr.update msg model

        ( Settings__Kodi__Services__Msg msg, Settings__Kodi__Services__Model model ) ->
            pages.settings__kodi__services.update msg model

        ( Settings__Kodi__System__Msg msg, Settings__Kodi__System__Model model ) ->
            pages.settings__kodi__system.update msg model

        ( Music__Album__Albumid_Int__Msg msg, Music__Album__Albumid_Int__Model model ) ->
            pages.music__album__albumid_int.update msg model

        ( Music__Artist__Artistid_Int__Msg msg, Music__Artist__Artistid_Int__Model model ) ->
            pages.music__artist__artistid_int.update msg model

        ( Music__Genre__Genre_String__Msg msg, Music__Genre__Genre_String__Model model ) ->
            pages.music__genre__genre_string.update msg model

        _ ->
            ( bigModel, Cmd.none )



-- BUNDLE - (view + subscriptions)


bundle : Model -> Bundle
bundle bigModel =
    case bigModel of
        Top__Model model ->
            pages.top.bundle model

        Addons__Model model ->
            pages.addons.bundle model

        Browser__Model model ->
            pages.browser.bundle model

        Lab__Model model ->
            pages.lab.bundle model

        Movies__Model model ->
            pages.movies.bundle model

        Music__Model model ->
            pages.music.bundle model

        NotFound__Model model ->
            pages.notFound.bundle model

        Playlists__Model model ->
            pages.playlists.bundle model

        Thumbsup__Model model ->
            pages.thumbsup.bundle model

        Tvshows__Model model ->
            pages.tvshows.bundle model

        Help__About__Model model ->
            pages.help__about.bundle model

        Help__Addons__Model model ->
            pages.help__addons.bundle model

        Help__Changelog__Model model ->
            pages.help__changelog.bundle model

        Help__Developers__Model model ->
            pages.help__developers.bundle model

        Help__Keyboard__Model model ->
            pages.help__keyboard.bundle model

        Help__License__Model model ->
            pages.help__license.bundle model

        Help__Readme__Model model ->
            pages.help__readme.bundle model

        Help__Translations__Model model ->
            pages.help__translations.bundle model

        Movies__Recent__Model model ->
            pages.movies__recent.bundle model

        Music__Albums__Model model ->
            pages.music__albums.bundle model

        Music__Artists__Model model ->
            pages.music__artists.bundle model

        Music__Genres__Model model ->
            pages.music__genres.bundle model

        Music__Videos__Model model ->
            pages.music__videos.bundle model

        Settings__Addons__Model model ->
            pages.settings__addons.bundle model

        Settings__Nav__Model model ->
            pages.settings__nav.bundle model

        Settings__Search__Model model ->
            pages.settings__search.bundle model

        Settings__Web__Model model ->
            pages.settings__web.bundle model

        Tvshows__Recent__Model model ->
            pages.tvshows__recent.bundle model

        Browser__Source_String__Model model ->
            pages.browser__source_string.bundle model

        Playlists__Name_String__Model model ->
            pages.playlists__name_string.bundle model

        Videoplayer__Movieid_Int__Model model ->
            pages.videoplayer__movieid_int.bundle model

        Music__Top__Top__Model model ->
            pages.music__top__top.bundle model

        Settings__Kodi__Games__Model model ->
            pages.settings__kodi__games.bundle model

        Settings__Kodi__Interface__Model model ->
            pages.settings__kodi__interface.bundle model

        Settings__Kodi__Media__Model model ->
            pages.settings__kodi__media.bundle model

        Settings__Kodi__Player__Model model ->
            pages.settings__kodi__player.bundle model

        Settings__Kodi__Pvr__Model model ->
            pages.settings__kodi__pvr.bundle model

        Settings__Kodi__Services__Model model ->
            pages.settings__kodi__services.bundle model

        Settings__Kodi__System__Model model ->
            pages.settings__kodi__system.bundle model

        Music__Album__Albumid_Int__Model model ->
            pages.music__album__albumid_int.bundle model

        Music__Artist__Artistid_Int__Model model ->
            pages.music__artist__artistid_int.bundle model

        Music__Videos__Videoid_Int__Model model ->
            pages.music__videos__videoid_int.bundle model

        Music__Genre__Genre_String__Model model ->
            pages.music__genre__genre_string.bundle model


view : Model -> Document Msg
view model =
    (bundle model).view ()


subscriptions : Model -> Sub Msg
subscriptions model =
    (bundle model).subscriptions ()


save : Model -> Shared.Model -> Shared.Model
save model =
    (bundle model).save ()


load : Model -> Shared.Model -> ( Model, Cmd Msg )
load model =
    (bundle model).load ()



-- UPGRADING PAGES


type alias Upgraded params model msg =
    { init : params -> Shared.Model -> ( Model, Cmd Msg )
    , update : msg -> model -> ( Model, Cmd Msg )
    , bundle : model -> Bundle
    }


type alias Bundle =
    { view : () -> Document Msg
    , subscriptions : () -> Sub Msg
    , save : () -> Shared.Model -> Shared.Model
    , load : () -> Shared.Model -> ( Model, Cmd Msg )
    }


upgrade : (model -> Model) -> (msg -> Msg) -> Page params model msg -> Upgraded params model msg
upgrade toModel toMsg page =
    let
        init_ params shared =
            page.init shared (Url.create params shared.key shared.url) |> Tuple.mapBoth toModel (Cmd.map toMsg)

        update_ msg model =
            page.update msg model |> Tuple.mapBoth toModel (Cmd.map toMsg)

        bundle_ model =
            { view = \_ -> page.view model |> Document.map toMsg
            , subscriptions = \_ -> page.subscriptions model |> Sub.map toMsg
            , save = \_ -> page.save model
            , load = \_ -> load_ model
            }

        load_ model shared =
            page.load shared model |> Tuple.mapBoth toModel (Cmd.map toMsg)
    in
    { init = init_
    , update = update_
    , bundle = bundle_
    }


pages :
    { top : Upgraded Pages.Top.Params Pages.Top.Model Pages.Top.Msg
    , addons : Upgraded Pages.Addons.Params Pages.Addons.Model Pages.Addons.Msg
    , browser : Upgraded Pages.Browser.Params Pages.Browser.Model Pages.Browser.Msg
    , lab : Upgraded Pages.Lab.Params Pages.Lab.Model Pages.Lab.Msg
    , movies : Upgraded Pages.Movies.Params Pages.Movies.Model Pages.Movies.Msg
    , music : Upgraded Pages.Music.Params Pages.Music.Model Pages.Music.Msg
    , notFound : Upgraded Pages.NotFound.Params Pages.NotFound.Model Pages.NotFound.Msg
    , playlists : Upgraded Pages.Playlists.Params Pages.Playlists.Model Pages.Playlists.Msg
    , thumbsup : Upgraded Pages.Thumbsup.Params Pages.Thumbsup.Model Pages.Thumbsup.Msg
    , tvshows : Upgraded Pages.Tvshows.Params Pages.Tvshows.Model Pages.Tvshows.Msg
    , help__about : Upgraded Pages.Help.About.Params Pages.Help.About.Model Pages.Help.About.Msg
    , help__addons : Upgraded Pages.Help.Addons.Params Pages.Help.Addons.Model Pages.Help.Addons.Msg
    , help__changelog : Upgraded Pages.Help.Changelog.Params Pages.Help.Changelog.Model Pages.Help.Changelog.Msg
    , help__developers : Upgraded Pages.Help.Developers.Params Pages.Help.Developers.Model Pages.Help.Developers.Msg
    , help__keyboard : Upgraded Pages.Help.Keyboard.Params Pages.Help.Keyboard.Model Pages.Help.Keyboard.Msg
    , help__license : Upgraded Pages.Help.License.Params Pages.Help.License.Model Pages.Help.License.Msg
    , help__readme : Upgraded Pages.Help.Readme.Params Pages.Help.Readme.Model Pages.Help.Readme.Msg
    , help__translations : Upgraded Pages.Help.Translations.Params Pages.Help.Translations.Model Pages.Help.Translations.Msg
    , movies__recent : Upgraded Pages.Movies.Recent.Params Pages.Movies.Recent.Model Pages.Movies.Recent.Msg
    , music__albums : Upgraded Pages.Music.Albums.Params Pages.Music.Albums.Model Pages.Music.Albums.Msg
    , music__artists : Upgraded Pages.Music.Artists.Params Pages.Music.Artists.Model Pages.Music.Artists.Msg
    , music__genres : Upgraded Pages.Music.Genres.Params Pages.Music.Genres.Model Pages.Music.Genres.Msg
    , music__videos : Upgraded Pages.Music.Videos.Params Pages.Music.Videos.Model Pages.Music.Videos.Msg
    , settings__addons : Upgraded Pages.Settings.Addons.Params Pages.Settings.Addons.Model Pages.Settings.Addons.Msg
    , settings__nav : Upgraded Pages.Settings.Nav.Params Pages.Settings.Nav.Model Pages.Settings.Nav.Msg
    , settings__search : Upgraded Pages.Settings.Search.Params Pages.Settings.Search.Model Pages.Settings.Search.Msg
    , settings__web : Upgraded Pages.Settings.Web.Params Pages.Settings.Web.Model Pages.Settings.Web.Msg
    , tvshows__recent : Upgraded Pages.Tvshows.Recent.Params Pages.Tvshows.Recent.Model Pages.Tvshows.Recent.Msg
    , browser__source_string : Upgraded Pages.Browser.Source_String.Params Pages.Browser.Source_String.Model Pages.Browser.Source_String.Msg
    , playlists__name_string : Upgraded Pages.Playlists.Name_String.Params Pages.Playlists.Name_String.Model Pages.Playlists.Name_String.Msg
    , videoplayer__movieid_int : Upgraded Pages.Videoplayer.Movieid_Int.Params Pages.Videoplayer.Movieid_Int.Model Pages.Videoplayer.Movieid_Int.Msg
    , music__top__top : Upgraded Pages.Music.Top.Top.Params Pages.Music.Top.Top.Model Pages.Music.Top.Top.Msg
    , settings__kodi__games : Upgraded Pages.Settings.Kodi.Games.Params Pages.Settings.Kodi.Games.Model Pages.Settings.Kodi.Games.Msg
    , settings__kodi__interface : Upgraded Pages.Settings.Kodi.Interface.Params Pages.Settings.Kodi.Interface.Model Pages.Settings.Kodi.Interface.Msg
    , settings__kodi__media : Upgraded Pages.Settings.Kodi.Media.Params Pages.Settings.Kodi.Media.Model Pages.Settings.Kodi.Media.Msg
    , settings__kodi__player : Upgraded Pages.Settings.Kodi.Player.Params Pages.Settings.Kodi.Player.Model Pages.Settings.Kodi.Player.Msg
    , settings__kodi__pvr : Upgraded Pages.Settings.Kodi.Pvr.Params Pages.Settings.Kodi.Pvr.Model Pages.Settings.Kodi.Pvr.Msg
    , settings__kodi__services : Upgraded Pages.Settings.Kodi.Services.Params Pages.Settings.Kodi.Services.Model Pages.Settings.Kodi.Services.Msg
    , settings__kodi__system : Upgraded Pages.Settings.Kodi.System.Params Pages.Settings.Kodi.System.Model Pages.Settings.Kodi.System.Msg
    , music__album__albumid_int : Upgraded Pages.Music.Album.Albumid_Int.Params Pages.Music.Album.Albumid_Int.Model Pages.Music.Album.Albumid_Int.Msg
    , music__artist__artistid_int : Upgraded Pages.Music.Artist.Artistid_Int.Params Pages.Music.Artist.Artistid_Int.Model Pages.Music.Artist.Artistid_Int.Msg
    , music__videos__videoid_int : Upgraded Pages.Music.Videos.Videoid_Int.Params Pages.Music.Videos.Videoid_Int.Model Pages.Music.Videos.Videoid_Int.Msg
    , music__genre__genre_string : Upgraded Pages.Music.Genre.Genre_String.Params Pages.Music.Genre.Genre_String.Model Pages.Music.Genre.Genre_String.Msg
    }
pages =
    { top = Pages.Top.page |> upgrade Top__Model Top__Msg
    , addons = Pages.Addons.page |> upgrade Addons__Model Addons__Msg
    , browser = Pages.Browser.page |> upgrade Browser__Model Browser__Msg
    , lab = Pages.Lab.page |> upgrade Lab__Model Lab__Msg
    , movies = Pages.Movies.page |> upgrade Movies__Model Movies__Msg
    , music = Pages.Music.page |> upgrade Music__Model Music__Msg
    , notFound = Pages.NotFound.page |> upgrade NotFound__Model NotFound__Msg
    , playlists = Pages.Playlists.page |> upgrade Playlists__Model Playlists__Msg
    , thumbsup = Pages.Thumbsup.page |> upgrade Thumbsup__Model Thumbsup__Msg
    , tvshows = Pages.Tvshows.page |> upgrade Tvshows__Model Tvshows__Msg
    , help__about = Pages.Help.About.page |> upgrade Help__About__Model Help__About__Msg
    , help__addons = Pages.Help.Addons.page |> upgrade Help__Addons__Model Help__Addons__Msg
    , help__changelog = Pages.Help.Changelog.page |> upgrade Help__Changelog__Model Help__Changelog__Msg
    , help__developers = Pages.Help.Developers.page |> upgrade Help__Developers__Model Help__Developers__Msg
    , help__keyboard = Pages.Help.Keyboard.page |> upgrade Help__Keyboard__Model Help__Keyboard__Msg
    , help__license = Pages.Help.License.page |> upgrade Help__License__Model Help__License__Msg
    , help__readme = Pages.Help.Readme.page |> upgrade Help__Readme__Model Help__Readme__Msg
    , help__translations = Pages.Help.Translations.page |> upgrade Help__Translations__Model Help__Translations__Msg
    , movies__recent = Pages.Movies.Recent.page |> upgrade Movies__Recent__Model Movies__Recent__Msg
    , music__albums = Pages.Music.Albums.page |> upgrade Music__Albums__Model Music__Albums__Msg
    , music__artists = Pages.Music.Artists.page |> upgrade Music__Artists__Model Music__Artists__Msg
    , music__genres = Pages.Music.Genres.page |> upgrade Music__Genres__Model Music__Genres__Msg
    , music__videos = Pages.Music.Videos.page |> upgrade Music__Videos__Model Music__Videos__Msg
    , settings__addons = Pages.Settings.Addons.page |> upgrade Settings__Addons__Model Settings__Addons__Msg
    , settings__nav = Pages.Settings.Nav.page |> upgrade Settings__Nav__Model Settings__Nav__Msg
    , settings__search = Pages.Settings.Search.page |> upgrade Settings__Search__Model Settings__Search__Msg
    , settings__web = Pages.Settings.Web.page |> upgrade Settings__Web__Model Settings__Web__Msg
    , tvshows__recent = Pages.Tvshows.Recent.page |> upgrade Tvshows__Recent__Model Tvshows__Recent__Msg
    , browser__source_string = Pages.Browser.Source_String.page |> upgrade Browser__Source_String__Model Browser__Source_String__Msg
    , playlists__name_string = Pages.Playlists.Name_String.page |> upgrade Playlists__Name_String__Model Playlists__Name_String__Msg
    , videoplayer__movieid_int = Pages.Videoplayer.Movieid_Int.page |> upgrade Videoplayer__Movieid_Int__Model Videoplayer__Movieid_Int__Msg
    , music__top__top = Pages.Music.Top.Top.page |> upgrade Music__Top__Top__Model Music__Top__Top__Msg
    , settings__kodi__games = Pages.Settings.Kodi.Games.page |> upgrade Settings__Kodi__Games__Model Settings__Kodi__Games__Msg
    , settings__kodi__interface = Pages.Settings.Kodi.Interface.page |> upgrade Settings__Kodi__Interface__Model Settings__Kodi__Interface__Msg
    , settings__kodi__media = Pages.Settings.Kodi.Media.page |> upgrade Settings__Kodi__Media__Model Settings__Kodi__Media__Msg
    , settings__kodi__player = Pages.Settings.Kodi.Player.page |> upgrade Settings__Kodi__Player__Model Settings__Kodi__Player__Msg
    , settings__kodi__pvr = Pages.Settings.Kodi.Pvr.page |> upgrade Settings__Kodi__Pvr__Model Settings__Kodi__Pvr__Msg
    , settings__kodi__services = Pages.Settings.Kodi.Services.page |> upgrade Settings__Kodi__Services__Model Settings__Kodi__Services__Msg
    , settings__kodi__system = Pages.Settings.Kodi.System.page |> upgrade Settings__Kodi__System__Model Settings__Kodi__System__Msg
    , music__album__albumid_int = Pages.Music.Album.Albumid_Int.page |> upgrade Music__Album__Albumid_Int__Model Music__Album__Albumid_Int__Msg
    , music__artist__artistid_int = Pages.Music.Artist.Artistid_Int.page |> upgrade Music__Artist__Artistid_Int__Model Music__Artist__Artistid_Int__Msg
    , music__videos__videoid_int = Pages.Music.Videos.Videoid_Int.page |> upgrade Music__Videos__Videoid_Int__Model Music__Videos__Videoid_Int__Msg
    , music__genre__genre_string = Pages.Music.Genre.Genre_String.page |> upgrade Music__Genre__Genre_String__Model Music__Genre__Genre_String__Msg
    }
