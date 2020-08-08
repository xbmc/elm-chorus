module Components.VerticalNavTvshows exposing (view)

import Components.VerticalNav
import Element exposing (Element)
import Spa.Generated.Route as Route exposing (Route)


view : Route -> Element msg
view currentRoute =
    Components.VerticalNav.view
        "sections"
        currentRoute
        [ { route = Route.Tvshows__Recent
          , label = "TV shows"
          }
        , { route = Route.Tvshows
          , label = "All TV shows"
          }
        ]
        [Route.Tvshows]