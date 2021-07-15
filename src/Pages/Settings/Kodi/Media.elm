module Pages.Settings.Kodi.Media exposing (Model, Msg, Params, page)

import Colors
import Components.SettingsBlockLayout exposing (..)
import Components.VerticalNavSettings
import Element exposing (..)
import Dropdown exposing (Dropdown, OutMsg(..), Placement(..))
import Material.Icons as Filled
import Material.Icons.Types as MITypes exposing (Coloring(..), Icon)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Spa.Document exposing (Document)
import Spa.Generated.Route exposing (Route)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Params =
    ()


type alias Model =
    { route : Route
    , actionDropdown : Dropdown Options
    , actionSelected : String
    , videoArtworkDropdown : Dropdown Options
    , videoArtworkSelected : String
    , albumInfoDropdown : Dropdown Options
    , albumInfoSelected : String
    , artistInfoDropdown : Dropdown Options
    , artistInfoSelected : String
    , musicArtworkDropdown : Dropdown Options
    , musicArtworkSelected : String
  }


init : Url Params -> ( Model, Cmd Msg )
init url =
    ( { route = url.route
      , actionDropdown =
            Dropdown.init
                |> Dropdown.id "action"
                |> Dropdown.optionsBy .name actionList
      , actionSelected = ""
      , videoArtworkDropdown =
            Dropdown.init
                |> Dropdown.id "videoArtwork"
                |> Dropdown.optionsBy .name videoArtworkList
      , videoArtworkSelected = ""
      , albumInfoDropdown =
            Dropdown.init
                |> Dropdown.id "albumInfo"
                |> Dropdown.optionsBy .name albumInfoList
      , albumInfoSelected = ""
      , artistInfoDropdown =
            Dropdown.init
                |> Dropdown.id "artistInfo"
                |> Dropdown.optionsBy .name artistInfoList
      , artistInfoSelected = ""
      , musicArtworkDropdown =
            Dropdown.init
                |> Dropdown.id "musicArtwork"
                |> Dropdown.optionsBy .name musicArtworkList
      , musicArtworkSelected = ""
    }, Cmd.none )

settingsDropdownBlock : Dropdown Options -> (Dropdown.Msg Options -> Msg) -> String -> String -> Element Msg
settingsDropdownBlock dropdown msg title description =
    column [ paddingEach { top = 0, bottom = 30, left = 20, right = 20 } ]
        [ row [ paddingEach { top = 0, bottom = 20, left = 0, right = 0 } ]
            [ paragraph [ width (px 300), Font.size 14, Font.color (rgb255 3 3 3), Font.medium ] [ text title ]
            , row [width (px 400), Font.size 14, Font.color (rgb255 3 3 3), Font.light, paddingXY 0 5] [
              Dropdown.labelHidden (True, "nolabel") dropdown
                |> Dropdown.menuAttributes [Background.color (rgb255 85 85 85), Font.color (rgb255 255 255 255),Font.medium, Font.size 13]
                |> Dropdown.optionSelectedAttributes [Background.color (rgb255 117 117 117)]
                |> Dropdown.maxHeight 300
                |> Dropdown.inputAttributes [width (px 400), Font.alignLeft, Border.widthEach { top = 0, bottom = 1, left = 0, right = 0}, Border.rounded 0,Font.medium, Font.size 13]
                |> Dropdown.view msg
            , el [alignRight] (Element.html (Filled.expand_more 18 Inherit))
            ]
            ]
        , row []
            [ el [ width (px 300) ] (text "")
            , paragraph [ width (px 400), Font.size 12, Font.color (rgb255 142 142 142) ] [ text description ]
            ]
        ]

actionList : List Options
actionList =
  [ Options "Choose"
  , Options "Play"
  , Options "Resume"
  , Options "Show information"
  , Options "Queue item"
  ]

videoArtworkList : List Options
videoArtworkList =
  [ Options "Maximum"
  , Options "Basic"
  , Options "Custom"
  , Options "None"
  ]

albumInfoList : List Options
albumInfoList =
  [ Options "Universal Album Scraper"
  , Options "General Album Scraper"
  , Options "Local information only"
  ]

artistInfoList : List Options
artistInfoList =
  [ Options "Universal Artist Scraper"
  , Options "General Artist Scraper"
  ]

musicArtworkList : List Options
musicArtworkList =
  [ Options "Maximum"
  , Options "Basic"
  , Options "Custom"
  , Options "None"
  ]

-- UPDATE


type Msg
    = ReplaceMe
    | ActionDropdownMsg (Dropdown.Msg Options)
    | VideoArtworkDropdownMsg (Dropdown.Msg Options)
    | AlbumInfoDropdownMsg (Dropdown.Msg Options)
    | ArtistInfoDropdownMsg (Dropdown.Msg Options)
    | MusicArtworkDropdownMsg (Dropdown.Msg Options)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Cmd.none )

        ActionDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.actionDropdown
            in
            ( { model
                | actionDropdown = dropdown
                , actionSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.actionSelected
              }
            , Cmd.map ActionDropdownMsg cmd
            )

        VideoArtworkDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.videoArtworkDropdown
            in
            ( { model
                | videoArtworkDropdown = dropdown
                , videoArtworkSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.videoArtworkSelected
              }
            , Cmd.map VideoArtworkDropdownMsg cmd
            )

        AlbumInfoDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.albumInfoDropdown
            in
            ( { model
                | albumInfoDropdown = dropdown
                , albumInfoSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.albumInfoSelected
              }
            , Cmd.map AlbumInfoDropdownMsg cmd
            )

        ArtistInfoDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.artistInfoDropdown
            in
            ( { model
                | artistInfoDropdown = dropdown
                , artistInfoSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.artistInfoSelected
              }
            , Cmd.map ArtistInfoDropdownMsg cmd
            )

        MusicArtworkDropdownMsg subMsg ->
            let
                ( dropdown, cmd, outMsg ) =
                    Dropdown.update subMsg model.musicArtworkDropdown
            in
            ( { model
                | musicArtworkDropdown = dropdown
                , musicArtworkSelected =
                    case outMsg of
                        Selected ( _, name, _ ) ->
                            name

                        TextChanged _ ->
                            ""

                        _ ->
                            model.musicArtworkSelected
              }
            , Cmd.map MusicArtworkDropdownMsg cmd
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Settings.Kodi.Media"
    , body =
        [ row [ Element.height fill, Element.width fill ]
            [ column [ Element.height fill, Element.width fill, scrollbarY ] (Components.VerticalNavSettings.view model.route)
            , column [ Element.height fill, Element.width (fillPortion 5), spacingXY 5 7, Background.color Colors.white, padding 40, Font.size 24, Font.light ]
                [ el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Library")
                , settingsToggleBlock "Update library on startup (video)" "Check for new media files on startup."
                , settingsToggleBlock "Hide progress of library updates (video)" "Hide the library scanning progress bar during scans."
                , settingsToggleBlock "Update library on startup (music)" "Check for new and removed media files on startup."
                , settingsToggleBlock "Hide progress of library updates (music)" "Hide the library scanning progress bar during scans."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "General")
                , settingsToggleBlock "Show parent folder items" "Display the (..) item in lists for visiting the parent folders."
                , settingsToggleBlock "Ignore articles when sorting" "Ignore certain tokens, e.g. \"The\", during sort operations. \"The Simpsons\" would for example be sorted as \"Simpsons\"."
                , settingsToggleBlock "Show file extensions" "Show file extensions on media files, for example \"You Enjoy Myself\" would be shown as \"You Enjoy Myself.mp3\"."
                , settingsToggleBlock "Show \"Add source\" buttons" "Show the add source button in root sections of the user interface."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Video")
                , settingsDropdownBlock model.actionDropdown ActionDropdownMsg "Default select action" "Toggle between [Choose], [Play] (default), [Resume] and [Show information].[CR][Choose] Will select an item, e.g. open a directory in files mode.[CR][Resume] Will automatically resume videos from the last position that you were viewing them, even after restarting the system."
                , settingsToggleBlock "Combine split video items" "Combines multi-part video files, DVD folders or movie folders, down to a single item in non-library views."
                , settingsToggleBlock "Replace file names with library titles" "When a file is scanned into the library it will display the metadata title instead of the file name."
                , settingsToggleBlock "Show movies sets (video)" "When enabled, movies belonging to a \"Movie set\" are grouped together under one entry for the set in the movie library, this entry can then be opened to display the individual movies. When disabled, each movie will have its own entry in the movie library even if it belongs to a set."
                , settingsToggleBlock "Include sets containing a single movie (video)" "When enabled, a \"Movie set\" entry is used even if the movie library contains only a single movie from that set. When disabled, a \"Movie set\" entry is used only if the movie library contains more than one movie from that set."
                , settingsInputBlock "Movie set information folder (video)" "Select the folder where movie set information (images) are saved locally."
                , settingsToggleBlock "Show all performances for music videos (video)" "When enabled, shows all performers in the artist list for music videos, not just the main artist"
                , settingsDropdownBlock model.videoArtworkDropdown VideoArtworkDropdownMsg "Artwork level (video)" "The amount of artwork automatically selected - [Maximum] all local images and remote art; [Basic] save space on limited devices or when using a simple skin; [Custom] configured by user for detailed control; [None] no art"
                , settingsToggleBlock "Extract thumbnails from video files" "Extract thumbnails to display in library mode."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Music")
                , settingsToggleBlock "Show song and album artists (music)" "When enabled, both song and album artists are shown. When disabled, only album artists are shown and artists that appear only on individual songs from an album are excluded."
                , settingsToggleBlock "Split albums into individual discs (music)" "When enabled, opening a multi-disc album shows the discs as individual items instead of all the songs. Opening a disc then shows the songs on that disc."
                , settingsToggleBlock "Use artist sortname when sorting by artist (music)" "When sorting music items by artist use sortname e.g. Parton, Dolly rather than name."
                , settingsInputBlock "Artist information folder (music)" "Select the folder where artist information (info files and images) should be saved in."
                , settingsDropdownBlock model.albumInfoDropdown AlbumInfoDropdownMsg "Default provider for album information (music)" "Select the default album information provider."
                , settingsDropdownBlock model.artistInfoDropdown ArtistInfoDropdownMsg "Default provider for artist information (music)" "Select the default artist information provider."
                , settingsToggleBlock "Prefer online information (music)" "With this enabled, any information that is downloaded for albums and artists will override anything you have set in your song tags, such as genres, year, song artists etc. Useful if you have MusicBrainz identifiers in your song tags."
                , settingsDropdownBlock model.musicArtworkDropdown MusicArtworkDropdownMsg "Artwork level (music)" "The amount of artwork automatically selected - [Maximum] all local images and remote art; [Basic] save space on limited devices or when using a simple skin; [Custom] configured by user for detailed control; [None] no art"
                , settingsToggleBlock "Prefer online album art (music)" "Where no local album cover exists, online art will be used. Where neither is available, cover images embedded in music files will be used"
                , settingsToggleBlock "Switch to visualisation on playback" "Automatically go to the visualisation window when audio playback starts"
                , settingsToggleBlock "Enable tag reading in file view" "When browsing music files in file view read the tags of those not in the music library as you go. This can make large directories slow to display, especially over a network."
                , el [ Font.color (rgb255 18 178 231), Font.size 24, Font.light, paddingEach { top = 0, bottom = 30, left = 0, right = 0 } ] (text "Pictures")
                , settingsToggleBlock "Show EXIF picture information" "If EXIF information exists (date, time, camera used, etc.). It will be displayed."
                , settingsToggleBlock "Automatically generate thumbnails" "Automatically generate picture thumbnails when entering picture folder."
                , settingsToggleBlock "Show video files in listings" "Show videos in picture file lists."
                , row [ width (px 800), Background.color Colors.headerBackground, paddingXY 20 25 ]
                    [ Input.button [ Background.color Colors.cerulean, Font.color Colors.white, paddingXY 30 8, Font.size 14, Border.rounded 2 ]
                        { onPress = Nothing
                        , label = text "SAVE"
                        }
                    ]
                , el [ height (px 100) ] (text "")
                ]
            ]
        ]
    }
