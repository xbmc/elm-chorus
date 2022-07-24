module Pages.Movies exposing (Model, Msg, Params, page)

import Colors exposing (greyIcon)
import Components.VerticalNav
import Components.VerticalNavMovies
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
import Element.Input as Input
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Random
import Request
import Shared exposing (sendAction, sendActions)
import SharedType exposing (SortDirection(..))
import SharedUtil exposing (..)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Svg.Attributes
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
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


type MovieSort
    = Title SortDirection
    | Random SortDirection
    | Year SortDirection
    | DateAdded SortDirection
    | Rating SortDirection


type alias Params =
    ()


type alias Model =
    { currentlyPlaying : Maybe ItemDetails
    , movie_list : List MovieObj
    , route : Route
    , currentButton : MovieSort
    , seed : Random.Seed
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { currentlyPlaying = shared.currentlyPlaying, movie_list = sortByTitle shared.movie_list, route = url.route, currentButton = Title Asc, seed = Random.initialSeed 1453 }
    , sendAction """{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": { "filter": {"field": "playcount", "operator": "is", "value": "0"}, "properties" : ["art", "rating", "thumbnail", "playcount", "file","year","dateadded"], "sort": { "order": "ascending", "method": "label", "ignorearticle": true } }, "id": "libMovies"}"""
    )



-- UPDATE


type Msg
    = SetCurrentlyPlaying MovieObj
    | TitleButtonMsg
    | YearButtonMsg
    | DateButtonMsg
    | RatingButtonMsg
    | RandomButtonMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying movie ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next movie -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"movieid": """ ++ String.fromInt movie.movieid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, movie_list = List.reverse model.movie_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, movie_list = List.reverse model.movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, movie_list = sortByTitle model.movie_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, movie_list = List.reverse model.movie_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, movie_list = List.reverse model.movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, movie_list = sortByYear model.movie_list }, Cmd.none )

        DateButtonMsg ->
            case model.currentButton of
                DateAdded Asc ->
                    ( { model | currentButton = DateAdded Desc, movie_list = List.reverse model.movie_list }, Cmd.none )

                DateAdded Desc ->
                    ( { model | currentButton = DateAdded Asc, movie_list = List.reverse model.movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = DateAdded Asc, movie_list = sortByDate model.movie_list }, Cmd.none )

        RatingButtonMsg ->
            case model.currentButton of
                Rating Asc ->
                    ( { model | currentButton = Rating Desc, movie_list = List.reverse model.movie_list }, Cmd.none )

                Rating Desc ->
                    ( { model | currentButton = Rating Asc, movie_list = List.reverse model.movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Rating Asc, movie_list = sortByRating model.movie_list }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.movie_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, movie_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, movie_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, movie_list = list, seed = seedoutput }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | currentlyPlaying = model.currentlyPlaying, movie_list = model.movie_list }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | movie_list = shared.movie_list }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


constructMovieItem : MovieObj -> Element Msg
constructMovieItem movie =
    column [ spacingXY 5 0, Element.width fill, Element.height fill ]
        [ image
            [ Element.width (fill |> minimum 150 |> maximum 150)
            , Element.height (fill |> minimum 200 |> maximum 200)
            , inFront
                (row []
                    [ link [ paddingXY 5 3, Background.color (rgb 0.2 0.2 0.2) ]
                        { url = Route.toString (Route.Videoplayer__Movieid_Int { movieid = movie.movieid })
                        , label = Element.html (Filled.play_arrow 24 (MITypes.Color <| greyIcon))
                        }
                    ]
                )

            {- , Element.Events.onMouseEnter ShowMenu
               , Element.Events.onMouseLeave CloseMenu
            -}
            ]
            (if String.isEmpty movie.thumbnail then
                { src = "https://via.placeholder.com/70"
                , description = "Hero Image"
                }

             else
                { description = movie.label
                , src = crossOrigin "http://localhost:8080" [ "image", percentEncode movie.thumbnail ] []
                }
            )
        , column [ alignBottom, Background.color (rgb 1 1 1), Element.width (fill |> minimum 150 |> maximum 150), clip ]
            [ el [ Font.color (Element.rgb 0 0 0), Font.size 18 ] (Element.text movie.label)
            , el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18 ] (Element.text "2020")
            ]
        ]



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Movies"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill ]
                [ Components.VerticalNavMovies.view model.route
                , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 15 ]
                    [ Element.text "SORT"
                    , sortButton model.currentButton (Title Asc) "Title " TitleButtonMsg
                    , sortButton model.currentButton (Year Asc) "Year " YearButtonMsg
                    , sortButton model.currentButton (DateAdded Asc) "Date Added " DateButtonMsg
                    , sortButton model.currentButton (Rating Asc) "Rating " RatingButtonMsg
                    , sortButton model.currentButton (Random Asc) "Random " RandomButtonMsg
                    ]
                ]
            , wrappedRow [ Element.height fill, Element.width (fillPortion 6), Background.color (rgb 0.8 0.8 0.8), spacingXY 5 10 ]
                (List.map
                    (\movie ->
                        constructMovieItem movie
                    )
                    model.movie_list
                )
            ]
        ]
    }


sortButton : MovieSort -> MovieSort -> String -> msg -> Element msg
sortButton currentButton button name buttonMsg =
    let
        isCurrentButton =
            case ( currentButton, button ) of
                ( Title _, Title _ ) ->
                    ( True, Title )

                ( Year _, Year _ ) ->
                    ( True, Year )

                ( DateAdded _, DateAdded _ ) ->
                    ( True, DateAdded )

                ( Rating _, Rating _ ) ->
                    ( True, Rating )

                ( Random _, Random _ ) ->
                    ( True, Random )

                _ ->
                    ( False, Random )
    in
    Input.button [ paddingXY 10 0 ]
        { onPress = Just buttonMsg
        , label =
            currentButtonText currentButton name isCurrentButton
        }


currentButtonText : MovieSort -> String -> ( Bool, SortDirection -> MovieSort ) -> Element msg
currentButtonText currentButton name ( isCurrent, button ) =
    case isCurrent of
        True ->
            if currentButton == button Asc then
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↑") ]

            else
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↓") ]

        False ->
            row [ Font.color Colors.navText ] [ Element.text name ]
