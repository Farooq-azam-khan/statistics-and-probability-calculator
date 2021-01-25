module Main exposing (main)

import Browser
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type Probability
    = Probability Float


type Lambda
    = Lambda Float


type Distribution
    = Binomial Int Probability
    | Geometric Probability
    | Poission Lambda


e : Float
e =
    2.718281828459045


mean : Distribution -> Float
mean d =
    case d of
        Binomial _ (Probability p) ->
            p

        Geometric (Probability p) ->
            1 / p

        Poission (Lambda l) ->
            l


variance : Distribution -> Float
variance d =
    case d of
        Binomial _ (Probability p) ->
            (1 - p) * p

        Geometric (Probability p) ->
            (1 - p) / (p * p)

        Poission (Lambda l) ->
            l


factorial : Int -> Int
factorial n =
    if n <= 1 then
        1

    else
        n * factorial (n - 1)


choose : Int -> Int -> Int
choose n k =
    if k > n then
        n

    else
        factorial n // (factorial n * factorial (n - k))


probability : Distribution -> Int -> Float
probability d x =
    case d of
        Binomial n (Probability p) ->
            let
                c1 =
                    toFloat (choose n x)

                c2 =
                    p ^ Basics.toFloat x

                c3 =
                    (1 - p) ^ Basics.toFloat (n - x)
            in
            c1 * c2 * c3

        Geometric (Probability p) ->
            let
                c1 =
                    (1 - p) ^ (toFloat x - 1)
            in
            c1 * p

        Poission (Lambda lamb) ->
            let
                c1 =
                    lamb ^ toFloat x

                c2 =
                    e ^ (-1 * lamb)
            in
            (c1 * c2) / toFloat (factorial x)


type alias Model =
    { selected_distribution : Distribution }


type Msg
    = NoOp
    | SelectBinomial
    | SelectGeometric
    | SelectPoission


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
    { selected_distribution = Poission (Lambda 0.1) }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        SelectBinomial ->
            { model | selected_distribution = Binomial 0 (Probability 0) }

        SelectGeometric ->
            { model | selected_distribution = Geometric (Probability 0.1) }

        SelectPoission ->
            { model | selected_distribution = Poission (Lambda 0.1) }


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Statistics and Probability Calculator" ]
        , span [] [ text "Selected Distribution" ]
        , div []
            [ button [ onClick SelectGeometric ] [ text "Geometric" ]
            , button [ onClick SelectBinomial ] [ text "Binomial" ]
            , button [ onClick SelectPoission ] [ text "Poission" ]
            ]
        , h2
            []
            [ case model.selected_distribution of
                Geometric _ ->
                    text "Geometric"

                Binomial _ _ ->
                    text "Binomial"

                Poission _ ->
                    text "Poission"
            ]
        , div []
            [ text "Mean: "
            , text (toString (mean model.selected_distribution))
            ]
        , div []
            [ text "Variance: "
            , text (toString (variance model.selected_distribution))
            ]
        ]
