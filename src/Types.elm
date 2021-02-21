module Types exposing (Model, Msg(..), create_formula, create_inline_formula, Lesson(..), Lessons(..))

import Html exposing (Html)
import Browser
import Browser.Navigation as Nav
import Distribution exposing (..)
import Url


type  Lesson = Lesson {name: String, next_lesson: Maybe Lesson, content: Html Msg}
type Lessons 
    = Introduction 
    | Methods_Of_Enumeration 
    | Discrete_Random_Variables
    | Mathematical_Expectation

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
    | ChangeCurrentLesson Lesson


type alias Model =
    { selected_distribution : Distribution
    , key : Nav.Key
    , url : Url.Url
    , lessons : List Lesson
    , current_lesson: Lesson
    }


create_formula : String -> String
create_formula f =
    "\\[ ++ f ++ \\]"


create_inline_formula : String -> String
create_inline_formula f =
    "\\(" ++ f ++ "\\)"
