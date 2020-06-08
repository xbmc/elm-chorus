module Generated.Pages exposing
    ( Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Generated.Route as Route exposing (Route)
import Global
import Page exposing (Bundle, Document)
import Pages.Top
import Pages.Addons
import Pages.Browser
import Pages.Docs
import Pages.Help
import Pages.Movies
import Pages.Music
import Pages.NotFound
import Pages.Playlist
import Pages.TVshows
import Pages.Thumbups



-- TYPES


type Model
    = Top_Model Pages.Top.Model
    | Addons_Model Pages.Addons.Model
    | Browser_Model Pages.Browser.Model
    | Docs_Model Pages.Docs.Model
    | Help_Model Pages.Help.Model
    | Movies_Model Pages.Movies.Model
    | Music_Model Pages.Music.Model
    | NotFound_Model Pages.NotFound.Model
    | Playlist_Model Pages.Playlist.Model
    | TVshows_Model Pages.TVshows.Model
    | Thumbups_Model Pages.Thumbups.Model


type Msg
    = Top_Msg Pages.Top.Msg
    | Addons_Msg Pages.Addons.Msg
    | Browser_Msg Pages.Browser.Msg
    | Docs_Msg Pages.Docs.Msg
    | Help_Msg Pages.Help.Msg
    | Movies_Msg Pages.Movies.Msg
    | Music_Msg Pages.Music.Msg
    | NotFound_Msg Pages.NotFound.Msg
    | Playlist_Msg Pages.Playlist.Msg
    | TVshows_Msg Pages.TVshows.Msg
    | Thumbups_Msg Pages.Thumbups.Msg



-- PAGES


type alias UpgradedPage flags model msg =
    { init : flags -> Global.Model -> ( Model, Cmd Msg, Cmd Global.Msg )
    , update : msg -> model -> Global.Model -> ( Model, Cmd Msg, Cmd Global.Msg )
    , bundle : model -> Global.Model -> Bundle Msg
    }


type alias UpgradedPages =
    { top : UpgradedPage Pages.Top.Flags Pages.Top.Model Pages.Top.Msg
    , addons : UpgradedPage Pages.Addons.Flags Pages.Addons.Model Pages.Addons.Msg
    , browser : UpgradedPage Pages.Browser.Flags Pages.Browser.Model Pages.Browser.Msg
    , docs : UpgradedPage Pages.Docs.Flags Pages.Docs.Model Pages.Docs.Msg
    , help : UpgradedPage Pages.Help.Flags Pages.Help.Model Pages.Help.Msg
    , movies : UpgradedPage Pages.Movies.Flags Pages.Movies.Model Pages.Movies.Msg
    , music : UpgradedPage Pages.Music.Flags Pages.Music.Model Pages.Music.Msg
    , notFound : UpgradedPage Pages.NotFound.Flags Pages.NotFound.Model Pages.NotFound.Msg
    , playlist : UpgradedPage Pages.Playlist.Flags Pages.Playlist.Model Pages.Playlist.Msg
    , tVshows : UpgradedPage Pages.TVshows.Flags Pages.TVshows.Model Pages.TVshows.Msg
    , thumbups : UpgradedPage Pages.Thumbups.Flags Pages.Thumbups.Model Pages.Thumbups.Msg
    }


pages : UpgradedPages
pages =
    { top = Pages.Top.page |> Page.upgrade Top_Model Top_Msg
    , addons = Pages.Addons.page |> Page.upgrade Addons_Model Addons_Msg
    , browser = Pages.Browser.page |> Page.upgrade Browser_Model Browser_Msg
    , docs = Pages.Docs.page |> Page.upgrade Docs_Model Docs_Msg
    , help = Pages.Help.page |> Page.upgrade Help_Model Help_Msg
    , movies = Pages.Movies.page |> Page.upgrade Movies_Model Movies_Msg
    , music = Pages.Music.page |> Page.upgrade Music_Model Music_Msg
    , notFound = Pages.NotFound.page |> Page.upgrade NotFound_Model NotFound_Msg
    , playlist = Pages.Playlist.page |> Page.upgrade Playlist_Model Playlist_Msg
    , tVshows = Pages.TVshows.page |> Page.upgrade TVshows_Model TVshows_Msg
    , thumbups = Pages.Thumbups.page |> Page.upgrade Thumbups_Model Thumbups_Msg
    }



-- INIT


init : Route -> Global.Model -> ( Model, Cmd Msg, Cmd Global.Msg )
init route =
    case route of
        Route.Top ->
            pages.top.init ()
        
        Route.Addons ->
            pages.addons.init ()
        
        Route.Browser ->
            pages.browser.init ()
        
        Route.Docs ->
            pages.docs.init ()
        
        Route.Help ->
            pages.help.init ()
        
        Route.Movies ->
            pages.movies.init ()
        
        Route.Music ->
            pages.music.init ()
        
        Route.NotFound ->
            pages.notFound.init ()
        
        Route.Playlist ->
            pages.playlist.init ()
        
        Route.TVshows ->
            pages.tVshows.init ()
        
        Route.Thumbups ->
            pages.thumbups.init ()



-- UPDATE


update : Msg -> Model -> Global.Model -> ( Model, Cmd Msg, Cmd Global.Msg )
update bigMsg bigModel =
    case ( bigMsg, bigModel ) of
        ( Top_Msg msg, Top_Model model ) ->
            pages.top.update msg model
        
        ( Addons_Msg msg, Addons_Model model ) ->
            pages.addons.update msg model
        
        ( Browser_Msg msg, Browser_Model model ) ->
            pages.browser.update msg model
        
        ( Docs_Msg msg, Docs_Model model ) ->
            pages.docs.update msg model
        
        ( Help_Msg msg, Help_Model model ) ->
            pages.help.update msg model
        
        ( Movies_Msg msg, Movies_Model model ) ->
            pages.movies.update msg model
        
        ( Music_Msg msg, Music_Model model ) ->
            pages.music.update msg model
        
        ( NotFound_Msg msg, NotFound_Model model ) ->
            pages.notFound.update msg model
        
        ( Playlist_Msg msg, Playlist_Model model ) ->
            pages.playlist.update msg model
        
        ( TVshows_Msg msg, TVshows_Model model ) ->
            pages.tVshows.update msg model
        
        ( Thumbups_Msg msg, Thumbups_Model model ) ->
            pages.thumbups.update msg model
        
        _ ->
            always ( bigModel, Cmd.none, Cmd.none )



-- BUNDLE - (view + subscriptions)


bundle : Model -> Global.Model -> Bundle Msg
bundle bigModel =
    case bigModel of
        Top_Model model ->
            pages.top.bundle model
        
        Addons_Model model ->
            pages.addons.bundle model
        
        Browser_Model model ->
            pages.browser.bundle model
        
        Docs_Model model ->
            pages.docs.bundle model
        
        Help_Model model ->
            pages.help.bundle model
        
        Movies_Model model ->
            pages.movies.bundle model
        
        Music_Model model ->
            pages.music.bundle model
        
        NotFound_Model model ->
            pages.notFound.bundle model
        
        Playlist_Model model ->
            pages.playlist.bundle model
        
        TVshows_Model model ->
            pages.tVshows.bundle model
        
        Thumbups_Model model ->
            pages.thumbups.bundle model


view : Model -> Global.Model -> Document Msg
view model =
    bundle model >> .view


subscriptions : Model -> Global.Model -> Sub Msg
subscriptions model =
    bundle model >> .subscriptions