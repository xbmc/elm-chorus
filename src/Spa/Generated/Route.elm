module Spa.Generated.Route exposing
    ( Route(..)
    , fromUrl
    , toString
    )

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type Route
    = Top
    | Addons
    | Browser
    | Movies
    | Music
    | NotFound
    | Playlists
    | TVShows


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse routes


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Top Parser.top
        , Parser.map Addons (Parser.s "addons")
        , Parser.map Browser (Parser.s "browser")
        , Parser.map Movies (Parser.s "movies")
        , Parser.map Music (Parser.s "music")
        , Parser.map NotFound (Parser.s "not-found")
        , Parser.map Playlists (Parser.s "playlists")
        , Parser.map TVShows (Parser.s "t-v-shows")
        ]


toString : Route -> String
toString route =
    let
        segments : List String
        segments =
            case route of
                Top ->
                    []
                
                Addons ->
                    [ "addons" ]
                
                Browser ->
                    [ "browser" ]
                
                Movies ->
                    [ "movies" ]
                
                Music ->
                    [ "music" ]
                
                NotFound ->
                    [ "not-found" ]
                
                Playlists ->
                    [ "playlists" ]
                
                TVShows ->
                    [ "t-v-shows" ]
    in
    segments
        |> String.join "/"
        |> String.append "/"