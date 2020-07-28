module Spa.Document exposing
    ( Document
    , map
    , toBrowserDocument
    )

import Browser
import Element exposing (..)


type alias Document msg =
    { title : String
    , body : List (Element msg)
    }


map : (msg1 -> msg2) -> Document msg1 -> Document msg2
map fn doc =
    { title = doc.title
    , body = List.map (Element.map fn) doc.body
    }


toBrowserDocument : { body : Document msg, header : Element msg, playerBar : Element msg, rightSidebar : Element msg } -> Browser.Document msg
toBrowserDocument { body, header, playerBar, rightSidebar } =
    { title = body.title
    , body =
        [ Element.layout [ width fill, height fill, inFront (headerAndSidebar header rightSidebar), inFront playerBar ]
            (column [ width fill, height fill ] body.body)
        ]
    }


headerAndSidebar : Element msg -> Element msg -> Element msg
headerAndSidebar header rightSidebar =
    Element.row [ width fill, height fill ] [ header, rightSidebar ]
