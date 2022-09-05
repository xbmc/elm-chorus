module Pages.Movies exposing (Model, Msg, Params, page)

import Colors exposing (greyIcon)
import Components.SectionHeader
import Components.VerticalNav
import Components.VerticalNavMovies
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
import Element.Input as Input
import Helper exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Random
import Set exposing (Set)
import Shared exposing (sendAction, sendActions)
import SharedType exposing (ObjectSort(..), SortDirection(..))
import SharedUtil exposing (..)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
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


type FilterTab
    = Default
    | Select
    | YearFilter
    | GenreFilter
    | TagFilter
    | ActorFilter
    | RatedFilter
    | StudioFilter
    | WriterFilter
    | SetFilter
    | DirectorFilter


type alias Params =
    ()


type alias Model =
    { currentlyPlaying : Maybe ItemDetails
    , movie_list : List MovieObj
    , temp_movie_list : List MovieObj
    , route : Route
    , currentButton : ObjectSort
    , currentfilter : FilterTab
    , unwatchedButton : Bool
    , inprogressButton : Bool
    , watchedButton : Bool
    , seed : Random.Seed
    , yearbuttons : List FilterButton
    , genrebuttons : List FilterButton
    , tagbuttons : List FilterButton
    , actorbuttons : List FilterButton
    , ratedbuttons : List FilterButton
    , studiobuttons : List FilterButton
    , writerbuttons : List FilterButton
    , directorbuttons : List FilterButton
    , setbuttons : List FilterButton
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { currentlyPlaying = shared.currentlyPlaying
      , movie_list = sortByTitle shared.movie_list
      , temp_movie_list = shared.movie_list
      , route = url.route
      , currentButton = Title Asc
      , currentfilter = Default
      , unwatchedButton = False
      , inprogressButton = False
      , watchedButton = False
      , seed = Random.initialSeed 1453
      , yearbuttons = List.concatMap (\obj -> [ FilterButton (String.fromInt obj) False ]) (Set.toList (Set.fromList (List.map .year shared.movie_list)))
      , genrebuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .genre shared.movie_list)))
      , tagbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .tags shared.movie_list)))
      , actorbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap (\movie -> List.map (\cast -> cast.name) (List.take 5 movie.cast)) shared.movie_list)))
      , ratedbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.map .mpaa shared.movie_list)))
      , studiobuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .studio shared.movie_list)))
      , writerbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .writer shared.movie_list)))
      , directorbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .director shared.movie_list)))
      , setbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.map .set shared.movie_list)))
      }
    , sendAction """{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": {"properties" : ["art", "rating", "thumbnail", "playcount", "file","year","dateadded","genre","director","cast","streamdetails","mpaa","runtime","writer","plot","resume","set","tag","studio"]}, "id": "libMovies"}"""
    )



-- UPDATE


type Msg
    = SetCurrentlyPlaying MovieObj
    | TitleButtonMsg
    | YearButtonMsg
    | DateButtonMsg
    | RatingButtonMsg
    | RandomButtonMsg
    | ChangeFilterTabMsg FilterTab
    | YearMsg Int
    | GenreMsg Int
    | UnwatchedMsg
    | InProgressMsg
    | TagMsg Int
    | ActorMsg Int
    | RatedMsg Int
    | StudioMsg Int
    | ToggleOffYear
    | ToggleOffGenre
    | ToggleOffTag
    | ToggleOffRated
    | ToggleOffStudio
    | ToggleOffActor
    | ToggleOffWriter
    | ToggleOffSet
    | WatchedMsg
    | WriterMsg Int
    | SetMsg Int
    | DirectorMsg Int
    | ToggleOffDirector
    | ToggleOffAll


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
                    ( { model | currentButton = Title Desc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, temp_movie_list = sortByTitle model.temp_movie_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, temp_movie_list = sortByYear model.temp_movie_list }, Cmd.none )

        DateButtonMsg ->
            case model.currentButton of
                DateAdded Asc ->
                    ( { model | currentButton = DateAdded Desc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                DateAdded Desc ->
                    ( { model | currentButton = DateAdded Asc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = DateAdded Asc, temp_movie_list = sortByDate model.temp_movie_list }, Cmd.none )

        RatingButtonMsg ->
            case model.currentButton of
                Rating Asc ->
                    ( { model | currentButton = Rating Desc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                Rating Desc ->
                    ( { model | currentButton = Rating Asc, temp_movie_list = List.reverse model.temp_movie_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Rating Asc, temp_movie_list = sortByRating model.temp_movie_list }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.temp_movie_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, temp_movie_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, temp_movie_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, temp_movie_list = list, seed = seedoutput }, Cmd.none )

        ChangeFilterTabMsg tab ->
            ( { model | currentfilter = tab }, Cmd.none )

        YearMsg idx ->
            let
                yearbutton =
                    updateFilter idx model.yearbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list yearbutton model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, yearbuttons = yearbutton }, Cmd.none )

        GenreMsg idx ->
            let
                genrebutton =
                    updateFilter idx model.genrebuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons genrebutton model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, genrebuttons = genrebutton }, Cmd.none )

        UnwatchedMsg ->
            let
                unwatched =
                    not model.unwatchedButton
            in
            ( { model | temp_movie_list = filterMovie model.currentButton unwatched model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, unwatchedButton = unwatched }, Cmd.none )

        InProgressMsg ->
            let
                inprogress =
                    not model.inprogressButton
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton inprogress model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, inprogressButton = inprogress }, Cmd.none )

        WatchedMsg ->
            let
                watched =
                    not model.watchedButton
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton watched model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, watchedButton = watched }, Cmd.none )

        TagMsg idx ->
            let
                tagbutton =
                    updateFilter idx model.tagbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons tagbutton model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, tagbuttons = tagbutton }, Cmd.none )

        ActorMsg idx ->
            let
                actorbutton =
                    updateFilter idx model.actorbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons actorbutton model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, actorbuttons = actorbutton }, Cmd.none )

        RatedMsg idx ->
            let
                ratedbutton =
                    updateFilter idx model.ratedbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons ratedbutton model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, ratedbuttons = ratedbutton }, Cmd.none )

        StudioMsg idx ->
            let
                studiobutton =
                    updateFilter idx model.studiobuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons studiobutton model.setbuttons model.directorbuttons model.writerbuttons, studiobuttons = studiobutton }, Cmd.none )

        WriterMsg idx ->
            let
                writerbutton =
                    updateFilter idx model.writerbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons writerbutton, writerbuttons = writerbutton }, Cmd.none )

        SetMsg idx ->
            let
                setbutton =
                    updateFilter idx model.setbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons setbutton model.directorbuttons model.writerbuttons, setbuttons = setbutton }, Cmd.none )

        DirectorMsg idx ->
            let
                directorbutton =
                    updateFilter idx model.directorbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons directorbutton model.writerbuttons, directorbuttons = directorbutton }, Cmd.none )

        ToggleOffYear ->
            let
                yearbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.yearbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list yearbutton model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, yearbuttons = yearbutton }, Cmd.none )

        ToggleOffGenre ->
            let
                genrebutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.genrebuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons genrebutton model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, genrebuttons = genrebutton }, Cmd.none )

        ToggleOffTag ->
            let
                tagbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.tagbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons tagbutton model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, tagbuttons = tagbutton }, Cmd.none )

        ToggleOffRated ->
            let
                ratedbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.ratedbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons ratedbutton model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, ratedbuttons = ratedbutton }, Cmd.none )

        ToggleOffStudio ->
            let
                studiobutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.studiobuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons studiobutton model.setbuttons model.directorbuttons model.writerbuttons, studiobuttons = studiobutton }, Cmd.none )

        ToggleOffActor ->
            let
                actorbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.actorbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons actorbutton model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons, actorbuttons = actorbutton }, Cmd.none )

        ToggleOffWriter ->
            let
                writerbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.writerbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons writerbutton, writerbuttons = writerbutton }, Cmd.none )

        ToggleOffSet ->
            let
                setbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.setbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons setbutton model.directorbuttons model.writerbuttons, setbuttons = setbutton }, Cmd.none )

        ToggleOffDirector ->
            let
                directorbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.directorbuttons
            in
            ( { model | temp_movie_list = filterMovie model.currentButton model.unwatchedButton model.inprogressButton model.watchedButton model.movie_list model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons directorbutton model.writerbuttons, directorbuttons = directorbutton }, Cmd.none )

        ToggleOffAll ->
            let
                yearbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.yearbuttons

                genrebuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.genrebuttons

                tagbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.tagbuttons

                ratedbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.ratedbuttons

                studiobuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.studiobuttons

                actorbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.actorbuttons

                setbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.setbuttons

                directorbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.directorbuttons

                writerbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.writerbuttons
            in
            ( { model | yearbuttons = yearbuttons, genrebuttons = genrebuttons, tagbuttons = tagbuttons, ratedbuttons = ratedbuttons, studiobuttons = studiobuttons, actorbuttons = actorbuttons, setbuttons = setbuttons, directorbuttons = directorbuttons, writerbuttons = writerbuttons, unwatchedButton = False, inprogressButton = False, currentfilter = Default, temp_movie_list = sortFilterMovie model.currentButton model.movie_list }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | currentlyPlaying = model.currentlyPlaying }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Movies"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ case model.currentfilter of
                Default ->
                    column [ Element.height fill, Element.width fill ]
                        [ Components.VerticalNavMovies.view model.route
                        , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 15 ]
                            [ column [ Element.width fill, spacing 10 ]
                                [ row [ Element.width fill, Font.size 15 ]
                                    [ Element.text "FILTERS"
                                    , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.actorbuttons ++ model.studiobuttons ++ model.ratedbuttons ++ model.tagbuttons ++ model.setbuttons ++ model.directorbuttons ++ model.writerbuttons)) == False || model.unwatchedButton == True || model.inprogressButton == True || model.watchedButton == True then
                                        Input.button [ alignRight ]
                                            { onPress = Just (ChangeFilterTabMsg Select)
                                            , label =
                                                Element.html (Filled.add 25 (MITypes.Color <| Colors.darkGreyIcon))
                                            }

                                      else
                                        Element.none
                                    ]
                                , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.actorbuttons ++ model.studiobuttons ++ model.ratedbuttons ++ model.tagbuttons ++ model.setbuttons ++ model.directorbuttons ++ model.writerbuttons)) == True && (model.unwatchedButton == False && model.inprogressButton == False) then
                                    Input.button [ paddingXY 10 10, Background.color (Element.rgba255 168 167 166 1), Font.color Colors.white, mouseOver [ Background.color Colors.navTextHover ] ]
                                        { onPress = Just (ChangeFilterTabMsg Select)
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "Add Filter ", Element.html (Filled.add_circle 15 (MITypes.Color <| Colors.whiteIcon)) ]
                                        }

                                  else
                                    Element.none
                                , closeFilterButton model.yearbuttons ToggleOffYear
                                , closeFilterButton model.genrebuttons ToggleOffGenre
                                , if model.unwatchedButton == True then
                                    Input.button [ Element.width fill, paddingXY 10 10, Background.color Colors.navTextHover, Font.color Colors.white ]
                                        { onPress = Just UnwatchedMsg
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "Unwatched", el [ alignRight ] (Element.html (Filled.remove_circle 15 (MITypes.Color <| Colors.whiteIcon))) ]
                                        }

                                  else
                                    Element.none
                                , if model.watchedButton == True then
                                    Input.button [ Element.width fill, paddingXY 10 10, Background.color Colors.navTextHover, Font.color Colors.white ]
                                        { onPress = Just WatchedMsg
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "Watched", el [ alignRight ] (Element.html (Filled.remove_circle 15 (MITypes.Color <| Colors.whiteIcon))) ]
                                        }

                                  else
                                    Element.none
                                , if model.inprogressButton == True then
                                    Input.button [ Element.width fill, paddingXY 10 10, Background.color Colors.navTextHover, Font.color Colors.white ]
                                        { onPress = Just InProgressMsg
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "In Progress", el [ alignRight ] (Element.html (Filled.remove_circle 15 (MITypes.Color <| Colors.whiteIcon))) ]
                                        }

                                  else
                                    Element.none
                                , closeFilterButton model.writerbuttons ToggleOffWriter
                                , closeFilterButton model.directorbuttons ToggleOffDirector
                                , closeFilterButton model.tagbuttons ToggleOffTag
                                , closeFilterButton model.actorbuttons ToggleOffActor
                                , closeFilterButton model.setbuttons ToggleOffSet
                                , closeFilterButton model.ratedbuttons ToggleOffRated
                                , closeFilterButton model.studiobuttons ToggleOffStudio
                                ]
                            , column [ Element.width fill, spacing 15 ]
                                [ Element.text "SORT"
                                , sortButton model.currentButton (Title Asc) "Title " TitleButtonMsg
                                , sortButton model.currentButton (Year Asc) "Year " YearButtonMsg
                                , sortButton model.currentButton (DateAdded Asc) "Date Added " DateButtonMsg
                                , sortButton model.currentButton (Rating Asc) "Rating " RatingButtonMsg
                                , sortButton model.currentButton (Random Asc) "Random " RandomButtonMsg
                                ]
                            ]
                        ]

                Select ->
                    selectFilterView model.unwatchedButton model.inprogressButton model.watchedButton model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons model.setbuttons model.directorbuttons model.writerbuttons

                YearFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffYear YearMsg model.yearbuttons

                GenreFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffGenre GenreMsg model.genrebuttons

                TagFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffTag TagMsg model.tagbuttons

                ActorFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffActor ActorMsg model.actorbuttons

                RatedFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffRated RatedMsg model.ratedbuttons

                StudioFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffStudio StudioMsg model.studiobuttons

                DirectorFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffDirector DirectorMsg model.directorbuttons

                SetFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffSet SetMsg model.setbuttons

                WriterFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffWriter WriterMsg model.writerbuttons
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ let
                    all_filter_button =
                        checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.actorbuttons ++ model.studiobuttons ++ model.ratedbuttons ++ model.tagbuttons ++ model.setbuttons ++ model.directorbuttons ++ model.writerbuttons)

                    togglefilter =
                        (if model.unwatchedButton == True then
                            [ "Unwatched" ]

                         else
                            []
                        )
                            ++ (if model.inprogressButton == True then
                                    [ "In Progress" ]

                                else
                                    []
                               )
                            ++ (if model.watchedButton == True then
                                    [ "Watched" ]

                                else
                                    []
                               )
                  in
                  case List.isEmpty all_filter_button && List.isEmpty togglefilter of
                    False ->
                        Element.row [ Element.width fill, Element.height (px 40), Background.color Colors.white, Font.size 18, Element.htmlAttribute (Html.Attributes.style "box-shadow" "0 2px 6px -6px black"), paddingXY 10 0 ]
                            [ el [ centerX, Font.size 14, Font.color Colors.black ]
                                (Element.text (String.join "," (List.map .name all_filter_button ++ togglefilter)))
                            , Input.button [ paddingXY 10 0, alignRight, Element.htmlAttribute (Html.Attributes.style "margin-right" "50px") ]
                                { onPress = Just ToggleOffAll
                                , label = Element.html (Filled.close 15 (MITypes.Color <| Colors.blackIcon))
                                }
                            ]

                    True ->
                        Element.none
                , wrappedRow [ Element.height fill, Element.width (fillPortion 6), Background.color Colors.background, spacingXY 15 10, padding 25 ]
                    (List.map
                        (\movie ->
                            Components.SectionHeader.viewMovies (SetCurrentlyPlaying movie) movie
                        )
                        model.temp_movie_list
                    )
                ]
            ]
        ]
    }


selectFilterView : Bool -> Bool -> Bool -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> Element Msg
selectFilterView unwatched inprogress watched yearbutton genrebutton tagbutton actorbutton ratedbutton studiobutton setbutton directorbutton writerbutton =
    column [ Element.height fill, Element.width (fillPortion 1), paddingXY 5 30, spacing 10, Font.color Colors.greyscaleGray, Background.color Colors.sidebar ]
        [ Input.button [ paddingXY 10 10 ]
            { onPress = Just (ChangeFilterTabMsg Default)
            , label = row [ Font.size 14 ] [ Element.html (Filled.keyboard_arrow_left 20 (MITypes.Color <| Colors.darkGreyIcon)), Element.text "SELECT A FILTER" ]
            }
        , filterFieldButton (ChangeFilterTabMsg YearFilter) "Year" yearbutton
        , filterFieldButton (ChangeFilterTabMsg GenreFilter) "Genre" genrebutton
        , Input.button [ paddingXY 30 0 ]
            { onPress = Just UnwatchedMsg
            , label =
                el
                    (case unwatched of
                        False ->
                            [ Font.color (Element.rgba255 43 47 48 1) ]

                        True ->
                            [ Font.color Colors.navTextHover ]
                    )
                    (Element.text "Unwatched")
            }
        , Input.button [ paddingXY 30 0 ]
            { onPress = Just WatchedMsg
            , label =
                el
                    (case watched of
                        False ->
                            [ Font.color (Element.rgba255 43 47 48 1) ]

                        True ->
                            [ Font.color Colors.navTextHover ]
                    )
                    (Element.text "Watched")
            }
        , Input.button [ paddingXY 30 0 ]
            { onPress = Just InProgressMsg
            , label =
                el
                    (case inprogress of
                        False ->
                            [ Font.color (Element.rgba255 43 47 48 1) ]

                        True ->
                            [ Font.color Colors.navTextHover ]
                    )
                    (Element.text "In Progress")
            }
        , filterFieldButton (ChangeFilterTabMsg WriterFilter) "Writer" writerbutton
        , filterFieldButton (ChangeFilterTabMsg DirectorFilter) "Director" directorbutton
        , filterFieldButton (ChangeFilterTabMsg TagFilter) "Tag" tagbutton
        , filterFieldButton (ChangeFilterTabMsg ActorFilter) "Actor" actorbutton
        , filterFieldButton (ChangeFilterTabMsg SetFilter) "Set" setbutton
        , filterFieldButton (ChangeFilterTabMsg RatedFilter) "Rated" ratedbutton
        , filterFieldButton (ChangeFilterTabMsg StudioFilter) "Studio" studiobutton
        ]
