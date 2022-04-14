module Pages.Settings.Nav exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNavSettings
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route }, Cmd.none )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Nav"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Main Menu Structure")
                , paragraph [ width (px 750), Font.size 14, Font.color (rgb255 3 3 3), paddingEach { top = 0, bottom = 30, left = 20, right = 20 }, Font.medium ]
                    [ text "Here you can change the title, url and icons  "
                    , link [ Font.color (rgb255 18 178 231), Font.medium ]
                        { url = "https://mui.com/components/material-icons/"
                        , label = el [ Font.medium, mouseOver [ Font.color Colors.headerBackground ] ] (text "icons ")
                        }
                    , text "for menu items. You can also remove, re-order and add new items. Click here restore defaults"
                    ]
                ]
            ]
        ]
    }
