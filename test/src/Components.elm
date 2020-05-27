module Components exposing (layout)

import Document exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Generated.Route as Route exposing (Route)

import Html exposing (Html)
import Html.Attributes
import Svg.Attributes
import FeatherIcons


layout : { page : Document msg } -> Document msg
layout { page } =
    { title = page.title
    , body = 
        [ 
            column [ width fill, height fill] [ 
                header
                , row [width fill, height fill] [
                    el [width (fillPortion 1), height fill] leftSidebar
                    , column [width (fillPortion 20), height fill, paddingXY 0 25] page.body
                    ]
                , footer
            ]
        ]
    }
{-layout { page } =
    { title = page.title
    , body =
        [ column [ spacing 32, padding 20, width (fill |> maximum 780), height fill, centerX ]
            [ navbar
            , column [ height fill ] page.body
            , footer
            ]
        ]
    }
    -}
header : Element msg
header =
    row [ width fill, Background.color (rgb 0.1 0.1 0.1), spacing 10, padding 0 ]
        [ Element.link [] {
            label = image [width (px 50)] {
                description = ""
                , src = "https://kodi.wiki/images/8/8e/Thumbnail-symbol-transparent.png" 
            }
            , url = Route.Top |> Route.toHref
        }
        , el [Font.color (Element.rgb 1 1 1)] (text "Kodi")
        ]

leftSidebar : Element msg
leftSidebar =
    column [ height fill, Background.color (rgb 0.9 0.9 0.9), spacing 30, paddingXY 10 20, alignLeft ]
        [ el [] (musicButton)
        , el [] (movieButton)
        , el [] (tvshowButton)
        , el [] (browserButton)
        , el [] (addonsButton)
        , el [] (likesButton)
        , el [] (playlistButton)
        , el [] (settingsButton)
        , el [] (helpButton)
        ]

footer : Element msg
footer = row [ height (px 70), width fill, alignBottom][
            row [ height fill, width (fillPortion 1), Background.color (rgb 0.2 0.2 0.2), alignBottom, padding 10, spacing 30  ][
                el [centerX] (reverseButton),
                el [centerX] (playButton),
                el [centerX] (skipButton)
            ]
            , column [height fill, width (fillPortion 2)] [
                row [ height (px 70), width fill, Background.color (rgb 0.2 0.2 0.2), alignBottom, padding 10, spacing 30  ][
                    image [ alignLeft]
                        { src = "https://via.placeholder.com/70"
                        , description = "Hero Image"
                        }
                        , el [ Font.color (Element.rgb 0.6 0.6 0.6) , Font.size 18 , Font.family [ Font.typeface "Open Sans" , Font.sansSerif ] ] (text "Nothing playing")
                        , el [ alignRight, Font.color (Element.rgb 0.6 0.6 0.6) , Font.size 18 , Font.family [ Font.typeface "Open Sans" , Font.sansSerif ] ] (text "0")
                ]
            ]
            , column [height fill, width (fillPortion 1)] [
                el [] (text "Volume")
                , row [width fill, Background.color (rgb 0.2 0.2 0.2), alignBottom, paddingXY 10 0, spacing 30][
                    el [centerX] (volumeButton),
                    el [centerX] (repeatButton),
                    el [centerX] (shuffleButton),
                    el [centerX] (controlButton)
                ]
            ]
        ]

{-
navbar : Element msg
navbar =
    row [ width fill ]
        [ el [ Font.size 24, Font.bold ] <| link ( "home", Route.Top )
        , row [ alignRight, spacing 20 ]
            [ link ( "docs", Route.Docs )
            , link ( "a broken link", Route.NotFound )
            , externalButtonLink ( "tweet about it", "https://twitter.com/intent/tweet?text=elm-spa is ez pz" )
            ]
        ]
-}

link : ( String, Route ) -> Element msg
link ( label, route ) =
    Element.link styles.link
        { label = text label
        , url = Route.toHref route
        }


externalButtonLink : ( String, String ) -> Element msg
externalButtonLink ( label, url ) =
    Element.newTabLink styles.button
        { label = text label
        , url = url
        }

{-
footer : Element msg
footer =
    row [] [ text "built with elm ❤" ]
-}


-- STYLES


colors : { blue : Color, white : Color, red : Color }
colors =
    { white = rgb 1 1 1
    , red = rgb255 204 85 68
    , blue = rgb255 50 100 150
    }


styles :
    { link : List (Element.Attribute msg)
    , button : List (Element.Attribute msg)
    }
styles =
    { link =
        [ Font.underline
        , Font.color colors.blue
        , mouseOver [ alpha 0.6 ]
        ]
    , button =
        [ Font.color colors.white
        , Background.color colors.red
        , Border.rounded 4
        , paddingXY 24 10
        , mouseOver [ alpha 0.6 ]
        ]
    }

    {- Player controls -}
reverseButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.skipBack |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [Svg.Attributes.color "lightgrey"])
        }

playButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.play |> FeatherIcons.withSize 48 |> FeatherIcons.toHtml [Svg.Attributes.color "lightgrey"])
    }
    
skipButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.skipForward |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [Svg.Attributes.color "lightgrey"])
        }
        
{- Secondary controls 
    includes:
    | volume
    | repeat
    | shuffle
    | controls
-}
volumeButton =
    Element.link []
        { url = Route.Docs |> Route.toHref
        , label = Element.html (FeatherIcons.volume2 |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [Svg.Attributes.color "lightgrey"])
        }
repeatButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.repeat |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [Svg.Attributes.color "lightgrey"])
    }  
shuffleButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.shuffle |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [Svg.Attributes.color "lightgrey"])
        }
controlButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.moreVertical |> FeatherIcons.withSize 36 |> FeatherIcons.toHtml [Svg.Attributes.color "lightgrey"])
        }

{- left sidebar controls -}
musicButton =
    Element.link []
        { url = Route.Docs |> Route.toHref
        , label = Element.html (FeatherIcons.music |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }
movieButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.video |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }
tvshowButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.tv |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }
browserButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.menu |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }
addonsButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.package |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }
likesButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.thumbsUp |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }
playlistButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.clipboard |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        } 
settingsButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.settings |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }
helpButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (FeatherIcons.helpCircle |> FeatherIcons.withSize 24 |> FeatherIcons.toHtml [])
        }  
