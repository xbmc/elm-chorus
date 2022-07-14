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
import Random
import Shared exposing (sendActions)
import SharedType exposing (SortDirection(..))
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


type AlbumSort
    = Title SortDirection
    | DateAdded SortDirection
    | Year SortDirection
    | Artist SortDirection
    | Random SortDirection


type alias Model =
    { album_list : List AlbumObj
    , route : Route
    , currentButton : AlbumSort
    , seed : Random.Seed
    , song_list : List SongObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { album_list = sortByTitleAlbum shared.album_list, route = url.route, currentButton = Title Asc, seed = Random.initialSeed 1453, song_list = shared.song_list }, Cmd.none )



-- UPDATE


type Msg
    = TitleButtonMsg
    | DateButtonMsg
    | YearButtonMsg
    | ArtistButtonMsg
    | RandomButtonMsg
    | AlbumCardButtonMsg AlbumObj


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, album_list = List.reverse model.album_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, album_list = List.reverse model.album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, album_list = sortByTitleAlbum model.album_list }, Cmd.none )

        DateButtonMsg ->
            case model.currentButton of
                DateAdded Asc ->
                    ( { model | currentButton = DateAdded Desc, album_list = List.reverse model.album_list }, Cmd.none )

                DateAdded Desc ->
                    ( { model | currentButton = DateAdded Asc, album_list = List.reverse model.album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = DateAdded Asc, album_list = sortByDateAlbum model.album_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, album_list = List.reverse model.album_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, album_list = List.reverse model.album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, album_list = sortByYearAlbum model.album_list }, Cmd.none )

        ArtistButtonMsg ->
            case model.currentButton of
                Artist Asc ->
                    ( { model | currentButton = Artist Desc, album_list = List.reverse model.album_list }, Cmd.none )

                Artist Desc ->
                    ( { model | currentButton = Artist Asc, album_list = List.reverse model.album_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Artist Asc, album_list = sortByArtistAlbum model.album_list }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.album_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, album_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, album_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, album_list = list, seed = seedoutput }, Cmd.none )

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
            [ column [ Element.height fill, Element.width fill ]
                [ Components.VerticalNavMusic.view model.route
                , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 15 ]
                    [ Element.text "SORT"
                    , sortButton model.currentButton (Title Asc) "Title " TitleButtonMsg
                    , sortButton model.currentButton (Year Asc) "Year " YearButtonMsg
                    , sortButton model.currentButton (DateAdded Asc) "Date Added " DateButtonMsg
                    , sortButton model.currentButton (Artist Asc) "Artist " ArtistButtonMsg
                    , sortButton model.currentButton (Random Asc) "Random " RandomButtonMsg
                    ]
                ]
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ wrappedRow [ Element.height fill, Element.width fill, paddingXY 20 15, spacingXY 10 7 ]
                    (List.map
                        (\album ->
                            Components.SectionHeader.viewAlbums (AlbumCardButtonMsg album) album
                        )
                        model.album_list
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
