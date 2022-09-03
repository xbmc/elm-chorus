module Helper exposing (..)

import Colors
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Icon)
import SharedType exposing (ObjectSort(..), SortDirection(..))
import SharedUtil exposing (..)
import String exposing (fromInt, padLeft)


durationToString : Int -> String
durationToString duration =
    (duration
        // 60
        |> fromInt
        |> padLeft 2 '0'
    )
        ++ ":"
        ++ (modBy 60 duration
                |> fromInt
                |> padLeft 2 '0'
           )


filterFieldButton : msg -> String -> List FilterButton -> Element msg
filterFieldButton buttonMsg name filterbutton =
    Input.button [ paddingXY 30 0 ]
        { onPress = Just buttonMsg
        , label =
            el
                (case List.isEmpty (checkFilterButton filterbutton) of
                    True ->
                        [ Font.color (Element.rgba255 43 47 48 1) ]

                    False ->
                        [ Font.color Colors.navTextHover ]
                )
                (Element.text name)
        }


filterView : msg -> msg -> (Int -> msg) -> List FilterButton -> Element msg
filterView addfilter toggleOff onButtonPressed filterbuttons =
    column [ Element.height fill, Element.width (fillPortion 1), paddingXY 5 30, spacing 16, Font.color Colors.greyscaleGray, Background.color Colors.sidebar ]
        [ Input.button [ paddingXY 10 0 ]
            { onPress = Just addfilter
            , label = row [] [ Element.html (Filled.keyboard_arrow_left 20 (MITypes.Color <| Colors.darkGreyIcon)), Element.text "SELECT AN OPTION" ]
            }
        , column [ paddingXY 30 0, spacing 10 ]
            [ Input.button [ Font.color Colors.navText ]
                { onPress = Just toggleOff
                , label = Element.text "Deselect all"
                }
            , column [ spacing 10 ]
                (List.indexedMap
                    (\index obj ->
                        if obj.name /= "" then
                            Input.button
                                [ case obj.state of
                                    True ->
                                        Font.color Colors.navTextHover

                                    False ->
                                        Font.color Colors.navText
                                ]
                                { onPress = Just (onButtonPressed index)
                                , label = Element.text obj.name
                                }

                        else
                            Element.none
                    )
                    filterbuttons
                )
            ]
        ]


closeFilterButton : List FilterButton -> msg -> Element msg
closeFilterButton list buttonMsg =
    case List.isEmpty (checkFilterButton list) of
        False ->
            Input.button [ Element.width fill, paddingXY 10 10, Background.color Colors.navTextHover, Font.color Colors.white ]
                { onPress = Just buttonMsg
                , label = row [ Element.width fill, spacingXY 10 0 ] [ row [ width (px 140), clipX ] [ Element.text (String.join "," (List.map .name (checkFilterButton list))) ], el [ alignRight ] (Element.html (Filled.remove_circle 15 (MITypes.Color <| Colors.whiteIcon))) ]
                }

        True ->
            Element.none


sortButton : ObjectSort -> ObjectSort -> String -> msg -> Element msg
sortButton currentButton button name buttonMsg =
    let
        isCurrentButton =
            case ( currentButton, button ) of
                ( Title _, Title _ ) ->
                    ( True, Title )

                ( DateAdded _, DateAdded _ ) ->
                    ( True, DateAdded )

                ( Year _, Year _ ) ->
                    ( True, Year )

                ( Artist _, Artist _ ) ->
                    ( True, Artist )

                ( Random _, Random _ ) ->
                    ( True, Random )

                ( Rating _, Rating _ ) ->
                    ( True, Rating )

                ( Album _, Album _ ) ->
                    ( True, Album )

                _ ->
                    ( False, Random )
    in
    Input.button [ paddingXY 10 0 ]
        { onPress = Just buttonMsg
        , label =
            currentButtonText currentButton name isCurrentButton
        }


currentButtonText : ObjectSort -> String -> ( Bool, SortDirection -> ObjectSort ) -> Element msg
currentButtonText currentButton name ( isCurrent, button ) =
    case isCurrent of
        True ->
            if currentButton == button Asc then
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↑") ]

            else
                row [ Font.color Colors.navTextHover ] [ Element.text (name ++ " ↓") ]

        False ->
            row [ Font.color Colors.navText ] [ Element.text name ]
