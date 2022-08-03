module Pages.Music.Genre.Genre_String exposing (Model, Msg, Params, page)

import Colors exposing (cardHover, darkGreyIcon)
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
import Html exposing (..)
import Html.Attributes exposing (..)
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


materialButtonRight : ( Icon msg, msg ) -> Element msg
materialButtonRight ( icon, action ) =
    Input.button [ paddingXY 5 0 ]
        { onPress = Just action
        , label = Element.html (icon 18 (MITypes.Color <| darkGreyIcon))
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
                                el [ Element.width fill, paddingEach { left = 10, top = 0, right = 60, bottom = 0 } ]
                                    (row [ Element.width fill, paddingXY 5 5, Background.color Colors.background, mouseOver [ Background.color (rgba 223 223 223 0.5) ], Font.size 13, Element.Events.onDoubleClick (SetCurrentlyPlaying song), Element.htmlAttribute (Html.Attributes.class "song-card-parent"), htmlAttribute <| Html.Attributes.style "border-bottom" "1px solid rgb(216 ,216 ,216 ,1)" ]
                                        [ column [ paddingEach { left = 0, top = 0, right = 500, bottom = 0 }, Element.width (px 600) ]
                                            [ row [ spacing 10 ]
                                                [ case song.thumbnail of
                                                    "" ->
                                                        image [ Element.width (px 35), Element.height (px 35) ]
                                                            { src = "https://via.placeholder.com/170x170"
                                                            , description = "Hero Image"
                                                            }

                                                    _ ->
                                                        image [ Element.width (px 35), Element.height (px 35) ]
                                                            { src = crossOrigin "http://localhost:8080" [ "image", percentEncode song.thumbnail ] []
                                                            , description = "Thumbnail"
                                                            }
                                                , el [ Font.color (Element.rgba255 43 47 48 0.5) ] (Element.text (String.fromInt song.track))
                                                , el [ Font.color Colors.black ] (Element.text song.label)
                                                ]
                                            , el [ Element.htmlAttribute (Html.Attributes.class "song-play"), Background.color cardHover, Element.width (px 35), Element.height (px 35) ] (materialButton ( Filled.play_arrow, SetCurrentlyPlaying song ))
                                            ]
                                        , column [ Element.width (px 300) ]
                                            [ row []
                                                (List.map
                                                    (\album ->
                                                        el [ Font.color (Element.rgba255 43 47 48 0.5), paddingXY 5 0 ] (Element.text album.label)
                                                    )
                                                    (List.filter (\album -> song.albumid == album.albumid) model.album_list)
                                                )
                                            ]
                                        , column [ alignRight, Element.width (px 300) ]
                                            [ row [ alignRight ]
                                                [ row [ Element.width (px 300), alignLeft ]
                                                    (List.map
                                                        (\artist ->
                                                            el [ Font.color (Element.rgba255 43 47 48 0.5), paddingXY 5 0 ] (Element.text artist)
                                                        )
                                                        song.artist
                                                    )
                                                , el [ alignRight, Font.color (Element.rgba255 43 47 48 0.5), Element.htmlAttribute (Html.Attributes.class "hide-onhover") ] (song.duration |> durationToString |> Element.text)
                                                ]
                                            , row [ alignRight, Background.color (rgba 223 223 223 0.4), Element.htmlAttribute (Html.Attributes.class "song-icons") ] [ materialButtonRight ( Filled.thumb_up, SetCurrentlyPlaying song ), materialButtonRight ( Filled.add_box, SetCurrentlyPlaying song ), materialButtonRight ( Filled.more_horiz, SetCurrentlyPlaying song ) ]
                                            ]
                                        ]
                                    )
                            )
                            model.song_list
                        )
                    ]
                ]
            ]
        ]
    }
