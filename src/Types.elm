module Types exposing (Model, Msg(..), create_formula, create_inline_formula)

import Browser
import Browser.Navigation as Nav
import Distribution exposing (..)
import Url


type Msg
    = NoOp
    | SelectBinomial
    | SelectGeometric
    | SelectPoission
    | ChangeGeometricProbability String
    | ChangeBinomialN String
    | ChangeBinomialP String
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest


type alias Model =
    { selected_distribution : Distribution
    , key : Nav.Key
    , url : Url.Url
    }


create_formula : String -> String
create_formula f =
    "\\[ ++ f ++ \\]"


create_inline_formula : String -> String
create_inline_formula f =
    "\\(" ++ f ++ "\\)"
