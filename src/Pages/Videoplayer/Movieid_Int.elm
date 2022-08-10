module Pages.Videoplayer.Movieid_Int exposing (Model, Msg, Params, page)

import Colors exposing (black, cardHover, darkGreyIcon, greyIcon, white, whiteIcon)
import Components.SectionHeader
import Components.Video
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font exposing (Font)
import Element.Input as Input
import Helper exposing (durationToString)
import Html exposing (video)
import Html.Attributes exposing (..)
import Http
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Shared exposing (sendActions)
import SharedType exposing (VideoModal(..))
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (ItemDetails, MovieObj, Path, prepareDownloadDecoder)


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



-- INIT


type alias Params =
    { movieid : Int }


type alias Model =
    { movieid : Int
    , movie : Maybe MovieObj
    , movie_list : List MovieObj
    , prepareDownloadPath : Maybe String
    , modalstate : VideoModal
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    let
        initialModel =
            { movieid = params.movieid
            , movie = getMovie params.movieid shared.movie_list
            , movie_list = shared.movie_list
            , prepareDownloadPath = shared.prepareDownloadPath
            , modalstate = Closed
            }
    in
    case getMovie params.movieid shared.movie_list of
        Nothing ->
            ( initialModel, Cmd.none )

        Just mov ->
            ( initialModel, postRequestMovie mov.file )


checkMovieId : Int -> MovieObj -> Bool
checkMovieId firstId movie =
    if firstId == movie.movieid then
        True

    else
        False


checkGenre : MovieObj -> MovieObj -> Bool
checkGenre mov movie =
    if mov.genre == movie.genre && mov /= movie then
        True

    else
        False


getRelatedMovies : MovieObj -> List MovieObj -> List MovieObj
getRelatedMovies mov movies =
    List.filter (\movie -> checkGenre mov movie) movies


getMovie : Int -> List MovieObj -> Maybe MovieObj
getMovie id movielist =
    List.head (List.filter (\movie -> checkMovieId id movie) movielist)



-- UPDATE


type Msg
    = GotMovie (Result Http.Error Path)
    | SetCurrentlyPlaying MovieObj
    | QueueMsg
    | ToggleModalMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying movie ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next movie -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"movieid": """ ++ String.fromInt movie.movieid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        QueueMsg ->
            ( model, sendActions [ """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"movieid": """ ++ String.fromInt model.movieid ++ """}}}""" ] )

        ToggleModalMsg ->
            case model.modalstate of
                Closed ->
                    ( { model | modalstate = Open }, Cmd.none )

                Open ->
                    ( { model | modalstate = Closed }, Cmd.none )

        GotMovie result ->
            case result of
                Ok pathObj ->
                    ( { model | prepareDownloadPath = Just pathObj.path }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | prepareDownloadPath = model.prepareDownloadPath }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | movie_list = shared.movie_list, prepareDownloadPath = shared.prepareDownloadPath }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


postRequestMovie : String -> Cmd Msg
postRequestMovie path =
    Http.get
        { url = crossOrigin "http://localhost:8080" [ """jsonrpc?request={"jsonrpc":"2.0","params":{"path":\"""" ++ path ++ """"},"method":"Files.PrepareDownload","id":"1"}""" ] []
        , expect = Http.expectJson GotMovie prepareDownloadDecoder
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Videoplayer.Movieid_Int"
    , body =
        [ case model.movie of
            Nothing ->
                column [ Element.height fill, Element.width fill ]
                    [ Element.text (String.fromInt model.movieid)
                    ]

            Just movie ->
                column [ Element.height fill, Element.width fill, Background.color Colors.sidebar ]
                    [ row [ Element.height (fillPortion 1), Element.width fill, Background.color (Element.rgba255 50 53 55 1), Element.htmlAttribute (Html.Attributes.class "card-parent"), paddingXY 20 15 ]
                        [ column [ Element.width (px 250), Element.height (px 250), Element.htmlAttribute (Html.Attributes.class "card-parent"), alignTop ]
                            [ case movie.thumbnail of
                                "" ->
                                    image [ Element.height (fill |> maximum 250), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = "/thumbnail_default.png"
                                        , description = "Default Thumbnail"
                                        }

                                _ ->
                                    image [ Element.height (fill |> maximum 360), Element.width (fillPortion 2 |> maximum 240) ]
                                        { src = crossOrigin "http://localhost:8080" [ "image", percentEncode movie.poster ] []
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
                                        { onPress = Just (SetCurrentlyPlaying movie)
                                        , label = Element.html (Filled.play_arrow 45 (MITypes.Color <| Colors.whiteIcon))
                                        }
                                    )
                                ]
                            ]
                        , column [ alignTop, Element.height fill, Element.width (fillPortion 7 |> maximum 900), paddingXY 10 35 ]
                            [ row [ alignRight, alignTop, Font.size 25, Element.htmlAttribute (Html.Attributes.style "position" "absolute") ] [ Element.text (String.slice 0 3 (String.fromFloat movie.rating)), Element.html (Filled.star 36 (MITypes.Color <| greyIcon)) ]
                            , row [] [ el [ Font.color white, Font.size 30 ] (Element.text movie.label), el [ alignBottom, paddingXY 10 0, Font.size 15 ] (Element.text (String.fromInt movie.year)) ]
                            , el [ Font.size 19, paddingEach { top = 20, left = 0, right = 0, bottom = 0 } ] (movie.runtime |> durationToString |> text)
                            , column [ paddingEach { top = 20, left = 0, right = 0, bottom = 0 }, spacingXY 0 12, Font.size 14 ]
                                [ row []
                                    [ el [ Font.color white ] (Element.text "Genre: ")
                                    , row []
                                        (List.map
                                            (\genre ->
                                                Element.text (genre ++ " ")
                                            )
                                            movie.genre
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Director: ")
                                    , row []
                                        (List.map
                                            (\director ->
                                                Element.text (director ++ " ")
                                            )
                                            movie.director
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Writers: ")
                                    , row []
                                        (List.map
                                            (\writer ->
                                                Element.text (writer ++ ", ")
                                            )
                                            movie.writer
                                        )
                                    ]
                                , row []
                                    [ el [ Font.color white ] (Element.text "Cast: ")
                                    , row []
                                        (List.map
                                            (\cast ->
                                                Element.text (cast.name ++ ", ")
                                            )
                                            (List.take 5 movie.cast)
                                        )
                                    ]
                                , row [] [ el [ Font.color white ] (Element.text "Rated: "), Element.text movie.mpaa ]
                                ]
                            , column [ paddingXY 0 20, spacingXY 0 10 ]
                                [ row [ spacingXY 5 0 ]
                                    [ el [ Font.color white ] (Element.text "Video:")
                                    , Element.text (String.toUpper movie.streamdetails.video_codec)
                                    , Element.text (String.toUpper (String.fromInt movie.streamdetails.video_height ++ "P"))
                                    , Element.text (String.toUpper ("(" ++ String.fromInt movie.streamdetails.video_width ++ " X " ++ String.fromInt movie.streamdetails.video_height ++ ")"))
                                    ]
                                , row [ paddingXY 0 0, spacingXY 5 0 ]
                                    [ el [ Font.color white ] (Element.text "Audio:")
                                    , Element.text (String.toUpper movie.streamdetails.audio_codec)
                                    , Element.text (String.toUpper (String.fromInt movie.streamdetails.audio_channel))
                                    , Element.text (String.toUpper ("(" ++ movie.streamdetails.audio_language ++ ")"))
                                    ]
                                ]
                            , row [ spacingXY 10 0 ]
                                [ Input.button [ paddingXY 12 8, Background.color Colors.navTextHover ]
                                    { onPress = Just (SetCurrentlyPlaying movie)
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
                        ]
                    , column [ Element.height (fillPortion 5), Element.width fill, paddingXY 35 35, spacingXY 5 7 ]
                        [ el [ Font.size 30, Font.color black ] (Element.text "Synopsis")
                        , paragraph [ Element.width (fill |> maximum 950), spacing 10, paddingXY 0 10, Font.color Colors.black ] [ Element.text movie.plot ]
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
                                movie.cast
                            )
                        , column [ paddingXY 0 30, spacingXY 0 20 ]
                            [ el [ Font.size 30, Font.color Colors.black ] (Element.text "More Related Movies")
                            , row []
                                (List.map
                                    (\movies ->
                                        Components.SectionHeader.viewMovies (SetCurrentlyPlaying movie) movies
                                    )
                                    (getRelatedMovies movie model.movie_list)
                                )
                            ]
                        ]
                    , case movie.fanart of
                        "" ->
                            column [ Element.htmlAttribute (Html.Attributes.class "image-gradient"), alignRight, alignTop ]
                                [ image [ Element.width (fillPortion 2 |> maximum 740) ]
                                    { src = "/concert.jpg"
                                    , description = "Fanart"
                                    }
                                ]

                        _ ->
                            column [ Element.htmlAttribute (Html.Attributes.class "image-gradient"), alignRight, alignTop ]
                                [ image [ Element.width (fillPortion 2 |> maximum 740) ]
                                    { src = crossOrigin "http://localhost:8080" [ "image", percentEncode movie.fanart ] []
                                    , description = "Fanart"
                                    }
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
                                                [ Element.text movie.label
                                                , Input.button [ alignRight ]
                                                    { onPress = Just ToggleModalMsg
                                                    , label = Element.html (Filled.close 16 (MITypes.Color <| greyIcon))
                                                    }
                                                ]
                                            , Components.Video.view [ Background.color (rgb 0 0 0), Element.width (px 700) ]
                                                { poster = crossOrigin "http://localhost:8080" [ "image", percentEncode movie.thumbnail ] []
                                                , source = crossOrigin "http://localhost:8080" [ path ] []
                                                }
                                            ]
                                ]

                        Closed ->
                            Element.none
                    ]
        ]
    }
