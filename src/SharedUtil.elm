module SharedUtil exposing (..)

import Html exposing (b)
import WSDecoder exposing (AlbumObj, ArtistObj, MovieObj)



-- sortBy(then the name of field according to  which the list will get sorted followed by for which object)
-- for ex: sortByArtistAlbum will return a list sorted according to artist field in album object


sortByArtistAlbum : List AlbumObj -> List AlbumObj
sortByArtistAlbum list =
    List.sortBy .artist list


sortByLabelAlbum : List AlbumObj -> List AlbumObj
sortByLabelAlbum list =
    List.sortBy .label list


sortByLabelArtist : List ArtistObj -> List ArtistObj
sortByLabelArtist list =
    List.sortBy .label list


sortByLabelMovie : List MovieObj -> List MovieObj
sortByLabelMovie list =
    List.sortBy .label list
