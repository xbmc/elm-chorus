module Components.SectionHeader exposing (view, viewAlbums, viewArtists, viewAlbumSongs)

import Colors exposing (greyIcon)
import Element as Element exposing (Attribute, Element, alignBottom, alignRight, alignTop, centerX, centerY, clipX, column, el, fill, fillPortion, height, image, maximum, mouseOver, padding, paddingEach, paddingXY, px, row, rgb, spacingXY, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Material.Icons as Filled
import Material.Icons.Types as MITypes
import Url exposing (percentDecode, percentEncode)
import Url.Builder exposing (crossOrigin)
import Helper exposing (durationToString)
import Spa.Generated.Route as Route exposing (Route)
import WSDecoder exposing (AlbumObj, ArtistObj, ItemDetails, SongObj)



view : String -> Maybe msg -> Bool -> List { title : String, action : Maybe msg } -> Element msg
view headline toggleMoreVertAction showMoreVertIcons moreVertItems =
    Element.row
        [ width fill
        , height (px 50)
        , Background.color Colors.white
        , Font.size 18
        , paddingEach
            { top = 0
            , right = 50
            , bottom = 0
            , left = 16
            }
        ]
        [ Element.text headline
        , Input.button [ height (px 50), width (px 50), alignRight ]
            { onPress = toggleMoreVertAction
            , label =
                el
                    (moreVertMenu
                        showMoreVertIcons
                        moreVertItems
                    )
                    (Element.html
                        (Filled.more_vert 18 (MITypes.Color <| Colors.fromElementColorToColor <| Colors.grey))
                    )
            }
        ]


moreVertMenu : Bool -> List { title : String, action : Maybe msg } -> List (Attribute msg)
moreVertMenu showMenu moreVertItems =
    if showMenu then
        [ Element.below
            (Element.column [ width (px 250), Background.color Colors.grey ]
                (List.map
                    (\n ->
                        Input.button [ height (px 50), width fill, centerX, alignRight ]
                            { onPress = n.action
                            , label = Element.text n.title
                            }
                    )
                    moreVertItems
                )
            )
        ]

    else
        []

artistLabel : ArtistObj -> Element msg
artistLabel artist =
    Element.link [ alignBottom, Element.width fill, Element.height fill, paddingXY 7 16, Font.center, Font.color Colors.black ]
        { url = Route.toString (Route.Music__Artist__Artistid_Int { artistid = artist.artistid })
        , label = Element.text artist.label
        }

viewArtists : List ArtistObj -> Element msg
viewArtists artistlist =
    wrappedRow [ Element.height fill, Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
        (List.map
            (\artist ->
                column [ paddingXY 5 5, Background.color (rgb 1 1 1), mouseOver [ Background.color Colors.sidebar ], Element.height (fill |> maximum 170), Element.width (fill |> maximum 280), Border.rounded 3, clipX ]
                    [ case artist.thumbnail of
                        "" ->
                            image [ width fill, height fill, Element.inFront (artistLabel artist) ]
                                { src = "https://via.placeholder.com/170"
                                , description = "Hero Image"
                                }
                        _ ->
                            image [ width fill, height fill, Element.inFront (artistLabel artist) ]
                                { src = crossOrigin "http://localhost:8080" [ "image", percentEncode artist.thumbnail ] []
                                , description = "Thumbnail"
                                }
                    ]
            )
            artistlist
        )

viewAlbums : List AlbumObj -> Element msg
viewAlbums albumlist =
    wrappedRow [ Element.height fill, Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
        (List.map
            (\album ->
                column [ paddingXY 5 5, Background.color (rgb 1 1 1), mouseOver [ Background.color Colors.sidebar ], Element.height (fill |> maximum 220), Element.width (fill |> maximum 160), Border.rounded 3, clipX ]
                    [ image [ alignTop, width fill, height fill ]
                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
                        , description = "Thumbnail"
                        }
                    , Element.link [ alignBottom, Element.width fill, Element.height fill, paddingXY 7 16, Font.center, Font.color Colors.black ]
                        { url = Route.toString (Route.Music__Album__Albumid_Int { albumid = album.albumid })
                        , label =
                            column []
                                [ Element.text album.label
                                , wrappedRow []
                                    (List.map
                                        (\artist ->
                                            Element.text artist
                                        )
                                        album.artist
                                    )
                                ]
                        }
                    ]
            )
            albumlist
        )

viewAlbumSongs : List AlbumObj -> List SongObj -> Element msg
viewAlbumSongs albumlist songlist =
    column [Element.height fill, Element.width fill]
        (List.map
            (\album ->
                row [ Element.height fill, Element.width fill]
                    [ column []
                        [ case album.thumbnail of
                            "" ->
                                image [ width (fillPortion 1), height fill ]
                                    { src = "https://via.placeholder.com/170"
                                    , description = "Hero Image"
                                    }
                            _ ->
                                image [ width (fillPortion 1), height fill]
                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
                                    , description = "Thumbnail"
                                    } 
                        ]
                    , column [ Element.height fill, Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
                        (List.map
                            (\song ->
                                row [ Element.width fill, paddingXY 5 5, Background.color (rgb 0.2 0.2 0.2), mouseOver [ Background.color (rgb 0.4 0.4 0.4) ]]
                                        [ el [ Font.color Colors.background ] (Element.text song.label)
                                        , row [ alignRight ]
                                            (List.map
                                                (\artist ->
                                                    el [ Font.color Colors.background, paddingXY 5 0 ] (Element.text artist)
                                                )
                                                song.artist
                                            )
                                        , el [ alignRight, Font.color Colors.background ] (song.duration |> durationToString |> Element.text)
                                        ]
                            )
                            (List.filter (\song -> (song.albumid == album.albumid)) songlist) --filtered song list
                        )
                    ]
            )
            albumlist
        )
