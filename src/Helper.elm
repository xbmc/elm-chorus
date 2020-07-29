module Helper exposing (..)

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
