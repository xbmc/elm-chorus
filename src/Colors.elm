module Colors exposing (..)

import Color
import Element


fromElementColorToColor : Element.Color -> Color.Color
fromElementColorToColor color =
    color
        |> Element.toRgb
        |> Color.fromRgba


fromColorToElementColor : Color.Color -> Element.Color
fromColorToElementColor color =
    color
        |> Color.toRgba
        |> Element.fromRgb



-- =============================================================================
-- Name:            Colours
-- Description:     Colour variables.
--                  Names from: http://chir.ag/projects/name-that-color/
-- =============================================================================
--
--  Palettes.
--
-- Base


greyIcon : Color.Color
greyIcon =
    Color.rgba 1 1 1 0.5


blackIcon : Color.Color
blackIcon =
    Color.rgba 0 0 0 0.9


grey : Element.Color
grey =
    Element.rgb255 51 51 51


black : Element.Color
black =
    Element.rgb255 0 0 0


white : Element.Color
white =
    Element.rgb255 255 255 255


red : Element.Color
red =
    Element.rgb255 250 0 0



-- Palette


cerulean : Element.Color
cerulean =
    Element.rgb255 18 178 231


greyCerulean : Element.Color
greyCerulean =
    Element.rgb255 51 122 183


ceriseRed : Element.Color
ceriseRed =
    Element.rgb255 219 36 100



-- Greyscale Palette


greyscaleAlabaster : Element.Color
greyscaleAlabaster =
    Element.rgb255 250 250 250


greyscaleMercury : Element.Color
greyscaleMercury =
    Element.rgb255 229 229 229


greyscaleAlto : Element.Color
greyscaleAlto =
    Element.rgb255 221 221 221


greyscaleCloudy : Element.Color
greyscaleCloudy =
    Element.rgb255 168 167 166


greyscaleLoblolly : Element.Color
greyscaleLoblolly =
    Element.rgb255 186 193 200


greyscaleShark : Element.Color
greyscaleShark =
    Element.rgb255 49 50 51


greyscaleDoveGray : Element.Color
greyscaleDoveGray =
    Element.rgb255 102 102 102


greyscaleGray : Element.Color
greyscaleGray =
    Element.rgb255 136 136 136


greyscaleDustGray : Element.Color
greyscaleDustGray =
    Element.rgb255 153 153 153


greyscaleOuterSpace : Element.Color
greyscaleOuterSpace =
    Element.rgb255 43 47 48


greyscaleDeepSpace : Element.Color
greyscaleDeepSpace =
    Element.rgb255 27 28 29



-- Brand


brandPrimary : Element.Color
brandPrimary =
    cerulean


brandHighlight : Element.Color
brandHighlight =
    Element.rgb255 244 252 255


kodi : Element.Color
kodi =
    brandPrimary


local : Element.Color
local =
    ceriseRed



-- Background colors.


backgroundKodi : Element.Color
backgroundKodi =
    greyscaleDeepSpace


backgroundLocal : Element.Color
backgroundLocal =
    greyscaleShark



-- Text Colours.


textDark : Element.Color
textDark =
    greyscaleOuterSpace


textLight : Element.Color
textLight =
    greyscaleAlabaster



-- Action colours.


record : Element.Color
record =
    Element.rgb255 191 10 7



-- Components
-- Shell


background : Element.Color
background =
    Element.rgb255 224 223 223


sidebar : Element.Color
sidebar =
    Element.rgb255 242 242 242


scrollbar : Element.Color
scrollbar =
    greyscaleAlto


scrollbarHandle : Element.Color
scrollbarHandle =
    Element.rgba 0 0 0 0.2


scrollbarHoverHandle : Element.Color
scrollbarHoverHandle =
    Element.rgba 0 0 0 0.4



-- Playlist


playlistBackground : Element.Color
playlistBackground =
    greyscaleDeepSpace


playlistHeaderBackground : Element.Color
playlistHeaderBackground =
    greyscaleShark


playlistSubHeaderBackground : Element.Color
playlistSubHeaderBackground =
    Element.rgba 1 1 1 0.1


playlistSubHeaderActiveBackground : Element.Color
playlistSubHeaderActiveBackground =
    Element.rgba 1 1 1 0.1


playlistActiveBackground : Element.Color
playlistActiveBackground =
    Element.rgb255 11 12 12


playlistTitleText : Element.Color
playlistTitleText =
    Element.rgb255 189 193 194


playlistTitleHoverText : Element.Color
playlistTitleHoverText =
    Element.rgba 1 1 1 0.95


playlistText : Element.Color
playlistText =
    Element.rgb255 153 153 153


playlistRemove : Element.Color
playlistRemove =
    Element.rgb255 139 0 0


playlistItemBorder : Element.Color
playlistItemBorder =
    Element.rgba 1 1 1 0.1


playlistHeaderText : Element.Color
playlistHeaderText =
    Element.rgba 1 1 1 0.8


playlistHeaderActiveText : Element.Color
playlistHeaderActiveText =
    white


playlistSubHeaderText : Element.Color
playlistSubHeaderText =
    playlistText


playlistSubHeaderActiveText : Element.Color
playlistSubHeaderActiveText =
    white


playlistToggleIcon : Element.Color
playlistToggleIcon =
    greyIcon
        |> fromColorToElementColor



-- Player


playerBackground : Element.Color
playerBackground =
    Element.rgb255 24 25 26


playerSideBackground : Element.Color
playerSideBackground =
    Element.rgba 1 1 1 0.05


playerText : Element.Color
playerText =
    Element.rgb255 186 193 200


playerPrimaryText : Element.Color
playerPrimaryText =
    white


playerControl : Element.Color
playerControl =
    greyIcon
        |> fromColorToElementColor


playerControlHover : Element.Color
playerControlHover =
    white


playerControlActive : Element.Color
playerControlActive =
    white


playerSliderBackground : Element.Color
playerSliderBackground =
    Element.rgb255 31 31 32


playerSliderRangeBackground : Element.Color
playerSliderRangeBackground =
    Element.rgba 1 1 1 0.1



-- Header


headerBackground : Element.Color
headerBackground =
    Element.rgb255 30 33 34


headerSearchBackground : Element.Color
headerSearchBackground =
    Element.rgba 1 1 1 0.9


headerText : Element.Color
headerText =
    Element.rgba 1 1 1 0.6


headerSearchText : Element.Color
headerSearchText =
    Element.rgba 0 0 0 0.4


headerSearchIcon : Element.Color
headerSearchIcon =
    Element.rgba 0 0 0 0.6



-- Nav


navHeaderBackground : Element.Color
navHeaderBackground =
    Element.rgb255 30 33 34


navBackground : Element.Color
navBackground =
    white


navHoverBackground : Element.Color
navHoverBackground =
    Element.rgba 0 0 0 0.05


navText : Element.Color
navText =
    greyscaleOuterSpace


navTextHover : Element.Color
navTextHover =
    kodi



-- Entity page


detailHeaderBackground : Element.Color
detailHeaderBackground =
    Element.rgb255 50 53 55


detailHeaderBackgroundLocal : Element.Color
detailHeaderBackgroundLocal =
    Element.rgb255 34 36 37


detailContentBackground : Element.Color
detailContentBackground =
    Element.rgb255 245 245 245



-- Remote


remoteBackground : Element.Color
remoteBackground =
    playerBackground
