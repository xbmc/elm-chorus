module SharedUtil exposing (..)

import Random
import Random.List
import WSDecoder exposing (AlbumObj, ArtistObj, MovieObj, TvshowObj, VideoObj)


dateParts : String -> List String
dateParts date =
    let
        parts : List String
        parts =
            String.split "-" (String.slice 0 10 date)
    in
    case parts of
        year :: month :: day :: [] ->
            [ year, month, day ]

        _ ->
            parts


sortByTitle list =
    List.sortBy (.label >> String.toLower) list


sortByYear list =
    List.sortBy .year list


sortByDate list =
    List.sortBy (.dateadded >> dateParts) list


sortByRating list =
    List.sortBy .rating list


sortByArtist list =
    List.sortBy
        (.artist
            >> List.sort
            >> List.head
            >> Maybe.withDefault ""
            >> String.toLower
        )
        list


sortByAlbumVideo : List VideoObj -> List VideoObj
sortByAlbumVideo list =
    List.sortBy (.album >> String.toLower) list


sortByRandom mySeed list =
    Random.step
        (Random.List.shuffle list)
        mySeed
