module SharedType exposing (..)


type RepeatType
    = Off
    | One
    | All


type Tabs
    = Kodi KodiTabs
    | Local


type KodiTabs
    = Audio
    | Video


type SortDirection
    = Asc
    | Desc


type VideoModal
    = Open
    | Closed


type AlbumSort
    = Title SortDirection
    | DateAdded SortDirection
    | Year SortDirection
    | Artist SortDirection
    | Random SortDirection
    | Rating SortDirection
