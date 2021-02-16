module Route exposing (..)

import Url exposing (Url)
import Url.Parser exposing (..)


type Route
    = Lessons
    | Calculator
    | Home
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map Lessons (s "lessons")
        , map Calculator (s "calculator")
        ]


parseLocation : Url -> Route
parseLocation url =
    let
        _ =
            Debug.log "here:" (parse routeParser url)
    in
    Maybe.withDefault NotFound (parse routeParser url)
