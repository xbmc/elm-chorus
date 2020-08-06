module Components.Header exposing (headerHeight, view)

import Colors
import Element exposing (Element, alignTop, el, fill, height, image, px, row, text, width, paddingXY)
import Element.Background as Background
import Element.Font as Font exposing (alignRight)
import Spa.Generated.Route as Route


headerHeight : Int
headerHeight =
    50


view : msg -> Element msg
view searchChanged =
    row [ width fill, alignTop, height (px headerHeight), Background.color Colors.headerBackground ]
        [ Element.link []
            { label =
                image [ width (px 37), height (px 37), paddingXY 7 0 ]
                    { description = ""
                    , src = "https://raw.githubusercontent.com/ionif/elm-chorus/master/logo.png"
                    }
            , url = Route.Top |> Route.toString
            }
        -- , Input.search [] { onChange = searchChanged, text = "", placeholder = Just (Input.placeholder [] (Element.text "Search")), label = Input.labelHidden "Search" }
        ]
