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
import Shared
import SharedType exposing (SortDirection(..))
import SharedUtil exposing (..)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import WSDecoder exposing (AlbumObj)


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
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { album_list = shared.album_list, route = url.route, currentButton = Title Asc, seed = Random.initialSeed 1453 }, Cmd.none )



-- UPDATE


type Msg
    = TitleButtonMsg
    | DateButtonMsg
    | YearButtonMsg
    | ArtistButtonMsg
    | RandomButtonMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, album_list = sortByTitleAlbum model.album_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, album_list = List.reverse (sortByTitleAlbum model.album_list) }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc }, Cmd.none )

        DateButtonMsg ->
            case model.currentButton of
                DateAdded Asc ->
                    ( { model | currentButton = DateAdded Desc, album_list = sortByDateAlbum model.album_list }, Cmd.none )

                DateAdded Desc ->
                    ( { model | currentButton = DateAdded Asc, album_list = List.reverse (sortByDateAlbum model.album_list) }, Cmd.none )

                _ ->
                    ( { model | currentButton = DateAdded Asc }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, album_list = sortByYearAlbum model.album_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, album_list = List.reverse (sortByYearAlbum model.album_list) }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc }, Cmd.none )

        ArtistButtonMsg ->
            case model.currentButton of
                Artist Asc ->
                    ( { model | currentButton = Artist Desc, album_list = sortByArtistAlbum model.album_list }, Cmd.none )

                Artist Desc ->
                    ( { model | currentButton = Artist Asc, album_list = List.reverse (sortByArtistAlbum model.album_list) }, Cmd.none )

                _ ->
                    ( { model | currentButton = Artist Asc }, Cmd.none )

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
                    ( { model | currentButton = Random Asc }, Cmd.none )


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
                [ Components.SectionHeader.viewAlbums model.album_list
                ]
            ]
        ]
    }


sortButton : AlbumSort -> AlbumSort -> String -> msg -> Element msg
sortButton currentButton button name buttonMsg =
    Input.button [ paddingXY 10 0 ]
        { onPress = Just buttonMsg
        , label =
            case ( currentButton, button ) of
                ( Title _, Title _ ) ->
                    row [ Font.color Colors.navTextHover ]
                        [ Element.text
                            (if currentButton == Title Asc then
                                name ++ "↑"

                             else
                                name ++ "↓"
                            )
                        ]

                ( DateAdded _, DateAdded _ ) ->
                    row [ Font.color Colors.navTextHover ]
                        [ Element.text
                            (if currentButton == DateAdded Asc then
                                name ++ "↑"

                             else
                                name ++ "↓"
                            )
                        ]

                ( Year _, Year _ ) ->
                    row [ Font.color Colors.navTextHover ]
                        [ Element.text
                            (if currentButton == Year Asc then
                                name ++ "↑"

                             else
                                name ++ "↓"
                            )
                        ]

                ( Artist _, Artist _ ) ->
                    row [ Font.color Colors.navTextHover ]
                        [ Element.text
                            (if currentButton == Artist Asc then
                                name ++ "↑"

                             else
                                name ++ "↓"
                            )
                        ]

                ( Random _, Random _ ) ->
                    row [ Font.color Colors.navTextHover ]
                        [ Element.text
                            (if currentButton == Random Asc then
                                name ++ "↑"

                             else
                                name ++ "↓"
                            )
                        ]

                _ ->
                    row [ Font.color Colors.navText ] [ Element.text (name ++ "↑") ]
        }
