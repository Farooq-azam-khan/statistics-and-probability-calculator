module Main exposing (main)

import BinomialDistribution as BD exposing (Binomial, create_binomial)
import Browser
import GeometricDistribution as GD exposing (Geometric)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import PoissionDistribution as PD exposing (Poission)


type Distributions
    = Binomial Int Float
    | Geometric Float
    | Poission Float


type alias Model =
    { selected_distribution : Distributions }


type Msg
    = NoOp


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- INIT


init : Model
init =
    { selected_distribution = Poission 0.1 }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Statistics and Probability Calculator" ]
        , p
            []
            [ case model.selected_distribution of
                Geometric _ ->
                    text "Geometric"

                Binomial _ _ ->
                    text "Binomial"

                Poission _ ->
                    text "Poission"
            ]
        ]
