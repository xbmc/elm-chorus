module Pages.Help.License exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNavHelp
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html, hr, li, ul)
import Html.Attributes exposing (class, style)
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



-- MARKDOWN


content : Html msg
content =
    Markdown.toHtml [ class "markdown" ] """

# Chorus2 License
                    
                    
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public 

License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later
 
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the 

implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public 

License for more details.

You should have received a copy of the GNU General Public License [along with this program;] if not, write to the 

Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

Included Images
---------
All photos used within Chorus are licensed under [Creative Commons Zero] which means you can copy, modify, 

distribute and use the photos for free. Images have been sourced from:
- [Unsplash] - [CC0 License]
- [Pexels] - [ CC0 License]

Other included images and gifs have been hand crafted by [Jeremy Graham]

Included Libraries
---------
[Click here] to view the included libraries used by Chorus and their associated licenses.

[Click here]: https://github.com/xbmc/chorus2/tree/master/src/lib
[Jeremy Graham]: http://jez.me/
[Pexels]: https://www.pexels.com/
[Unsplash]: https://unsplash.com/
[CC0 License]: https://unsplash.com/license
[ CC0 License]: https://www.pexels.com/license/
[Unsplash - CC0 License]: https://unsplash.com/license
[Creative Commons Zero]: https://creativecommons.org/publicdomain/zero/1.0/
[along with this program;]: https://github.com/xbmc/chorus2/blob/master/LICENSE
"""



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Help.License"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width (fillPortion 3), scrollbarY ] (Components.VerticalNavHelp.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.white, padding 40 ]
                [ el [ Font.color (rgb255 0 0 0) ] (Element.html content) ]
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.greyscaleMercury, padding 40 ] []
            ]
        ]
    }
