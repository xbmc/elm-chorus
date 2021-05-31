module Components.LeftSidebar exposing (view,initialModel)

import Colors
import Element exposing (..)
import Element.Background as Background
import Html.Attributes
import Element.Events as Events
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Spa.Generated.Route as Route exposing (Route)

type Model
    = Normal
    | Hover

update : Msg -> Model -> Model
update msg model =
    case msg of
        Leave ->
            Normal

        Enter ->
            Hover

initialModel : Model
initialModel =
    Normal

type Msg
    = Enter
    | Leave

view : Model -> Element msg
view model =
    column [ height fill, centerX, spacing 20, padding 15, alignLeft, htmlAttribute <| Html.Attributes.style "pointer-events" "all" ]
        [ musicButton model
        , movieButton model
        , tvshowButton model
        , browserButton model
        , addonsButton model
        , thumbsupButton model
        , playlistButton model
        , settingsButton model
        , helpButton model
        ]

--
-- materialIconLink : ( Icon msg, Route ) -> Element Msg
-- materialIconLink ( icon, route ) =
--     row[]
--     [el
--         [ Element.mouseOver
--             [ scale 1.1
--             , Background.color Colors.brandPrimary
--             ]
--         ]
--     <|
--         Element.link []
--             { url = Route.toString route
--             , label = Element.html (icon 20 (MITypes.Color <| (Colors.fromElementColorToColor <| Colors.greyscaleOuterSpace)))
--             }
--       ]

materialIconLinkNew : Model-> Icon Msg -> Route -> String  -> Element msg
materialIconLinkNew  model icon route  name =
    let
        temp =
            case model of
                Hover ->
                    [ Element.onRight (Element.text name), scale 1.1, Background.color Colors.brandPrimary]

                Normal ->
                    []
    in
    row[]
    [el
        (Events.onMouseEnter Enter
              :: Events.onMouseLeave Leave
              :: temp)

        (Element.link []
            { url = Route.toString route
            , label = Element.html (icon 20 (MITypes.Color <| (Colors.fromElementColorToColor <| Colors.greyscaleOuterSpace)))
            })
      ]

-- buttons


musicButton : Model -> Element msg
musicButton model =
    materialIconLinkNew model Filled.library_music Route.Music "Music"


movieButton : Model -> Element msg
movieButton model =
    materialIconLinkNew model Filled.movie Route.Movies__Recent "Movies"


tvshowButton : Model -> Element msg
tvshowButton model =
    materialIconLinkNew model Filled.tv Route.Tvshows__Recent "TV shows"


browserButton : Model -> Element msg
browserButton model =
    materialIconLinkNew model Filled.list Route.Browser "Browser"


addonsButton : Model -> Element msg
addonsButton model =
    materialIconLinkNew model Filled.extension Route.Addons "Add-ons"


thumbsupButton : Model -> Element msg
thumbsupButton model =
    materialIconLinkNew model Filled.thumb_up Route.Thumbsup "Thumbs up"


playlistButton : Model -> Element msg
playlistButton model =
    materialIconLinkNew model Filled.assignment Route.Playlists "Playlists"


settingsButton : Model -> Element msg
settingsButton model =
    materialIconLinkNew model Filled.settings Route.Settings__Web "Settings"


helpButton : Model -> Element msg
helpButton model =
    materialIconLinkNew model Filled.help Route.Help "Help"
