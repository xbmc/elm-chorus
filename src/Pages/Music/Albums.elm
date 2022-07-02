module Pages.Music.Albums exposing (Model, Msg, Params, page)

import Colors
import Components.SectionHeader
import Components.VerticalNav
import Components.VerticalNavMusic
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import Shared
import SharedType exposing (Selected(..))
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import WSDecoder exposing (AlbumObj)


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
    { album_list : List AlbumObj
    , route : Route
    , currentButton : Selected
    , titleToggle : Bool
    , dateToggle : Bool
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared url =
    ( { album_list = shared.album_list, route = url.route, currentButton = Title, titleToggle = True, dateToggle = False }, Cmd.none )



-- UPDATE


type Msg
    = TitleButtonMsg
    | DateButtonMsg


sbylabelalbum : List AlbumObj -> List AlbumObj
sbylabelalbum list =
    List.sortBy (.label >> String.toLower) list


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TitleButtonMsg ->
            ( { model
                | currentButton = Title
                , titleToggle = not model.titleToggle
                , album_list =
                    case model.titleToggle of
                        True ->
                            sbylabelalbum model.album_list

                        False ->
                            List.reverse (sbylabelalbum model.album_list)
              }
            , Cmd.none
            )

        DateButtonMsg ->
            ( { model | currentButton = DateAdded, dateToggle = not model.dateToggle }, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


sortButton : Selected -> Selected -> String -> msg -> Bool -> Element msg
sortButton currentButton button name buttonMsg toggle =
    Input.button [ paddingXY 10 0 ]
        { onPress = Just buttonMsg
        , label =
            if currentButton == button then
                row [ Font.color Colors.navTextHover ]
                    [ Element.text
                        (name
                            ++ (if toggle then
                                    "↑"

                                else
                                    "↓"
                               )
                        )
                    ]

            else
                row [ Font.color Colors.navText ] [ Element.text (name ++ "↑") ]
        }



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Music.Artists"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill ]
                [ Components.VerticalNavMusic.view model.route
                , column [ Element.height fill, Element.width fill, paddingXY 20 30, Background.color Colors.sidebar, spacingXY 0 15 ]
                    [ Element.text "SORT"
                    , sortButton model.currentButton Title "Title " TitleButtonMsg model.titleToggle
                    , sortButton model.currentButton DateAdded "Date Added " DateButtonMsg model.dateToggle
                    ]
                ]
            , column [ Element.height fill, Element.width (fillPortion 6), paddingXY 0 0, spacingXY 5 7, Background.color Colors.background ]
                [ Components.SectionHeader.viewAlbums model.album_list
                ]
            ]
        ]
    }
