module Types exposing (Model, Msg(..), create_formula, create_inline_formula)

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


create_formula : String -> String
create_formula f =
    "\\[ ++ f ++ \\]"


create_inline_formula : String -> String
create_inline_formula f =
    "\\(" ++ f ++ "\\)"
