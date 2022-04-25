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
    | Lab
    | Movies
    | Music
    | NotFound
    | Playlists
    | Thumbsup
    | Tvshows
    | Help__About
    | Help__Addons
    | Help__Changelog
    | Help__Developers
    | Help__Keyboard
    | Help__License
    | Help__Readme
    | Help__Translations
    | Movies__Recent
    | Music__Albums
    | Music__Artists
    | Music__Genres
    | Music__Videos
    | Settings__Addons
    | Settings__Nav
    | Settings__Search
    | Settings__Web
    | Tvshows__Recent
    | Browser__Source_String { source : String }
    | Playlists__Name_String { name : String }
    | Videoplayer__Movieid_Int { movieid : Int }
    | Music__Top__Top
    | Settings__Kodi__Games
    | Settings__Kodi__Interface
    | Settings__Kodi__Media
    | Settings__Kodi__Player
    | Settings__Kodi__Pvr
    | Settings__Kodi__Services
    | Settings__Kodi__System
    | Music__Album__Albumid_Int { albumid : Int }
    | Music__Artist__Artistid_Int { artistid : Int }
    | Music__Videos__Videoid_Int { videoid : Int }
    | Music__Genre__Genre_String { genre : String }


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse routes


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Top Parser.top
        , Parser.map Addons (Parser.s "addons")
        , Parser.map Browser (Parser.s "browser")
        , Parser.map Lab (Parser.s "lab")
        , Parser.map Movies (Parser.s "movies")
        , Parser.map Music (Parser.s "music")
        , Parser.map NotFound (Parser.s "not-found")
        , Parser.map Playlists (Parser.s "playlists")
        , Parser.map Thumbsup (Parser.s "thumbsup")
        , Parser.map Tvshows (Parser.s "tvshows")
        , Parser.map Help__About (Parser.s "help" </> Parser.s "about")
        , Parser.map Help__Addons (Parser.s "help" </> Parser.s "addons")
        , Parser.map Help__Changelog (Parser.s "help" </> Parser.s "changelog")
        , Parser.map Help__Developers (Parser.s "help" </> Parser.s "developers")
        , Parser.map Help__Keyboard (Parser.s "help" </> Parser.s "keyboard")
        , Parser.map Help__License (Parser.s "help" </> Parser.s "license")
        , Parser.map Help__Readme (Parser.s "help" </> Parser.s "readme")
        , Parser.map Help__Translations (Parser.s "help" </> Parser.s "translations")
        , Parser.map Movies__Recent (Parser.s "movies" </> Parser.s "recent")
        , Parser.map Music__Albums (Parser.s "music" </> Parser.s "albums")
        , Parser.map Music__Artists (Parser.s "music" </> Parser.s "artists")
        , Parser.map Music__Genres (Parser.s "music" </> Parser.s "genres")
        , Parser.map Music__Videos (Parser.s "music" </> Parser.s "videos")
        , Parser.map Settings__Addons (Parser.s "settings" </> Parser.s "addons")
        , Parser.map Settings__Nav (Parser.s "settings" </> Parser.s "nav")
        , Parser.map Settings__Search (Parser.s "settings" </> Parser.s "search")
        , Parser.map Settings__Web (Parser.s "settings" </> Parser.s "web")
        , Parser.map Tvshows__Recent (Parser.s "tvshows" </> Parser.s "recent")
        , (Parser.s "browser" </> Parser.string)
            |> Parser.map (\source -> { source = source })
            |> Parser.map Browser__Source_String
        , (Parser.s "playlists" </> Parser.string)
            |> Parser.map (\name -> { name = name })
            |> Parser.map Playlists__Name_String
        , (Parser.s "videoplayer" </> Parser.int)
            |> Parser.map (\movieid -> { movieid = movieid })
            |> Parser.map Videoplayer__Movieid_Int
        , Parser.map Music__Top__Top (Parser.s "music" </> Parser.s "top")
        , Parser.map Settings__Kodi__Games (Parser.s "settings" </> Parser.s "kodi" </> Parser.s "games")
        , Parser.map Settings__Kodi__Interface (Parser.s "settings" </> Parser.s "kodi" </> Parser.s "interface")
        , Parser.map Settings__Kodi__Media (Parser.s "settings" </> Parser.s "kodi" </> Parser.s "media")
        , Parser.map Settings__Kodi__Player (Parser.s "settings" </> Parser.s "kodi" </> Parser.s "player")
        , Parser.map Settings__Kodi__Pvr (Parser.s "settings" </> Parser.s "kodi" </> Parser.s "pvr")
        , Parser.map Settings__Kodi__Services (Parser.s "settings" </> Parser.s "kodi" </> Parser.s "services")
        , Parser.map Settings__Kodi__System (Parser.s "settings" </> Parser.s "kodi" </> Parser.s "system")
        , (Parser.s "music" </> Parser.s "album" </> Parser.int)
            |> Parser.map (\albumid -> { albumid = albumid })
            |> Parser.map Music__Album__Albumid_Int
        , (Parser.s "music" </> Parser.s "artist" </> Parser.int)
            |> Parser.map (\artistid -> { artistid = artistid })
            |> Parser.map Music__Artist__Artistid_Int
        , (Parser.s "music" </> Parser.s "genre" </> Parser.string)
            |> Parser.map (\genre -> { genre = genre })
            |> Parser.map Music__Genre__Genre_String
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

                Help__About ->
                    [ "help", "about" ]

                Help__Addons ->
                    [ "help", "addons" ]

                Help__Changelog ->
                    [ "help", "changelog" ]

                Help__Developers ->
                    [ "help", "developers" ]

                Help__Keyboard ->
                    [ "help", "keyboard" ]

                Help__License ->
                    [ "help", "license" ]

                Help__Readme ->
                    [ "help", "readme" ]

                Help__Translations ->
                    [ "help", "translations" ]

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

                Settings__Addons ->
                    [ "settings", "addons" ]

                Settings__Nav ->
                    [ "settings", "nav" ]

                Settings__Search ->
                    [ "settings", "search" ]

                Settings__Web ->
                    [ "settings", "web" ]

                Tvshows__Recent ->
                    [ "tvshows", "recent" ]

                Browser__Source_String { source } ->
                    [ "browser", source ]

                Playlists__Name_String { name } ->
                    [ "playlists", name ]

                Videoplayer__Movieid_Int { movieid } ->
                    [ "videoplayer", String.fromInt movieid ]

                Music__Top__Top ->
                    [ "music", "top" ]

                Settings__Kodi__Games ->
                    [ "settings", "kodi", "games" ]

                Settings__Kodi__Interface ->
                    [ "settings", "kodi", "interface" ]

                Settings__Kodi__Media ->
                    [ "settings", "kodi", "media" ]

                Settings__Kodi__Player ->
                    [ "settings", "kodi", "player" ]

                Settings__Kodi__Pvr ->
                    [ "settings", "kodi", "pvr" ]

                Settings__Kodi__Services ->
                    [ "settings", "kodi", "services" ]

                Settings__Kodi__System ->
                    [ "settings", "kodi", "system" ]

                Music__Album__Albumid_Int { albumid } ->
                    [ "music", "album", String.fromInt albumid ]

                Music__Artist__Artistid_Int { artistid } ->
                    [ "music", "artist", String.fromInt artistid ]

                Music__Videos__Videoid_Int { videoid } ->
                    [ "music", "videos", String.fromInt videoid ]

                Music__Genre__Genre_String { genre } ->
                    [ "music", "genre", genre ]
    in
    segments
        |> String.join "/"
        |> String.append "/"
