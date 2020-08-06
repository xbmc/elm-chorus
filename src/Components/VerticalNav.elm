module Components.VerticalNav exposing (view)

import Colors
import Element exposing (Attribute, Element, column, el, fill, fillPortion, padding, paddingXY, spacing)
import Element.Background
import Element.Font as Font exposing (Font)
import Spa.Generated.Route as Route exposing (Route)


view :
    String
    -> Route
    ->
        List
            { route : Route
            , label : String
            }
    ->  List Route
    -> Element msg
view header currentRoute links listPagesWithFilter =
    case List.member currentRoute listPagesWithFilter of
        False ->
            column [ Element.height fill, Element.width (fillPortion 1), paddingXY 16 8, spacing 16, Font.color Colors.greyscaleGray, Element.Background.color Colors.sidebar ]
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
        True ->
            column [ Element.height fill, Element.width (fillPortion 1), Font.color Colors.greyscaleGray, Element.Background.color Colors.sidebar ]
                [ column [Element.height fill, Element.width fill, paddingXY 16 8, spacing 16]
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
                , column [Element.height fill, Element.width fill, paddingXY 16 8, spacing 16] 
                    [ Element.text "FILTERS" ]
                , column [Element.height fill, Element.width fill, paddingXY 16 8, spacing 16] 
                    [ Element.text "SORT" ]
                ]


isCurrentRoute : Route -> Route -> Attribute msg
isCurrentRoute route currentRoute =
    if route == currentRoute then
        Font.color Colors.navTextHover

    else
        Font.color Colors.navText
