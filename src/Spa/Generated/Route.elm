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
    | Help
    | Lab
    | Movies
    | Music
    | NotFound
    | Playlists
    | Thumbsup
    | Tvshows
    | Music__Top
    | Movies__Recent
    | Music__Albums
    | Music__Artists
    | Music__Genres
    | Music__Videos
    | Settings__Web
    | Tvshows__Recent


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse routes


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Top Parser.top
        , Parser.map Addons (Parser.s "addons")
        , Parser.map Browser (Parser.s "browser")
        , Parser.map Help (Parser.s "help")
        , Parser.map Lab (Parser.s "lab")
        , Parser.map Movies (Parser.s "movies")
        , Parser.map Music (Parser.s "music")
        , Parser.map NotFound (Parser.s "not-found")
        , Parser.map Playlists (Parser.s "playlists")
        , Parser.map Thumbsup (Parser.s "thumbsup")
        , Parser.map Tvshows (Parser.s "tvshows")
        , Parser.map Music__Top (Parser.s "music")
        , Parser.map Movies__Recent (Parser.s "movies" </> Parser.s "recent")
        , Parser.map Music__Albums (Parser.s "music" </> Parser.s "albums")
        , Parser.map Music__Artists (Parser.s "music" </> Parser.s "artists")
        , Parser.map Music__Genres (Parser.s "music" </> Parser.s "genres")
        , Parser.map Music__Videos (Parser.s "music" </> Parser.s "videos")
        , Parser.map Settings__Web (Parser.s "settings" </> Parser.s "web")
        , Parser.map Tvshows__Recent (Parser.s "tvshows" </> Parser.s "recent")
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
                
                Help ->
                    [ "help" ]
                
                Lab ->
                    [ "lab" ]
                
                Movies ->
                    [ "movies" ]
                
                Music ->
                    [ "music" ]
                
                NotFound ->
                    [ "not-found" ]
                
                Playlists ->
                    [ "playlists" ]
                
                Thumbsup ->
                    [ "thumbsup" ]
                
                Tvshows ->
                    [ "tvshows" ]
                
                Music__Top ->
                    [ "music" ]
                
                Movies__Recent ->
                    [ "movies", "recent" ]
                
                Music__Albums ->
                    [ "music", "albums" ]
                
                Music__Artists ->
                    [ "music", "artists" ]
                
                Music__Genres ->
                    [ "music", "genres" ]
                
                Music__Videos ->
                    [ "music", "videos" ]
                
                Settings__Web ->
                    [ "settings", "web" ]
                
                Tvshows__Recent ->
                    [ "tvshows", "recent" ]
    in
    segments
        |> String.join "/"
        |> String.append "/"