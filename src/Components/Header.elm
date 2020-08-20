module Components.Header exposing (headerHeight, view)

import Colors
import Element exposing (Element, alignRight, fill, height, htmlAttribute, image, paddingXY, px, row, text, width)
import Element.Background as Background
import Element.Input as Input
import Html.Attributes
import Spa.Generated.Route as Route


headerHeight : Int
headerHeight =
    50


view : (String -> msg) -> Element msg
view searchChanged =
    row [ width fill, height (px headerHeight), Background.color Colors.headerBackground, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
        [ Element.link []
            { label =
                image [ width (px 37), height (px 37), paddingXY 7 0 ]
                    { description = ""
                    , src = "https://raw.githubusercontent.com/ionif/elm-chorus/master/logo.png"
                    }
            , url = Route.Top |> Route.toString
            }
        , Input.search [ alignRight, width (px 200), height fill ] { onChange = searchChanged, text = "", placeholder = Just (Input.placeholder [] (Element.text "Search")), label = Input.labelHidden "Search" }
        ]
