module SharedUtil exposing (..)

import Material.Icons exposing (mood, style)
import Random
import Random.List
import SharedType exposing (..)
import WSDecoder exposing (AlbumObj, ArtistObj, InProgressTvShow, MovieObj, TvshowObj, VideoObj)


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


checkFilterButton : List FilterButton -> List FilterButton
checkFilterButton filterbutton =
    List.filter (\obj -> obj.state == True && obj.name /= "") filterbutton


updateFilter : Int -> List FilterButton -> List FilterButton
updateFilter idx list =
    let
        toggle id task =
            if id == idx then
                { task | name = task.name, state = not task.state }

            else
                { task | name = task.name, state = task.state }
    in
    List.indexedMap toggle list


sortFilterAlbum : ObjectSort -> List AlbumObj -> List AlbumObj
sortFilterAlbum current list =
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


sortFilterArtist : ObjectSort -> List ArtistObj -> List ArtistObj
sortFilterArtist current list =
    case current of
        Title Asc ->
            sortByTitle list

        Title Desc ->
            List.reverse (sortByTitle list)

        _ ->
            list


sortFilterVideo : ObjectSort -> List VideoObj -> List VideoObj
sortFilterVideo current list =
    case current of
        Title Asc ->
            sortByTitle list

        Title Desc ->
            List.reverse (sortByTitle list)

        Year Asc ->
            sortByYear list

        Year Desc ->
            List.reverse (sortByYear list)

        Artist Asc ->
            sortByArtist list

        Artist Desc ->
            List.reverse (sortByArtist list)

        Album Asc ->
            sortByAlbumVideo list

        Album Desc ->
            List.reverse (sortByAlbumVideo list)

        _ ->
            list


sortFilterTvShow : ObjectSort -> List TvshowObj -> List TvshowObj
sortFilterTvShow current list =
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

        Rating Asc ->
            sortByRating list

        Rating Desc ->
            List.reverse (sortByRating list)

        _ ->
            list


sortFilterMovie : ObjectSort -> List MovieObj -> List MovieObj
sortFilterMovie current list =
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

        Rating Asc ->
            sortByRating list

        Rating Desc ->
            List.reverse (sortByRating list)

        _ ->
            list


filterAlbum : ObjectSort -> List AlbumObj -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List AlbumObj
filterAlbum currentSort album yearbuttons genrebuttons stylebuttons labelbuttons =
    let
        first =
            if List.isEmpty (checkFilterButton yearbuttons) == True then
                album

            else
                filterByYearAlbum album yearbuttons

        second =
            if List.isEmpty (checkFilterButton genrebuttons) == True then
                first

            else
                filterByGenreAlbum first genrebuttons

        third =
            if List.isEmpty (checkFilterButton stylebuttons) == True then
                second

            else
                filterByStyleAlbum second stylebuttons

        final =
            if List.isEmpty (List.filter (\k -> k.state == True) labelbuttons) == True then
                third

            else
                filterByAlbumLabel third labelbuttons
    in
    sortFilterAlbum currentSort (uniqueList final)


filterArtist : ObjectSort -> List ArtistObj -> List FilterButton -> List FilterButton -> List FilterButton -> List ArtistObj
filterArtist currentSort artist genrebuttons moodbuttons stylebuttons =
    let
        first =
            if List.isEmpty (checkFilterButton genrebuttons) == True then
                artist

            else
                filterByGenreArtist artist genrebuttons

        second =
            if List.isEmpty (checkFilterButton moodbuttons) == True then
                first

            else
                filterByMoodArtist first moodbuttons

        final =
            if List.isEmpty (checkFilterButton stylebuttons) == True then
                second

            else
                filterByStyleArtist second stylebuttons
    in
    sortFilterArtist currentSort (uniqueList final)


filterVideo : ObjectSort -> List VideoObj -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List VideoObj
filterVideo currentSort video yearbuttons directorbuttons studiobuttons albumbuttons artistbuttons =
    let
        first =
            if List.isEmpty (checkFilterButton yearbuttons) == True then
                video

            else
                filterByYearVideo video yearbuttons

        second =
            if List.isEmpty (checkFilterButton directorbuttons) == True then
                first

            else
                filterByDirectorVideo first directorbuttons

        third =
            if List.isEmpty (checkFilterButton studiobuttons) == True then
                second

            else
                filterByStudioVideo second studiobuttons

        fourth =
            if List.isEmpty (checkFilterButton albumbuttons) == True then
                third

            else
                filterByAlbumVideo third albumbuttons

        final =
            if List.isEmpty (checkFilterButton artistbuttons) == True then
                fourth

            else
                filterByArtistVideo fourth artistbuttons
    in
    sortFilterVideo currentSort (uniqueList final)


filterTvShow : ObjectSort -> Bool -> Bool -> List TvshowObj -> List InProgressTvShow -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List TvshowObj
filterTvShow currentSort unwatched inprogress tvshow inprogress_tvshow yearbuttons genrebuttons tagbuttons actorbuttons ratedbuttons studiobuttons =
    let
        first =
            if List.isEmpty (checkFilterButton yearbuttons) == True then
                tvshow

            else
                filterByYearTvShow tvshow yearbuttons

        second =
            if List.isEmpty (checkFilterButton genrebuttons) == True then
                first

            else
                filterByGenreTvShow first genrebuttons

        third =
            if List.isEmpty (checkFilterButton tagbuttons) == True then
                second

            else
                filterByTagTvShow second tagbuttons

        fourth =
            if List.isEmpty (checkFilterButton ratedbuttons) == True then
                third

            else
                filterByRatedTvShow third ratedbuttons

        fifth =
            if List.isEmpty (checkFilterButton studiobuttons) == True then
                fourth

            else
                filterByStudioTvShow fourth studiobuttons

        sixth =
            if List.isEmpty (checkFilterButton actorbuttons) == True then
                fifth

            else
                filterByActorTvShow fifth actorbuttons

        seventh =
            if unwatched == True then
                List.filter (\tvshows -> tvshows.playcount == 0) sixth

            else
                sixth

        final =
            if inprogress == True then
                List.concatMap (\obj -> List.filter (\tvshows -> tvshows.tvshowid == obj.tvshowid) seventh) inprogress_tvshow

            else
                seventh
    in
    sortFilterTvShow currentSort (uniqueList final)


filterMovie : ObjectSort -> Bool -> Bool -> Bool -> List MovieObj -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List FilterButton -> List MovieObj
filterMovie currentSort unwatched inprogress watched movie yearbuttons genrebuttons tagbuttons actorbuttons ratedbuttons studiobuttons setbuttons directorbutton writerbutton =
    let
        first =
            if List.isEmpty (checkFilterButton yearbuttons) == True then
                movie

            else
                filterByYearMovie movie yearbuttons

        second =
            if List.isEmpty (checkFilterButton genrebuttons) == True then
                first

            else
                filterByGenreMovie first genrebuttons

        third =
            if List.isEmpty (checkFilterButton tagbuttons) == True then
                second

            else
                filterByTagMovie second tagbuttons

        fourth =
            if List.isEmpty (checkFilterButton ratedbuttons) == True then
                third

            else
                filterByRatedMovie third ratedbuttons

        fifth =
            if List.isEmpty (checkFilterButton studiobuttons) == True then
                fourth

            else
                filterByStudioMovie fourth studiobuttons

        sixth =
            if List.isEmpty (checkFilterButton actorbuttons) == True then
                fifth

            else
                filterByActorMovie fifth actorbuttons

        seventh =
            if List.isEmpty (checkFilterButton setbuttons) == True then
                sixth

            else
                filterBySetMovie sixth setbuttons

        eighth =
            if List.isEmpty (checkFilterButton writerbutton) == True then
                seventh

            else
                filterByWriterMovie seventh writerbutton

        nineth =
            if List.isEmpty (checkFilterButton directorbutton) == True then
                eighth

            else
                filterByDirectorMovie eighth directorbutton

        tenth =
            if unwatched == True then
                List.filter (\tvshows -> tvshows.playcount == 0) nineth

            else
                nineth

        eleventh =
            if watched == True then
                List.filter (\tvshows -> tvshows.playcount == 1) tenth

            else
                tenth

        final =
            if inprogress == True then
                List.filter (\tvshows -> tvshows.position > 0) eleventh

            else
                eleventh
    in
    sortFilterMovie currentSort (uniqueList final)


filterByYearAlbum : List AlbumObj -> List FilterButton -> List AlbumObj
filterByYearAlbum album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> String.fromInt album.year == filterobj.name) album_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByGenreAlbum : List AlbumObj -> List FilterButton -> List AlbumObj
filterByGenreAlbum album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> List.member filterobj.name album.genre) album_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByStyleAlbum : List AlbumObj -> List FilterButton -> List AlbumObj
filterByStyleAlbum album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> List.member filterobj.name album.style) album_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByAlbumLabel : List AlbumObj -> List FilterButton -> List AlbumObj
filterByAlbumLabel album_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\album -> filterobj.name == album.albumlabel) album_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByGenreArtist : List ArtistObj -> List FilterButton -> List ArtistObj
filterByGenreArtist artist_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\artist -> List.member filterobj.name artist.genre) artist_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByMoodArtist : List ArtistObj -> List FilterButton -> List ArtistObj
filterByMoodArtist artist_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\artist -> List.member filterobj.name artist.mood) artist_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByStyleArtist : List ArtistObj -> List FilterButton -> List ArtistObj
filterByStyleArtist artist_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\artist -> List.member filterobj.name artist.style) artist_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByYearVideo : List VideoObj -> List FilterButton -> List VideoObj
filterByYearVideo video_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\video -> String.fromInt video.year == filterobj.name) video_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByDirectorVideo : List VideoObj -> List FilterButton -> List VideoObj
filterByDirectorVideo video_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\video -> List.member filterobj.name video.director) video_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByStudioVideo : List VideoObj -> List FilterButton -> List VideoObj
filterByStudioVideo video_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\video -> List.member filterobj.name video.studio) video_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByAlbumVideo : List VideoObj -> List FilterButton -> List VideoObj
filterByAlbumVideo video_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\video -> video.album == filterobj.name) video_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByArtistVideo : List VideoObj -> List FilterButton -> List VideoObj
filterByArtistVideo video_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\video -> List.member filterobj.name video.artist) video_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByYearTvShow : List TvshowObj -> List FilterButton -> List TvshowObj
filterByYearTvShow tvshow_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\tvshow -> String.fromInt tvshow.year == filterobj.name) tvshow_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByGenreTvShow : List TvshowObj -> List FilterButton -> List TvshowObj
filterByGenreTvShow tvshow_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\tvshow -> List.member filterobj.name tvshow.genre) tvshow_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByTagTvShow : List TvshowObj -> List FilterButton -> List TvshowObj
filterByTagTvShow tvshow_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\tvshow -> List.member filterobj.name tvshow.tags) tvshow_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByActorTvShow : List TvshowObj -> List FilterButton -> List TvshowObj
filterByActorTvShow tvshow_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\tvshow -> List.member filterobj.name (List.map (\cast -> cast.name) tvshow.cast)) tvshow_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByRatedTvShow : List TvshowObj -> List FilterButton -> List TvshowObj
filterByRatedTvShow tvshow_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\tvshow -> tvshow.mpaa == filterobj.name) tvshow_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByStudioTvShow : List TvshowObj -> List FilterButton -> List TvshowObj
filterByStudioTvShow tvshow_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\tvshow -> List.member filterobj.name tvshow.studio) tvshow_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByYearMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByYearMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> String.fromInt movie.year == filterobj.name) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByGenreMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByGenreMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> List.member filterobj.name movie.genre) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByTagMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByTagMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> List.member filterobj.name movie.tags) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByActorMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByActorMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> List.member filterobj.name (List.map (\cast -> cast.name) movie.cast)) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByRatedMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByRatedMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> movie.mpaa == filterobj.name) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByStudioMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByStudioMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> List.member filterobj.name movie.studio) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterBySetMovie : List MovieObj -> List FilterButton -> List MovieObj
filterBySetMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> movie.set == filterobj.name) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByDirectorMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByDirectorMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> List.member filterobj.name movie.director) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


filterByWriterMovie : List MovieObj -> List FilterButton -> List MovieObj
filterByWriterMovie movie_list list =
    let
        final =
            List.concatMap (\filterobj -> List.filter (\movie -> List.member filterobj.name movie.writer) movie_list) (checkFilterButton list)
    in
    if List.isEmpty final == True then
        []

    else
        final


uniqueList : List a -> List a
uniqueList list =
    List.foldl
        (\a uniques ->
            if List.member a uniques then
                uniques

            else
                uniques ++ [ a ]
        )
        []
        list
