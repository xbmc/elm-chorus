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
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
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
    , artist_list : List ArtistObj
    , route : Route
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { genre = parseGenre (percentDecode params.genre)
      , song_list = List.filter (\song -> List.member params.genre song.genre) shared.song_list
      , album_list = List.filter (\album -> List.member params.genre album.genre) shared.album_list
      , artist_list = List.filter (\artist -> List.member params.genre artist.genre) shared.artist_list
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
    | DoNothing


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

        DoNothing ->
            ( model, Cmd.none )


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
                    , wrappedRow [ Element.height fill, Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
                        (List.map
                            (\artist ->
                                column [ paddingXY 5 5, Background.color (rgb 1 1 1), mouseOver [ Background.color Colors.sidebar ], Element.height (fill |> maximum 170), Element.width (fill |> maximum 280), Border.rounded 3, clipX ]
                                    [ image [ alignTop, width fill, height fill ]
                                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode artist.thumbnail ] []
                                        , description = "Thumbnail"
                                        }
                                    , Element.link [ alignBottom, Element.width fill, Element.height fill, paddingXY 7 16, Font.center, Font.color Colors.black ]
                                        { url = Route.toString (Route.Music__Artist__Artistid_Int { artistid = artist.artistid })
                                        , label = Element.text artist.label
                                        }
                                    ]
                            )
                            model.artist_list
                        )
                    ]
                , column [ Element.height fill, Element.width fill ]
                    [ Components.SectionHeader.view (model.genre ++ " Albums")
                        Nothing
                        False
                        []
                    , wrappedRow [ Element.height fill, Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
                        (List.map
                            (\album ->
                                column [ paddingXY 5 5, Background.color (rgb 1 1 1), mouseOver [ Background.color Colors.sidebar ], Element.height (fill |> maximum 220), Element.width (fill |> maximum 160), Border.rounded 3, clipX ]
                                    [ image [ alignTop, width fill, height fill ]
                                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
                                        , description = "Thumbnail"
                                        }
                                    , Element.link [ alignBottom, Element.width fill, Element.height fill, paddingXY 7 16, Font.center, Font.color Colors.black ]
                                        { url = Route.toString (Route.Music__Album__Albumid_Int { albumid = album.albumid })
                                        , label =
                                            column []
                                                [ Element.text album.label
                                                , wrappedRow []
                                                    (List.map
                                                        (\artist ->
                                                            Element.text artist
                                                        )
                                                        album.artist
                                                    )
                                                ]
                                        }
                                    ]
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
