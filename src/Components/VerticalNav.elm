module Components.VerticalNav exposing (view)

import Element exposing (Element, column, fill, fillPortion)
import Spa.Generated.Route as Route exposing (Route)


view :
    List
        { route : Route
        , label : String
        }
    -> Element msg
view links =
    column [ Element.height fill, Element.width (fillPortion 1) ]
        (List.map
            (\a ->
                Element.link []
                    { url = Route.toString a.route
                    , label = Element.text a.label
                    }
            )
            links
        )
