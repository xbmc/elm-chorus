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
import Pages.Movies
import Pages.Music
import Pages.NotFound
import Pages.Playlists
import Pages.TVShows
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
    | Movies__Model Pages.Movies.Model
    | Music__Model Pages.Music.Model
    | NotFound__Model Pages.NotFound.Model
    | Playlists__Model Pages.Playlists.Model
    | TVShows__Model Pages.TVShows.Model


type Msg
    = Top__Msg Pages.Top.Msg
    | Addons__Msg Pages.Addons.Msg
    | Browser__Msg Pages.Browser.Msg
    | Movies__Msg Pages.Movies.Msg
    | Music__Msg Pages.Music.Msg
    | NotFound__Msg Pages.NotFound.Msg
    | Playlists__Msg Pages.Playlists.Msg
    | TVShows__Msg Pages.TVShows.Msg



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
        
        Route.Movies ->
            pages.movies.init ()
        
        Route.Music ->
            pages.music.init ()
        
        Route.NotFound ->
            pages.notFound.init ()
        
        Route.Playlists ->
            pages.playlists.init ()
        
        Route.TVShows ->
            pages.tVShows.init ()



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
        
        ( Movies__Msg msg, Movies__Model model ) ->
            pages.movies.update msg model
        
        ( Music__Msg msg, Music__Model model ) ->
            pages.music.update msg model
        
        ( NotFound__Msg msg, NotFound__Model model ) ->
            pages.notFound.update msg model
        
        ( Playlists__Msg msg, Playlists__Model model ) ->
            pages.playlists.update msg model
        
        ( TVShows__Msg msg, TVShows__Model model ) ->
            pages.tVShows.update msg model
        
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
        
        Movies__Model model ->
            pages.movies.bundle model
        
        Music__Model model ->
            pages.music.bundle model
        
        NotFound__Model model ->
            pages.notFound.bundle model
        
        Playlists__Model model ->
            pages.playlists.bundle model
        
        TVShows__Model model ->
            pages.tVShows.bundle model


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
    , movies : Upgraded Pages.Movies.Params Pages.Movies.Model Pages.Movies.Msg
    , music : Upgraded Pages.Music.Params Pages.Music.Model Pages.Music.Msg
    , notFound : Upgraded Pages.NotFound.Params Pages.NotFound.Model Pages.NotFound.Msg
    , playlists : Upgraded Pages.Playlists.Params Pages.Playlists.Model Pages.Playlists.Msg
    , tVShows : Upgraded Pages.TVShows.Params Pages.TVShows.Model Pages.TVShows.Msg
    }
pages =
    { top = Pages.Top.page |> upgrade Top__Model Top__Msg
    , addons = Pages.Addons.page |> upgrade Addons__Model Addons__Msg
    , browser = Pages.Browser.page |> upgrade Browser__Model Browser__Msg
    , movies = Pages.Movies.page |> upgrade Movies__Model Movies__Msg
    , music = Pages.Music.page |> upgrade Music__Model Music__Msg
    , notFound = Pages.NotFound.page |> upgrade NotFound__Model NotFound__Msg
    , playlists = Pages.Playlists.page |> upgrade Playlists__Model Playlists__Msg
    , tVShows = Pages.TVShows.page |> upgrade TVShows__Model TVShows__Msg
    }