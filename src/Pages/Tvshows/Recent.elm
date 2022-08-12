module Pages.Tvshows.Recent exposing (Model, Msg, Params, page)

import Colors exposing (greyIcon)
import Components.SectionHeader
import Components.VerticalNav
import Components.VerticalNavTvshows
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events
import Element.Font as Font
import Element.Input as Input
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import Request
import Shared exposing (sendAction, sendActions)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Svg.Attributes
import Url exposing (percentEncode)
import Url.Builder exposing (crossOrigin)
import WSDecoder exposing (ItemDetails, TvshowObj)



--import TvshowItem exposing ()
--import Components exposing ()


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
    ()


type alias Model =
    { currentlyPlaying : Maybe ItemDetails
    , tvshow_list : List TvshowObj
    , route : Route
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { currentlyPlaying = shared.currentlyPlaying, tvshow_list = shared.tvshow_list, route = url.route }
    , sendAction """{"jsonrpc": "2.0", "method": "VideoLibrary.GetTvshows", "params": { "filter": {"field": "playcount", "operator": "is", "value": "0"}, "properties" : ["art", "rating", "thumbnail", "playcount", "file","year","dateadded","mpaa","genre","season","studio","episode","watchedepisodes","plot","cast"], "sort": { "order": "ascending", "method": "label", "ignorearticle": true } }, "id": "libTvshows"}"""
    )



-- UPDATE


type Msg
    = SetCurrentlyPlaying TvshowObj
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentlyPlaying tvshow ->
            ( model
            , sendActions
                [ {- clear the queue -} """{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}"""
                , {- add the next tvshow -} """{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"tvshowid": """ ++ String.fromInt tvshow.tvshowid ++ """}}}"""
                , {- play -} """{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}"""
                ]
            )

        NoOp ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    { shared | currentlyPlaying = model.currentlyPlaying, tvshow_list = model.tvshow_list }


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { model | tvshow_list = shared.tvshow_list }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


materialButton : ( Icon msg, msg ) -> Element msg
materialButton ( icon, action ) =
    Input.button [ paddingXY 5 3, Background.color (rgb 0.2 0.2 0.2) ]
        { onPress = Just action
        , label = Element.html (icon 24 (MITypes.Color <| greyIcon))
        }


constructTvshowItem : TvshowObj -> Element Msg
constructTvshowItem tvshow =
    column [ spacingXY 5 0, Element.width fill, Element.height fill ]
        [ image
            [ Element.width (fill |> minimum 150 |> maximum 150)
            , Element.height (fill |> minimum 200 |> maximum 200)
            , inFront
                (row []
                    [ materialButton ( Filled.play_arrow, NoOp ) ]
                )

            {- , Element.Events.onMouseEnter ShowMenu
               , Element.Events.onMouseLeave CloseMenu
            -}
            ]
            (if String.isEmpty tvshow.thumbnail then
                { src = "/thumbnail_default.png"
                , description = "Hero Image"
                }

             else
                { description = tvshow.label
                , src = crossOrigin "http://localhost:8080" [ "image", percentEncode tvshow.thumbnail ] []
                }
            )
        , column [ alignBottom, Background.color (rgb 1 1 1), Element.width (fill |> minimum 150 |> maximum 150), clip ]
            [ el [ Font.color (Element.rgb 0 0 0), Font.size 18 ] (Element.text tvshow.label)
            , el [ Font.color (Element.rgb 0.6 0.6 0.6), Font.size 18 ] (Element.text "2020")
            ]
        ]



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Tvshows"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ Components.VerticalNavTvshows.view model.route
            , column [ Element.height fill, Element.width (fillPortion 6), spacingXY 5 7, Background.color Colors.background ]
                [ column [ Element.height fill, Element.width fill ]
                    [ Components.SectionHeader.view "Recently Added TV shows"
                        Nothing
                        False
                        []
                    , wrappedRow [ Element.height fill, Element.width (fillPortion 6), Background.color (rgb 0.8 0.8 0.8), spacingXY 15 10, padding 30 ]
                        (List.map
                            (\tvshow ->
                                Components.SectionHeader.viewTvShows (SetCurrentlyPlaying tvshow) tvshow
                            )
                            model.tvshow_list
                        )
                    ]
                , column [ Element.height fill, Element.width fill ]
                    [ Components.SectionHeader.view "All TV shows"
                        Nothing
                        False
                        []
                    , wrappedRow [ Element.height fill, Element.width (fillPortion 6), Background.color (rgb 0.8 0.8 0.8), spacingXY 15 10, padding 30 ]
                        (List.map
                            (\tvshow ->
                                Components.SectionHeader.viewTvShows (SetCurrentlyPlaying tvshow) tvshow
                            )
                            model.tvshow_list
                        )
                    ]
                ]
            ]
        ]
    }
