module Pages.Help.Readme exposing (Model, Msg, Params, page)

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

# Kodi Web Interface - Elm Chorus

The default Web Interface for Kodi.

A great modern Web UI for Kodi. Browse your Music, Movies or TV Shows from the comfort of your own web 

browser. You can play media via Kodi or stream it in your browser. Works best with Chrome but plays well with 

most modern browsers.

Successor to [Chorus2]. A complete rebuild using Elm.

##  Author

[Alex Ionkov] with help from [these kind people].

## Current state
In Elm-Chorus, the basic layout and functionality from Chorus 2 has already been implemented but it still lacks some features,

styling and layout pages. Still considered in-development project, expect bugs, changes, nuclear war,etc.

## Feature requests / Bugs

Add them to the list. For bugs please include Kodi version, Web browser version, Chorus version and any errors 

that display in the console. For feature requests, checkout the API browser to see if your request is currently 

possible.

## Streaming

Disclaimer: The success of this depends on the file formats vs what the browser supports. In general most things 

work.

### Audio streaming

In the top right there are some tabs, two of them are named Kodi and Local, this is how you toggle what player 

the UI is controlling. In Local mode the logo and accents are pinky-red, In Kodi mode the logo is the Kodi blue. 

When you are in a given mode, actions affect that player, so if you click Play on a track when in Local mode, it will 

play through the browser, likewise, when in Kodi mode all commands are sent to Kodi. You can also add media to 

other playlists by clicking the menu buttons (three dots vertical) on most media items.

### Video streaming

Video streaming via HTML5 "sort of" works, it really depends on the codec used. An embedded VLC player is also 

available with better codec support. This looks like the best we can get until Kodi supports transcoding. **Chrome** 

**users: ** Chrome has removed support for vlc/divx plugins so streaming a video requires a [Chrome friendly codec]. 

For best results use Chrome with mp4 video that has 2 channel audio (5.1 audio doesn't seem to work).

## Kodi settings via the web interface

You can change most of the settings you would find in Kodi via the settings page in the web interface. Some 

settings have been omitted as they require interaction with the GUI and others are just a basic text field with no 

options.

## Contributing

If you would like to make this project better I would appreciate any help. You can do pull requests against the 

main branch. See the [developers] section for information about getting a dev environment up and running the project.

### Translations

At the moment, there are a handful of languages available but more can be easily added. More strings are always being

added so always consider english as the source of truth. So if you see something in english but want it in your language, 

I need you! To contribute, send us a Pull request or if you don't know git, a link to the language file.

_English is the only real complete translation file so start with that as your base_.

## Donate

Are you a fan of Chorus? You can buy Alex a beer to say thanks :)

## License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License 

as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later 

version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the 

implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public 

License for more details.

You should have received a copy of the GNU General Public License [along with this program]; if not, write to the 

Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

[Click here for more information] .

[Click here for more information]: https://github.com/xbmc/chorus2/blob/master/src/lang/en/license.md
[along with this program]: https://github.com/xbmc/chorus2/blob/master/LICENSE
[developers]: http://localhost:1234/help/developers
[Chrome friendly codec]: https://en.wikipedia.org/wiki/HTML5_video#Browser_support
[Alex Ionkov]: https://ionkov.com/
[these kind people]: https://github.com/xbmc/elm-chorus/graphs/contributors
[Chorus2]: https://github.com/xbmc/chorus2
"""



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Help.Readme"
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
