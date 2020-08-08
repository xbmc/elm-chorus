module Components.Video exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes


view : List (Attribute msg) -> { poster : String, source : String } -> Element msg
view attrs { poster, source } =
    el attrs <|
        html <|
            Html.video
                [ Html.Attributes.attribute "controls" "controls"
                , Html.Attributes.preload "none"
                , Html.Attributes.poster poster
                ]
                [ Html.source
                    [ Html.Attributes.id "mp4"
                    , Html.Attributes.src source
                    , Html.Attributes.type_ "video/mp4"
                    ]
                    []
                ]
