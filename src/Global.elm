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

import Browser.Navigation as Nav
import Components
import Document exposing (Document)
import Generated.Route as Route exposing (Route)
import Task
import Url exposing (Url)



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
    , Cmd.none
    )

-- PORTS

port sendAction : String -> Cmd msg
port messageReceiver : (String -> msg) -> Sub msg

-- UPDATE
type Param 
    = Analogfastforward
    | Analogmove
    | Analogmovexleft
    | Analogmovexright
    | Analogmoveydown
    | Analogmoveyup
    | Analogrewind
    | Analogseekback
    | Analogseekforward
    | Aspectratio
    | Audiodelay
    | Audiodelayminus
    | Audiodelayplus
    | Audionextlanguage
    | Audiotoggledigital
    | Back
    | Backspace
    | Bigstepback
    | Bigstepforward
    | Blue
    | Browsesubtitle
    | Channeldown
    | Channelnumberseparator
    | Channelup
    | Chapterorbigstepback
    | Chapterorbigstepforward
    | Close
    | Codecinfo
    | Contextmenu
    | Copy
    | Createbookmark
    | Createepisodebookmark
    | Cursorleft
    | Cursorright
    | Cyclesubtitle
    | Decreasepar
    | Decreaserating
    | Decreasevisrating
    | Delete
    | Doubleclick
    | Down
    | Enter
    | Error
    | Fastforward
    | Filter
    | Filterclear
    | Filtersms2
    | Filtersms3
    | Filtersms4
    | Filtersms5
    | Filtersms6
    | Filtersms7
    | Filtersms8
    | Filtersms9
    | Firstpage
    | Fullscreen
    | Green
    | Guiprofile
    | Highlight
    | Increasepar
    | Increaserating
    | Increasevisrating
    | Info
    | Jumpsms2
    | Jumpsms3
    | Jumpsms4
    | Jumpsms5
    | Jumpsms6
    | Jumpsms7
    | Jumpsms8
    | Jumpsms9
    | Lastpage
    | Left
    | Leftclick
    | Lockpreset
    | Longclick
    | Longpress
    | Menu
    | Middleclick
    | Mousedrag
    | Mousedragend
    | Mousemove
    | Move
    | Moveitemdown
    | Moveitemup
    | Mute
    | Nextcalibration
    | Nextchannelgroup
    | Nextletter
    | Nextpicture
    | Nextpreset
    | Nextresolution
    | Nextscene
    | Nextstereomode
    | Nextsubtitle
    | Noop
    | Number0
    | Number1
    | Number2
    | Number3
    | Number4
    | Number5
    | Number6
    | Number7
    | Number8
    | Number9
    | Osd
    | Pagedown
    | Pageup
    | Pangesture
    | Parentdir
    | Parentfolder
    | Pause
    | Play
    | Playerdebug
    | Playerprocessinfo
    | Playerprogramselect
    | Playerresolutionselect
    | Playlist
    | Playnext
    | Playpause
    | Playpvr
    | Playpvrradio
    | Playpvrtv
    | Previouschannelgroup
    | Previousmenu
    | Previouspicture
    | Previouspreset
    | Previousscene
    | Previousstereomode
    | Prevletter
    | Queue
    | Randompreset
    | Record
    | Red
    | Reloadkeymaps
    | Rename
    | Resetcalibration
    | Rewind
    | Right
    | Rightclick
    | Rotate
    | Rotateccw
    | Rotategesture
    | Scanitem
    | Screenshot
    | Scrolldown
    | Scrollup
    | Select
    | Setrating
    | Settingslevelchange
    | Settingsreset
    | Shift
    | Showpreset
    | Showsubtitles
    | Showtime
    | Showtimerrule
    | Showvideomenu
    | Skipnext
    | Skipprevious
    | Smallstepback
    | Stepback
    | Stepforward
    | Stereomode
    | Stereomodetomono
    | Stop
    | Subtitlealign
    | Subtitledelay
    | Subtitledelayminus
    | Subtitledelayplus
    | Subtitleshiftdown
    | Subtitleshiftup
    | Swipedown
    | Swipeleft
    | Swiperight
    | Swipeup
    | Switchplayer
    | Symbols
    | Tap
    | Togglecommskip
    | Togglefont
    | Togglefullscreen
    | Togglestereomode
    | Togglewatched
    | Up
    | Verticalshiftdown
    | Verticalshiftup
    | Videonextstream
    | Voicerecognizer
    | Volampdown
    | Volampup
    | Volumeamplification
    | Volumedown
    | Volumeup
    | Wheeldown
    | Wheelup
    | Yellow
    | Zoomgesture
    | Zoomin
    | Zoomlevel1
    | Zoomlevel2
    | Zoomlevel3
    | Zoomlevel4
    | Zoomlevel5
    | Zoomlevel6
    | Zoomlevel7
    | Zoomlevel8
    | Zoomlevel9
    | Zoomnormal
    | Zoomout

{- only action should be of method Input.ExecuteAction-}
type alias Action = 
    { method : String
    , params : Param
    , id : Int
    }

type Msg
    = Navigate Route
    | PlayPause

{-todo-}
actionToStr : Action -> String
actionToStr action =
    if action.method != "" then
        " \"method\": \"" ++ action.method

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate route ->
            ( model
            , Nav.pushUrl model.key (Route.toHref route)
            )

        Send action ->
            ( model
            , sendAction (actionToStr action)
            {-"""{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id": 1 }"""-}
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
        , playPauseMsg = toMsg PlayPause
        }



-- COMMANDS


send : msg -> Cmd msg
send =
    Task.succeed >> Task.perform identity


navigate : Route -> Cmd Msg
navigate route =
    send (Navigate route)
