module Pages.Videoplayer.Movieid_Int exposing (Params, Model, Msg, page)

import Shared
import Components.Video
import Element exposing (..)
import Element.Background as Background
import Html.Attributes
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import WSDecoder exposing (ItemDetails, MovieObj)

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
    { movieid : Int }


type alias Model =
    { movieid : Int
    , movie : Maybe MovieObj
    , movie_list : List MovieObj }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { movieid = params.movieid
    , movie = getMovie params.movieid shared.movie_list
    , movie_list = shared.movie_list
    }, Cmd.none )


checkMovieId : Int -> MovieObj -> Bool
checkMovieId firstId movie =
    if firstId == movie.movieid then
        True

    else
        False


getMovie : Int -> List MovieObj -> Maybe MovieObj
getMovie id movielist =
    List.head (List.filter (\movie -> checkMovieId id movie) movielist)

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
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | movie_list = shared.movie_list }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Videoplayer.Movieid_Int"
    , body = [ column [Element.width fill, Element.height fill] 
                        --(List.map (\movie -> Element.text movie.label) model.movie_list)
                        [Element.text (String.fromInt model.movieid)
                        , wrappedRow [ Element.height fill, Element.width (fillPortion 6), Background.color (rgb 0.8 0.8 0.8), spacingXY 5 10 ]
                (List.map
                    (\movie ->
                        Element.text movie.label
                    )
                    model.movie_list
                )
                    ]
                ]
    }