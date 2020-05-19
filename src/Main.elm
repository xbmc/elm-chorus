port module Main exposing (main)

import Browser exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)
import Html.Attributes
import Element.Input as Input
import Element exposing (Element, el, html)
import Element.Font as Font
import FontAwesome.Attributes as Icon
import FontAwesome.Brands as Icon
import FontAwesome.Icon as Icon exposing (Icon)
import FontAwesome.Layering as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Styles as Icon
import FontAwesome.Svg as SvgIcon
import FontAwesome.Transforms as Icon


blue =
    Element.rgb255 238 238 238

purple =
    Element.rgb255 208 208 208

{- Player controls -}
reverseButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-fast-backward fa-lg" ] [])
        }

playButton =
    Input.button[]
        { onPress = Just PlayPause
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-play fa-2x" ] [])
    }
    
skipButton =
    Input.button[]
        { onPress = Just Skip
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-fast-forward fa-lg" ] [])
        }
        
{- Secondary controls 
    includes:
    | volume
    | repeat
    | shuffle
    | controls
-}
volumeButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-volume-up fa-lg" ] [])
        }
repeatButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-redo-alt fa-lg" ] [])
    }  
shuffleButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-random fa-lg" ] [])
        }
controlButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-ellipsis-v fa-lg" ] [])
        }

{- left sidebar controls -}
musicButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-music fa-lg" ] [])
        }
movieButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-film fa-lg" ] [])
        }
tvshowButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-tv fa-md" ] [])
        }
browserButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-bars fa-lg" ] [])
        }
addonsButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-puzzle-piece fa-lg" ] [])
        }
likesButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-thumbs-up fa-lg" ] [])
        }
playlistButton =
    Input.button[]
        { onPress = Nothing
        , label = Element.html (Html.i [ Html.Attributes.class "fa fa-clipboard-list fa-lg" ] [])
        }     
-- MAIN


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

-- PORTS

port sendMessage : String -> Cmd msg
port messageReceiver : (String -> msg) -> Sub msg


-- MODEL


type alias Model =
    { draft : String
    , messages: List String
    }


type Msg
    = Send
    | PlayPause
    | Skip
    | Recv String


init : () -> ( Model, Cmd Msg )
init flags =
    ( { draft = "", messages = [] }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Send ->
      ( { model | draft = "" }
      , sendMessage model.draft
      )
    PlayPause ->
      ( { model | draft = "" }
      , sendMessage """{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id": 1 }"""
      )

    Skip ->
      ( { model | draft = "" }
      , sendMessage """{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "skipnext" }, "id": 1 }"""
      )

    Recv message ->
      ( { model | messages = model.messages ++ [message] }
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  messageReceiver Recv



-- VIEW


edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }


view : Model -> Document Msg
view model =
    { title = "Kodi"
    , body =
        [ layout [ inFront <| leftSidebar, inFront <| header, inFront <|  footer ] <|
            column [ width fill ]
                [ header
                , leftSidebar
                , hero
                , content
                , footer
                ]
        ]
    }

header : Element Msg
header =
    row [ width fill, Background.color (rgb 0.1 0.1 0.1), spacing 10, padding 0 ]
        [ el [] (image [width (px 50)] {description = "", src = "https://kodi.wiki/images/8/8e/Thumbnail-symbol-transparent.png" })
        ]

leftSidebar : Element Msg
leftSidebar =
    column [ height fill, Background.color (rgb 0.9 0.9 0.9), spacing 30, paddingXY 10 70, alignLeft ]
        [ el [] (musicButton)
        , el [] (movieButton)
        , el [] (tvshowButton)
        , el [] (browserButton)
        , el [] (addonsButton)
        , el [] (likesButton)
        , el [] (playlistButton)
        ]

hero : Element Msg
hero =
    row [ width fill, Background.color (rgb 0 0.7 0) ]
        [ image [ width fill ]
            { src = "https://via.placeholder.com/1400x400"
            , description = "Hero Image"
            }
        ]


content : Element Msg
content =
    column
        [ width
            (fill
                |> maximum 750
                |> minimum 250
            )
        , Background.color (rgb 0 0.9 0)
        , centerX
        , spacing 10
        , padding 10
        ]
        [ textColumn []
            [ image [ alignRight ]
                { src = "https://via.placeholder.com/250"
                , description = "Hero Image"
                }
            , home
            ]
        , textColumn []
            [ image [ paddingEach { edges | right = 10 }, alignLeft ]
                { src = "https://via.placeholder.com/250"
                , description = "Hero Image"
                }
            , about
            ]
        , textColumn []
            [ image [ alignRight ]
                { src = "https://via.placeholder.com/250"
                , description = "Hero Image"
                }
            , services
            ]
        , textColumn []
            [ image [ paddingEach { edges | right = 10 }, alignLeft ]
                { src = "https://via.placeholder.com/250"
                , description = "Hero Image"
                }
            , contactUs
            ]
        ]


home : Element Msg
home =
    paragraph []
        [ text
            "Home lots of text ...."
        ]


about : Element Msg
about =
    paragraph []
        [ text
            "About lots of text ...."
        ]


services : Element Msg
services =
    paragraph []
        [ text
            "lots of text ...."
        ]


contactUs : Element Msg
contactUs =
    paragraph []
        [ text
            "lots of text ...."
        ]


footer : Element Msg
footer = row[width fill, alignBottom][
            row [ height (px 70), width (fillPortion 1), Background.color (rgb 0.3 0.3 0.3), alignBottom, padding 10, spacing 30  ][
                el [centerX] (reverseButton),
                el [centerX] (playButton),
                el [centerX] (skipButton)
            ],
            row [ height (px 70), width (fillPortion 2), Background.color (rgb 0.3 0.3 0.3), alignBottom, padding 10, spacing 30  ][
                image [ alignLeft]
                    { src = "https://via.placeholder.com/70"
                    , description = "Hero Image"
                    },
                column[] [
                    el [ Font.color (Element.rgb 0.6 0.6 0.6) , Font.size 18 , Font.family [ Font.typeface "Open Sans" , Font.sansSerif ] ] (text "Nothing playing"),
                    el [ Font.color (Element.rgb 0.6 0.6 0.6) , Font.size 18 , Font.family [ Font.typeface "Open Sans" , Font.sansSerif ] ] (text "Nothing playing")
                ]
            ],
            row [ height (px 70), width (fillPortion 1), Background.color (rgb 0.2 0.2 0.2), alignBottom, padding 10, spacing 30][
                el [centerX] (volumeButton),
                el [centerX] (repeatButton),
                el [centerX] (shuffleButton),
                el [centerX] (controlButton)
            ]
        ]
