module Components.Header exposing (headerHeight, view)

import Colors
import Element exposing (Element, alignTop, el, fill, height, image, px, row, text, width)
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
                image [ width (px 50) ]
                    { description = ""
                    , src = "https://github.com/ionif/elm-chorus/blob/master/logo.png"
                    }
            , url = Route.Top |> Route.toString
            }
        , el [ Font.color (Element.rgb 1 1 1) ] (text "Kodi")

        -- , Input.search [] { onChange = searchChanged, text = "", placeholder = Just (Input.placeholder [] (Element.text "Search")), label = Input.labelHidden "Search" }
        ]
