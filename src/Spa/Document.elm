module Spa.Document exposing
    ( Document
    , map
    , toBrowserDocument
    )

import Browser
import Colors exposing (greyscaleGray)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html.Attributes


type alias Document msg =
    { title : String
    , body : List (Element msg)
    }


map : (msg1 -> msg2) -> Document msg1 -> Document msg2
map fn doc =
    { title = doc.title
    , body = List.map (Element.map fn) doc.body
    }


toBrowserDocument : { body : Document msg, header : Element msg, playerBar : Element msg, rightSidebar : Element msg, leftSidebar : Element msg, dialogBox : Element msg } -> Browser.Document msg
toBrowserDocument { body, header, playerBar, rightSidebar, leftSidebar, dialogBox } =
    { title = body.title
    , body =
        [ Element.layout
            [ width fill
            , height fill
            , inFront (frame header playerBar rightSidebar leftSidebar dialogBox)
            , Font.color greyscaleGray
            , Font.size 14
            , Font.family [ Font.typeface "opensans-light", Font.sansSerif ]
            ]
            (column [ width fill, height fill ] body.body)
        ]
    }


frame : Element msg -> Element msg -> Element msg -> Element msg -> Element msg -> Element msg
frame header playerBar rightSidebar leftSidebar dialogBox =
    column
        [ height fill, width fill, htmlAttribute <| Html.Attributes.style "pointer-events" "none", inFront dialogBox ]
        [ row [ height fill, width fill ]
            [ column
                [ height fill, width fill ]
                [ header
                , column [ width (px 50), height fill, Background.color Colors.navBackground ] [ leftSidebar ]
                ]
            , column
                [ height fill ]
                [ rightSidebar ]
            ]
        , playerBar
        ]
