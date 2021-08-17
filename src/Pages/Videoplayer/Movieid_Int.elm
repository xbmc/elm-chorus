module Pages.Videoplayer.Movieid_Int exposing (Model, Msg, Params, page)

import Components.Video
import Element exposing (..)
import Element.Background as Background
import Html.Attributes
import Http
import Shared
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (ItemDetails, MovieObj, Path, prepareDownloadDecoder)


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
    , movie_list : List MovieObj
    , prepareDownloadPath : Maybe String
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    case getMovie params.movieid shared.movie_list of
        Nothing ->
            ( { movieid = params.movieid
              , movie = getMovie params.movieid shared.movie_list
              , movie_list = shared.movie_list
              , prepareDownloadPath = shared.prepareDownloadPath
              }
            , Cmd.none
            )

        Just mov ->
            ( { movieid = params.movieid
              , movie = getMovie params.movieid shared.movie_list
              , movie_list = shared.movie_list
              , prepareDownloadPath = shared.prepareDownloadPath
              }
            , postRequestMovie mov.file
            )


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
    = GotMovie (Result Http.Error Path)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotMovie result ->
            case result of
                Ok pathObj ->
                    ( { model | prepareDownloadPath = Just pathObj.path }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | prepareDownloadPath = model.prepareDownloadPath }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | movie_list = shared.movie_list, prepareDownloadPath = shared.prepareDownloadPath }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


postRequestMovie : String -> Cmd Msg
postRequestMovie path =
    Http.get
        { url = crossOrigin "http://localhost:8080" [ """jsonrpc?request={"jsonrpc":"2.0","params":{"path":\"""" ++ path ++ """"},"method":"Files.PrepareDownload","id":"1"}""" ] []
        , expect = Http.expectJson GotMovie prepareDownloadDecoder
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Videoplayer.Movieid_Int"
    , body =
        [ case model.movie of
            Nothing ->
                Element.text "Erro fetching movie"

            Just movie ->
                case model.prepareDownloadPath of
                    Nothing ->
                        Element.text movie.label

                    Just path ->
                        Components.Video.view [ Background.color (rgb 0 0 0) ]
                            { poster = crossOrigin "http://localhost:8080" [ "image", percentEncode movie.thumbnail ] []
                            , source = crossOrigin "http://localhost:8080" [ path ] []

                            --source = crossOrigin "http://localhost:8080" [ "vfs/%2fUsers%2falex%2fDesktop%2fdesktop%2fFilms%2fSenior%20Project%2fused%2fIMG_2652.m4v"] [] --source = crossOrigin "http://localhost:8080" [ "video", percentEncode movie.file ] [] -- fix url
                            }
        ]
    }
