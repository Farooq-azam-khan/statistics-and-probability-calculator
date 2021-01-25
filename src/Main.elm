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
    = Binomial (Maybe Int) (Maybe Probability)
    | Geometric (Maybe Probability)
    | Poission (Maybe Lambda)


e : Float
e =
    2.718281828459045


mean : Distribution -> Maybe Float
mean d =
    case d of
        Binomial _ (Just (Probability p)) ->
            Just p

        Binomial _ Nothing ->
            Nothing

        Geometric (Just (Probability p)) ->
            if p /= 0 then
                Just (1 / p)

            else
                Nothing

        Geometric Nothing ->
            Nothing

        Poission (Just (Lambda l)) ->
            Just l

        Poission Nothing ->
            Nothing


variance : Distribution -> Maybe Float
variance d =
    case d of
        Binomial _ (Just (Probability p)) ->
            Just ((1 - p) * p)

        Binomial _ Nothing ->
            Nothing

        Geometric (Just (Probability p)) ->
            Just ((1 - p) / (p * p))

        Geometric Nothing ->
            Nothing

        Poission (Just (Lambda l)) ->
            Just l

        Poission Nothing ->
            Nothing


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


probability : Distribution -> Int -> Maybe Float
probability d x =
    case d of
        Binomial (Just n) (Just (Probability p)) ->
            let
                c1 =
                    toFloat (choose n x)

                c2 =
                    p ^ Basics.toFloat x

                c3 =
                    (1 - p) ^ Basics.toFloat (n - x)
            in
            Just (c1 * c2 * c3)

        Binomial _ _ ->
            Nothing

        Geometric (Just (Probability p)) ->
            let
                c1 =
                    (1 - p) ^ (toFloat x - 1)
            in
            Just (c1 * p)

        Geometric _ ->
            Nothing

        Poission (Just (Lambda lamb)) ->
            let
                c1 =
                    lamb ^ toFloat x

                c2 =
                    e ^ (-1 * lamb)
            in
            Just ((c1 * c2) / toFloat (factorial x))

        Poission _ ->
            Nothing


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
