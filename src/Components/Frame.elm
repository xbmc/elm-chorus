module Components.Frame exposing (layout)

import Components.DialogView exposing (config)
import Components.Header as Header
import Components.LayoutType exposing (DialogType(..), LayoutType)
import Components.LeftSidebar as LeftSidebar
import Components.PlayerRow as PlayerRow exposing (view)
import Components.RightSidebar as RightSidebar
import Dialog exposing (view)
import Element exposing (..)
import Material.Icons.Types exposing (Coloring(..))
import Spa.Document exposing (Document)


layout : LayoutType msg -> { body : Document msg, header : Element msg, playerBar : Element msg, rightSidebar : Element msg, leftSidebar : Element msg, dialogBox : Element msg }
layout layoutType =
    let
        dialogConfig =
            case layoutType.dialogBox.showDialog of
                ConnectionDialog ->
                    Just (Components.DialogView.config layoutType.dialogBox.attemptReconnectionMsg)

                TextInputDialog ->
                    Just (Components.DialogView.textInputConfig layoutType.dialogBox.playlistName layoutType.dialogBox.closeDialogMsg layoutType.dialogBox.textChangeMsg)

                None ->
                    Maybe.Nothing
    in
    { body =
        { title = layoutType.page.title
        , body =
            [ column [ width fill, height fill ]
                [ el [ height (px Header.headerHeight) ] Element.none
                , row
                    [ width fill, height fill, paddingEach { top = 0, right = 0, bottom = 0, left = 50 } ]
                    [ column [ width fill, height fill ] layoutType.page.body
                    ]
                ]
            ]
        }
    , header = Header.view layoutType.searchChanged
    , playerBar = PlayerRow.view layoutType
    , rightSidebar = RightSidebar.view layoutType.showRightSidebarMenu layoutType.rightSidebarExtended layoutType.rightSidebarMsg (layoutType.windowHeight - PlayerRow.playerHeight) layoutType.connection
    , leftSidebar = LeftSidebar.view layoutType.leftSidebarControl
    , dialogBox = Dialog.view dialogConfig
    }
