module Pages.Music.Albums exposing (Model, Msg, Params, page)

import Colors
import Components.SectionHeader
import Components.VerticalNav
import Components.VerticalNavMusic
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Random
import Set exposing (Set)
import Shared exposing (sendActions)
import SharedType exposing (AlbumSort(..), SortDirection(..))
import SharedUtil exposing (..)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import WSDecoder exposing (AlbumObj, SongObj)


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
    { album_list : List AlbumObj
    , route : Route
    , currentButton : AlbumSort
    , seed : Random.Seed
    , song_list : List SongObj
    , currentfilter : FilterTab
    , yearbuttons : List FilterButton
    , temp_album_list : List AlbumObj
    , genrebuttons : List FilterButton
    , stylebuttons : List FilterButton
    , labelbuttons : List FilterButton
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { album_list = sortByTitle shared.album_list
      , route = url.route
      , currentfilter = Default
      , currentButton = Title Asc
      , seed = Random.initialSeed 1453
      , song_list = shared.song_list
      , temp_album_list = shared.album_list
      , yearbuttons = List.concatMap (\obj -> [ FilterButton (String.fromInt obj) False ]) (Set.toList (Set.fromList (List.map .year shared.album_list)))
      , genrebuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .genre shared.album_list)))
      , stylebuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .style shared.album_list)))
      , labelbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.map .albumlabel shared.album_list)))
      }
    , Cmd.none
    )


type FilterTab
    = Default
    | Select
    | YearFilter
    | GenreFilter
    | StyleFilter
    | AlbumLabelFilter



-- UPDATE


type Msg
    = TitleButtonMsg
    | DateButtonMsg
    | YearButtonMsg
    | ArtistButtonMsg
    | RandomButtonMsg
    | RatingButtonMsg
    | AlbumCardButtonMsg AlbumObj
    | ChangeFilterTabMsg FilterTab
    | YearsMsg Int
    | GenreMsg Int
    | StyleMsg Int
    | AlbumLabelMsg Int
    | ToggleOffYear
    | ToggleOffGenre
    | ToggleOffStyle
    | ToggleOffLabel
    | ToggleOffAll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, temp_album_list = sortByTitle model.temp_album_list }, Cmd.none )

        DateButtonMsg ->
            case model.currentButton of
                DateAdded Asc ->
                    ( { model | currentButton = DateAdded Desc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                DateAdded Desc ->
                    ( { model | currentButton = DateAdded Asc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = DateAdded Asc, temp_album_list = sortByDate model.temp_album_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, temp_album_list = sortByYear model.temp_album_list }, Cmd.none )

        ArtistButtonMsg ->
            case model.currentButton of
                Artist Asc ->
                    ( { model | currentButton = Artist Desc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                Artist Desc ->
                    ( { model | currentButton = Artist Asc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Artist Asc, temp_album_list = sortByArtist model.temp_album_list }, Cmd.none )

        RatingButtonMsg ->
            case model.currentButton of
                Rating Asc ->
                    ( { model | currentButton = Rating Desc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                Rating Desc ->
                    ( { model | currentButton = Rating Asc, temp_album_list = List.reverse model.temp_album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Rating Asc, temp_album_list = List.reverse (sortByRating model.temp_album_list) }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.temp_album_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, temp_album_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, temp_album_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, temp_album_list = list, seed = seedoutput }, Cmd.none )

        AlbumCardButtonMsg album ->
            let
                songs =
                    List.filter (\song -> song.albumid == album.albumid) model.song_list

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

        YearsMsg idx ->
            let
                yearbutton =
                    updateFilter idx model.yearbuttons
            in
            ( { model | temp_album_list = filterAlbum model.currentButton model.album_list yearbutton model.genrebuttons model.stylebuttons model.labelbuttons, yearbuttons = yearbutton }, Cmd.none )

        GenreMsg idx ->
            let
                genrebutton =
                    updateFilter idx model.genrebuttons
            in
            ( { model | temp_album_list = filterAlbum model.currentButton model.album_list model.yearbuttons genrebutton model.stylebuttons model.labelbuttons, genrebuttons = genrebutton }, Cmd.none )

        StyleMsg idx ->
            let
                stylebutton =
                    updateFilter idx model.stylebuttons
            in
            ( { model | temp_album_list = filterAlbum model.currentButton model.album_list model.yearbuttons model.genrebuttons stylebutton model.labelbuttons, stylebuttons = stylebutton }, Cmd.none )

        AlbumLabelMsg idx ->
            let
                labelbutton =
                    updateFilter idx model.labelbuttons
            in
            ( { model | temp_album_list = filterAlbum model.currentButton model.album_list model.yearbuttons model.genrebuttons model.stylebuttons labelbutton, labelbuttons = labelbutton }, Cmd.none )

        ToggleOffYear ->
            let
                yearbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.yearbuttons
            in
            ( { model | yearbuttons = yearbutton, temp_album_list = filterAlbum model.currentButton model.album_list yearbutton model.genrebuttons model.stylebuttons model.labelbuttons }, Cmd.none )

        ToggleOffGenre ->
            let
                genrebuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.genrebuttons
            in
            ( { model | temp_album_list = filterAlbum model.currentButton model.album_list model.yearbuttons genrebuttons model.stylebuttons model.labelbuttons, genrebuttons = genrebuttons }, Cmd.none )

        ToggleOffStyle ->
            let
                stylebutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.stylebuttons
            in
            ( { model | temp_album_list = filterAlbum model.currentButton model.album_list model.yearbuttons model.genrebuttons stylebutton model.labelbuttons, stylebuttons = stylebutton }, Cmd.none )

        ToggleOffLabel ->
            let
                labelbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.labelbuttons
            in
            ( { model | temp_album_list = filterAlbum model.currentButton model.album_list model.yearbuttons model.genrebuttons model.stylebuttons labelbutton, labelbuttons = labelbutton }, Cmd.none )

        ToggleOffAll ->
            let
                yearbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.yearbuttons

                genrebuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.genrebuttons

                stylebuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.stylebuttons

                labelbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.labelbuttons
            in
            ( { model | stylebuttons = stylebuttons, genrebuttons = genrebuttons, labelbuttons = labelbuttons, yearbuttons = yearbuttons, currentfilter = Default, temp_album_list = sortFilterAlbum model.currentButton model.album_list }, Cmd.none )


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
                        , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 30 ]
                            [ column [ Element.width fill, spacing 10 ]
                                [ row [ Element.width fill, Font.size 15 ]
                                    [ Element.text "FILTERS"
                                    , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.stylebuttons ++ model.labelbuttons)) == False then
                                        Input.button [ alignRight ]
                                            { onPress = Just (ChangeFilterTabMsg Select)
                                            , label =
                                                Element.html (Filled.add 25 (MITypes.Color <| Colors.darkGreyIcon))
                                            }

                                      else
                                        Element.none
                                    ]
                                , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.stylebuttons ++ model.labelbuttons)) == True then
                                    Input.button [ paddingXY 10 10, Background.color (Element.rgba255 168 167 166 1), Font.color Colors.white, mouseOver [ Background.color Colors.navTextHover ] ]
                                        { onPress = Just (ChangeFilterTabMsg Select)
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "Add Filter ", Element.html (Filled.add_circle 15 (MITypes.Color <| Colors.whiteIcon)) ]
                                        }

                                  else
                                    Element.none
                                , closeFilterButton model.yearbuttons ToggleOffYear
                                , closeFilterButton model.genrebuttons ToggleOffGenre
                                , closeFilterButton model.stylebuttons ToggleOffStyle
                                , closeFilterButton model.labelbuttons ToggleOffLabel
                                ]
                            , column [ Element.width fill, spacing 15 ]
                                [ Element.text "SORT"
                                , sortButton model.currentButton (Title Asc) "Title " TitleButtonMsg
                                , sortButton model.currentButton (Year Asc) "Year " YearButtonMsg
                                , sortButton model.currentButton (DateAdded Asc) "Date Added " DateButtonMsg
                                , sortButton model.currentButton (Rating Asc) "Rating " RatingButtonMsg
                                , sortButton model.currentButton (Artist Asc) "Artist " ArtistButtonMsg
                                , sortButton model.currentButton (Random Asc) "Random " RandomButtonMsg
                                ]
                            ]
                        ]

                Select ->
                    selectfilterview model.labelbuttons model.stylebuttons model.genrebuttons model.yearbuttons

                YearFilter ->
                    filterview (ChangeFilterTabMsg Select) ToggleOffYear YearsMsg model.yearbuttons

                GenreFilter ->
                    filterview (ChangeFilterTabMsg Select) ToggleOffGenre GenreMsg model.genrebuttons

                StyleFilter ->
                    filterview (ChangeFilterTabMsg Select) ToggleOffStyle StyleMsg model.stylebuttons

                AlbumLabelFilter ->
                    filterview (ChangeFilterTabMsg Select) ToggleOffLabel AlbumLabelMsg model.labelbuttons
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ let
                    all_filter_button =
                        checkFilterButton (model.yearbuttons ++ model.genrebuttons ++ model.stylebuttons ++ model.labelbuttons)
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
                , wrappedRow [ Element.height fill, Element.width fill, paddingXY 20 15, spacingXY 10 7 ]
                    (List.map
                        (\album ->
                            Components.SectionHeader.viewAlbums (AlbumCardButtonMsg album) album
                        )
                        model.temp_album_list
                    )
                ]
            ]
        ]
    }


sortButton : AlbumSort -> AlbumSort -> String -> msg -> Element msg
sortButton currentButton button name buttonMsg =
    let
        isCurrentButton =
            case ( currentButton, button ) of
                ( Title _, Title _ ) ->
                    ( True, Title )

                ( DateAdded _, DateAdded _ ) ->
                    ( True, DateAdded )

                ( Year _, Year _ ) ->
                    ( True, Year )

                ( Artist _, Artist _ ) ->
                    ( True, Artist )

                ( Random _, Random _ ) ->
                    ( True, Random )

                ( Rating _, Rating _ ) ->
                    ( True, Rating )

                _ ->
                    ( False, Random )
    in
    Input.button [ paddingXY 10 0 ]
        { onPress = Just buttonMsg
        , label =
            currentButtonText currentButton name isCurrentButton
        }


currentButtonText : AlbumSort -> String -> ( Bool, SortDirection -> AlbumSort ) -> Element msg
currentButtonText currentButton name ( isCurrent, button ) =
    case isCurrent of
        True ->
            if currentButton == button Asc then
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↑") ]

            else
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↓") ]

        False ->
            row [ Font.color Colors.navText ] [ Element.text name ]


filterfieldbutton : msg -> String -> List FilterButton -> Element msg
filterfieldbutton buttonMsg name filterbutton =
    Input.button [ paddingXY 30 0 ]
        { onPress = Just buttonMsg
        , label =
            el
                (case List.isEmpty (checkFilterButton filterbutton) of
                    True ->
                        [ Font.color (Element.rgba255 43 47 48 1) ]

                    False ->
                        [ Font.color Colors.navTextHover ]
                )
                (Element.text name)
        }


selectfilterview : List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> Element Msg
selectfilterview labelbutton stylebutton genrebutton filterbutton =
    column [ Element.height fill, Element.width (fillPortion 1), paddingXY 5 30, spacing 10, Font.color Colors.greyscaleGray, Background.color Colors.sidebar ]
        [ Input.button [ paddingXY 10 10 ]
            { onPress = Just (ChangeFilterTabMsg Default)
            , label = row [ Font.size 14 ] [ Element.html (Filled.keyboard_arrow_left 20 (MITypes.Color <| Colors.darkGreyIcon)), Element.text "SELECT A FILTER" ]
            }
        , filterfieldbutton (ChangeFilterTabMsg YearFilter) "Year" filterbutton
        , filterfieldbutton (ChangeFilterTabMsg GenreFilter) "Genre" genrebutton
        , filterfieldbutton (ChangeFilterTabMsg StyleFilter) "Style" stylebutton
        , filterfieldbutton (ChangeFilterTabMsg AlbumLabelFilter) "Label" labelbutton
        ]


filterview : msg -> msg -> (Int -> msg) -> List FilterButton -> Element msg
filterview addfilter toggleOff onButtonPressed filterbuttons =
    column [ Element.height fill, Element.width (fillPortion 1), paddingXY 5 30, spacing 16, Font.color Colors.greyscaleGray, Background.color Colors.sidebar ]
        [ Input.button [ paddingXY 10 0 ]
            { onPress = Just addfilter
            , label = row [] [ Element.html (Filled.keyboard_arrow_left 20 (MITypes.Color <| Colors.darkGreyIcon)), Element.text "SELECT AN OPTION" ]
            }
        , column [ paddingXY 30 0, spacing 10 ]
            [ Input.button [ Font.color Colors.navText ]
                { onPress = Just toggleOff
                , label = Element.text "Deselect all"
                }
            , column [ spacing 10 ]
                (List.indexedMap
                    (\index obj ->
                        if obj.name /= "" then
                            Input.button
                                [ case obj.state of
                                    True ->
                                        Font.color Colors.navTextHover

                                    False ->
                                        Font.color Colors.navText
                                ]
                                { onPress = Just (onButtonPressed index)
                                , label = Element.text obj.name
                                }

                        else
                            Element.none
                    )
                    filterbuttons
                )
            ]
        ]


closeFilterButton : List FilterButton -> msg -> Element msg
closeFilterButton list buttonMsg =
    case List.isEmpty (checkFilterButton list) of
        False ->
            Input.button [ Element.width fill, paddingXY 10 10, Background.color Colors.navTextHover, Font.color Colors.white ]
                { onPress = Just buttonMsg
                , label = row [ Element.width fill, spacingXY 10 0 ] [ row [ width (px 140), clipX ] [ Element.text (String.join "," (List.map .name (checkFilterButton list))) ], el [ alignRight ] (Element.html (Filled.remove_circle 15 (MITypes.Color <| Colors.whiteIcon))) ]
                }

        True ->
            Element.none
