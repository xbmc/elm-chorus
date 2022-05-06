module Pages.Help.Developers exposing (Model, Msg, Params, page)

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

# Developers information

Do you want to help with making Chorus even better? Find help below...

This page contains information about getting your dev environment up and running so you can build and test 

your changes without the hassle of setting up all the required dependencies.

## Developing elm chorus

To develop elm-chorus, you must have the following:

** For MacOS, Windows, Linux **
- Kodi application
- Chrome/Chromium, Firefox
- Elm
- NPM

### Installing Kodi Application

You can refer to this [guide] in order to install the application and run the following commands:

~~~
sudo apt install software-properties-common

sudo add-apt-repository -y ppa:team-xbmc/ppa

sudo apt install kodi
~~~

** For NPM ** : you can checkout the [official website].

** For Elm ** : you can refer to this[ guide] in order to install Elm.

### Building/Running the Project

Firstly, make sure that you have Kodi application running in the background, then run the following commands:

~~~
git clone https://github.com/xbmc/elm-chorus.git

cd elm-chorus/

npm start
~~~
and point your browser to http://localhost:1234 by default or whatever port Node tells you.

## Committing your changes

As a rule of thumb, you should use elm-format in order to format the Elm files in which you have made the changes and Prettier for JS, CSS, etc. 

before pushing it.

** **

[official website]:https://nodejs.org/en/
[guide]: https://kodi.wiki/view/HOW-TO:Install_Kodi_for_Linux
[ guide]: https://guide.elm-lang.org/install/elm.html
"""



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Help.Developers"
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
