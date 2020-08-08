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

import Pages.Top
import Pages.Addons
import Pages.Browser
import Pages.Help
import Pages.Lab
import Pages.Movies
import Pages.Music
import Pages.NotFound
import Pages.Playlists
import Pages.Thumbsup
import Pages.Tvshows
import Pages.Movies.Recent
import Pages.Music.Albums
import Pages.Music.Artists
import Pages.Music.Genres
import Pages.Music.Videos
import Pages.Settings.Web
import Pages.Tvshows.Recent
import Pages.Browser.Source_String
import Pages.Music.Top.Top
import Pages.Music.Album.Albumid_Int
import Pages.Music.Artist.Artistid_Int
import Pages.Music.Genre.Genre_String
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
    | Help__Model Pages.Help.Model
    | Lab__Model Pages.Lab.Model
    | Movies__Model Pages.Movies.Model
    | Music__Model Pages.Music.Model
    | NotFound__Model Pages.NotFound.Model
    | Playlists__Model Pages.Playlists.Model
    | Thumbsup__Model Pages.Thumbsup.Model
    | Tvshows__Model Pages.Tvshows.Model
    | Movies__Recent__Model Pages.Movies.Recent.Model
    | Music__Albums__Model Pages.Music.Albums.Model
    | Music__Artists__Model Pages.Music.Artists.Model
    | Music__Genres__Model Pages.Music.Genres.Model
    | Music__Videos__Model Pages.Music.Videos.Model
    | Settings__Web__Model Pages.Settings.Web.Model
    | Tvshows__Recent__Model Pages.Tvshows.Recent.Model
    | Browser__Source_String__Model Pages.Browser.Source_String.Model
    | Music__Top__Top__Model Pages.Music.Top.Top.Model
    | Music__Album__Albumid_Int__Model Pages.Music.Album.Albumid_Int.Model
    | Music__Artist__Artistid_Int__Model Pages.Music.Artist.Artistid_Int.Model
    | Music__Genre__Genre_String__Model Pages.Music.Genre.Genre_String.Model


type Msg
    = Top__Msg Pages.Top.Msg
    | Addons__Msg Pages.Addons.Msg
    | Browser__Msg Pages.Browser.Msg
    | Help__Msg Pages.Help.Msg
    | Lab__Msg Pages.Lab.Msg
    | Movies__Msg Pages.Movies.Msg
    | Music__Msg Pages.Music.Msg
    | NotFound__Msg Pages.NotFound.Msg
    | Playlists__Msg Pages.Playlists.Msg
    | Thumbsup__Msg Pages.Thumbsup.Msg
    | Tvshows__Msg Pages.Tvshows.Msg
    | Movies__Recent__Msg Pages.Movies.Recent.Msg
    | Music__Albums__Msg Pages.Music.Albums.Msg
    | Music__Artists__Msg Pages.Music.Artists.Msg
    | Music__Genres__Msg Pages.Music.Genres.Msg
    | Music__Videos__Msg Pages.Music.Videos.Msg
    | Settings__Web__Msg Pages.Settings.Web.Msg
    | Tvshows__Recent__Msg Pages.Tvshows.Recent.Msg
    | Browser__Source_String__Msg Pages.Browser.Source_String.Msg
    | Music__Top__Top__Msg Pages.Music.Top.Top.Msg
    | Music__Album__Albumid_Int__Msg Pages.Music.Album.Albumid_Int.Msg
    | Music__Artist__Artistid_Int__Msg Pages.Music.Artist.Artistid_Int.Msg
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
        
        Route.Help ->
            pages.help.init ()
        
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
        
        Route.Settings__Web ->
            pages.settings__web.init ()
        
        Route.Tvshows__Recent ->
            pages.tvshows__recent.init ()
        
        Route.Browser__Source_String params ->
            pages.browser__source_string.init params
        
        Route.Music__Top__Top ->
            pages.music__top__top.init ()
        
        Route.Music__Album__Albumid_Int params ->
            pages.music__album__albumid_int.init params
        
        Route.Music__Artist__Artistid_Int params ->
            pages.music__artist__artistid_int.init params
        
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
        
        ( Help__Msg msg, Help__Model model ) ->
            pages.help.update msg model
        
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
        
        ( Settings__Web__Msg msg, Settings__Web__Model model ) ->
            pages.settings__web.update msg model
        
        ( Tvshows__Recent__Msg msg, Tvshows__Recent__Model model ) ->
            pages.tvshows__recent.update msg model
        
        ( Browser__Source_String__Msg msg, Browser__Source_String__Model model ) ->
            pages.browser__source_string.update msg model
        
        ( Music__Top__Top__Msg msg, Music__Top__Top__Model model ) ->
            pages.music__top__top.update msg model
        
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
        
        Help__Model model ->
            pages.help.bundle model
        
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
        
        Settings__Web__Model model ->
            pages.settings__web.bundle model
        
        Tvshows__Recent__Model model ->
            pages.tvshows__recent.bundle model
        
        Browser__Source_String__Model model ->
            pages.browser__source_string.bundle model
        
        Music__Top__Top__Model model ->
            pages.music__top__top.bundle model
        
        Music__Album__Albumid_Int__Model model ->
            pages.music__album__albumid_int.bundle model
        
        Music__Artist__Artistid_Int__Model model ->
            pages.music__artist__artistid_int.bundle model
        
        Music__Genre__Genre_String__Model model ->
            pages.music__genre__genre_string.bundle model


view : Model -> Document Msg
view =
    bundle >> .view


subscriptions : Model -> Sub Msg
subscriptions =
    bundle >> .subscriptions


save : Model -> Shared.Model -> Shared.Model
save =
    bundle >> .save


load : Model -> Shared.Model -> ( Model, Cmd Msg )
load =
    bundle >> .load



-- UPGRADING PAGES


type alias Upgraded params model msg =
    { init : params -> Shared.Model -> ( Model, Cmd Msg )
    , update : msg -> model -> ( Model, Cmd Msg )
    , bundle : model -> Bundle
    }


type alias Bundle =
    { view : Document Msg
    , subscriptions : Sub Msg
    , save : Shared.Model -> Shared.Model
    , load : Shared.Model -> ( Model, Cmd Msg )
    }


upgrade : (model -> Model) -> (msg -> Msg) -> Page params model msg -> Upgraded params model msg
upgrade toModel toMsg page =
    let
        init_ params shared =
            page.init shared (Url.create params shared.key shared.url) |> Tuple.mapBoth toModel (Cmd.map toMsg)

        update_ msg model =
            page.update msg model |> Tuple.mapBoth toModel (Cmd.map toMsg)

        bundle_ model =
            { view = page.view model |> Document.map toMsg
            , subscriptions = page.subscriptions model |> Sub.map toMsg
            , save = page.save model
            , load = load_ model
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
    , help : Upgraded Pages.Help.Params Pages.Help.Model Pages.Help.Msg
    , lab : Upgraded Pages.Lab.Params Pages.Lab.Model Pages.Lab.Msg
    , movies : Upgraded Pages.Movies.Params Pages.Movies.Model Pages.Movies.Msg
    , music : Upgraded Pages.Music.Params Pages.Music.Model Pages.Music.Msg
    , notFound : Upgraded Pages.NotFound.Params Pages.NotFound.Model Pages.NotFound.Msg
    , playlists : Upgraded Pages.Playlists.Params Pages.Playlists.Model Pages.Playlists.Msg
    , thumbsup : Upgraded Pages.Thumbsup.Params Pages.Thumbsup.Model Pages.Thumbsup.Msg
    , tvshows : Upgraded Pages.Tvshows.Params Pages.Tvshows.Model Pages.Tvshows.Msg
    , movies__recent : Upgraded Pages.Movies.Recent.Params Pages.Movies.Recent.Model Pages.Movies.Recent.Msg
    , music__albums : Upgraded Pages.Music.Albums.Params Pages.Music.Albums.Model Pages.Music.Albums.Msg
    , music__artists : Upgraded Pages.Music.Artists.Params Pages.Music.Artists.Model Pages.Music.Artists.Msg
    , music__genres : Upgraded Pages.Music.Genres.Params Pages.Music.Genres.Model Pages.Music.Genres.Msg
    , music__videos : Upgraded Pages.Music.Videos.Params Pages.Music.Videos.Model Pages.Music.Videos.Msg
    , settings__web : Upgraded Pages.Settings.Web.Params Pages.Settings.Web.Model Pages.Settings.Web.Msg
    , tvshows__recent : Upgraded Pages.Tvshows.Recent.Params Pages.Tvshows.Recent.Model Pages.Tvshows.Recent.Msg
    , browser__source_string : Upgraded Pages.Browser.Source_String.Params Pages.Browser.Source_String.Model Pages.Browser.Source_String.Msg
    , music__top__top : Upgraded Pages.Music.Top.Top.Params Pages.Music.Top.Top.Model Pages.Music.Top.Top.Msg
    , music__album__albumid_int : Upgraded Pages.Music.Album.Albumid_Int.Params Pages.Music.Album.Albumid_Int.Model Pages.Music.Album.Albumid_Int.Msg
    , music__artist__artistid_int : Upgraded Pages.Music.Artist.Artistid_Int.Params Pages.Music.Artist.Artistid_Int.Model Pages.Music.Artist.Artistid_Int.Msg
    , music__genre__genre_string : Upgraded Pages.Music.Genre.Genre_String.Params Pages.Music.Genre.Genre_String.Model Pages.Music.Genre.Genre_String.Msg
    }
pages =
    { top = Pages.Top.page |> upgrade Top__Model Top__Msg
    , addons = Pages.Addons.page |> upgrade Addons__Model Addons__Msg
    , browser = Pages.Browser.page |> upgrade Browser__Model Browser__Msg
    , help = Pages.Help.page |> upgrade Help__Model Help__Msg
    , lab = Pages.Lab.page |> upgrade Lab__Model Lab__Msg
    , movies = Pages.Movies.page |> upgrade Movies__Model Movies__Msg
    , music = Pages.Music.page |> upgrade Music__Model Music__Msg
    , notFound = Pages.NotFound.page |> upgrade NotFound__Model NotFound__Msg
    , playlists = Pages.Playlists.page |> upgrade Playlists__Model Playlists__Msg
    , thumbsup = Pages.Thumbsup.page |> upgrade Thumbsup__Model Thumbsup__Msg
    , tvshows = Pages.Tvshows.page |> upgrade Tvshows__Model Tvshows__Msg
    , movies__recent = Pages.Movies.Recent.page |> upgrade Movies__Recent__Model Movies__Recent__Msg
    , music__albums = Pages.Music.Albums.page |> upgrade Music__Albums__Model Music__Albums__Msg
    , music__artists = Pages.Music.Artists.page |> upgrade Music__Artists__Model Music__Artists__Msg
    , music__genres = Pages.Music.Genres.page |> upgrade Music__Genres__Model Music__Genres__Msg
    , music__videos = Pages.Music.Videos.page |> upgrade Music__Videos__Model Music__Videos__Msg
    , settings__web = Pages.Settings.Web.page |> upgrade Settings__Web__Model Settings__Web__Msg
    , tvshows__recent = Pages.Tvshows.Recent.page |> upgrade Tvshows__Recent__Model Tvshows__Recent__Msg
    , browser__source_string = Pages.Browser.Source_String.page |> upgrade Browser__Source_String__Model Browser__Source_String__Msg
    , music__top__top = Pages.Music.Top.Top.page |> upgrade Music__Top__Top__Model Music__Top__Top__Msg
    , music__album__albumid_int = Pages.Music.Album.Albumid_Int.page |> upgrade Music__Album__Albumid_Int__Model Music__Album__Albumid_Int__Msg
    , music__artist__artistid_int = Pages.Music.Artist.Artistid_Int.page |> upgrade Music__Artist__Artistid_Int__Model Music__Artist__Artistid_Int__Msg
    , music__genre__genre_string = Pages.Music.Genre.Genre_String.page |> upgrade Music__Genre__Genre_String__Model Music__Genre__Genre_String__Msg
    }