module Components.Header exposing (headerHeight, view)

import Colors
import Components.LayoutType exposing (ShowRightSidebarMenu)
import Element exposing (Element, alignRight, fill, height, htmlAttribute, image, paddingXY, px, row, text, width)
import Element.Background as Background
import Element.Input as Input
import Html.Attributes
import SharedType exposing (..)
import Spa.Generated.Route as Route


headerHeight : Int
headerHeight =
    50


view : ShowRightSidebarMenu msg -> (String -> msg) -> Element msg
view { tabSwitch } searchChanged =
    row
        [ width fill
        , height (px headerHeight)
        , case tabSwitch of
            Kodi ->
                Background.color Colors.headerBackground

            Local ->
                Background.color Colors.greyscaleShark
        , htmlAttribute <| Html.Attributes.style "pointer-events" "all"
        ]
        [ Element.link []
            { label =
                image [ width (px 37), height (px 37), paddingXY 7 0 ]
                    { description = ""
                    , src =
                        case tabSwitch of
                            Kodi ->
                                "logo.png"

                            Local ->
                                "ceriseRed-logo.png"
                    }
            , url = Route.Top |> Route.toString
            }
        , Input.search [ alignRight, width (px 200), height fill ] { onChange = searchChanged, text = "", placeholder = Just (Input.placeholder [] (Element.text "Search")), label = Input.labelHidden "Search" }
        ]
