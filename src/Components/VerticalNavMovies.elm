module Components.VerticalNavMovies exposing (view)

import Components.VerticalNav
import Element exposing (Element)
import Spa.Generated.Route as Route exposing (Route)


view : Route -> Element msg
view currentRoute =
    Components.VerticalNav.view
        "sections"
        currentRoute
        [ { route = Route.Movies__Recent
          , label = "Movies"
          }
        , { route = Route.Movies
          , label = "All movies"
          }
        ]
        [Route.Movies]