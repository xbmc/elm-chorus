module Components.VerticalNavPlaylists exposing (view)

import Colors
import Element exposing (Attribute, Element, column, el, fill, fillPortion, padding, paddingXY, spacing)
import Element.Background as Background
import Element.Font as Font exposing (Font)
import Element.Input as Input
import Spa.Generated.Route as Route exposing (Route)


view :
    String
    -> Route
    ->
        List
            { route : Route
            , label : String
            }
    -> msg
    -> Element msg
view header currentRoute links newPlaylistMsg =
    column [ Element.height fill, Element.width (fillPortion 1), Font.color Colors.greyscaleGray, Background.color Colors.sidebar ]
        [ column [ Element.height fill, Element.width fill, paddingXY 16 8, spacing 16 ]
            ([ header |> String.toUpper |> Element.text ]
                ++ List.map
                    (\a ->
                        Element.link [ isCurrentRoute a.route currentRoute, paddingXY 16 0 ]
                            { url = Route.toString a.route
                            , label = Element.text a.label
                            }
                    )
                    links
            )
        , column [ Element.height fill, Element.width fill, paddingXY 16 8, spacing 16 ]
            [ el
                [ Background.color Colors.greyscaleGray
                , Element.mouseOver
                    [ Background.color Colors.greyscaleOuterSpace
                    ]
                ]
              <|
                Input.button [ paddingXY 10 10 ]
                    { onPress = Just newPlaylistMsg
                    , label = el [ Font.color Colors.white ] (Element.text "New Playlist")
                    }
            ]
        ]


isCurrentRoute : Route -> Route -> Attribute msg
isCurrentRoute route currentRoute =
    if route == currentRoute then
        Font.color Colors.navTextHover

    else
        Font.color Colors.navText
