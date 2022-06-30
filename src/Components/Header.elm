module Components.Header exposing (headerHeight, view)

import Colors
import Components.LayoutType exposing (ShowRightSidebarMenu)
import Element exposing (Element, alignRight, fill, height, htmlAttribute, image, paddingXY, px, row, text, width)
import Element.Background as Background
import Element.Input as Input
import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import Icons exposing (..)
import SharedType exposing (..)
import Spa.Generated.Route as Route


headerHeight : Int
headerHeight =
    50


redLogoSvg : Html msg
redLogoSvg =
    div [ style "width" "25px", style "height" "25px", class "scale" ]
        [ ceriseRedLogo [] ]


blueLogoSvg : Html msg
blueLogoSvg =
    div [ style "width" "25px", style "height" "25px", class "scale" ]
        [ logo [] ]


view : ShowRightSidebarMenu msg -> (String -> msg) -> Element msg
view { tabSwitch } searchChanged =
    row
        [ width fill
        , height (px headerHeight)
        , case tabSwitch of
            Kodi _ ->
                Background.color Colors.headerBackground

            Local ->
                Background.color Colors.greyscaleShark
        , htmlAttribute <| Html.Attributes.style "pointer-events" "all"
        ]
        [ Element.link [ paddingXY 10 0 ]
            { label =
                case tabSwitch of
                    Kodi _ ->
                        Element.html blueLogoSvg

                    Local ->
                        Element.html redLogoSvg
            , url = Route.Top |> Route.toString
            }
        , Input.search [ alignRight, width (px 200), height fill ] { onChange = searchChanged, text = "", placeholder = Just (Input.placeholder [] (Element.text "Search")), label = Input.labelHidden "Search" }
        ]
