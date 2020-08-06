module Components.VerticalNavMusic exposing (view)

import Components.VerticalNav
import Element exposing (Element)
import Spa.Generated.Route as Route exposing (Route)


view : Route -> Element msg
view currentRoute =
    Components.VerticalNav.view
        "sections"
        currentRoute
        [ { route = Route.Music
          , label = "Music"
          }
        , { route = Route.Music__Genres
          , label = "Genres"
          }
        , { route = Route.Music__Top__Top
          , label = "Top Music"
          }
        , { route = Route.Music__Artists
          , label = "Artists"
          }
        , { route = Route.Music__Albums
          , label = "Albums"
          }
        , { route = Route.Music__Videos
          , label = "Videos"
          }
        ]
        [ Route.Music__Artists
        , Route.Music__Albums
        , Route.Music__Videos
        ]
