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


years : String -> List String
years date =
    let
        parts : List String
        parts =
            String.split "-" date
    in
    case parts of
        year :: month :: day :: [] ->
            [ year ]

        _ ->
            parts


sortByTitleAlbum : List AlbumObj -> List AlbumObj
sortByTitleAlbum list =
    List.sortBy (.label >> String.toLower) list


sortByYearAlbum : List AlbumObj -> List AlbumObj
sortByYearAlbum list =
    List.sortBy (.dateadded >> years) list


sortByDateAlbum : List AlbumObj -> List AlbumObj
sortByDateAlbum list =
    List.sortBy (.dateadded >> dateParts) list


sortByArtistAlbum : List AlbumObj -> List AlbumObj
sortByArtistAlbum list =
    List.sortBy
        (.artist
            >> List.sort
            >> List.head
            >> Maybe.withDefault ""
            >> String.toLower
        )
        list


sortByTitleArtist : List ArtistObj -> List ArtistObj
sortByTitleArtist list =
    List.sortBy (.label >> String.toLower) list


sortByTitleVideo : List VideoObj -> List VideoObj
sortByTitleVideo list =
    List.sortBy (.label >> String.toLower) list


sortByTitleMovie : List MovieObj -> List MovieObj
sortByTitleMovie list =
    List.sortBy (.label >> String.toLower) list


sortByTitleTvShow : List TvshowObj -> List TvshowObj
sortByTitleTvShow list =
    List.sortBy (.label >> String.toLower) list


sortByRandom mySeed list =
    Random.step
        (Random.List.shuffle list)
        mySeed
