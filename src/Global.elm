port module Global exposing
    ( Flags
    , Model
    , Msg
    , init
    , navigate
    , subscriptions
    , update
    , view
    )

import Action exposing (Method(..), Param(..))
import Browser.Navigation as Nav
import Components
import Document exposing (Document)
import Generated.Route as Route exposing (Route)
import Task
import Url exposing (Url)
import Json.Encode as Encode



-- INIT


type alias Flags =
    ()


type alias Model =
    { flags : Flags
    , url : Url
    , key : Nav.Key
    , rightMenu : Bool
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model
        flags
        url
        key
        False
    , Cmd.none
    )



-- PORTS


port sendAction : String -> Cmd msg


port responseReceiver : (String -> msg) -> Sub msg



-- UPDATE


type Msg
    = Navigate Route
    | Send Method Param Int



{- convert method param int to json action
format ->
    { "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id":0}
 -}
toStr : Method -> Param -> Int -> String
toStr method param int =
    Encode.encode 0
        <| Encode.object
            [ ( "jsonrpc", Encode.string "2.0" )
            , case method of 
                InputExecuteAction -> 
                    ( "method", Encode.string "Input.ExecuteAction" )
            , ( "params"
              , Encode.object
                    [ ("action"
                    , case param of 
                        Analogfastforward ->
                            Encode.string "analogfastforward"
                        Analogmove ->
                            Encode.string "analogmove"
                        Analogmovexleft ->
                            Encode.string "analogmovexleft"
                        Analogmovexright ->
                            Encode.string "analogmovexright"
                        Analogmoveydown ->
                            Encode.string "analogmoveydown"
                        Analogmoveyup ->
                            Encode.string "analogmoveyup"
                        Analogrewind ->
                            Encode.string "analogrewind"
                        Analogseekback ->
                            Encode.string "analogseekback"
                        Analogseekforward ->
                            Encode.string "analogseekforward"
                        Aspectratio ->
                            Encode.string "aspectratio"
                        Audiodelay ->
                            Encode.string "audiodelay"
                        Audiodelayminus ->
                            Encode.string "audiodelayminus"
                        Audiodelayplus ->
                            Encode.string "audiodelayplus"
                        Audionextlanguage ->
                            Encode.string "audionextlanguage"
                        Audiotoggledigital ->
                            Encode.string "audiotoggledigital"
                        Back ->
                            Encode.string "back"
                        Backspace ->
                            Encode.string "backspace"
                        Bigstepback ->
                            Encode.string "bigstepback"
                        Bigstepforward ->
                            Encode.string "bigstepforward"
                        Blue ->
                            Encode.string "blue"
                        Browsesubtitle ->
                            Encode.string "browsesubtitle"
                        Channeldown ->
                            Encode.string "channeldown"
                        Channelnumberseparator ->
                            Encode.string "channelnumberseparator"
                        Channelup ->
                            Encode.string "channelup"
                        Chapterorbigstepback ->
                            Encode.string "chapterorbigstepback"
                        Chapterorbigstepforward ->
                            Encode.string "chapterorbigstepforward"
                        Close ->
                            Encode.string "close"
                        Codecinfo ->
                            Encode.string "codecinfo"
                        Contextmenu ->
                            Encode.string "contextmenu"
                        Copy ->
                            Encode.string "copy"
                        Createbookmark ->
                            Encode.string "createbookmark"
                        Createepisodebookmark ->
                            Encode.string "createepisodebookmark"
                        Cursorleft ->
                            Encode.string "cursorleft"
                        Cursorright ->
                            Encode.string "cursorright"
                        Cyclesubtitle ->
                            Encode.string "cyclesubtitle"
                        Decreasepar ->
                            Encode.string "decreasepar"
                        Decreaserating ->
                            Encode.string "decreaserating"
                        Decreasevisrating ->
                            Encode.string "decreasevisrating"
                        Delete ->
                            Encode.string "delete"
                        Doubleclick ->
                            Encode.string "doubleclick"
                        Down ->
                            Encode.string "down"
                        Enter ->
                            Encode.string "enter"
                        Error ->
                            Encode.string "error"
                        Fastforward ->
                            Encode.string "fastforward"
                        Filter ->
                            Encode.string "filter"
                        Filterclear ->
                            Encode.string "filterclear"
                        Filtersms2 ->
                            Encode.string "filtersms2"
                        Filtersms3 ->
                            Encode.string "filtersms3"
                        Filtersms4 ->
                            Encode.string "filtersms4"
                        Filtersms5 ->
                            Encode.string "filtersms5"
                        Filtersms6 ->
                            Encode.string "filtersms6"
                        Filtersms7 ->
                            Encode.string "filtersms7"
                        Filtersms8 ->
                            Encode.string "filtersms8"
                        Filtersms9 ->
                            Encode.string "filtersms9"
                        Firstpage ->
                            Encode.string "firstpage"
                        Fullscreen ->
                            Encode.string "fullscreen"
                        Green ->
                            Encode.string "green"
                        Guiprofile ->
                            Encode.string "guiprofile"
                        Highlight ->
                            Encode.string "highlight"
                        Increasepar ->
                            Encode.string "increasepar"
                        Increaserating ->
                            Encode.string "increaserating"
                        Increasevisrating ->
                            Encode.string "increasevisrating"
                        Info ->
                            Encode.string "info"
                        Jumpsms2 ->
                            Encode.string "jumpsms2"
                        Jumpsms3 ->
                            Encode.string "jumpsms3"
                        Jumpsms4 ->
                            Encode.string "jumpsms4"
                        Jumpsms5 ->
                            Encode.string "jumpsms5"
                        Jumpsms6 ->
                            Encode.string "jumpsms6"
                        Jumpsms7 ->
                            Encode.string "jumpsms7"
                        Jumpsms8 ->
                            Encode.string "jumpsms8"
                        Jumpsms9 ->
                            Encode.string "jumpsms9"
                        Lastpage ->
                            Encode.string "lastpage"
                        Left ->
                            Encode.string "left"
                        Leftclick ->
                            Encode.string "leftclick"
                        Lockpreset ->
                            Encode.string "lockpreset"
                        Longclick ->
                            Encode.string "longclick"
                        Longpress ->
                            Encode.string "longpress"
                        Menu ->
                            Encode.string "menu"
                        Middleclick ->
                            Encode.string "middleclick"
                        Mousedrag ->
                            Encode.string "mousedrag"
                        Mousedragend ->
                            Encode.string "mousedragend"
                        Mousemove ->
                            Encode.string "mousemove"
                        Move ->
                            Encode.string "move"
                        Moveitemdown ->
                            Encode.string "moveitemdown"
                        Moveitemup ->
                            Encode.string "moveitemup"
                        Mute ->
                            Encode.string "mute"
                        Nextcalibration ->
                            Encode.string "nextcalibration"
                        Nextchannelgroup ->
                            Encode.string "nextchannelgroup"
                        Nextletter ->
                            Encode.string "nextletter"
                        Nextpicture ->
                            Encode.string "nextpicture"
                        Nextpreset ->
                            Encode.string "nextpreset"
                        Nextresolution ->
                            Encode.string "nextresolution"
                        Nextscene ->
                            Encode.string "nextscene"
                        Nextstereomode ->
                            Encode.string "nextstereomode"
                        Nextsubtitle ->
                            Encode.string "nextsubtitle"
                        Noop ->
                            Encode.string "noop"
                        Number0 ->
                            Encode.string "number0"
                        Number1 ->
                            Encode.string "number1"
                        Number2 ->
                            Encode.string "number2"
                        Number3 ->
                            Encode.string "number3"
                        Number4 ->
                            Encode.string "number4"
                        Number5 ->
                            Encode.string "number5"
                        Number6 ->
                            Encode.string "number6"
                        Number7 ->
                            Encode.string "number7"
                        Number8 ->
                            Encode.string "number8"
                        Number9 ->
                            Encode.string "number9"
                        Osd ->
                            Encode.string "osd"
                        Pagedown ->
                            Encode.string "pagedown"
                        Pageup ->
                            Encode.string "pageup"
                        Pangesture ->
                            Encode.string "pangesture"
                        Parentdir ->
                            Encode.string "parentdir"
                        Parentfolder ->
                            Encode.string "parentfolder"
                        Pause ->
                            Encode.string "pause"
                        Play ->
                            Encode.string "play"
                        Playerdebug ->
                            Encode.string "playerdebug"
                        Playerprocessinfo ->
                            Encode.string "playerprocessinfo"
                        Playerprogramselect ->
                            Encode.string "playerprogramselect"
                        Playerresolutionselect ->
                            Encode.string "playerresolutionselect"
                        Playlist ->
                            Encode.string "playlist"
                        Playnext ->
                            Encode.string "playnext"
                        Playpause ->
                            Encode.string "playpause"
                        Playpvr ->
                            Encode.string "playpvr"
                        Playpvrradio ->
                            Encode.string "playpvrradio"
                        Playpvrtv ->
                            Encode.string "playpvrtv"
                        Previouschannelgroup ->
                            Encode.string "previouschannelgroup"
                        Previousmenu ->
                            Encode.string "previousmenu"
                        Previouspicture ->
                            Encode.string "previouspicture"
                        Previouspreset ->
                            Encode.string "previouspreset"
                        Previousscene ->
                            Encode.string "previousscene"
                        Previousstereomode ->
                            Encode.string "previousstereomode"
                        Prevletter ->
                            Encode.string "prevletter"
                        Queue ->
                            Encode.string "queue"
                        Randompreset ->
                            Encode.string "randompreset"
                        Record ->
                            Encode.string "record"
                        Red ->
                            Encode.string "red"
                        Reloadkeymaps ->
                            Encode.string "reloadkeymaps"
                        Rename ->
                            Encode.string "rename"
                        Resetcalibration ->
                            Encode.string "resetcalibration"
                        Rewind ->
                            Encode.string "rewind"
                        Right ->
                            Encode.string "right"
                        Rightclick ->
                            Encode.string "rightclick"
                        Rotate ->
                            Encode.string "rotate"
                        Rotateccw ->
                            Encode.string "rotateccw"
                        Rotategesture ->
                            Encode.string "rotategesture"
                        Scanitem ->
                            Encode.string "scanitem"
                        Screenshot ->
                            Encode.string "screenshot"
                        Scrolldown ->
                            Encode.string "scrolldown"
                        Scrollup ->
                            Encode.string "scrollup"
                        Select ->
                            Encode.string "select"
                        Setrating ->
                            Encode.string "setrating"
                        Settingslevelchange ->
                            Encode.string "settingslevelchange"
                        Settingsreset ->
                            Encode.string "settingsreset"
                        Shift ->
                            Encode.string "shift"
                        Showpreset ->
                            Encode.string "showpreset"
                        Showsubtitles ->
                            Encode.string "showsubtitles"
                        Showtime ->
                            Encode.string "showtime"
                        Showtimerrule ->
                            Encode.string "showtimerrule"
                        Showvideomenu ->
                            Encode.string "showvideomenu"
                        Skipnext ->
                            Encode.string "skipnext"
                        Skipprevious ->
                            Encode.string "skipprevious"
                        Smallstepback ->
                            Encode.string "smallstepback"
                        Stepback ->
                            Encode.string "stepback"
                        Stepforward ->
                            Encode.string "stepforward"
                        Stereomode ->
                            Encode.string "stereomode"
                        Stereomodetomono ->
                            Encode.string "stereomodetomono"
                        Stop ->
                            Encode.string "stop"
                        Subtitlealign ->
                            Encode.string "subtitlealign"
                        Subtitledelay ->
                            Encode.string "subtitledelay"
                        Subtitledelayminus ->
                            Encode.string "subtitledelayminus"
                        Subtitledelayplus ->
                            Encode.string "subtitledelayplus"
                        Subtitleshiftdown ->
                            Encode.string "subtitleshiftdown"
                        Subtitleshiftup ->
                            Encode.string "subtitleshiftup"
                        Swipedown ->
                            Encode.string "swipedown"
                        Swipeleft ->
                            Encode.string "swipeleft"
                        Swiperight ->
                            Encode.string "swiperight"
                        Swipeup ->
                            Encode.string "swipeup"
                        Switchplayer ->
                            Encode.string "switchplayer"
                        Symbols ->
                            Encode.string "symbols"
                        Tap ->
                            Encode.string "tap"
                        Togglecommskip ->
                            Encode.string "togglecommskip"
                        Togglefont ->
                            Encode.string "togglefont"
                        Togglefullscreen ->
                            Encode.string "togglefullscreen"
                        Togglestereomode ->
                            Encode.string "togglestereomode"
                        Togglewatched ->
                            Encode.string "togglewatched"
                        Up ->
                            Encode.string "up"
                        Verticalshiftdown ->
                            Encode.string "verticalshiftdown"
                        Verticalshiftup ->
                            Encode.string "verticalshiftup"
                        Videonextstream ->
                            Encode.string "videonextstream"
                        Voicerecognizer ->
                            Encode.string "voicerecognizer"
                        Volampdown ->
                            Encode.string "volampdown"
                        Volampup ->
                            Encode.string "volampup"
                        Volumeamplification ->
                            Encode.string "volumeamplification"
                        Volumedown ->
                            Encode.string "volumedown"
                        Volumeup ->
                            Encode.string "volumeup"
                        Wheeldown ->
                            Encode.string "wheeldown"
                        Wheelup ->
                            Encode.string "wheelup"
                        Yellow ->
                            Encode.string "yellow"
                        Zoomgesture ->
                            Encode.string "zoomgesture"
                        Zoomin ->
                            Encode.string "zoomin"
                        Zoomlevel1 ->
                            Encode.string "zoomlevel1"
                        Zoomlevel2 ->
                            Encode.string "zoomlevel2"
                        Zoomlevel3 ->
                            Encode.string "zoomlevel3"
                        Zoomlevel4 ->
                            Encode.string "zoomlevel4"
                        Zoomlevel5 ->
                            Encode.string "zoomlevel5"
                        Zoomlevel6 ->
                            Encode.string "zoomlevel6"
                        Zoomlevel7 ->
                            Encode.string "zoomlevel7"
                        Zoomlevel8 ->
                            Encode.string "zoomlevel8"
                        Zoomlevel9 ->
                            Encode.string "zoomlevel9"
                        Zoomnormal ->
                            Encode.string "zoomnormal"
                        Zoomout ->
                            Encode.string "zoomout"
                    )]
              )
            , ( "id", Encode.int 0 )
            ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate route ->
            ( model
            , Nav.pushUrl model.key (Route.toHref route)
            )

        Send method param int ->
            ( model
            , sendAction (toStr method param int)
            )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- VIEW

view :
    { page : Document msg
    , global : Model
    , toMsg : Msg -> msg
    }
    -> Document msg
view { page, global, toMsg } =
    Components.layout
        { page = page
        , playPauseMsg = toMsg (Send InputExecuteAction Playpause 0)
        , skipMsg = toMsg (Send InputExecuteAction Skipnext 0)
        , reverseMsg = toMsg (Send InputExecuteAction Skipprevious 0)
        , muteMsg = toMsg (Send InputExecuteAction Mute 0)
        , repeatMsg = toMsg (Send InputExecuteAction Play 0)
        , shuffleMsg = toMsg (Send InputExecuteAction Play 0)
        }

-- COMMANDS

send : msg -> Cmd msg
send =
    Task.succeed >> Task.perform identity


navigate : Route -> Cmd Msg
navigate route =
    send (Navigate route)
