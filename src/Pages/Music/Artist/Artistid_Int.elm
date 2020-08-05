module Pages.Music.Artist.Artistid_Int exposing (Params, Model, Msg, page)

import Shared exposing (sendActions)
import Colors
import Components.SectionHeader
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
import Element.Input as Input
import WSDecoder exposing (ArtistObj, SongObj, AlbumObj)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Helper exposing (durationToString)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)

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
    { artistid : Int }


type alias Model =
    { artistid : Int
    , artist : Maybe ArtistObj
    , album_list : List AlbumObj
    , song_list : List SongObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { artistid = params.artistid
    , artist = getArtist params.artistid shared.artist_list
    , album_list = shared.album_list
    , song_list = shared.song_list }, Cmd.none )

checkArtistId : Int -> ArtistObj -> Bool
checkArtistId firstId artist =
    if firstId == artist.artistid then
        True
    else 
        False

getArtist : Int -> List ArtistObj -> Maybe ArtistObj
getArtist id artistlist =
    List.head (List.filter(\artist -> checkArtistId id artist) artistlist)

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
    { title = "Music.Artist.Artistid_Int"
    , body = [ case model.artist of
                    Nothing ->
                        column [Element.height fill, Element.width fill ]
                            [ Element.text (String.fromInt model.artistid) 
                            ]
                    Just artist ->
                        column [Element.height fill, Element.width fill]
                            [ row [Element.height (fillPortion 1), Element.width fill, Background.color Colors.navHeaderBackground ]
                                [ image [Element.height (fill |> maximum 240), Element.width (fillPortion 1 |> maximum 240)]
                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode artist.thumbnail ] []
                                    , description = "Thumbnail"
                                    }
                                , column [ alignTop, Element.height fill, Element.width (fillPortion 7) ]
                                    [ Element.text (artist.label)
                                    , row []
                                        [ Element.text ("Buttons")
                                        ]
                                    ]
                                ]
                            , case model.artist of
                                Nothing ->
                                    el [] (Element.text "")
                                Just art ->
                                    Components.SectionHeader.viewAlbumSongs (List.filter (\album -> List.member art.label album.artist) model.album_list) model.song_list
                            ]
                        ]
    }