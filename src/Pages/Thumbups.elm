module Pages.Thumbups exposing (Flags, Model, Msg, page)

import Element
import Page exposing (Document, Page)


type alias Flags =
    ()


type alias Model =
    {}


type Msg
    = NoOp


page : Page Flags Model Msg
page =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }


init : Model
init =
    {}


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            {}


view : Model -> Document Msg
view model =
    { title = "Thumbups"
    , body = [ Element.text "Thumbups" ]
    }