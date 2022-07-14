module Pages.Music.Genre.Genre_String exposing (Model, Msg, Params, page)

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
import Helper exposing (durationToString)
import List.Extra exposing (unique)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Request exposing (Property(..))
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentDecode, percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (AlbumObj, ArtistObj, ItemDetails, SongObj)


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
    { genre : String }


type alias Model =
    { genre : String
    , song_list : List SongObj
    , album_list : List AlbumObj
    , artist_string_list : List String
    , artist_list : List ArtistObj
    , route : Route
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { genre = parseGenre (percentDecode params.genre)
      , song_list = List.filter (\song -> List.member params.genre song.genre) shared.song_list
      , album_list = List.filter (\album -> List.member params.genre album.genre) shared.album_list
      , artist_string_list = unique (List.concatMap (\song -> song.artist) (List.filter (\song -> List.member params.genre song.genre) shared.song_list)) --get all artists from songs with the current genre, this is unused, just example code
      , artist_list = List.filter (\artist -> List.member artist.label (unique (List.concatMap (\song -> song.artist) (List.filter (\song -> List.member params.genre song.genre) shared.song_list)))) shared.artist_list
      , route = Route.Top
      }
    , Cmd.none
    )


parseGenre : Maybe String -> String
parseGenre string =
    case string of
        Nothing ->
            "None"

        Just str ->
            str



-- UPDATE


type Msg
    = SetCurrentlyPlaying SongObj
    | AlbumCardButtonMsg AlbumObj
    | ArtistCardButtonMsg ArtistObj


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying song ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next song -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": """ ++ String.fromInt song.songid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        AlbumCardButtonMsg album ->
            let
                songs =
                    List.filter (\song -> song.albumid == album.albumid) model.song_list

                added_songs =
                    List.map (\song -> """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": """ ++ String.fromInt song.songid ++ """}}}""") songs

                output =
                    [ """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}""" ] ++ added_songs ++ [ """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}""" ]
            in
            ( model, sendActions output )

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


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| Colors.greyIcon))
        }


blackMaterialButton : ( Icon msg, msg ) -> Element msg
blackMaterialButton ( icon, action ) =
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| Colors.blackIcon))
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Music.Genre_String"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ Components.VerticalNavMusic.view model.route
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ column [ Element.height fill, Element.width fill, Font.color Colors.greyscaleGray ]
                    [ Components.SectionHeader.view (model.genre ++ " Artists")
                        Nothing
                        False
                        []
                    , wrappedRow [ Element.height fill, Element.width fill, paddingXY 20 20, spacingXY 15 7 ]
                        (List.map
                            (\artist ->
                                Components.SectionHeader.viewArtists (ArtistCardButtonMsg artist) artist
                            )
                            model.artist_list
                        )
                    ]
                , column [ Element.height fill, Element.width fill ]
                    [ Components.SectionHeader.view (model.genre ++ " Albums")
                        Nothing
                        False
                        []
                    , wrappedRow [ Element.height fill, Element.width fill, paddingXY 20 15, spacingXY 10 7 ]
                        (List.map
                            (\album ->
                                Components.SectionHeader.viewAlbums (AlbumCardButtonMsg album) album
                            )
                            model.album_list
                        )
                    ]
                , column [ Element.height fill, Element.width fill, alignBottom ]
                    [ Components.SectionHeader.view (model.genre ++ " Songs")
                        Nothing
                        False
                        []
                    , column [ Element.height fill, Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
                        (List.map
                            (\song ->
                                row [ Element.width fill, paddingXY 5 5, Background.color (rgb 0.2 0.2 0.2), mouseOver [ Background.color (rgb 0.4 0.4 0.4) ], Element.Events.onDoubleClick (SetCurrentlyPlaying song) ]
                                    [ materialButton ( Filled.play_arrow, SetCurrentlyPlaying song )
                                    , materialButton ( Filled.thumb_up, SetCurrentlyPlaying song )
                                    , el [ Font.color Colors.background ] (Element.text song.label)
                                    , row [ alignRight ]
                                        (List.map
                                            (\artist ->
                                                el [ Font.color Colors.background, paddingXY 5 0 ] (Element.text artist)
                                            )
                                            song.artist
                                        )
                                    , el [ alignRight, Font.color Colors.background ] (song.duration |> durationToString |> Element.text)
                                    , materialButton ( Filled.more_horiz, SetCurrentlyPlaying song )
                                    ]
                            )
                            model.song_list
                        )
                    ]
                ]
            ]
        ]
    }
