module Components.VerticalNavSettings exposing (view)

import Components.VerticalNav
import Element exposing (Element)
import Spa.Generated.Route as Route exposing (Route)


view : Route -> List (Element msg)
view currentRoute =
    [ Components.VerticalNav.view
        "General"
        currentRoute
        [ { route = Route.Settings__Web
          , label = "Web interface"
          }
        , { route = Route.Settings__Nav
          , label = "Main Menu"
          }
        , { route = Route.Settings__Addons
          , label = "Add-ons"
          }
        , { route = Route.Settings__Search
          , label = "Search"
          }
        ]
        []
    , Components.VerticalNav.view
        "Kodi Settings"
        currentRoute
        [ { route = Route.Settings__Kodi__Games
          , label = "Games"
          }
        , { route = Route.Settings__Kodi__Interface
          , label = "Interface"
          }
        , { route = Route.Settings__Kodi__Media
          , label = "Media"
          }
        , { route = Route.Settings__Kodi__Player
          , label = "Player"
          }
        , { route = Route.Settings__Kodi__Pvr
          , label = "PVR & Live TV"
          }
        , { route = Route.Settings__Kodi__Services
          , label = "Services"
          }
        , { route = Route.Settings__Kodi__System
          , label = "System"
          }
        ]
        []
    ]
