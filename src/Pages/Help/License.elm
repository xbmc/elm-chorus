module Pages.Help.License exposing (..)

import Colors
import Components.VerticalNavHelp
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (hr, li, ul)
import Html.Attributes exposing (style)
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



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Help.License"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavHelp.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 0 0 0), Font.size 33, paddingEach { top = 15, bottom = 30, left = 0, right = 0 } ] (text "Chorus2 License")
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0), paddingEach { top = 0, bottom = 10, left = 0, right = 0 } ] [ text "This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version." ]
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0), paddingEach { top = 0, bottom = 10, left = 0, right = 0 } ] [ text "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details." ]
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0) ]
                    [ text "You should have received a copy of the GNU General Public License "
                    , link [ Font.color (rgb255 18 178 231) ]
                        { url = "https://github.com/xbmc/chorus2/blob/master/LICENSE"
                        , label = el [ Font.medium, mouseOver [ Font.color Colors.headerBackground ] ] (text "along with this program")
                        }
                    , text "; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA."
                    ]
                , el [ Font.color (rgb255 0 0 0), Font.size 23, paddingEach { top = 45, bottom = 10, left = 0, right = 0 } ] (text "Included Images")
                , paragraph [ paddingEach { top = 0, bottom = 10, left = 0, right = 0 } ] [ html <| hr [ Html.Attributes.style "width" "750px", Html.Attributes.style "margin" "0px", Html.Attributes.style "border" "1px solid #F6F6F6" ] [] ]
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0) ]
                    [ text "All photos used within Chorus are licensed under "
                    , link [ Font.color (rgb255 18 178 231) ]
                        { url = "https://creativecommons.org/publicdomain/zero/1.0/"
                        , label = el [ Font.medium, mouseOver [ Font.color Colors.headerBackground ] ] (text "Creative Commons Zero")
                        }
                    , text " which means you can copy, modify, distribute and use the photos for free. Images have been sourced from:"
                    ]
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0), paddingEach { top = 15, bottom = 0, left = 0, right = 0 } ]
                    [ html <| ul [ Html.Attributes.style "margin" "0", Html.Attributes.style "display" "inline-block" ] [ li [] [] ]
                    , link [ Font.color (rgb255 18 178 231) ]
                        { url = "https://creativecommons.org/publicdomain/zero/1.0/"
                        , label = el [ Font.medium, mouseOver [ Font.color Colors.headerBackground ] ] (text "Unsplash - CC0 License")
                        }
                    ]
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0), paddingEach { top = 15, bottom = 0, left = 0, right = 0 } ]
                    [ html <| ul [ Html.Attributes.style "margin" "0", Html.Attributes.style "display" "inline-block" ] [ li [] [] ]
                    , link [ Font.color (rgb255 18 178 231) ]
                        { url = "https://creativecommons.org/publicdomain/zero/1.0/"
                        , label = el [ Font.medium, mouseOver [ Font.color Colors.headerBackground ] ] (text "Pexels - CC0 License")
                        }
                    ]
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0), paddingEach { top = 15, bottom = 0, left = 0, right = 0 } ]
                    [ text "Other included images and gifs have been hand crafted by "
                    , link [ Font.color (rgb255 18 178 231) ]
                        { url = "http://jez.me/"
                        , label = el [ Font.medium, mouseOver [ Font.color Colors.headerBackground ] ] (text "Jeremy Graham")
                        }
                    ]
                , el [ Font.color (rgb255 0 0 0), Font.size 23, paddingEach { top = 45, bottom = 10, left = 0, right = 0 } ] (text "Included Libraries")
                , paragraph [ paddingEach { top = 0, bottom = 10, left = 0, right = 0 } ] [ html <| hr [ Html.Attributes.style "width" "750px", Html.Attributes.style "margin" "0px", Html.Attributes.style "border" "1px solid #F6F6F6" ] [] ]
                , paragraph [ width (px 780), Font.size 15, Font.color (rgb255 0 0 0), paddingEach { top = 15, bottom = 0, left = 0, right = 0 } ]
                    [ link [ Font.color (rgb255 18 178 231) ]
                        { url = "https://github.com/xbmc/chorus2/tree/master/src/lib"
                        , label = el [ Font.medium, mouseOver [ Font.color Colors.headerBackground ] ] (text "Click here ")
                        }
                    , text "to view the included libraries used by Chorus and their associated licenses."
                    ]
                ]
            ]
        ]
    }
