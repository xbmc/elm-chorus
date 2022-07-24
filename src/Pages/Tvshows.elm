module Pages.Tvshows exposing (Model, Msg, Params, page)

import Colors exposing (greyIcon)
import Components.VerticalNav
import Components.VerticalNavTvshows
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
import WSDecoder exposing (ItemDetails, TvshowObj)


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


type TvShowSort
    = Title SortDirection
    | Year SortDirection
    | DateAdded SortDirection
    | Rating SortDirection
    | Random SortDirection


type alias Params =
    ()


type alias Model =
    { currentlyPlaying : Maybe ItemDetails
    , tvshow_list : List TvshowObj
    , route : Route
    , currentButton : TvShowSort
    , seed : Random.Seed
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { currentlyPlaying = shared.currentlyPlaying, tvshow_list = sortByTitle shared.tvshow_list, route = url.route, currentButton = Title Asc, seed = Random.initialSeed 1453 }
    , sendAction """{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": { "filter": {"field": "playcount", "operator": "is", "value": "0"}, "properties" : ["art", "rating", "thumbnail", "playcount", "file","dateadded","year"], "sort": { "order": "ascending", "method": "label", "ignorearticle": true } }, "id": "libMovies"}"""
    )



-- UPDATE


type Msg
    = SetCurrentlyPlaying TvshowObj
    | NoOp
    | TitleButtonMsg
    | YearButtonMsg
    | DateButtonMsg
    | RatingButtonMsg
    | RandomButtonMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying tvshow ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next tvshow -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"tvshowid": """ ++ String.fromInt tvshow.tvshowid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, tvshow_list = sortByTitle model.tvshow_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, tvshow_list = sortByYear model.tvshow_list }, Cmd.none )

        DateButtonMsg ->
            case model.currentButton of
                DateAdded Asc ->
                    ( { model | currentButton = DateAdded Desc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                DateAdded Desc ->
                    ( { model | currentButton = DateAdded Asc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = DateAdded Asc, tvshow_list = sortByDate model.tvshow_list }, Cmd.none )

        RatingButtonMsg ->
            case model.currentButton of
                Rating Asc ->
                    ( { model | currentButton = Rating Desc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                Rating Desc ->
                    ( { model | currentButton = Rating Asc, tvshow_list = List.reverse model.tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Rating Asc, tvshow_list = List.reverse (sortByRating model.tvshow_list) }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.tvshow_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, tvshow_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, tvshow_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, tvshow_list = list, seed = seedoutput }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | currentlyPlaying = model.currentlyPlaying, tvshow_list = model.tvshow_list }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | tvshow_list = shared.tvshow_list }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3, Background.color (rgb 0.2 0.2 0.2) ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| greyIcon))
        }


constructTvshowItem : TvshowObj -> Element Msg
constructTvshowItem tvshow =
    column [ spacingXY 5 0, Element.width fill, Element.height fill ]
        [ image
            [ Element.width (fill |> minimum 150 |> maximum 150)
            , Element.height (fill |> minimum 200 |> maximum 200)
            , inFront
                (row []
                    [ materialButton ( Filled.play_arrow, NoOp ) ]
                )

            {- , Element.Events.onMouseEnter ShowMenu
               , Element.Events.onMouseLeave CloseMenu
            -}
            ]
            (if String.isEmpty tvshow.thumbnail then
                { src = "https://via.placeholder.com/70"
                , description = "Hero Image"
                }

             else
                { description = tvshow.label
                , src = crossOrigin "http://localhost:8080" [ "image", percentEncode tvshow.thumbnail ] []
                }
            )
        , column [ alignBottom, Background.color (rgb 1 1 1), Element.width (fill |> minimum 150 |> maximum 150), clip ]
            [ el [ Font.color (Element.rgb 0 0 0), Font.size 18 ] (Element.text tvshow.label)
            , el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18 ] (Element.text "2020")
            ]
        ]



-- VIEW


view : Model -> Document Msg
view model =
    { title = "TVShows"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill ]
                [ Components.VerticalNavTvshows.view model.route
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
                    (\tvshow ->
                        constructTvshowItem tvshow
                    )
                    model.tvshow_list
                )
            ]
        ]
    }


sortButton : TvShowSort -> TvShowSort -> String -> msg -> Element msg
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


currentButtonText : TvShowSort -> String -> ( Bool, SortDirection -> TvShowSort ) -> Element msg
currentButtonText currentButton name ( isCurrent, button ) =
    case isCurrent of
        True ->
            if currentButton == button Asc then
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↑") ]

            else
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↓") ]

        False ->
            row [ Font.color Colors.navText ] [ Element.text name ]
