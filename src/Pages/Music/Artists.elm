module Pages.Music.Artists exposing (Model, Msg, Params, page)

import Colors
import Components.SectionHeader
import Components.VerticalNav
import Components.VerticalNavMusic
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
import Element.Input as Input
import Helper exposing (..)
import Html.Attributes exposing (class, style)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Random
import Set exposing (Set)
import Shared exposing (sendActions)
import SharedType exposing (ObjectSort(..), SortDirection(..))
import SharedUtil exposing (..)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import WSDecoder exposing (ArtistObj, SongObj)


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


type FilterTab
    = Default
    | Select
    | MoodFilter
    | GenreFilter
    | StyleFilter


type alias Model =
    { artist_list : List ArtistObj
    , temp_artist_list : List ArtistObj
    , route : Route
    , currentButton : ObjectSort
    , seed : Random.Seed
    , song_list : List SongObj
    , currentfilter : FilterTab
    , genrebuttons : List FilterButton
    , moodbuttons : List FilterButton
    , stylebuttons : List FilterButton
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { artist_list = sortByTitle shared.artist_list
      , temp_artist_list = sortByTitle shared.artist_list
      , route = url.route
      , currentButton = Title Asc
      , seed = Random.initialSeed 1453
      , song_list = shared.song_list
      , currentfilter = Default
      , genrebuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .genre shared.artist_list)))
      , moodbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .mood shared.artist_list)))
      , stylebuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .style shared.artist_list)))
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = TitleButtonMsg
    | RandomButtonMsg
    | ArtistCardButtonMsg ArtistObj
    | ChangeFilterTabMsg FilterTab
    | MoodMsg Int
    | GenreMsg Int
    | StyleMsg Int
    | ToggleOffMood
    | ToggleOffGenre
    | ToggleOffStyle
    | ToggleOffAll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, temp_artist_list = List.reverse model.temp_artist_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, temp_artist_list = List.reverse model.temp_artist_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, temp_artist_list = sortByTitle model.temp_artist_list }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.temp_artist_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, temp_artist_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, temp_artist_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, temp_artist_list = list, seed = seedoutput }, Cmd.none )

        ArtistCardButtonMsg artist ->
            let
                songs =
                    List.filter (\album -> List.member artist.label album.artist) model.song_list

                added_songs =
                    List.map (\song -> """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": """ ++ String.fromInt song.songid ++ """}}}""") songs

                output =
                    [ """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}""" ]
                        ++ added_songs
                        ++ [ """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}""" ]
            in
            ( model, sendActions output )

        ChangeFilterTabMsg tab ->
            ( { model | currentfilter = tab }, Cmd.none )

        MoodMsg idx ->
            let
                moodbutton =
                    updateFilter idx model.moodbuttons
            in
            ( { model | temp_artist_list = filterArtist model.currentButton model.artist_list model.genrebuttons moodbutton model.stylebuttons, moodbuttons = moodbutton }, Cmd.none )

        GenreMsg idx ->
            let
                genrebutton =
                    updateFilter idx model.genrebuttons
            in
            ( { model | temp_artist_list = filterArtist model.currentButton model.artist_list genrebutton model.moodbuttons model.stylebuttons, genrebuttons = genrebutton }, Cmd.none )

        StyleMsg idx ->
            let
                stylebutton =
                    updateFilter idx model.stylebuttons
            in
            ( { model | temp_artist_list = filterArtist model.currentButton model.artist_list model.genrebuttons model.moodbuttons stylebutton, stylebuttons = stylebutton }, Cmd.none )

        ToggleOffMood ->
            let
                moodbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.moodbuttons
            in
            ( { model | moodbuttons = moodbutton, temp_artist_list = filterArtist model.currentButton model.artist_list model.genrebuttons moodbutton model.stylebuttons }, Cmd.none )

        ToggleOffGenre ->
            let
                genrebutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.genrebuttons
            in
            ( { model | genrebuttons = genrebutton, temp_artist_list = filterArtist model.currentButton model.artist_list genrebutton model.moodbuttons model.stylebuttons }, Cmd.none )

        ToggleOffStyle ->
            let
                stylebutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.stylebuttons
            in
            ( { model | stylebuttons = stylebutton, temp_artist_list = filterArtist model.currentButton model.artist_list model.genrebuttons model.moodbuttons stylebutton }, Cmd.none )

        ToggleOffAll ->
            let
                genrebuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.genrebuttons

                moodbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.moodbuttons

                stylebuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.stylebuttons
            in
            ( { model | stylebuttons = stylebuttons, genrebuttons = genrebuttons, moodbuttons = moodbuttons, currentfilter = Default, temp_artist_list = sortFilterArtist model.currentButton model.artist_list }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Music.Artists"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ case model.currentfilter of
                Default ->
                    column [ Element.height fill, Element.width fill ]
                        [ Components.VerticalNavMusic.view model.route
                        , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 15 ]
                            [ column [ Element.width fill, spacing 10 ]
                                [ row [ Element.width fill, Font.size 15 ]
                                    [ Element.text "FILTERS"
                                    , if List.isEmpty (checkFilterButton (model.moodbuttons ++ model.genrebuttons ++ model.stylebuttons)) == False then
                                        Input.button [ alignRight ]
                                            { onPress = Just (ChangeFilterTabMsg Select)
                                            , label =
                                                Element.html (Filled.add 25 (MITypes.Color <| Colors.darkGreyIcon))
                                            }

                                      else
                                        Element.none
                                    ]
                                , if List.isEmpty (checkFilterButton (model.moodbuttons ++ model.genrebuttons ++ model.stylebuttons)) == True then
                                    Input.button [ paddingXY 10 10, Background.color (Element.rgba255 168 167 166 1), Font.color Colors.white, mouseOver [ Background.color Colors.navTextHover ] ]
                                        { onPress = Just (ChangeFilterTabMsg Select)
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "Add Filter ", Element.html (Filled.add_circle 15 (MITypes.Color <| Colors.whiteIcon)) ]
                                        }

                                  else
                                    Element.none
                                , closeFilterButton model.genrebuttons ToggleOffGenre
                                , closeFilterButton model.moodbuttons ToggleOffMood
                                , closeFilterButton model.stylebuttons ToggleOffStyle
                                ]
                            , column [ Element.width fill, spacing 15 ]
                                [ Element.text "SORT"
                                , sortButton model.currentButton (Title Asc) "Title " TitleButtonMsg
                                , sortButton model.currentButton (Random Asc) "Random " RandomButtonMsg
                                ]
                            ]
                        ]

                Select ->
                    selectFilterView model.genrebuttons model.moodbuttons model.stylebuttons

                MoodFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffMood MoodMsg model.moodbuttons

                GenreFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffGenre GenreMsg model.genrebuttons

                StyleFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffStyle StyleMsg model.stylebuttons
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ let
                    all_filter_button =
                        checkFilterButton (model.moodbuttons ++ model.genrebuttons ++ model.stylebuttons)
                  in
                  case List.isEmpty all_filter_button of
                    False ->
                        Element.row [ width fill, height (px 40), Background.color Colors.white, Font.size 18, Element.htmlAttribute (Html.Attributes.style "box-shadow" "0 2px 6px -6px black"), paddingXY 10 0 ]
                            [ el [ centerX, Font.size 14, Font.color Colors.black ]
                                (Element.text (String.join "," (List.map .name all_filter_button)))
                            , Input.button [ paddingXY 10 0, alignRight, Element.htmlAttribute (Html.Attributes.style "margin-right" "50px") ]
                                { onPress = Just ToggleOffAll
                                , label = Element.html (Filled.close 15 (MITypes.Color <| Colors.blackIcon))
                                }
                            ]

                    True ->
                        Element.none
                , wrappedRow [ Element.height fill, Element.width fill, paddingXY 20 20, spacingXY 15 7 ]
                    (List.map
                        (\artist ->
                            Components.SectionHeader.viewArtists (ArtistCardButtonMsg artist) artist
                        )
                        model.temp_artist_list
                    )
                ]
            ]
        ]
    }


selectFilterView : List FilterButton -> List FilterButton -> List FilterButton -> Element Msg
selectFilterView genrebutton moodbutton stylebutton =
    column [ Element.height fill, Element.width (fillPortion 1), paddingXY 5 30, spacing 10, Font.color Colors.greyscaleGray, Background.color Colors.sidebar ]
        [ Input.button [ paddingXY 10 10 ]
            { onPress = Just (ChangeFilterTabMsg Default)
            , label = row [ Font.size 14 ] [ Element.html (Filled.keyboard_arrow_left 20 (MITypes.Color <| Colors.darkGreyIcon)), Element.text "SELECT A FILTER" ]
            }
        , filterFieldButton (ChangeFilterTabMsg GenreFilter) "Genre" genrebutton
        , filterFieldButton (ChangeFilterTabMsg MoodFilter) "Mood" moodbutton
        , filterFieldButton (ChangeFilterTabMsg StyleFilter) "Style" stylebutton
        ]
