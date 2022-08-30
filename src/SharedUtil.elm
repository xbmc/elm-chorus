module SharedUtil exposing (..)

import Random
import Random.List
import SharedType exposing (..)
import WSDecoder exposing (AlbumObj, ArtistObj, MovieObj, TvshowObj, VideoObj)


type alias FilterButton =
    { name : String
    , state : Bool
    }


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


checkfilterbutton : List FilterButton -> List FilterButton
checkfilterbutton filterbutton =
    List.filter (\obj -> obj.state == True && obj.name /= "") filterbutton


updatefilter : Int -> List FilterButton -> List FilterButton
updatefilter idx list =
    let
        toggle id task =
            if id == idx then
                { task | name = task.name, state = not task.state }

            else
                { task | name = task.name, state = task.state }
    in
    List.indexedMap toggle list


sort_filter_album : AlbumSort -> List AlbumObj -> List AlbumObj
sort_filter_album current list =
    case current of
        Title Asc ->
            sortByTitle list

        Title Desc ->
            List.reverse (sortByTitle list)

        DateAdded Asc ->
            sortByDate list

        DateAdded Desc ->
            List.reverse (sortByDate list)

        Year Asc ->
            sortByYear list

        Year Desc ->
            List.reverse (sortByDate list)

        Artist Asc ->
            sortByArtist list

        Artist Desc ->
            List.reverse (sortByArtist list)

        Rating Asc ->
            sortByRating list

        Rating Desc ->
            List.reverse (sortByRating list)

        _ ->
            list


filter_album : AlbumSort -> List AlbumObj -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List AlbumObj
filter_album current_sort album yearbuttons genrebuttons stylebuttons labelbuttons =
    let
        first =
            if List.isEmpty (checkfilterbutton yearbuttons) == True then
                album

            else
                filterByYearAlbum album yearbuttons

        second =
            if List.isEmpty (checkfilterbutton genrebuttons) == True then
                first

            else
                filterByGenreAlbum first genrebuttons

        third =
            if List.isEmpty (checkfilterbutton stylebuttons) == True then
                second

            else
                filterByStyleAlbum second stylebuttons

        final =
            if List.isEmpty (List.filter (\k -> k.state == True) labelbuttons) == True then
                third

            else
                filterByAlbumLabel third labelbuttons
    in
    sort_filter_album current_sort final


filterByYearAlbum : List AlbumObj -> List FilterButton -> List AlbumObj
filterByYearAlbum album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> String.fromInt album.year == filterobj.name) album_list) (checkfilterbutton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByGenreAlbum : List AlbumObj -> List FilterButton -> List AlbumObj
filterByGenreAlbum album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> List.member filterobj.name album.genre) album_list) (checkfilterbutton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByStyleAlbum : List AlbumObj -> List FilterButton -> List AlbumObj
filterByStyleAlbum album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> List.member filterobj.name album.style) album_list) (checkfilterbutton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByAlbumLabel : List AlbumObj -> List FilterButton -> List AlbumObj
filterByAlbumLabel album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> filterobj.name == album.albumlabel) album_list) (checkfilterbutton list)
    in
    if List.isEmpty final == True then
        []

    else
        final
