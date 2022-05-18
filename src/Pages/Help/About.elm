module Pages.Help.About exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNavHelp
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (..)
import Html.Attributes exposing (class)
import Markdown exposing (..)
import Shared
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import VersionConstants exposing (chorusVersion, kodiVersion, localAudio)
import WSDecoder exposing (Connection(..))


page : Page Params Model Msg
page =
    Page.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , save = save
        , load = load
        }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | connect = shared.connection }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared
        | album_list = shared.album_list
        , artist_list = shared.artist_list
        , connection = shared.connection
        , controlMenu = shared.controlMenu
        , currentlyPlaying = shared.currentlyPlaying
        , flags = shared.flags
        , genre_list = shared.genre_list
        , key = shared.key
        , movie_list = shared.movie_list
        , players = shared.players
        , playing = shared.playing
        , progressSlider = shared.progressSlider
        , rightSidebarExtended = shared.rightSidebarExtended
        , searchString = shared.searchString
        , song_list = shared.song_list
        , source_list = []
        , tvshow_list = shared.tvshow_list
        , url = shared.url
        , volumeSlider = shared.volumeSlider
        , windowHeight = shared.windowHeight
        , windowWidth = shared.windowWidth
    }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route
    , connect : Connection
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { route = url.route
      , connect = shared.connection
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- MARKDOWN


contentUnderStatus : Html msg
contentUnderStatus =
    Markdown.toHtml [ class "markdown" ] """

Status Report
------------
"""


content : Html msg
content =
    Markdown.toHtml [ class "markdown" ] """




What is Chorus?
---------
Chorus is a web interface for controlling and interacting with [Kodi]. It is hosted by your Kodi installation so 

anything that can run Kodi should have no problems with Chorus.

With a web interface you could potentially be controlling a Kodi player from the other side of the world. But more 

likely, you will be controlling a local Kodi player in your home or office.

### Who made it possible?

* Kodi, and the thousands of awesome people who contribute to it. If you [love it, support it].

* These [wonderful people] who gave a helping hand.

* All the great tools available, which are really too many to list, but if you have anything to do with the contents 

  of [this folder] then cheers!

* The amazing photographers who have submitted their images to [unsplash] and [pexels] with a CC0 license.

Bugs and Features
---------
### Is something broken?
It happens, it could also be a "Cool idea"? Chorus is a complex app and Kodi is way more complex. For Chorus 

issues you can [create an issue] on Github. It is important that you provide as much information as possible. 

Great things to include are:

* Information from "Status report" on this page.
* Any errors that show up in the console of your browser.
* Detailed description including steps to replicate and screen shots if applicable.
* **And if you are an amazing person** a patch in a pull request to fix it :)

### Cool ideas
Got neat addition or a feature wish list for Chorus? You can add them to the [Github] page or even better, send 

through a pull request.

Tell me more
---------
View the [readme] for an overview, the [changelog] lists notable changes between versions or maybe you can help 

with [translations].


[Kodi]: https://kodi.tv/
[love it, support it]: http://kodi.tv/contribute/
[wonderful people]: https://github.com/xbmc/elm-chorus/graphs/contributors
[this folder]: https://github.com/xbmc/elm-chorus/tree/main/src
[pexels]: https://www.pexels.com/
[unsplash]: https://unsplash.com/
[Github]: https://github.com/xbmc/elm-chorus/issues
[create an issue]: https://github.com/xbmc/elm-chorus/issues
[readme]: http://localhost:1234/help/readme
[changelog]: http://localhost:1234/help/changelog
[translations]: http://localhost:1234/help/changelog
"""



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Help.About"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width (fillPortion 3), scrollbarY ] (Components.VerticalNavHelp.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.white, padding 40 ]
                [ el
                    [ Font.color (rgb255 0 0 0)
                    , Font.size 40
                    , Font.family
                        [ Font.typeface "Open Sans"
                        , Font.sansSerif
                        ]
                    ]
                    (Element.text "About Chorus")
                , Element.row [ padding 10, spacing 7 ]
                    [ Element.el [] none
                    , Element.el [] none
                    ]
                , el
                    [ Font.color (rgb255 0 0 0) ]
                    (Element.html contentUnderStatus)
                , Element.row [ padding 10, spacing 7 ]
                    [ Element.el [] none
                    , viewStatus model.connect
                    ]
                , el
                    [ Font.color (rgb255 0 0 0) ]
                    (Element.html content)
                ]
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.greyscaleMercury, padding 40 ] []
            ]
        ]
    }


viewStatus : Connection -> Element Msg
viewStatus connection =
    column [ Element.height fill, Element.width fill ]
        [ row [ Element.height fill, Element.width (fillPortion 6), spacing 87 ]
            [ el
                [ Font.color (rgb255 0 0 0)
                , Font.bold
                , Font.size 15
                , Font.family
                    [ Font.typeface "Open Sans"
                    , Font.sansSerif
                    ]
                ]
                (Element.text "Chorus version")
            , el
                [ Font.color (rgb255 0 0 0)
                ]
                (Element.text chorusVersion)
            ]
        , Element.row [ padding 10, spacing 7 ]
            [ Element.el [] none
            , Element.el [] none
            ]
        , row [ Element.height fill, Element.width fill, spacing 106 ]
            [ el
                [ Font.color (rgb255 0 0 0)
                , Font.extraBold
                , Font.size 15
                , Font.family
                    [ Font.typeface "Open Sans"
                    , Font.sansSerif
                    ]
                ]
                (Element.text "Kodi version")
            , el
                [ Font.color (rgb255 0 0 0)
                ]
                (Element.text kodiVersion)
            ]
        , Element.row [ padding 10, spacing 7 ]
            [ Element.el [] none
            , Element.el [] none
            ]
        , row [ Element.height fill, Element.width fill, spacing 85 ]
            [ el
                [ Font.color (rgb255 0 0 0)
                , Font.extraBold
                , Font.size 15
                , Font.family
                    [ Font.typeface "Open Sans"
                    , Font.sansSerif
                    ]
                ]
                (Element.text "Remote Control")
            , el
                [ Font.color (rgb255 0 0 0)
                ]
                (case connection of
                    Connected ->
                        Element.text "Remote control is set up correctly"

                    Disconnected ->
                        Element.text "You need to 'Allow remote control' for Kodi. You can do that"

                    NotAsked ->
                        Element.text "Remote control access not asked"
                )
            ]
        , Element.row [ padding 10, spacing 7 ]
            [ Element.el [] none
            , Element.el [] none
            ]
        , row [ Element.height fill, Element.width fill, spacing 115 ]
            [ el
                [ Font.color (rgb255 0 0 0)
                , Font.extraBold
                , Font.size 15
                , Font.family
                    [ Font.typeface "Open Sans"
                    , Font.sansSerif
                    ]
                ]
                (Element.text "Local Audio")
            , el
                [ Font.color (rgb255 0 0 0)
                ]
                (Element.text localAudio)
            ]
        ]
