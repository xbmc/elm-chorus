module Components.SectionHeader exposing (view)

import Colors exposing (greyIcon)
import Element as Element exposing (Attribute, Element, alignRight, centerX, centerY, el, fill, height, padding, paddingEach, px, width)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Material.Icons as Filled
import Material.Icons.Types as MITypes


view : String -> Maybe msg -> Bool -> List { title : String, action : Maybe msg } -> Element msg
view headline toggleMoreVertAction showMoreVertIcons moreVertItems =
    Element.row
        [ width fill
        , height (px 50)
        , Background.color Colors.white
        , Font.size 18
        , paddingEach
            { top = 0
            , right = 50
            , bottom = 0
            , left = 16
            }
        ]
        [ Element.text headline
        , Input.button [ height (px 50), width (px 50), alignRight ]
            { onPress = toggleMoreVertAction
            , label =
                el
                    (moreVertMenu
                        showMoreVertIcons
                        moreVertItems
                    )
                    (Element.html
                        (Filled.more_vert 18 (MITypes.Color <| Colors.fromElementColorToColor <| Colors.grey))
                    )
            }
        ]


moreVertMenu : Bool -> List { title : String, action : Maybe msg } -> List (Attribute msg)
moreVertMenu showMenu moreVertItems =
    if showMenu then
        [ Element.below
            (Element.column [ width (px 250), Background.color Colors.grey ]
                (List.map
                    (\n ->
                        Input.button [ height (px 50), width fill, centerX, alignRight ]
                            { onPress = n.action
                            , label = Element.text n.title
                            }
                    )
                    moreVertItems
                )
            )
        ]

    else
        []
