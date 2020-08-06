module Components.VerticalNavMovies exposing (view)

import Components.VerticalNav
import Element exposing (Element)
import Spa.Generated.Route as Route exposing (Route)


view : Route -> Element msg
view currentRoute =
    Components.VerticalNav.view
        "sections"
        currentRoute
        [ { route = Route.Movies
          , label = "Movies"
          }
        , { route = Route.Top
          , label = "All movies"
          }
        ]
        [Route.Top]