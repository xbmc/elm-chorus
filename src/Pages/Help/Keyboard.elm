module Pages.Help.Keyboard exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNavHelp
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes exposing (class)
import Markdown exposing (..)
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route }, Cmd.none )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Markdown


content : Html msg
content =
    Markdown.toHtml [ class "markdown" ] """

# Key Binds                     

You can use your keyboard to control Kodi, this is the default setting but you can change what the keyboard 

controls on the [settings page]. The available options are:

Kodi
---------
The keyboard controls Kodi and default keyboard interaction with the browser is disabled. (eg. using up and down 

arrows to scroll a page). [Browser command] = [Kodi action].

~~~
Cursor LEFT = Direction LEFT

Cursor RIGHT = Direction RIGHT

Cursor UP = Direction UP

Cursor DOWN = Direction DOWN

BACKSPACE = Back

ENTER = Select

TAB = Close

SPACE BAR = Play/Pause

Key "C" = Context menu

Key "+" = Volume Up

Key "-" = Volume Down

Key "X" = Stop

Key "T" = Toggle subtitles

Key ">" = Play Next

Key "<" = Play Prev

Key "" = Full screen

~~~
[Got improvements to add? click here]

Browser
---------
The keyboard controls the browser only. When the [remote] is open the keys will control only Kodi.

Both
---------
Keyboard commands are executed in Kodi and in the browser. When the [remote] is open the keys will control only 

Kodi. NOTE: Many commands are shared by both the browser and Kodi. Eg. Backspace.

** **       

[remote]: http://localhost:1234/#remote
[settings page]: http://localhost:1234/settings/web
[Got improvements to add? click here]:https://github.com/xbmc/chorus2/blob/master/src/js/apps/input/input_app.js.coffee
"""



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Help.Keyboard"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width (fillPortion 3), scrollbarY ] (Components.VerticalNavHelp.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.white, padding 40 ]
                [ el [ Font.color (rgb255 0 0 0) ] (Element.html content)
                ]
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.greyscaleMercury, padding 40 ] []
            ]
        ]
    }
