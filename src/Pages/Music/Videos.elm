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
import Random
import Shared exposing (sendActions)
import SharedType exposing (SortDirection(..))
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


type VideoSort
    = Title SortDirection
    | Year SortDirection
    | Artist SortDirection
    | Album SortDirection
    | Random SortDirection


type alias Params =
    ()


type alias Model =
    { video_list : List VideoObj
    , route : Route
    , currentButton : VideoSort
    , seed : Random.Seed
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { video_list = sortByTitle shared.video_list, route = url.route, currentButton = Title Asc, seed = Random.initialSeed 1453 }, Cmd.none )



-- UPDATE


type Msg
    = TitleButtonMsg
    | YearButtonMsg
    | ArtistButtonMsg
    | AlbumButtonMsg
    | RandomButtonMsg
    | VideoCardButtonMsg VideoObj


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleButtonMsg ->
            case model.currentButton of
                Title Asc ->
                    ( { model | currentButton = Title Desc, video_list = List.reverse model.video_list }, Cmd.none )

                Title Desc ->
                    ( { model | currentButton = Title Asc, video_list = List.reverse model.video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Title Asc, video_list = sortByTitle model.video_list }, Cmd.none )

        YearButtonMsg ->
            case model.currentButton of
                Year Asc ->
                    ( { model | currentButton = Year Desc, video_list = List.reverse model.video_list }, Cmd.none )

                Year Desc ->
                    ( { model | currentButton = Year Asc, video_list = List.reverse model.video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Year Asc, video_list = sortByYear model.video_list }, Cmd.none )

        ArtistButtonMsg ->
            case model.currentButton of
                Artist Asc ->
                    ( { model | currentButton = Artist Desc, video_list = List.reverse model.video_list }, Cmd.none )

                Artist Desc ->
                    ( { model | currentButton = Artist Asc, video_list = List.reverse model.video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Artist Asc, video_list = sortByArtist model.video_list }, Cmd.none )

        AlbumButtonMsg ->
            case model.currentButton of
                Album Asc ->
                    ( { model | currentButton = Album Desc, video_list = List.reverse model.video_list }, Cmd.none )

                Album Desc ->
                    ( { model | currentButton = Album Asc, video_list = List.reverse model.video_list }, Cmd.none )

                _ ->
                    ( { model | currentButton = Album Asc, video_list = sortByAlbumVideo model.video_list }, Cmd.none )

        RandomButtonMsg ->
            let
                output =
                    sortByRandom model.seed model.video_list

                list =
                    Tuple.first output

                seedoutput =
                    Tuple.second output
            in
            case model.currentButton of
                Random Asc ->
                    ( { model | currentButton = Random Desc, video_list = list, seed = seedoutput }, Cmd.none )

                Random Desc ->
                    ( { model | currentButton = Random Asc, video_list = list, seed = seedoutput }, Cmd.none )

                _ ->
                    ( { model | currentButton = Random Asc, video_list = list, seed = seedoutput }, Cmd.none )

        VideoCardButtonMsg video ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next video -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"musicvideoid": """ ++ String.fromInt video.videoid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )


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
            [ column [ Element.height fill, Element.width fill ]
                [ Components.VerticalNavMusic.view model.route
                , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 15 ]
                    [ Element.text "SORT"
                    , sortButton model.currentButton (Title Asc) "Title " TitleButtonMsg
                    , sortButton model.currentButton (Year Asc) "Year " YearButtonMsg
                    , sortButton model.currentButton (Artist Asc) "Artist " ArtistButtonMsg
                    , sortButton model.currentButton (Album Asc) "Album " AlbumButtonMsg
                    ]
                ]
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ wrappedRow [ Element.height fill, Element.width fill, paddingXY 20 15, spacingXY 10 7 ]
                    (List.map
                        (\video ->
                            Components.SectionHeader.viewVideos (VideoCardButtonMsg video) video
                        )
                        model.video_list
                    )
                ]
            ]
        ]
    }


sortButton : VideoSort -> VideoSort -> String -> msg -> Element msg
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


currentButtonText : VideoSort -> String -> ( Bool, SortDirection -> VideoSort ) -> Element msg
currentButtonText currentButton name ( isCurrent, button ) =
    case isCurrent of
        True ->
            if currentButton == button Asc then
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↑") ]

            else
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↓") ]

        False ->
            row [ Font.color Colors.navText ] [ Element.text name ]
