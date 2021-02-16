module Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


navbar : Html Msg
navbar =
    nav [ class "bg-indigo-700 " ]
        [ ul [ class "flex text-white items-center justify-center px-4 py-3 space-x-10" ]
            [ li [ class "hover:text-indigo-300" ] [ a [ href "/lessons" ] [ text "notes" ] ]
            , li [ class "hover:text-indigo-300" ]
                [ a [ href "/calculator" ] [ text "calculator" ]
                ]
            ]
        ]
