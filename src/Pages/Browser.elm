module Pages.Browser exposing (Model, Msg, Params, page)

import Components.VerticalNav
import Shared exposing (sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import WSDecoder exposing (SourceObj)


page : Page Params Model Msg
page =
    Page.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , save = save
        , load = load
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route
    , source_list : List SourceObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route, source_list = shared.source_list }
    , sendActions
        [ """{"jsonrpc": "2.0", "params": {"media": "video"}, "method": "Files.GetSources", "id": 1}"""
        , """{"jsonrpc": "2.0", "params": {"media": "music"}, "method": "Files.GetSources", "id": 1}"""
        ]
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared
        | album_list = shared.album_list
        , artist_list = shared.artist_list
        , connection = shared.connection
        , controlMenu = shared.controlMenu
        , currentlyPlaying = shared.currentlyPlaying
        , flags = shared.flags
        , genre_list = shared.genre_list
        , key = shared.key
        , movie_list = shared.movie_list
        , players = shared.players
        , playing = shared.playing
        , progressSlider = shared.progressSlider
        , rightSidebarExtended = shared.rightSidebarExtended
        , searchString = shared.searchString
        , song_list = shared.song_list
        , source_list = []
        , tvshow_list = shared.tvshow_list
        , url = shared.url
        , volumeSlider = shared.volumeSlider
        , windowHeight = shared.windowHeight
        , windowWidth = shared.windowWidth
    }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | source_list = shared.source_list }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Browser"
    , body =
        [ Components.VerticalNav.view
            "sources"
            model.route
            (List.map
                (\source ->
                    { route = Route.Browser__Source_String { source = percentEncode source.file }
                    , label = source.label
                    }
                )
                model.source_list
            )
            []
        ]
    }
