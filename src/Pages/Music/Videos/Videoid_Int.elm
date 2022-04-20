module Pages.Music.Videos.Videoid_Int exposing (Model, Msg, Params, page)

import Element exposing (..)
import Shared exposing (sendActions)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import WSDecoder exposing (AlbumObj, ArtistObj, SongObj, VideoObj)


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
    { videoid : Int }


type alias Model =
    { artist_list : List ArtistObj
    , videoid : Int
    , video : Maybe VideoObj
    , album_list : List AlbumObj
    , video_list : List VideoObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { videoid = params.videoid
      , video = getVideos params.videoid shared.video_list
      , album_list = shared.album_list
      , artist_list = shared.artist_list
      , video_list = shared.video_list
      }
    , Cmd.none
    )


getVideos : Int -> List VideoObj -> Maybe VideoObj
getVideos id videolist =
    List.head (List.filter (\video -> id == video.videoid) videolist)



-- UPDATE


type Msg
    = SetCurrentlyPlaying VideoObj


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying video ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next video -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"videoid": """ ++ String.fromInt video.videoid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )


save : Model -> Shared.Model -> Shared.Model
save _ shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load _ model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Document Msg
view _ =
    { title = "Music.Videos.Videoid_Int"
    , body =
        []
    }
