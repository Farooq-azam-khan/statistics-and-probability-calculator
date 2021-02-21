module Icons exposing (..)

import Svg as S exposing (..)
import Svg.Attributes exposing (..)

right_arrow className = svg [ class className, fill "none"
                  , stroke "currentColor"
                  , viewBox "0 0 24 24"
                  ]
                  [ S.path [ d "M17 8l4 4m0 0l-4 4m4-4H3"
                         , strokeLinecap "round"
                         , strokeLinejoin "round"
                         , strokeWidth "2" 
                         ] []
                  ]