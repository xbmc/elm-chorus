module Pages.Tvshows exposing (Model, Msg, Params, page)

import Colors exposing (greyIcon)
import Components.SectionHeader
import Components.VerticalNav
import Components.VerticalNavTvshows
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
import Svg.Attributes
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (InProgressTvShow, ItemDetails, TvshowObj)


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


type alias Params =
    ()


type alias Model =
    { currentlyPlaying : Maybe ItemDetails
    , tvshow_list : List TvshowObj
    , temp_tvshow_list : List TvshowObj
    , route : Route
    , currentButton : ObjectSort
    , currentfilter : FilterTab
    , seed : Random.Seed
    , inProgressTvShows : List InProgressTvShow
    , unwatchedButton : Bool
    , inprogressButton : Bool
    , yearbuttons : List FilterButton
    , genrebuttons : List FilterButton
    , tagbuttons : List FilterButton
    , actorbuttons : List FilterButton
    , ratedbuttons : List FilterButton
    , studiobuttons : List FilterButton
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { currentlyPlaying = shared.currentlyPlaying
      , tvshow_list = sortByTitle shared.tvshow_list
      , temp_tvshow_list = shared.tvshow_list
      , currentfilter = Default
      , unwatchedButton = False
      , inprogressButton = False
      , route = url.route
      , currentButton = Title Asc
      , inProgressTvShows = shared.inProgressTvShows
      , seed = Random.initialSeed 1453
      , yearbuttons = List.concatMap (\obj -> [ FilterButton (String.fromInt obj) False ]) (Set.toList (Set.fromList (List.map .year shared.tvshow_list)))
      , genrebuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .genre shared.tvshow_list)))
      , tagbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .tags shared.tvshow_list)))
      , actorbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap (\tvshow -> List.map (\cast -> cast.name) (List.take 5 tvshow.cast)) shared.tvshow_list)))
      , ratedbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.map .mpaa shared.tvshow_list)))
      , studiobuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .studio shared.tvshow_list)))
      }
    , sendActions [ """{"jsonrpc": "2.0", "method": "VideoLibrary.GetTVShows", "params": { "properties": ["art", "genre", "plot", "title", "originaltitle", "year", "rating", "thumbnail", "playcount", "file", "fanart","dateadded","mpaa","season","studio","episode","watchedepisodes","cast","tag"] }, "id": "libTvShows"}""", """{"jsonrpc":"2.0","method":"VideoLibrary.GetInProgressTVShows","params":{"properties":[]},"id":"asd"}""" ]
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
    | ToggleOffAll


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
                    ( { model | currentButton = Title Desc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, temp_tvshow_list = sortByTitle model.temp_tvshow_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, temp_tvshow_list = sortByYear model.temp_tvshow_list }, Cmd.none )

        DateButtonMsg ->
            case model.currentButton of
                DateAdded Asc ->
                    ( { model | currentButton = DateAdded Desc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                DateAdded Desc ->
                    ( { model | currentButton = DateAdded Asc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = DateAdded Asc, temp_tvshow_list = sortByDate model.temp_tvshow_list }, Cmd.none )

        RatingButtonMsg ->
            case model.currentButton of
                Rating Asc ->
                    ( { model | currentButton = Rating Desc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                Rating Desc ->
                    ( { model | currentButton = Rating Asc, temp_tvshow_list = List.reverse model.temp_tvshow_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Rating Asc, temp_tvshow_list = List.reverse (sortByRating model.temp_tvshow_list) }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.temp_tvshow_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, temp_tvshow_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, temp_tvshow_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, temp_tvshow_list = list, seed = seedoutput }, Cmd.none )

        ChangeFilterTabMsg tab ->
            ( { model | currentfilter = tab }, Cmd.none )

        YearMsg idx ->
            let
                yearbutton =
                    updateFilter idx model.yearbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows yearbutton model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons, yearbuttons = yearbutton }, Cmd.none )

        GenreMsg idx ->
            let
                genrebutton =
                    updateFilter idx model.genrebuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons genrebutton model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons, genrebuttons = genrebutton }, Cmd.none )

        UnwatchedMsg ->
            let
                unwatched =
                    not model.unwatchedButton
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton unwatched model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons, unwatchedButton = unwatched }, Cmd.none )

        InProgressMsg ->
            let
                inprogress =
                    not model.inprogressButton
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton inprogress model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons, inprogressButton = inprogress }, Cmd.none )

        TagMsg idx ->
            let
                tagbutton =
                    updateFilter idx model.tagbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons tagbutton model.actorbuttons model.ratedbuttons model.studiobuttons, tagbuttons = tagbutton }, Cmd.none )

        ActorMsg idx ->
            let
                actorbutton =
                    updateFilter idx model.actorbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons actorbutton model.ratedbuttons model.studiobuttons, actorbuttons = actorbutton }, Cmd.none )

        RatedMsg idx ->
            let
                ratedbutton =
                    updateFilter idx model.ratedbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons ratedbutton model.studiobuttons, ratedbuttons = ratedbutton }, Cmd.none )

        StudioMsg idx ->
            let
                studiobutton =
                    updateFilter idx model.studiobuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons studiobutton, studiobuttons = studiobutton }, Cmd.none )

        ToggleOffYear ->
            let
                yearbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.yearbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows yearbutton model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons, yearbuttons = yearbutton }, Cmd.none )

        ToggleOffGenre ->
            let
                genrebutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.genrebuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons genrebutton model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons, genrebuttons = genrebutton }, Cmd.none )

        ToggleOffTag ->
            let
                tagbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.tagbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons tagbutton model.actorbuttons model.ratedbuttons model.studiobuttons, tagbuttons = tagbutton }, Cmd.none )

        ToggleOffRated ->
            let
                ratedbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.ratedbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons ratedbutton model.studiobuttons, ratedbuttons = ratedbutton }, Cmd.none )

        ToggleOffStudio ->
            let
                studiobutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.studiobuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons studiobutton, studiobuttons = studiobutton }, Cmd.none )

        ToggleOffActor ->
            let
                actorbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.actorbuttons
            in
            ( { model | temp_tvshow_list = filterTvShow model.currentButton model.unwatchedButton model.inprogressButton model.tvshow_list model.inProgressTvShows model.yearbuttons model.genrebuttons model.tagbuttons actorbutton model.ratedbuttons model.studiobuttons, actorbuttons = actorbutton }, Cmd.none )

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
            in
            ( { model | yearbuttons = yearbuttons, genrebuttons = genrebuttons, tagbuttons = tagbuttons, ratedbuttons = ratedbuttons, studiobuttons = studiobuttons, actorbuttons = actorbuttons, unwatchedButton = False, inprogressButton = False, currentfilter = Default, temp_tvshow_list = sortFilterTvShow model.currentButton model.tvshow_list }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | currentlyPlaying = model.currentlyPlaying }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3, Background.color (rgb 0.2 0.2 0.2) ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| greyIcon))
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "TVShows"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ case model.currentfilter of
                Default ->
                    column [ Element.height fill, Element.width fill ]
                        [ Components.VerticalNavTvshows.view model.route
                        , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 15 ]
                            [ column [ Element.width fill, spacing 10 ]
                                [ row [ Element.width fill, Font.size 15 ]
                                    [ Element.text "FILTERS"
                                    , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.actorbuttons ++ model.studiobuttons ++ model.ratedbuttons ++ model.tagbuttons)) == False || model.unwatchedButton == True || model.inprogressButton == True then
                                        Input.button [ alignRight ]
                                            { onPress = Just (ChangeFilterTabMsg Select)
                                            , label =
                                                Element.html (Filled.add 25 (MITypes.Color <| Colors.darkGreyIcon))
                                            }

                                      else
                                        Element.none
                                    ]
                                , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.actorbuttons ++ model.studiobuttons ++ model.ratedbuttons ++ model.tagbuttons)) == True && (model.unwatchedButton == False && model.inprogressButton == False) then
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
                                , if model.inprogressButton == True then
                                    Input.button [ Element.width fill, paddingXY 10 10, Background.color Colors.navTextHover, Font.color Colors.white ]
                                        { onPress = Just InProgressMsg
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "In Progress", el [ alignRight ] (Element.html (Filled.remove_circle 15 (MITypes.Color <| Colors.whiteIcon))) ]
                                        }

                                  else
                                    Element.none
                                , closeFilterButton model.tagbuttons ToggleOffTag
                                , closeFilterButton model.actorbuttons ToggleOffActor
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
                    selectFilterView model.unwatchedButton model.inprogressButton model.yearbuttons model.genrebuttons model.tagbuttons model.actorbuttons model.ratedbuttons model.studiobuttons

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
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ let
                    all_filter_button =
                        checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.actorbuttons ++ model.studiobuttons ++ model.ratedbuttons ++ model.tagbuttons)

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
                , wrappedRow [ Element.height fill, Element.width fill, paddingXY 20 15, spacingXY 10 7 ]
                    (List.map
                        (\tvshow ->
                            Components.SectionHeader.viewTvShows (SetCurrentlyPlaying tvshow) tvshow
                        )
                        model.temp_tvshow_list
                    )
                ]
            ]
        ]
    }


selectFilterView : Bool -> Bool -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> Element Msg
selectFilterView unwatched inprogress yearbutton genrebutton tagbutton actorbutton ratedbutton studiobutton =
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
        , filterFieldButton (ChangeFilterTabMsg TagFilter) "Tag" tagbutton
        , filterFieldButton (ChangeFilterTabMsg ActorFilter) "Actor" actorbutton
        , filterFieldButton (ChangeFilterTabMsg RatedFilter) "Rated" ratedbutton
        , filterFieldButton (ChangeFilterTabMsg StudioFilter) "Studio" studiobutton
        ]
