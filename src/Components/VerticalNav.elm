module Components.VerticalNav exposing (view)

import Colors
import Element exposing (Attribute, Element, column, fill, fillPortion, padding, paddingXY, spacing)
import Element.Font as Font exposing (Font)
import Spa.Generated.Route as Route exposing (Route)


view :
    String
    -> Route
    ->
        List
            { route : Route
            , label : String
            }
    -> Element msg
view header currentRoute links =
    column [ Element.height fill, Element.width (fillPortion 1), paddingXY 16 8, spacing 16, Font.color Colors.greyscaleGray ]
        ([ header |> String.toUpper |> Element.text ]
            ++ List.map
                (\a ->
                    Element.link [ isCurrentRoute a.route currentRoute, paddingXY 16 0 ]
                        { url = Route.toString a.route
                        , label = Element.text a.label
                        }
                )
                links
        )


isCurrentRoute : Route -> Route -> Attribute msg
isCurrentRoute route currentRoute =
    if route == currentRoute then
        Font.color Colors.navTextHover

    else
        Font.color Colors.navText
