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
    | Movies__Recent
    | Music__Albums
    | Music__Artists
    | Music__Genres
    | Music__Videos
    | Settings__Web
    | Tvshows__Recent
    | Browser__Source_String { source : String }
    | Music__Top__Top
    | Music__Album__Albumid_Int { albumid : Int }
    | Music__Artist__Artistid_Int { artistid : Int }
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
        , Parser.map Help (Parser.s "help")
        , Parser.map Lab (Parser.s "lab")
        , Parser.map Movies (Parser.s "movies")
        , Parser.map Music (Parser.s "music")
        , Parser.map NotFound (Parser.s "not-found")
        , Parser.map Playlists (Parser.s "playlists")
        , Parser.map Thumbsup (Parser.s "thumbsup")
        , Parser.map Tvshows (Parser.s "tvshows")
        , Parser.map Movies__Recent (Parser.s "movies" </> Parser.s "recent")
        , Parser.map Music__Albums (Parser.s "music" </> Parser.s "albums")
        , Parser.map Music__Artists (Parser.s "music" </> Parser.s "artists")
        , Parser.map Music__Genres (Parser.s "music" </> Parser.s "genres")
        , Parser.map Music__Videos (Parser.s "music" </> Parser.s "videos")
        , Parser.map Settings__Web (Parser.s "settings" </> Parser.s "web")
        , Parser.map Tvshows__Recent (Parser.s "tvshows" </> Parser.s "recent")
        , (Parser.s "browser" </> Parser.string)
          |> Parser.map (\source -> { source = source })
          |> Parser.map Browser__Source_String
        , Parser.map Music__Top__Top (Parser.s "music" </> Parser.s "top")
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
                
                Browser__Source_String { source } ->
                    [ "browser", source ]
                
                Music__Top__Top ->
                    [ "music", "top" ]
                
                Music__Album__Albumid_Int { albumid } ->
                    [ "music", "album", String.fromInt albumid ]
                
                Music__Artist__Artistid_Int { artistid } ->
                    [ "music", "artist", String.fromInt artistid ]
                
                Music__Genre__Genre_String { genre } ->
                    [ "music", "genre", genre ]
    in
    segments
        |> String.join "/"
        |> String.append "/"