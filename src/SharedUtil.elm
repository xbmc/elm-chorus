module SharedUtil exposing (..)

import Spa.Generated.Route exposing (Route(..))
import WSDecoder exposing (AlbumObj, ArtistObj)



--FILTER_FEATURE
-- Below Methods are catogarized with thier respective Objects:-
-- AlbumObj


filterByYearForAlbum : String -> List AlbumObj -> Maybe AlbumObj
filterByYearForAlbum selected_date itemList =
    List.head (List.filter (\item -> selected_date == item.dateadded) itemList)


filterByLabelForAlbum : String -> List AlbumObj -> Maybe AlbumObj
filterByLabelForAlbum selected_label itemList =
    List.head (List.filter (\item -> selected_label == item.label) itemList)



--ArtistObj


filterByLabelForAritst : String -> List ArtistObj -> Maybe ArtistObj
filterByLabelForAritst selected_label itemList =
    List.head (List.filter (\item -> selected_label == item.label) itemList)
