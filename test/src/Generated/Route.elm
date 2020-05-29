module Generated.Route exposing
    ( Route(..)
    , fromUrl
    , toHref
    )

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type Route
    = Top
    | Addons
    | Browser
    | Docs
    | Help
    | Movies
    | Music
    | NotFound
    | Playlist
    | TVshows
    | Thumbups


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse routes


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Top Parser.top
        , Parser.map Addons (Parser.s "addons")
        , Parser.map Browser (Parser.s "browser")
        , Parser.map Docs (Parser.s "docs")
        , Parser.map Help (Parser.s "help")
        , Parser.map Movies (Parser.s "movies")
        , Parser.map Music (Parser.s "music")
        , Parser.map NotFound (Parser.s "not-found")
        , Parser.map Playlist (Parser.s "playlist")
        , Parser.map TVshows (Parser.s "t-vshows")
        , Parser.map Thumbups (Parser.s "thumbups")
        ]


toHref : Route -> String
toHref route =
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
                
                Docs ->
                    [ "docs" ]
                
                Help ->
                    [ "help" ]
                
                Movies ->
                    [ "movies" ]
                
                Music ->
                    [ "music" ]
                
                NotFound ->
                    [ "not-found" ]
                
                Playlist ->
                    [ "playlist" ]
                
                TVshows ->
                    [ "t-vshows" ]
                
                Thumbups ->
                    [ "thumbups" ]
    in
    segments
        |> String.join "/"
        |> String.append "/"