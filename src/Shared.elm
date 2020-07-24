port module Shared exposing
    ( Flags
    , Model
    , Msg
    , init
    , sendAction
    , sendActions
    , subscriptions
    , update
    , view
    , decodeWS
    , responseReceiver
    )

--modules

import Browser.Navigation exposing (Key, pushUrl)
import Components
import Element exposing (..)
import Json.Decode as D
import Method exposing (Method(..))
import Request exposing (Params, Property(..), request)
import SingleSlider exposing (SingleSlider)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Url exposing (Url)
import WSDecoder exposing (Item, ItemDetails, PType(..), ParamsResponse, PlayerObj(..), ResultResponse(..), SongObj, paramsResponseDecoder, resultResponseDecoder)



-- INIT


type alias Flags =
    ()


type alias Model =
    { flags : Flags
    , url : Url
    , key : Key
    , rightSidebarExtended : Bool
    , controlMenu : Bool
    , players : List PlayerObj
    , currentlyPlaying : ItemDetails
    , song_list : List SongObj
    , volumeSlider : SingleSlider Msg
    , progressSlider : SingleSlider Msg
    }


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( { flags = flags
      , url = url
      , key = key
      , rightSidebarExtended = False
      , controlMenu = False
      , players = []
      , currentlyPlaying = ItemDetails "" 0 ""
      , song_list = []
      , volumeSlider =
            SingleSlider.init
                { min = 0
                , max = 100
                , value = 50
                , step = 1
                , onChange = VolumeSliderChange
                }
      , progressSlider =
            SingleSlider.init
                { min = 0
                , max = 100
                , value = 50
                , step = 1
                , onChange = ProgressSliderChange
                }
      }
    , Cmd.none
    )



-- PORTS


port sendActions : List String -> Cmd msg

--single cmd
sendAction json =
    sendActions [json]

port responseReceiver : (String -> msg) -> Sub msg



-- UPDATE


type Msg
    = Navigate Route
    | Request Method (Maybe Params)
    | Recv String
    | PlayPause
    | ReceiveParamsResponse ParamsResponse
    | ReceiveResultResponse ResultResponse
    | ToggleRightSidebar
    | ToggleControlMenu
    | SendTextToKodi
    | ScanVideoLibrary
    | ScanMusicLibrary
    | VolumeSliderChange Float
    | ProgressSliderChange Float


songname : SongObj -> String
songname song =
    song.label


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate route ->
            ( model
            , pushUrl model.key (Route.toString route)
            )

        Request method params ->
            case params of
                Nothing ->
                    ( model
                    , sendAction (request method Nothing)
                    )

                Just param ->
                    ( model
                    , sendAction (request method (Just { playerid = param.playerid, songid = Nothing, properties = param.properties }))
                    )

        Recv _ ->
            ( model
            , Cmd.none
            )

        PlayPause ->
            ( model
            , sendAction """{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id": 1 }"""
            )

        ReceiveParamsResponse _ ->
            ( model
            , sendAction """{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "duration", "thumbnail"], "playerid": 0 }, "id": "AudioGetItem"}"""
            )

        ReceiveResultResponse result ->
            case result of
                ResultA _ ->
                    ( model
                    , Cmd.none
                    )

                ResultB playerObjects ->
                    ( { model | players = playerObjects }
                      --chain messages, once we get players we gotta see what's playing
                      --{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "album", "artist", "duration", "thumbnail", "file", "fanart", "streamdetails"], "playerid": 0 }, "id": "AudioGetItem"}
                    , sendAction
                        (request Player_GetItem
                            (Just
                                { playerid = Just 0
                                , songid = Nothing
                                , properties = Just [ Title, Album, Artist, Duration, Thumbnail ]
                                }
                            )
                        )
                      -- Player.getproperties percentage
                    )

                ResultC item ->
                    ( { model | currentlyPlaying = item }
                    , Cmd.none
                    )

                ResultD songlist ->
                    ( { model | song_list = songlist }, Cmd.none )
                    
                ResultE artistlist ->
                  ( model
                  , Cmd.none
                  )
                ResultF albumlist ->
                  ( model
                  , Cmd.none
                  )
                ResultG movielist ->
                  ( model
                  , Cmd.none
                  )

        ToggleRightSidebar ->
            ( { model | rightSidebarExtended = not model.rightSidebarExtended }
            , Cmd.none
            )

        ToggleControlMenu ->
            ( { model | controlMenu = not model.controlMenu }
            , Cmd.none
            )

        SendTextToKodi ->
            ( model, Cmd.none )

        ScanVideoLibrary ->
            -- todo
            ( model, sendAction """""" )

        ScanMusicLibrary ->
            -- todo
            ( model, sendAction """""" )

        VolumeSliderChange newValue ->
            let
                newSlider =
                    SingleSlider.update newValue model.volumeSlider
            in
            ( { model | volumeSlider = newSlider }, Cmd.none )

        ProgressSliderChange newValue ->
            let
                newSlider =
                    SingleSlider.update newValue model.progressSlider
            in
            ( { model | progressSlider = newSlider }, Cmd.none )



-- SUBSCRIPTIONS


decodeWS message =
    case D.decodeString paramsResponseDecoder message of
        Ok paramsMessage ->
            ReceiveParamsResponse paramsMessage

        Err _ ->
            case D.decodeString resultResponseDecoder message of
                Ok resultMessage ->
                    ReceiveResultResponse resultMessage

                Err _ ->
                    Recv message


subscriptions : Model -> Sub Msg
subscriptions _ =
    responseReceiver decodeWS



-- VIEW


view :
    { page : Document msg, toMsg : Msg -> msg }
    -> Model
    -> Document msg
view { page, toMsg } model =
    Components.layout
        { page = page
        , controlMenu =
            { controlMenu = model.controlMenu
            , controlMenuMsg = toMsg ToggleControlMenu
            , sendTextToKodiMsg = toMsg SendTextToKodi
            , scanMusicLibraryMsg = toMsg ScanMusicLibrary
            , scanVideoLibraryMsg = toMsg ScanMusicLibrary
            }
        , playerControl =
            { playPauseMsg = toMsg PlayPause
            , skipMsg = toMsg (Request Player_PlayPause Nothing) -- todo
            , reverseMsg = toMsg (Request Player_PlayPause (Just (Params (Just 0) Nothing Nothing))) -- todo
            }
        , currentlyPlaying =
            { currentlyPlaying = model.currentlyPlaying
            , progressSlider = Element.map toMsg (slider model.progressSlider)
            }
        , volumeAndControls =
            { muteMsg = toMsg (Request Application_SetMute (Just (Params (Just 0) Nothing Nothing)))
            , repeatMsg = toMsg (Request Player_SetRepeat (Just (Params (Just 0) Nothing Nothing)))
            , shuffleMsg = toMsg (Request Player_SetShuffle (Just (Params (Just 0) Nothing Nothing)))
            , volumeSlider = Element.map toMsg (slider model.volumeSlider)
            }
        , rightSidebarExtended = model.rightSidebarExtended
        , rightSidebarMsg = toMsg ToggleRightSidebar
        }


slider : SingleSlider msg -> Element msg
slider singleSliderMsg =
    SingleSlider.view singleSliderMsg |> Element.html
