module Types exposing (Model, Msg(..))

import Distribution exposing (..)


type Msg
    = NoOp
    | SelectBinomial
    | SelectGeometric
    | SelectPoission
    | ChangeGeometricProbability String
    | ChangeBinomialN String
    | ChangeBinomialP String


type alias Model =
    { selected_distribution : Distribution }
