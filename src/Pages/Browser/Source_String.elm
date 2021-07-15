module Pages.Browser.Source_String exposing (Model, Msg, Params, page)

import Colors
import Components.VerticalNav
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font exposing (Font)
import Shared exposing (sendAction)
import Spa.Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Url exposing (percentDecode, percentEncode)
import WSDecoder exposing (FileObj, FileType(..), SourceObj)


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
    { source : String
    }


type alias Model =
    { source : String
    , files : List FileObj
    , source_list : List SourceObj
    , route : Route
    }


init : Shared.Model -> Url Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { source = parseSource (percentDecode params.source)
      , files = shared.file_list
      , source_list = shared.source_list
      , route = Route.Top
      }
    , sendAction
        ("""{"jsonrpc":"2.0","method":"Files.GetDirectory","id":"1","params":{"directory":\"""" ++ parseSource (percentDecode params.source) ++ """","media":"files"}}""")
    )


parseSource : Maybe String -> String
parseSource string =
    case string of
        Nothing ->
            "None"

        Just str ->
            str



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )


save : Model -> Shared.Model -> Shared.Model
save model shared =
    shared


load : Shared.Model -> Model -> ( Model, Cmd Msg )
load shared model =
    ( { source = model.source, files = shared.file_list, source_list = shared.source_list, route = model.route }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Browser.Source_String"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ Components.VerticalNav.view
                "sources"
                model.route
                (List.map
                    (\source ->
                        { route = Route.Browser__Source_String { source = percentEncode source.file }
                        , label = source.label
                        }
                    )
                    model.source_list
                )
                []
            , column [ Element.width fill, Element.height fill ]
                (List.map
                    (\file ->
                        case file.filetype of
                            Directory ->
                                Element.link
                                    [ paddingXY 10 10
                                    , Background.color Colors.greyscaleDustGray
                                    , Element.mouseOver
                                        [ Background.color Colors.greyscaleOuterSpace ]
                                    , Font.color Colors.white
                                    ]
                                    { url = Route.toString (Route.Browser__Source_String { source = percentEncode file.file })
                                    , label = Element.text file.label
                                    }

                            File ->
                                el
                                    [ paddingXY 10 10
                                    , Background.color Colors.greyscaleDustGray
                                    , Element.mouseOver [ Background.color Colors.greyscaleOuterSpace ]
                                    , Font.color Colors.white
                                    ]
                                    (Element.text file.label)
                    )
                    model.files
                )
            ]
        ]
    }
