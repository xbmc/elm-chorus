module Pages.Music.Videos exposing (Model, Msg, Params, page)

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
import WSDecoder exposing (ArtistObj, VideoObj)


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
    { video_list : List VideoObj
    , temp_video_list : List VideoObj
    , route : Route
    , currentButton : ObjectSort
    , seed : Random.Seed
    , currentfilter : FilterTab
    , yearbuttons : List FilterButton
    , directorbuttons : List FilterButton
    , studiobuttons : List FilterButton
    , albumbuttons : List FilterButton
    , artistbuttons : List FilterButton
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { video_list = sortByTitle shared.video_list
      , temp_video_list = sortByTitle shared.video_list
      , route = url.route
      , currentButton = Title Asc
      , seed = Random.initialSeed 1453
      , currentfilter = Default
      , yearbuttons = List.concatMap (\obj -> [ FilterButton (String.fromInt obj) False ]) (Set.toList (Set.fromList (List.map .year shared.video_list)))
      , directorbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .director shared.video_list)))
      , studiobuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .studio shared.video_list)))
      , albumbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.map .album shared.video_list)))
      , artistbuttons = List.concatMap (\obj -> [ FilterButton obj False ]) (Set.toList (Set.fromList (List.concatMap .artist shared.video_list)))
      }
    , Cmd.none
    )


type FilterTab
    = Default
    | Select
    | YearFilter
    | DirectorFilter
    | StudioFilter
    | AlbumFilter
    | ArtistFilter



-- UPDATE


type Msg
    = TitleButtonMsg
    | YearButtonMsg
    | ArtistButtonMsg
    | AlbumButtonMsg
    | RandomButtonMsg
    | VideoCardButtonMsg VideoObj
    | ChangeFilterTabMsg FilterTab
    | YearMsg Int
    | DirectorMsg Int
    | StudioMsg Int
    | AlbumMsg Int
    | ArtistMsg Int
    | ToggleOffYear
    | ToggleOffDirector
    | ToggleOffStudio
    | ToggleOffAlbum
    | ToggleOffArtist
    | ToggleOffAll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, temp_video_list = sortByTitle model.temp_video_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, temp_video_list = sortByYear model.temp_video_list }, Cmd.none )

        ArtistButtonMsg ->
            case model.currentButton of
                Artist Asc ->
                    ( { model | currentButton = Artist Desc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                Artist Desc ->
                    ( { model | currentButton = Artist Asc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Artist Asc, temp_video_list = sortByArtist model.temp_video_list }, Cmd.none )

        AlbumButtonMsg ->
            case model.currentButton of
                Album Asc ->
                    ( { model | currentButton = Album Desc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                Album Desc ->
                    ( { model | currentButton = Album Asc, temp_video_list = List.reverse model.temp_video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Album Asc, temp_video_list = sortByAlbumVideo model.temp_video_list }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.temp_video_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, temp_video_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, temp_video_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, temp_video_list = list, seed = seedoutput }, Cmd.none )

        VideoCardButtonMsg video ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next video -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"musicvideoid": """ ++ String.fromInt video.videoid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        ChangeFilterTabMsg tab ->
            ( { model | currentfilter = tab }, Cmd.none )

        YearMsg idx ->
            let
                yearbutton =
                    updateFilter idx model.yearbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list yearbutton model.directorbuttons model.studiobuttons model.albumbuttons model.artistbuttons, yearbuttons = yearbutton }, Cmd.none )

        DirectorMsg idx ->
            let
                directorbutton =
                    updateFilter idx model.directorbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons directorbutton model.studiobuttons model.albumbuttons model.artistbuttons, directorbuttons = directorbutton }, Cmd.none )

        StudioMsg idx ->
            let
                studiobutton =
                    updateFilter idx model.studiobuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons model.directorbuttons studiobutton model.albumbuttons model.artistbuttons, studiobuttons = studiobutton }, Cmd.none )

        AlbumMsg idx ->
            let
                albumbutton =
                    updateFilter idx model.albumbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons model.directorbuttons model.studiobuttons albumbutton model.artistbuttons, albumbuttons = albumbutton }, Cmd.none )

        ArtistMsg idx ->
            let
                artistbutton =
                    updateFilter idx model.artistbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons model.directorbuttons model.studiobuttons model.albumbuttons artistbutton, artistbuttons = artistbutton }, Cmd.none )

        ToggleOffYear ->
            let
                yearbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.yearbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list yearbutton model.directorbuttons model.studiobuttons model.albumbuttons model.artistbuttons, yearbuttons = yearbutton }, Cmd.none )

        ToggleOffDirector ->
            let
                directorbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.directorbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons directorbutton model.studiobuttons model.albumbuttons model.artistbuttons, directorbuttons = directorbutton }, Cmd.none )

        ToggleOffStudio ->
            let
                studiobutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.studiobuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons model.directorbuttons studiobutton model.albumbuttons model.artistbuttons, studiobuttons = studiobutton }, Cmd.none )

        ToggleOffAlbum ->
            let
                albumbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.albumbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons model.directorbuttons model.studiobuttons albumbutton model.artistbuttons, albumbuttons = albumbutton }, Cmd.none )

        ToggleOffArtist ->
            let
                artistbutton =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.artistbuttons
            in
            ( { model | temp_video_list = filterVideo model.currentButton model.video_list model.yearbuttons model.directorbuttons model.studiobuttons model.albumbuttons artistbutton, artistbuttons = artistbutton }, Cmd.none )

        ToggleOffAll ->
            let
                yearbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.yearbuttons

                directorbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.directorbuttons

                studiobuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.studiobuttons

                albumbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.albumbuttons

                artistbuttons =
                    List.concatMap (\obj -> [ FilterButton obj.name False ]) model.artistbuttons
            in
            ( { model | yearbuttons = yearbuttons, directorbuttons = directorbuttons, studiobuttons = studiobuttons, albumbuttons = albumbuttons, artistbuttons = artistbuttons, currentfilter = Default, temp_video_list = sortFilterVideo model.currentButton model.video_list }, Cmd.none )


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
    { title = "Music.Videos"
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
                                    , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.albumbuttons ++ model.artistbuttons ++ model.studiobuttons ++ model.directorbuttons)) == False then
                                        Input.button [ alignRight ]
                                            { onPress = Just (ChangeFilterTabMsg Select)
                                            , label =
                                                Element.html (Filled.add 25 (MITypes.Color <| Colors.darkGreyIcon))
                                            }

                                      else
                                        Element.none
                                    ]
                                , if List.isEmpty (checkFilterButton (model.yearbuttons ++ model.albumbuttons ++ model.artistbuttons ++ model.studiobuttons ++ model.directorbuttons)) == True then
                                    Input.button [ paddingXY 10 10, Background.color (Element.rgba255 168 167 166 1), Font.color Colors.white, mouseOver [ Background.color Colors.navTextHover ] ]
                                        { onPress = Just (ChangeFilterTabMsg Select)
                                        , label = row [ Element.width fill, spacingXY 10 0 ] [ Element.text "Add Filter ", Element.html (Filled.add_circle 15 (MITypes.Color <| Colors.whiteIcon)) ]
                                        }

                                  else
                                    Element.none
                                , closeFilterButton model.yearbuttons ToggleOffYear
                                , closeFilterButton model.directorbuttons ToggleOffDirector
                                , closeFilterButton model.studiobuttons ToggleOffStudio
                                , closeFilterButton model.albumbuttons ToggleOffAlbum
                                , closeFilterButton model.artistbuttons ToggleOffArtist
                                ]
                            , column [ Element.width fill, spacing 15 ]
                                [ Element.text "SORT"
                                , sortButton model.currentButton (Title Asc) "Title " TitleButtonMsg
                                , sortButton model.currentButton (Year Asc) "Year " YearButtonMsg
                                , sortButton model.currentButton (Artist Asc) "Artist " ArtistButtonMsg
                                , sortButton model.currentButton (Album Asc) "Album " AlbumButtonMsg
                                ]
                            ]
                        ]

                Select ->
                    selectFilterView model.yearbuttons model.directorbuttons model.studiobuttons model.albumbuttons model.artistbuttons

                YearFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffYear YearMsg model.yearbuttons

                DirectorFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffDirector DirectorMsg model.directorbuttons

                StudioFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffStudio StudioMsg model.studiobuttons

                AlbumFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffAlbum AlbumMsg model.albumbuttons

                ArtistFilter ->
                    filterView (ChangeFilterTabMsg Select) ToggleOffArtist ArtistMsg model.artistbuttons
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ let
                    all_filter_button =
                        checkFilterButton (model.yearbuttons ++ model.albumbuttons ++ model.artistbuttons ++ model.studiobuttons ++ model.directorbuttons)
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
                        (\video ->
                            Components.SectionHeader.viewVideos (VideoCardButtonMsg video) video
                        )
                        model.temp_video_list
                    )
                ]
            ]
        ]
    }


sortButton : ObjectSort -> ObjectSort -> String -> msg -> Element msg
sortButton currentButton button name buttonMsg =
    let
        isCurrentButton =
            case ( currentButton, button ) of
                ( Title _, Title _ ) ->
                    ( True, Title )

                ( Artist _, Artist _ ) ->
                    ( True, Artist )

                ( Album _, Album _ ) ->
                    ( True, Album )

                ( Year _, Year _ ) ->
                    ( True, Year )

                _ ->
                    ( False, Title )
    in
    Input.button [ paddingXY 10 0 ]
        { onPress = Just buttonMsg
        , label =
            currentButtonText currentButton name isCurrentButton
        }


currentButtonText : ObjectSort -> String -> ( Bool, SortDirection -> ObjectSort ) -> Element msg
currentButtonText currentButton name ( isCurrent, button ) =
    case isCurrent of
        True ->
            if currentButton == button Asc then
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↑") ]

            else
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↓") ]

        False ->
            row [ Font.color Colors.navText ] [ Element.text name ]


selectFilterView : List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> Element Msg
selectFilterView yearbutton directorbutton studiobutton albumbutton artistbutton =
    column [ Element.height fill, Element.width (fillPortion 1), paddingXY 5 30, spacing 10, Font.color Colors.greyscaleGray, Background.color Colors.sidebar ]
        [ Input.button [ paddingXY 10 10 ]
            { onPress = Just (ChangeFilterTabMsg Default)
            , label = row [ Font.size 14 ] [ Element.html (Filled.keyboard_arrow_left 20 (MITypes.Color <| Colors.darkGreyIcon)), Element.text "SELECT A FILTER" ]
            }
        , filterFieldButton (ChangeFilterTabMsg YearFilter) "Year" yearbutton
        , filterFieldButton (ChangeFilterTabMsg DirectorFilter) "Director" directorbutton
        , filterFieldButton (ChangeFilterTabMsg StudioFilter) "Studio" studiobutton
        , filterFieldButton (ChangeFilterTabMsg AlbumFilter) "Album" albumbutton
        , filterFieldButton (ChangeFilterTabMsg ArtistFilter) "Artist" artistbutton
        ]
