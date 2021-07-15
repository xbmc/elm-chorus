module Pages.Music.Album.Albumid_Int exposing (Model, Msg, Params, page)

import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
import Element.Input as Input
import Helper exposing (durationToString)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Shared exposing (sendActions)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
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
    { albumid : Int }


type alias Model =
    { albumid : Int
    , album : Maybe AlbumObj
    , song_list : List SongObj
    
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { albumid = params.albumid ,album = getAlbum params.albumid shared.album_list, song_list = List.filter (\song -> song.albumid == params.albumid) shared.song_list }, Cmd.none )


checkAlbumId : Int -> AlbumObj -> Bool
checkAlbumId firstId album =
    if firstId == album.albumid then
        True

    else
        False


getAlbum : Int -> List AlbumObj -> Maybe AlbumObj
getAlbum id albumlist =
    List.head (List.filter (\album -> checkAlbumId id album) albumlist)


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| Colors.greyIcon))
        }



-- UPDATE


type Msg
    = SetCurrentlyPlaying SongObj


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
    { title = "Music.Album.Albumid_Int"
    , body =
        [ case model.album of
            Nothing ->
                column [ Element.height fill, Element.width fill ]
                    [ Element.text (String.fromInt model.albumid)
                    
                    ]

            Just album ->
                column [ Element.height fill, Element.width fill ]
                    [ row [ Element.height (fillPortion 1), Element.width fill, Background.color Colors.navHeaderBackground ]
                        [ image [ Element.height (fill |> maximum 240), Element.width (fillPortion 1 |> maximum 240) ]
                            { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
                            , description = "Thumbnail"
                            }
                        , column [ alignTop, Element.height fill, Element.width (fillPortion 7) ]
                            [ Element.text album.label
                            , row []
                                [ Element.text "Artist(s): "
                                , row []
                                    (List.map
                                        (\artist ->
                                            Element.text artist
                                        )
                                        album.artist
                                    )
                                ]
                            , row []
                                [ Element.text "Genre: "
                                , row []
                                    (List.map
                                        (\genre ->
                                            Element.text genre
                                        )
                                        album.genre
                                    )
                                ]
                            ]
                        ]
                    , column [ Element.height (fillPortion 5), Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
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
    }
