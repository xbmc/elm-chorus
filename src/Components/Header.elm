module Components.Header exposing (headerHeight, view)

import Colors
import Element exposing (Element, el, fill, height, image, px, row, text, width)
import Element.Background as Background
import Element.Font as Font
import Spa.Generated.Route as Route


headerHeight : Int
headerHeight =
    50


view : msg -> Element msg
view searchChanged =
    row [ width fill, height (px headerHeight), Background.color Colors.black ]
        [ Element.link []
            { label =
                image [ width (px 50) ]
                    { description = ""
                    , src = "https://kodi.wiki/images/8/8e/Thumbnail-symbol-transparent.png"
                    }
            , url = Route.Top |> Route.toString
            }
        , el [ Font.color (Element.rgb 1 1 1) ] (text "Kodi")

        -- , Input.search [] { onChange = searchChanged, text = "", placeholder = Just (Input.placeholder [] (Element.text "Search")), label = Input.labelHidden "Search" }
        ]
