module Components.VerticalNav exposing
    ( VerticalNav
    , view
    )

import Array
import Html exposing (..)
import Html.Events as Events
import Html.Attributes exposing (class)

type VerticalNav slide
    = VerticalNav (Internals slide)


type alias Internals slide =
    { pages : List Pages
    }

view :
    { verticalNav : VerticalNav nav
    , currentPage : Page page
    }
view options =
    let
        (VerticalNav internals) =
            options.verticalNav
    in
    [ row [ Element.height fill, Element.width fill ]
            [ options.verticalNav
            , page.view
        ]
    ]
