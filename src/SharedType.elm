module SharedType exposing (..)


type RepeatType
    = Off
    | One
    | All


type Tabs
    = Kodi KodiTabs
    | Local


type KodiTabs
    = AudTab
    | VidTab
