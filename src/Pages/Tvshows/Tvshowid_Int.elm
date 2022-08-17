module Pages.Tvshows.Tvshowid_Int exposing (Model, Msg, Params, page)

import Colors exposing (black, cardHover, darkGreyIcon, greyIcon, white, whiteIcon)
import Components.SectionHeader
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font exposing (Font)
import Element.Input as Input
import Html exposing (Html, div, img, input, label, p)
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Request
import Shared exposing (sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (ArtistObj, SeasonObj, TvshowObj, VideoObj)


page : Page Params Model Msg
page =
    Page.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , save = save
        , load = load
        }


type Msg
    = ReplaceMe


type alias Params =
    { tvshowid : Int }


type alias Model =
    { tvshowid : Int
    , tvshow : Maybe TvshowObj
    , tvshow_list : List TvshowObj
    , season_list : List SeasonObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { tvshowid = params.tvshowid, tvshow = getTvShow params.tvshowid shared.tvshow_list, tvshow_list = shared.tvshow_list, season_list = shared.season_list }
    , sendActions [ """{"jsonrpc": "2.0", "method": "VideoLibrary.GetSeasons", "params": {"tvshowid": """ ++ String.fromInt params.tvshowid ++ """ ,"properties":["season","episode","tvshowid","art"]}, "id": "libSeasons"}""" ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | season_list = model.season_list }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | season_list = shared.season_list }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getTvShow : Int -> List TvshowObj -> Maybe TvshowObj
getTvShow id tvShowlist =
    List.head (List.filter (\tvshow -> id == tvshow.tvshowid) tvShowlist)



-- VIEWS


view : Model -> Document Msg
view model =
    { title = "TvShow_Int"
    , body =
        [ case model.tvshow of
            Nothing ->
                column [ Element.height fill, Element.width fill ]
                    [ Element.text (String.fromInt model.tvshowid)
                    ]

            Just tvshow ->
                column [ Element.height fill, Element.width fill ]
                    [ row [ Element.height fill, Element.width fill, Background.color (Element.rgba255 50 53 51 1) ]
                        [ column [ Element.width (px 250), Element.height (px 250), Element.htmlAttribute (Html.Attributes.class "card-parent"), alignTop ]
                            [ case tvshow.thumbnail of
                                "" ->
                                    image [ Element.height (fill |> maximum 360), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = "/thumbnail_default.png"
                                        , description = "Default Thumbnail"
                                        }

                                _ ->
                                    image [ Element.height (fill |> maximum 360), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode tvshow.thumbnail ] []
                                        , description = "Thumbnail"
                                        }
                            , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 360), Element.width (fill |> minimum 230 |> maximum 240), Background.color cardHover ]
                                [ row [ alignTop, alignRight, paddingXY 15 15 ]
                                    [ Input.button []
                                        { onPress = Nothing
                                        , label = Element.html (Filled.thumb_up 25 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    ]
                                , el [ htmlAttribute (Html.Attributes.style "margin" "auto"), paddingEach { top = 0, left = 0, right = 0, bottom = 50 } ]
                                    (Input.button []
                                        { onPress = Nothing
                                        , label = Element.html (Filled.play_arrow 45 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    )
                                ]
                            ]
                        , column [ alignTop, Element.height fill, Element.width (fillPortion 7 |> maximum 900), paddingXY 10 35 ]
                            [ row [ alignRight, alignTop, Font.size 25, Element.htmlAttribute (Html.Attributes.style "position" "absolute") ] [ Element.text (String.slice 0 3 (String.fromFloat tvshow.rating)), Element.html (Filled.star 36 (MITypes.Color <| greyIcon)) ]
                            , row [] [ el [ Font.color white, Font.size 30 ] (Element.text tvshow.label), el [ alignBottom, paddingXY 10 0, Font.size 15 ] (Element.text (String.fromInt tvshow.year)) ]
                            , column [ paddingEach { top = 20, left = 0, right = 0, bottom = 0 }, spacingXY 0 12, Font.size 14 ]
                                [ row []
                                    [ el [ Font.color white ] (Element.text "Genre: ")
                                    , row []
                                        (List.map
                                            (\genre ->
                                                Element.text (genre ++ " ")
                                            )
                                            tvshow.genre
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Studio: ")
                                    , row []
                                        (List.map
                                            (\studio ->
                                                Element.text (studio ++ " ")
                                            )
                                            tvshow.studio
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Cast: ")
                                    , row []
                                        (List.map
                                            (\cast ->
                                                Element.text (cast.name ++ ", ")
                                            )
                                            (List.take 5 tvshow.cast)
                                        )
                                    ]
                                , row [] [ el [ Font.color white ] (Element.text "Rated: "), Element.text tvshow.mpaa ]
                                , row [] [ el [ Font.color white ] (Element.text "Episodes: "), Element.text (String.fromInt tvshow.episode ++ " total" ++ " " ++ "(" ++ String.fromInt (tvshow.episode - tvshow.watchepisode) ++ " unwatched)") ]
                                , Element.html
                                    (div [ style "margin" "2em 0em" ]
                                        [ input [ type_ "checkbox", id "description" ] []
                                        , label [ class "description-text", for "description" ] [ Html.text tvshow.plot ]
                                        ]
                                    )
                                ]
                            , row [ spacingXY 10 0 ]
                                [ Input.button [ paddingXY 12 8, Background.color Colors.navTextHover ]
                                    { onPress = Nothing -- TODO : make it functional once EpisodeObj have been created
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Play"), Element.html (Filled.play_circle_filled 16 (MITypes.Color <| whiteIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Nothing -- TODO : make it functional once EpisodeObj have been created
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Queue"), Element.html (Filled.add_circle 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Nothing -- TODO : Button to set Watched
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Set Watched"), Element.html (Filled.check_box 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Nothing -- TODO : Add More menu dropdown
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "More"), Element.html (Filled.more_vert 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                ]
                            ]
                        , case tvshow.fanart of
                            "" ->
                                image [ Element.width fill, Element.height fill, Element.htmlAttribute (Html.Attributes.class "image-gradient") ]
                                    { src = "/concert.jpg"
                                    , description = "Default-Fanart"
                                    }

                            _ ->
                                image [ Element.width fill, Element.height fill, Element.htmlAttribute (Html.Attributes.class "image-gradient") ]
                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode tvshow.fanart ] []
                                    , description = "Fanart"
                                    }
                        ]
                    , column [ Element.height fill, Element.width fill, paddingXY 35 35, spacingXY 5 7, Background.color (Element.rgba255 245 245 245 1) ]
                        [ wrappedRow [ spacingXY 15 0 ]
                            (List.map
                                (\season ->
                                    Components.SectionHeader.viewSeasons ReplaceMe season
                                )
                                model.season_list
                            )
                        ]
                    ]
        ]
    }
