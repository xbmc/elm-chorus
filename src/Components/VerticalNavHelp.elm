module Components.VerticalNavHelp exposing (..)

import Components.VerticalNav
import Element exposing (Element)
import Spa.Generated.Route as Route exposing (Route)


view : Route -> List (Element msg)
view currentRoute =
    [ Components.VerticalNav.view
        "HELP TOPICS"
        currentRoute
        [ { route = Route.Help__About
          , label = "About"
          }
        , { route = Route.Help__Readme
          , label = "Readme"
          }
        , { route = Route.Help__Changelog
          , label = "Changelog"
          }
        , { route = Route.Help__Keyboard
          , label = "Keyboard"
          }
        , { route = Route.Help__Addons
          , label = "Add-ons"
          }
        , { route = Route.Help__Developers
          , label = "Developers"
          }
        , { route = Route.Help__Translations
          , label = "Translations"
          }
        , { route = Route.Help__License
          , label = "License"
          }
        ]
        []
    ]
