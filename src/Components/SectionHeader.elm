module Components.SectionHeader exposing (view, viewAlbums, viewArtists, viewVideos)

import Colors exposing (cardHover)
import Element as Element exposing (Attribute, Element, alignBottom, alignLeft, alignRight, alignTop, centerX, centerY, clipX, column, el, fill, fillPortion, height, image, maximum, minimum, mouseOver, padding, paddingEach, paddingXY, px, rgb, row, spacingXY, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Helper exposing (durationToString)
import Html.Attributes
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Spa.Generated.Route as Route exposing (Route)
import Url exposing (percentDecode, percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (AlbumObj, ArtistObj, ItemDetails, SongObj, VideoObj)


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
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0 2px 6px -6px black")
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
    Element.link [ Element.width fill, Element.height fill, paddingXY 7 16, Font.center, Font.color Colors.black ]
        { url = Route.toString (Route.Music__Artist__Artistid_Int { artistid = artist.artistid })
        , label = Element.text artist.label
        }


videoLabel : VideoObj -> Element msg
videoLabel video =
    Element.link [ Element.width fill, Element.height fill, paddingXY 7 16, Font.center, Font.color Colors.black ]
        { url = Route.toString (Route.Music__Videos__Videoid_Int { videoid = video.videoid })
        , label = Element.text video.label
        }


viewArtists : msg -> ArtistObj -> Element msg
viewArtists buttonMsg artist =
    column
        [ Background.color (rgb 1 1 1)
        , Element.height (fill |> minimum 130 |> maximum 190)
        , Element.width (fill |> minimum 280 |> maximum 280)
        , Border.rounded 3
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        ]
        [ case artist.thumbnail of
            "" ->
                image [ width fill, height (px 150) ]
                    { src = "https://via.placeholder.com/170"
                    , description = "Hero Image"
                    }

            _ ->
                image [ width fill, height (px 150) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode artist.thumbnail ] []
                    , description = "Thumbnail"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 150), Element.width (px 280), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.thumb_up, buttonMsg )
                , materialButtonBig ( Filled.more_vert, buttonMsg )
                ]
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            ]
        , el [ alignLeft ] (artistLabel artist)
        ]


viewVideos : List VideoObj -> Element msg
viewVideos videoslist =
    wrappedRow [ Element.height fill, Element.width fill, paddingXY 5 5, spacingXY 5 7 ]
        (List.map
            (\video ->
                column
                    [ paddingXY 5 5
                    , Background.color (rgb 1 1 1)
                    , mouseOver [ Background.color Colors.sidebar ]
                    , Element.height (fill |> minimum 170 |> maximum 170)
                    , Element.width (fill |> minimum 280 |> maximum 280)
                    , Border.rounded 3
                    , clipX

                    --, Element.below (videoLabel video)
                    ]
                    [ case video.thumbnail of
                        "" ->
                            image [ width fill, height fill, Element.inFront (videoLabel video) ]
                                { src = "https://via.placeholder.com/170"
                                , description = "Hero Image"
                                }

                        _ ->
                            image [ width fill, height fill, Element.inFront (videoLabel video) ]
                                { src = crossOrigin "http://localhost:8080" [ "image", percentEncode video.thumbnail ] []
                                , description = "Thumbnail"
                                }
                    , videoLabel video
                    ]
            )
            videoslist
        )


viewAlbums : msg -> AlbumObj -> Element msg
viewAlbums buttonMsg album =
    column [ Background.color (rgb 1 1 1), Element.htmlAttribute (Html.Attributes.class "card-parent"), Element.height (fill |> maximum 220), Element.width (fill |> minimum 160 |> maximum 160), Border.rounded 3 ]
        [ image [ alignTop, width fill, height fill ]
            { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
            , description = "Thumbnail"
            }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 160), Element.width (fill |> minimum 160 |> maximum 160), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.thumb_up, buttonMsg )
                , materialButtonBig ( Filled.more_vert, buttonMsg )
                ]
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            ]
        , Element.link [ alignBottom, paddingEach { left = 10, right = 0, top = 5, bottom = 0 }, Font.color Colors.black ]
            { url = Route.toString (Route.Music__Album__Albumid_Int { albumid = album.albumid })
            , label =
                column []
                    [ Element.text album.label
                    , wrappedRow [ paddingEach { left = 0, right = 0, top = 5, bottom = 0 }, Font.color Colors.greyscaleGray, Font.size 13 ]
                        (List.map
                            (\artist ->
                                el [ alignLeft, height (px 20), width (px 130), clipX ] (Element.text artist)
                            )
                            album.artist
                        )
                    ]
            }
        ]


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 20 (MITypes.Color <| Colors.whiteIcon))
        }


materialButtonBig : ( Icon msg, msg ) -> Element msg
materialButtonBig ( icon, action ) =
    Input.button [ paddingXY 5 3 ]
        { onPress = Just action
        , label = Element.html (icon 30 (MITypes.Color <| Colors.whiteIcon))
        }
