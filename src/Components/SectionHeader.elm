module Components.SectionHeader exposing (view, viewAlbums, viewArtists, viewEpisode, viewMovies, viewSeasons, viewTvShows, viewVideos)

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
import Round
import Spa.Generated.Route as Route exposing (Route)
import Url exposing (percentDecode, percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (AlbumObj, ArtistObj, EpisodeObj, ItemDetails, MovieObj, SeasonObj, SongObj, TvshowObj, VideoObj)


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
    Element.link [ Element.width fill, Element.height fill, paddingXY 7 16, Font.color Colors.black ]
        { url = Route.toString (Route.Music__Artist__Artistid_Int { artistid = artist.artistid })
        , label = el [ height (px 15), width (px 250), clipX ] (Element.text artist.label)
        }


videoLabel : VideoObj -> Element msg
videoLabel video =
    Element.link [ Element.width fill, Element.height (px 30), paddingXY 12 10, Font.color Colors.black ]
        { url = Route.toString (Route.Music__Videos__Videoid_Int { videoid = video.videoid })
        , label =
            column []
                [ el [ height (px 15), width (px 250), clipX ] (Element.text video.label)
                , wrappedRow [ paddingEach { left = 0, right = 0, top = 10, bottom = 0 }, Font.color Colors.greyscaleGray, Font.size 13 ]
                    (List.map
                        (\artist ->
                            el [ alignLeft, height (px 20), width (px 130), clipX ] (Element.text artist)
                        )
                        video.artist
                    )
                ]
        }


viewArtists : msg -> ArtistObj -> Element msg
viewArtists buttonMsg artist =
    column
        [ Background.color (rgb 1 1 1)
        , Element.height (fill |> minimum 130 |> maximum 190)
        , Element.width (fill |> minimum 280 |> maximum 280)
        , Border.rounded 3
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0px 0px 2px #888888")
        ]
        [ case artist.thumbnail of
            "" ->
                image [ width fill, height (fill |> minimum 150 |> maximum 150) ]
                    { src = "/thumbnail_default.png"
                    , description = "Hero Image"
                    }

            _ ->
                image [ width fill, height (fill |> minimum 150 |> maximum 150) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode artist.thumbnail ] []
                    , description = "Thumbnail"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 150), Element.width (px 280), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.thumb_up, buttonMsg )
                , materialButtonBig ( Filled.more_vert, buttonMsg )
                ]
            , Element.link [ width fill, height fill, Element.htmlAttribute (Html.Attributes.class "card-link") ]
                { url = Route.toString (Route.Music__Artist__Artistid_Int { artistid = artist.artistid })
                , label = Element.none
                }
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            ]
        , el [ alignLeft ] (artistLabel artist)
        ]


viewVideos : msg -> VideoObj -> Element msg
viewVideos buttonMsg video =
    column
        [ Background.color (rgb 1 1 1)
        , Element.height (fill |> minimum 130 |> maximum 180)
        , Element.width (fill |> minimum 280 |> maximum 280)
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0px 0px 2px #888888")
        ]
        [ case video.thumbnail of
            "" ->
                image [ width fill, height (px 125) ]
                    { src = "/thumbnail_default.png"
                    , description = "Hero Image"
                    }

            _ ->
                image [ width fill, height (px 125) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode video.thumbnail ] []
                    , description = "Thumbnail"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 125), Element.width (px 280), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.thumb_up, buttonMsg )
                , materialButtonBig ( Filled.more_vert, buttonMsg )
                ]
            , Element.link [ width fill, height fill, Element.htmlAttribute (Html.Attributes.class "card-link") ]
                { url = Route.toString (Route.Music__Videos__Videoid_Int { videoid = video.videoid })
                , label = Element.none
                }
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            ]
        , videoLabel video
        ]


viewAlbums : msg -> AlbumObj -> Element msg
viewAlbums buttonMsg album =
    column
        [ Background.color (rgb 1 1 1)
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        , Element.height (fill |> maximum 220)
        , Element.width (fill |> minimum 160 |> maximum 160)
        , Border.rounded 3
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0px 0px 2px #888888")
        ]
        [ case album.thumbnail of
            "" ->
                image [ alignTop, width fill, height (fill |> minimum 160 |> maximum 160) ]
                    { src = "/thumbnail_default.png"
                    , description = "Thumbnail"
                    }

            _ ->
                image [ alignTop, width fill, height (fill |> minimum 160 |> maximum 160) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode album.thumbnail ] []
                    , description = "Thumbnail"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 160), Element.width (fill |> minimum 160 |> maximum 160), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.thumb_up, buttonMsg )
                , materialButtonBig ( Filled.more_vert, buttonMsg )
                ]
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            , Element.link [ width fill, height fill, Element.htmlAttribute (Html.Attributes.class "card-link") ]
                { url = Route.toString (Route.Music__Album__Albumid_Int { albumid = album.albumid })
                , label = Element.none
                }
            ]
        , Element.link [ alignBottom, paddingEach { left = 10, right = 0, top = 5, bottom = 0 }, Font.color Colors.black ]
            { url = Route.toString (Route.Music__Album__Albumid_Int { albumid = album.albumid })
            , label =
                column []
                    [ el [ height (px 15), width (px 135), clipX ] (Element.text album.label)
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


viewMovies : msg -> MovieObj -> Element msg
viewMovies buttonMsg movie =
    column
        [ Background.color (rgb 1 1 1)
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        , Element.height (fill |> maximum 310)
        , Element.width (fill |> minimum 170 |> maximum 170)
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0px 0px 2px #888888")
        ]
        [ case movie.poster of
            "" ->
                image [ alignTop, width fill, height (fill |> minimum 260 |> maximum 260) ]
                    { src = "/thumbnail_default.png"
                    , description = "Default thumbnail"
                    }

            _ ->
                image [ alignTop, width fill, height (fill |> minimum 260 |> maximum 260) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode movie.poster ] []
                    , description = "Poster"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 255), Element.width (fill |> minimum 170 |> maximum 170), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.check_box_outline_blank, buttonMsg ) -- TODO : checkbox to Set Watched
                , materialButton ( Filled.thumb_up, buttonMsg ) -- TODO : make it functional when the thumbs-up page gets implemented
                , materialButtonBig ( Filled.more_vert, buttonMsg ) -- TODO : Add Dropdown
                ]
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            , Element.link [ width fill, height fill, Element.htmlAttribute (Html.Attributes.class "card-link") ]
                { url = Route.toString (Route.Videoplayer__Movieid_Int { movieid = movie.movieid })
                , label = Element.none
                }
            ]
        , Element.link [ Element.width fill, Element.height fill, alignBottom, paddingEach { left = 10, right = 0, top = 10, bottom = 10 }, Font.color Colors.black ]
            { url = Route.toString (Route.Videoplayer__Movieid_Int { movieid = movie.movieid })
            , label =
                column []
                    [ el [ height (px 15), width (px 150) ] (Element.text movie.label)
                    , el [ paddingEach { left = 0, right = 0, top = 5, bottom = 0 }, Font.color Colors.greyscaleGray, Font.size 13 ]
                        (Element.text (String.fromInt movie.year))
                    ]
            }
        ]


viewTvShows : msg -> TvshowObj -> Element msg
viewTvShows buttonMsg tvshow =
    column
        [ Background.color (rgb 1 1 1)
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        , Element.height (fill |> maximum 310)
        , Element.width (fill |> minimum 170 |> maximum 170)
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0px 0px 2px #888888")
        ]
        [ case tvshow.thumbnail of
            "" ->
                image [ alignTop, width fill, height (fill |> minimum 260 |> maximum 260) ]
                    { src = "/thumbnail_default.png"
                    , description = "Default thumbnail"
                    }

            _ ->
                image [ alignTop, width fill, height (fill |> minimum 260 |> maximum 260) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode tvshow.thumbnail ] []
                    , description = "Poster"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 255), Element.width (fill |> minimum 170 |> maximum 170), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.check_box_outline_blank, buttonMsg ) -- TODO : checkbox to Set Watched
                , materialButton ( Filled.thumb_up, buttonMsg ) -- TODO : make it functional when the thumbs-up page gets implemented
                , materialButtonBig ( Filled.more_vert, buttonMsg ) -- TODO : Add Dropdown
                ]
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            , Element.link [ width fill, height fill, Element.htmlAttribute (Html.Attributes.class "card-link") ]
                { url = Route.toString (Route.Tvshows__Tvshowid_Int { tvshowid = tvshow.tvshowid })
                , label = Element.none
                }
            ]
        , Element.link [ Element.width fill, Element.height fill, alignBottom, paddingEach { left = 10, right = 0, top = 10, bottom = 10 }, Font.color Colors.black ]
            { url = Route.toString (Route.Tvshows__Tvshowid_Int { tvshowid = tvshow.tvshowid })
            , label =
                column []
                    [ el [ height (px 15), width (px 150), clipX ] (Element.text tvshow.label)
                    , el [ paddingEach { left = 0, right = 0, top = 5, bottom = 0 }, Font.color Colors.greyscaleGray, Font.size 13 ]
                        (Element.text (Round.round 1 tvshow.rating))
                    ]
            }
        ]


viewSeasons : Int -> msg -> SeasonObj -> Element msg
viewSeasons tvshowid buttonMsg season =
    column
        [ Background.color (rgb 1 1 1)
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        , Element.height (fill |> maximum 310)
        , Element.width (fill |> minimum 170 |> maximum 170)
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0px 0px 2px #888888")
        ]
        [ case season.poster of
            Nothing ->
                image [ alignTop, width fill, height (fill |> minimum 255 |> maximum 255) ]
                    { src = "/thumbnail_default.png"
                    , description = "Default thumbnail"
                    }

            Just poster ->
                image [ alignTop, width fill, height (fill |> minimum 255 |> maximum 255) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode poster ] []
                    , description = "Poster"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 255), Element.width (fill |> minimum 170 |> maximum 170), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.check_box_outline_blank, buttonMsg ) -- TODO : checkbox to Set Watched
                , materialButtonBig ( Filled.more_vert, buttonMsg ) -- TODO : Add Dropdown
                ]
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            , Element.link [ width fill, height fill, Element.htmlAttribute (Html.Attributes.class "card-link") ]
                { url = Route.toString (Route.Tvshows__Seasons__Seasonid_Int { tvshowid = tvshowid, season_no = season.season })
                , label = Element.none
                }
            ]
        , Element.link [ Element.width fill, Element.height fill, alignBottom, paddingEach { left = 10, right = 0, top = 10, bottom = 10 }, Font.color Colors.black ]
            { url = Route.toString (Route.Tvshows__Seasons__Seasonid_Int { tvshowid = tvshowid, season_no = season.season })
            , label =
                column []
                    [ el [ height (px 15), width (px 150), clipX ] (Element.text season.label)
                    , el [ paddingEach { left = 0, right = 0, top = 5, bottom = 0 }, Font.color Colors.greyscaleGray, Font.size 13 ]
                        (Element.text (String.fromInt season.episode ++ " episodes"))
                    ]
            }
        ]


viewEpisode : Int -> Int -> msg -> EpisodeObj -> Element msg
viewEpisode tvshowid season_no buttonMsg episode =
    column
        [ Background.color (rgb 1 1 1)
        , Element.height (fill |> minimum 140 |> maximum 190)
        , Element.width (fill |> minimum 280 |> maximum 280)
        , Element.htmlAttribute (Html.Attributes.class "card-parent")
        , Element.htmlAttribute (Html.Attributes.style "box-shadow" "0px 8px 6px -10px #888888")
        ]
        [ case episode.poster of
            "" ->
                image [ width fill, height (fill |> minimum 135 |> maximum 135) ]
                    { src = "/thumbnail_default.png"
                    , description = "Hero Image"
                    }

            _ ->
                image [ width fill, height (fill |> minimum 135 |> maximum 135) ]
                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode episode.poster ] []
                    , description = "Thumbnail"
                    }
        , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 135), Element.width (px 280), Background.color cardHover ]
            [ row [ alignTop, alignRight, paddingXY 0 10 ]
                [ materialButton ( Filled.check_box_outline_blank, buttonMsg )
                , materialButton ( Filled.thumb_up, buttonMsg )
                , materialButtonBig ( Filled.more_vert, buttonMsg )
                ]
            , Element.link [ width fill, height fill, Element.htmlAttribute (Html.Attributes.class "card-link") ]
                { url = Route.toString (Route.Tvshows__Seasons__Episodes__Episodeid_Int { tvshowid = tvshowid, season_no = season_no, episodeid = episode.episodeid })
                , label = Element.none
                }
            , el [ alignBottom, padding 10 ] (materialButtonBig ( Filled.play_arrow, buttonMsg ))
            ]
        , Element.link [ Element.width fill, Element.height fill, alignBottom, paddingEach { left = 10, right = 0, top = 10, bottom = 10 }, Font.color Colors.black ]
            { url = Route.toString (Route.Tvshows__Seasons__Episodes__Episodeid_Int { tvshowid = tvshowid, season_no = season_no, episodeid = episode.episodeid })
            , label =
                column [ spacingXY 0 10 ]
                    [ el [ height (px 15), width (px 250), clipX ] (Element.text episode.title)
                    , el [ Font.color Colors.greyscaleGray, Font.size 13 ] (Element.text ("Episode " ++ String.fromInt episode.episode))
                    ]
            }
        ]


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3, Element.htmlAttribute (Html.Attributes.class "card-button") ]
        { onPress = Just action
        , label = Element.html (icon 20 (MITypes.Color <| Colors.whiteIcon))
        }


materialButtonBig : ( Icon msg, msg ) -> Element msg
materialButtonBig ( icon, action ) =
    Input.button [ paddingXY 5 3, Element.htmlAttribute (Html.Attributes.class "card-button") ]
        { onPress = Just action
        , label = Element.html (icon 30 (MITypes.Color <| Colors.whiteIcon))
        }
