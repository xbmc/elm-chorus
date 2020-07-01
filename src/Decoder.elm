module Decoder exposing ()

-- Item

type ItemType
    = Song

type alias Item = 
    { id : Int 
    , type : String
    }

itemDecoder : Decoder Item
itemDecoder =
    Decode.succeed Item
        |> required "id" int
        |> required "type" typeDecoder

typeDecoder : Decoder String 
typeDecoder =
        Decode.field "type" Decode.string

-- Data

type alias Data =
    { item : Item }

dataDecoder : Decoder Data
dataDecoder =
    Decode.succeed Data
        |> required "item" itemDecoder

-- Player

type PlayerType
    = Audio 
    | Picture

type alias PlayerObj =
    { playerid : Int
    , speed : Int
    }

playerDecoder : Decoder Int
playerDecoder =
    Decode.succeed PlayerObj
        |> required "playerid" int
        |> required "speed" int

speedDecoder : Decoder Int
speedDecoder =
    Decode.field "speed" Decode.int

-- Params Response

type alias ParamsResponse =
    { data : Data
    , player : PlayerObj
    }

paramsResponseDecoder : Decoder ParamsResponse
paramsResponseDecoder =
    Decode.succeed ParamsResponse
        |> required "data" dataDecoder --custom (at [ "data", "item" ] itemDecoder)
        |> required "player" playerDecoder
        

type Response 
    = Maybe ParamsResponse
    | Maybe MethodResponse
    | Maybe ResultResponse

resultsDecoder : Decoder (List Result)
resultsDecoder =
  Decode.oneOf
    [ Decode.list resultDecoder
    , Decode.map (\result -> [result]) resultDecoder
    ]
