module Pages.Tvshows.Seasons.Episodes.Episodeid_Int exposing (Model, Msg, Params, page)

import Colors exposing (black, cardHover, darkGreyIcon, greyIcon, white, whiteIcon)
import Components.SectionHeader
import Components.Video
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font exposing (Font)
import Element.Input as Input
import Helper exposing (durationToString)
import Html exposing (Html, div, img, input, label, p)
import Html.Attributes exposing (..)
import Http
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Shared exposing (sendActions)
import SharedType exposing (VideoModal(..))
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (ArtistObj, EpisodeObj, Path, SeasonObj, TvshowObj, VideoObj, prepareDownloadDecoder)


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
    = GotEpisode (Result Http.Error Path)
    | SetCurrentlyPlaying EpisodeObj
    | QueueMsg
    | ToggleModalMsg


type alias Params =
    { tvshowid : Int, season_no : Int, episodeid : Int }


type alias Model =
    { episode_list : List EpisodeObj
    , tvshowid : Int
    , season_no : Int
    , episodeid : Int
    , episode : Maybe EpisodeObj
    , prepareDownloadPath : Maybe String
    , modalstate : VideoModal
    , tvshow : Maybe TvshowObj
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    let
        initialModel =
            { episode_list = shared.episode_list
            , tvshowid = params.tvshowid
            , season_no = params.season_no
            , episodeid = params.episodeid
            , episode = getEpisode params.episodeid shared.episode_list
            , prepareDownloadPath = shared.prepareDownloadPath
            , tvshow = getTvShow params.tvshowid shared.tvshow_list
            , modalstate = Closed
            }
    in
    case getEpisode params.episodeid shared.episode_list of
        Nothing ->
            ( initialModel, Cmd.none )

        Just episode ->
            ( initialModel, postRequestEpisode episode.file )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotEpisode result ->
            case result of
                Ok pathObj ->
                    ( { model | prepareDownloadPath = Just pathObj.path }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        SetCurrentlyPlaying episode ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next episode -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"episodeid": """ ++ String.fromInt episode.episodeid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        QueueMsg ->
            ( model, sendActions [ """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"episodeid": """ ++ String.fromInt model.episodeid ++ """}}}""" ] )

        ToggleModalMsg ->
            case model.modalstate of
                Closed ->
                    ( { model | modalstate = Open }, Cmd.none )

                Open ->
                    ( { model | modalstate = Closed }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getTvShow : Int -> List TvshowObj -> Maybe TvshowObj
getTvShow id tvshowlist =
    List.head (List.filter (\tvshow -> id == tvshow.tvshowid) tvshowlist)


getEpisode : Int -> List EpisodeObj -> Maybe EpisodeObj
getEpisode id episodelist =
    List.head (List.filter (\episode -> id == episode.episodeid) episodelist)


postRequestEpisode : String -> Cmd Msg
postRequestEpisode path =
    Http.get
        { url = crossOrigin "http://localhost:8080" [ """jsonrpc?request={"jsonrpc":"2.0","params":{"path":\"""" ++ path ++ """"},"method":"Files.PrepareDownload","id":"1"}""" ] []
        , expect = Http.expectJson GotEpisode prepareDownloadDecoder
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Episode_Int"
    , body =
        [ case ( model.episode, model.tvshow ) of
            ( Just episode, Just tvshow ) ->
                column [ Element.height fill, Element.width fill ]
                    [ row [ Element.height fill, Element.width fill, Background.color (Element.rgba255 50 53 55 1), paddingXY 20 0 ]
                        [ column [ Element.width (px 250), Element.height (px 250), Element.htmlAttribute (Html.Attributes.class "card-parent"), alignTop ]
                            [ case episode.poster of
                                "" ->
                                    image [ Element.height (fill |> maximum 250), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = "/thumbnail_default.png"
                                        , description = "Default Thumbnail"
                                        }

                                _ ->
                                    image [ Element.height (fill |> maximum 250), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode episode.poster ] []
                                        , description = "Thumbnail"
                                        }
                            , column [ Element.htmlAttribute (Html.Attributes.class "card"), Element.height (px 135), Element.width (fill |> minimum 230 |> maximum 240), Background.color cardHover ]
                                [ row [ alignTop, alignRight, paddingXY 15 15 ]
                                    [ Input.button []
                                        { onPress = Nothing
                                        , label = Element.html (Filled.thumb_up 25 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    ]
                                , el [ htmlAttribute (Html.Attributes.style "margin" "auto"), paddingEach { top = 0, left = 0, right = 0, bottom = 50 } ]
                                    (Input.button []
                                        { onPress = Just (SetCurrentlyPlaying episode)
                                        , label = Element.html (Filled.play_arrow 45 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    )
                                ]
                            ]
                        , column [ alignTop, Element.height fill, Element.width fill, paddingXY 10 35 ]
                            [ row [ alignRight, alignTop, Font.size 25, Element.htmlAttribute (Html.Attributes.style "position" "absolute") ] [ Element.text (String.slice 0 3 (String.fromFloat episode.rating)), Element.html (Filled.star 36 (MITypes.Color <| greyIcon)) ]
                            , row []
                                [ el [ Font.color white, Font.size 30 ] (Element.text episode.title)
                                , Element.link [ alignBottom, paddingXY 10 0, Font.size 15 ]
                                    { url = Route.toString (Route.Tvshows__Tvshowid_Int { tvshowid = model.tvshowid })
                                    , label = Element.text tvshow.label
                                    }
                                , el [ alignBottom ] (Element.text ("S" ++ String.fromInt episode.season ++ " E" ++ String.fromInt episode.episode))
                                ]
                            , el [ Font.size 19, paddingEach { top = 20, left = 0, right = 0, bottom = 0 } ] (episode.runtime |> durationToString |> text)
                            , column [ paddingEach { top = 20, left = 0, right = 0, bottom = 15 }, spacingXY 0 12, Font.size 14 ]
                                [ row []
                                    [ el [ Font.color white ] (Element.text "Season: ")
                                    , Element.link [ alignBottom, paddingXY 10 0, Font.size 15 ]
                                        { url = Route.toString (Route.Tvshows__Seasons__Seasonid_Int { tvshowid = model.tvshowid, season_no = model.season_no })
                                        , label = Element.text ("Season " ++ String.fromInt episode.season)
                                        }
                                    ]
                                , row [] [ el [ Font.color white ] (Element.text "First Aired: "), Element.text episode.firstaired ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Director: ")
                                    , row []
                                        (List.map
                                            (\director ->
                                                Element.text (director ++ " ")
                                            )
                                            episode.director
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Writers: ")
                                    , row []
                                        (List.map
                                            (\writer ->
                                                Element.text (writer ++ ", ")
                                            )
                                            episode.writer
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Cast: ")
                                    , row []
                                        (List.map
                                            (\cast ->
                                                Element.text (cast.name ++ ", ")
                                            )
                                            (List.take 5 episode.cast)
                                        )
                                    ]
                                ]
                            , column [ paddingXY 0 20, spacingXY 0 10 ]
                                [ row [ spacingXY 5 0 ]
                                    [ el [ Font.color white ] (Element.text "Video:")
                                    , Element.text (String.toUpper episode.streamdetails.video_codec)
                                    , Element.text (String.toUpper (String.fromInt episode.streamdetails.video_height ++ "P"))
                                    , Element.text (String.toUpper ("(" ++ String.fromInt episode.streamdetails.video_width ++ " X " ++ String.fromInt episode.streamdetails.video_height ++ ")"))
                                    ]
                                , row [ paddingXY 0 0, spacingXY 5 0 ]
                                    [ el [ Font.color white ] (Element.text "Audio:")
                                    , Element.text (String.toUpper episode.streamdetails.audio_codec)
                                    , Element.text (String.toUpper (String.fromInt episode.streamdetails.audio_channel))
                                    , Element.text (String.toUpper ("(" ++ episode.streamdetails.audio_language ++ ")"))
                                    ]
                                ]
                            , row [ spacingXY 10 0 ]
                                [ Input.button [ paddingXY 12 8, Background.color Colors.navTextHover ]
                                    { onPress = Just (SetCurrentlyPlaying episode)
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Play"), Element.html (Filled.play_circle_filled 16 (MITypes.Color <| whiteIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Just QueueMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Queue"), Element.html (Filled.add_circle 16 (MITypes.Color <| greyIcon)) ]
                                    }
                                , Input.button [ paddingXY 12 8, Background.color (Element.rgba255 71 74 75 1) ]
                                    { onPress = Just ToggleModalMsg
                                    , label = row [] [ el [ Font.color white, paddingEach { top = 0, left = 0, right = 10, bottom = 0 } ] (Element.text "Stream"), Element.html (Filled.cast_connected 16 (MITypes.Color <| greyIcon)) ]
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
                        , case episode.season_poster of
                            "" ->
                                image [ Element.width fill, Element.height fill, Element.htmlAttribute (Html.Attributes.class "image-gradient") ]
                                    { src = "/concert.jpg"
                                    , description = "Fanart"
                                    }

                            _ ->
                                image [ Element.width fill, Element.height fill, Element.htmlAttribute (Html.Attributes.class "image-gradient") ]
                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode episode.season_poster ] []
                                    , description = "Fanart"
                                    }
                        ]
                    , column [ Element.height fill, Element.width fill, paddingXY 35 35, spacingXY 5 30, Background.color (Element.rgba255 245 245 245 1) ]
                        [ el [ Font.size 25, Font.color black ] (Element.text "Synopsis")
                        , paragraph [ Element.width (fill |> maximum 950), spacing 10, paddingXY 0 10, Font.color Colors.black ] [ Element.text episode.plot ]
                        , column []
                            [ el [ Font.size 25, Font.color black ] (Element.text "Full cast")
                            , row [ Element.width (fill |> maximum 950), Element.height (px 200), clipX, scrollbarX, spacingXY 10 0 ]
                                (List.map
                                    (\cast ->
                                        case cast.thumbnail of
                                            "" ->
                                                image [ Element.width (px 80), Element.htmlAttribute (Html.Attributes.class "cast-image"), Element.htmlAttribute (Html.Attributes.title (cast.name ++ " " ++ "(" ++ cast.role ++ ")")) ]
                                                    { src = "/thumbnail_default.png"
                                                    , description = "thumbnail_default"
                                                    }

                                            _ ->
                                                image [ Element.width (px 80), Element.htmlAttribute (Html.Attributes.class "cast-image"), Element.htmlAttribute (Html.Attributes.title (cast.name ++ " " ++ "(" ++ cast.role ++ ")")) ]
                                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode cast.thumbnail ] []
                                                    , description = "cast-image"
                                                    }
                                    )
                                    episode.cast
                                )
                            ]
                        , column [ spacingXY 0 20 ]
                            [ el [ Font.size 25, Font.color black ] (Element.text ("Season " ++ String.fromInt episode.season))
                            , wrappedRow [ spacingXY 15 20 ]
                                (List.map
                                    (\episodes -> Components.SectionHeader.viewEpisode model.tvshowid model.season_no (SetCurrentlyPlaying episodes) episodes)
                                    (List.filter (\episodes -> model.season_no == episodes.season) model.episode_list)
                                )
                            ]
                        ]
                    , case model.modalstate of
                        Open ->
                            column [ Element.htmlAttribute (Html.Attributes.class "video-modal"), Element.width fill, Element.height fill ]
                                [ case model.prepareDownloadPath of
                                    Nothing ->
                                        column [ Element.htmlAttribute (Html.Attributes.class "video-modal-body") ]
                                            [ row [ Background.color Colors.backgroundLocal, paddingXY 20 20, Element.width fill, Font.color white, Font.size 20, spacingXY 20 0 ]
                                                [ Element.text "Video not available"
                                                , Input.button [ alignRight ]
                                                    { onPress = Just ToggleModalMsg
                                                    , label = Element.html (Filled.close 16 (MITypes.Color <| greyIcon))
                                                    }
                                                ]
                                            ]

                                    Just path ->
                                        column [ Element.htmlAttribute (Html.Attributes.class "video-modal-body") ]
                                            [ row [ Background.color Colors.backgroundLocal, paddingXY 20 20, Element.width fill, Font.color white, Font.size 20 ]
                                                [ Element.text episode.label
                                                , Input.button [ alignRight ]
                                                    { onPress = Just ToggleModalMsg
                                                    , label = Element.html (Filled.close 16 (MITypes.Color <| greyIcon))
                                                    }
                                                ]
                                            , Components.Video.view [ Background.color (rgb 0 0 0), Element.width (px 700) ]
                                                { poster = crossOrigin "http://localhost:8080" [ "image", percentEncode episode.poster ] []
                                                , source = crossOrigin "http://localhost:8080" [ path ] []
                                                }
                                            ]
                                ]

                        Closed ->
                            Element.none
                    ]

            _ ->
                Element.text (String.fromInt model.episodeid)
        ]
    }
