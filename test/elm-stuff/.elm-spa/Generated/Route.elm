module Generated.Route exposing
    ( Route(..)
    , toPath
    )

import Generated.Params as Params


type Route
    = NotFound Params.NotFound
    | Top Params.Top


toPath : Route -> String
toPath route =
    case route of
        NotFound _ ->
            "/not-found"
        
        
        Top _ ->
            "/"