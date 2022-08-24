module Pages.Tvshows.Seasons.Seasonid_Int exposing (Model, Msg, Params, page)

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
import Shared exposing (sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (ArtistObj, EpisodeObj, SeasonObj, TvshowObj, VideoObj)


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
    | PlayMsg
    | SetCurrentlyPlaying EpisodeObj
    | QueueMsg


type alias Params =
    { tvshowid : Int, season_no : Int }


type alias Model =
    { season_list : List SeasonObj
    , season_no : Int
    , tvshowid : Int
    , season : Maybe SeasonObj
    , tvshow_list : List TvshowObj
    , tvshow : Maybe TvshowObj
    , episode_list : List EpisodeObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { tvshowid = params.tvshowid
      , tvshow = getTvShow params.tvshowid shared.tvshow_list
      , tvshow_list = shared.tvshow_list
      , season_list = shared.season_list
      , season_no = params.season_no
      , season = getSeason params.season_no shared.season_list
      , episode_list = shared.episode_list
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        PlayMsg ->
            let
                add_episode =
                    List.map (\episode -> """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"episodeid": """ ++ String.fromInt episode.episodeid ++ """}}}""") (List.filter (\episodes -> model.season_no == episodes.season) model.episode_list)

                output =
                    [ """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}""" ]
                        ++ add_episode
                        ++ [ """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}""" ]
            in
            ( model, sendActions output )

        SetCurrentlyPlaying episode ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next episode -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"episodeid": """ ++ String.fromInt episode.episodeid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        QueueMsg ->
            ( model
            , sendActions
                (List.map (\episode -> """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"episodeid": """ ++ String.fromInt episode.episodeid ++ """}}}""") (List.filter (\episodes -> model.season_no == episodes.season) model.episode_list))
            )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getSeason : Int -> List SeasonObj -> Maybe SeasonObj
getSeason id seasonlist =
    List.head (List.filter (\season -> id == season.season) seasonlist)


getTvShow : Int -> List TvshowObj -> Maybe TvshowObj
getTvShow id tvShowlist =
    List.head (List.filter (\tvshow -> id == tvshow.tvshowid) tvShowlist)



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Season_Int"
    , body =
        [ case ( model.season, model.tvshow ) of
            ( Just season, Just tvshow ) ->
                column [ Element.height fill, Element.width fill ]
                    [ row [ Element.height fill, Element.width fill, Background.color (Element.rgba255 50 53 55 1) ]
                        [ column [ Element.width (px 250), Element.height (px 250), Element.htmlAttribute (Html.Attributes.class "card-parent"), alignTop ]
                            [ case season.poster of
                                "" ->
                                    image [ Element.height (fill |> maximum 250), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = "/thumbnail_default.png"
                                        , description = "Default Thumbnail"
                                        }

                                _ ->
                                    image [ Element.height (fill |> maximum 360), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode season.poster ] []
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
                                        { onPress = Just PlayMsg
                                        , label = Element.html (Filled.play_arrow 45 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    )
                                ]
                            ]
                        , column [ alignTop, Element.height fill, Element.width (fillPortion 7 |> maximum 900), paddingXY 10 35 ]
                            [ row [ alignRight, alignTop, Font.size 25, Element.htmlAttribute (Html.Attributes.style "position" "absolute") ] [ Element.text (String.slice 0 3 (String.fromFloat tvshow.rating)), Element.html (Filled.star 36 (MITypes.Color <| greyIcon)) ]
                            , row []
                                [ el [ Font.color white, Font.size 30 ] (Element.text season.label)
                                , Element.link [ alignBottom, paddingXY 10 0, Font.size 15 ]
                                    { url = Route.toString (Route.Tvshows__Tvshowid_Int { tvshowid = tvshow.tvshowid })
                                    , label = Element.text tvshow.label
                                    }
                                ]
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
                                    [ el [ Font.color white ] (Element.text "Cast: ")
                                    , row []
                                        (List.map
                                            (\cast ->
                                                Element.text (cast.name ++ ", ")
                                            )
                                            (List.take 5 tvshow.cast)
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
                                , row [] [ el [ Font.color white ] (Element.text "Rated: "), Element.text tvshow.mpaa ]
                                , row [] [ el [ Font.color white ] (Element.text "Episodes: "), Element.text (String.fromInt season.episode ++ " total" ++ " " ++ "(" ++ String.fromInt (season.episode - season.watchedepisodes) ++ " unwatched)") ]
                                , Element.html
                                    (div [ style "margin" "2em 0em" ]
                                        [ input [ type_ "checkbox", id "description" ] []
                                        , label [ class "description-text", for "description" ] [ Html.text tvshow.plot ]
                                        ]
                                    )
                                ]
                            , row [ spacingXY 10 0 ]
                                [ Input.button [ paddingXY 12 8, Background.color Colors.navTextHover ]
                                    { onPress = Just PlayMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Play"), Element.html (Filled.play_circle_filled 16 (MITypes.Color <| whiteIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Just QueueMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Queue"), Element.html (Filled.add_circle 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Nothing -- TODO : Button to set Watched
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Set Watched"), Element.html (Filled.check_box 16 (MITypes.Color <| greyIcon)) ]
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
                        [ wrappedRow [ spacingXY 15 20 ]
                            (List.map
                                (\episode -> Components.SectionHeader.viewEpisode model.tvshowid model.season_no (SetCurrentlyPlaying episode) episode)
                                (List.filter (\episodes -> model.season_no == episodes.season) model.episode_list)
                            )
                        ]
                    ]

            _ ->
                Element.text (String.fromInt model.season_no)
        ]
    }
