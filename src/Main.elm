module Main exposing (main)

import Browser
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String


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
    | ChangeGeometricProbability String
    | ChangeBinomialN String
    | ChangeBinomialP String


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
    { selected_distribution = Poission Nothing }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        SelectBinomial ->
            { model | selected_distribution = Binomial Nothing Nothing }

        SelectGeometric ->
            { model | selected_distribution = Geometric Nothing }

        SelectPoission ->
            { model | selected_distribution = Poission Nothing }

        ChangeGeometricProbability str_val ->
            let
                maybe_float =
                    String.toFloat str_val
            in
            case maybe_float of
                Just float_val ->
                    { model | selected_distribution = Geometric (Just (Probability float_val)) }

                Nothing ->
                    { model | selected_distribution = Geometric Nothing }

        ChangeBinomialN str_val ->
            let
                maybe_int =
                    String.toInt str_val

                un_changed_p =
                    case model.selected_distribution of
                        Binomial _ mp ->
                            mp

                        _ ->
                            Nothing
            in
            { model | selected_distribution = Binomial maybe_int un_changed_p }

        ChangeBinomialP str_val ->
            let
                mf =
                    String.toFloat str_val

                unchanged_n =
                    case model.selected_distribution of
                        Binomial n _ ->
                            n

                        _ ->
                            Nothing
            in
            case mf of
                Just f ->
                    { model | selected_distribution = Binomial unchanged_n (Just (Probability f)) }

                Nothing ->
                    { model | selected_distribution = Binomial unchanged_n Nothing }


introduction : Html Msg
introduction =
    section []
        [ h2 [] [ text "Introduction to Probability" ]
        , dl []
            [ dt [] [ text "Random Experiment" ]
            , dd [] [ text "A random experiment is an experiment where the outcome cannot be predicted with certainty." ]
            , dt [] [ text "Independence" ]
            , dd [] [ text "Two phenomina are Independent if observing the outcome of the first does not affect the probability of observing the second. P(A and B) = P(A) * P(B)" ]
            ]
        ]


methods_of_enumeration : Html Msg
methods_of_enumeration =
    section []
        [ h2 [] [ text "Methods of Enummeration" ]
        , ul []
            [ li [] [ a [ href "#multiplication-principle" ] [ text "Multiplication Principle" ] ]
            , li [] [ a [ href "#permutation" ] [ text "Permutation" ] ]
            , li [] [ a [ href "#combinatorics" ] [ text "Combinatorics" ] ]
            , li [] [ a [ href "#sampling-with-and-without-replacement" ] [ text "Sampling with and Without Replacement" ] ]
            ]
        , div [ id "multiplication-principle" ]
            [ h3 [] [ text "Multiplication Principle" ]
            , p [] []
            ]
        , div [ id "permutation" ] [ h3 [] [ text "Permutation" ] ]
        , div [ id "combinatorics" ] [ h3 [] [ text "Combinatorics" ] ]
        , div [ id "sampling-with-and-without-replacement" ]
            [ h3 [] [ text "Sampling with and without Replacement" ]
            , table []
                [ tr []
                    [ th []
                        [ text "Replacement \\ Order" ]
                    , th
                        []
                        [ text "TRUE" ]
                    , th [] [ text "FALSE" ]
                    ]
                , tr []
                    [ td [] [ text "TRUE" ]
                    , td [] [ text "n^r" ]
                    , td [] [ text "(n+r-1) 'choose' r" ]
                    ]
                , tr []
                    [ td [] [ text "FALSE" ]
                    , td [] [ text "n 'permute' r" ]
                    , td [] [ text "n 'choose' r" ]
                    ]
                ]
            ]
        ]


discrete_random_variables : Html Msg
discrete_random_variables =
    section []
        [ h2 [] [ text "Discrete Random Variables" ]
        , ul []
            [ li []
                [ a [ href "#random-variable" ] [ text "Random Variable" ] ]
            , li
                []
                [ a
                    [ href "#probability-mass-function"
                    ]
                    [ text "Probability Mass Function" ]
                ]
            , li []
                [ a [ href "#cummulative-distribution-function" ] [ text "Cummulative Distribution Function" ]
                ]
            ]
        , div [ id "random-variable" ]
            [ h3 [] [ text "Random Variable" ]
            , dl []
                [ dt [] [ text "Random Variable" ]
                , dd [] [ text "Given a random experiment with an outcome space S, a function X that assigns one and only one real number X(s) = x to each element s in S. The space of X is the set of all real numbers. {x : X(s) = x | s in S}." ]
                , dt [] [ text "Discrete Random Variable" ]
                , dd [] [ text "A random variable X is a discrete random variable if and only if: 1. there are a finite number of possible outcomes of X; 2. there are a countably infinite number of possible outcomes of X." ]
                ]
            ]
        , div [ id "probability-mass-function" ]
            [ h3 [] [ text "Probability Mass Function" ]
            , dl []
                [ dt [] [ text "Probability Mass Function (pmf)" ]
                , dd []
                    [ p [] [ text "The probability Mass Function denoted as P(X = x) = f(x) of a discrete random variable X is function that satifiles the following properties." ]
                    , ol []
                        [ li [] [ text "f(x) > 0, x in S;" ]
                        , li [] [ text "Sum_{x in S} f(x) = 1" ]
                        , li [] [ text "P(X in A) = Sum_{x in A} f(x), where A subset of S" ]
                        ]
                    , p [] [ text "where S is the Support of X" ]
                    ]
                ]
            , p [] [ text "Example: let f(x) = c * x^2 for x = 1,2,3. Find the constant c such that it satisfies the probability mass function." ]
            ]
        , div [ id "cummulative-distribution-function" ]
            [ h3 [] [ text "Cummulative Distribution Function" ]
            , dl []
                [ dt []
                    [ text "Cummulative Distribution Function (cdf)" ]
                , dd
                    []
                    [ p [] [ text "X takes discrete values from 0 to k" ]
                    , p [] [ text "F(x) = P(X <= x)" ]
                    , p [] [ text "F(x) = Sum_{m = 0}^{x} f(m)" ]
                    , p [] [ text "and P(X > x) = 1 - P(X <= x)" ]
                    ]
                ]
            ]
        ]


mathematical_expectation : Html Msg
mathematical_expectation =
    section []
        [ h2 [] [ text "Mathematical Expectation" ]
        , ul []
            [ li [] [ a [ href "#expectation" ] [ text "Expectation" ] ]
            , li [] [ a [ href "#mean-of-X" ] [ text "Mean of Random Variable X" ] ]
            , li [] [ a [ href "#variance-of-X" ] [ text "Variance and Standard Deviation of X" ] ]
            ]
        , div [ id "expectation" ]
            [ h3 [] [ text "Expectation" ]
            , dl []
                [ dt [] [ text "Expectation" ]
                , dd []
                    [ p [] [ text "if f(x) is the pmf of a discrete random variable X with support S, and if the Sum_{x in S} u(x)f(x) exists (does not go to infinity) then the resulting sum is the expectation, or the expectation value of the function u(x)." ]
                    , p [] [ text "It is denoted as E[u(X)] = Sum_{x in S} u(x) f(x)" ]
                    ]
                ]
            ]
        , div [ id "mean-of-X" ] [ h3 [] [ text "Mean of Random Variable X" ] ]
        , div [ id "variance-of-x" ] [ h3 [] [ text "Variance and Standard Deviation of X" ] ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Statistics and Probability" ]
        , introduction
        , methods_of_enumeration
        , discrete_random_variables
        , mathematical_expectation
        , p [] [ text "Selected Distribution" ]
        , div []
            [ div []
                [ button [ onClick SelectGeometric ] [ text "Geometric" ]
                , button [ onClick SelectBinomial ] [ text "Binomial" ]
                , button [ onClick SelectPoission ] [ text "Poission" ]
                ]
            , div []
                [ case model.selected_distribution of
                    Geometric jp ->
                        div []
                            [ input
                                [ type_ "number"
                                , Html.Attributes.min "0"
                                , case jp of
                                    Just (Probability p) ->
                                        value (String.fromFloat p)

                                    Nothing ->
                                        value ""
                                , onInput ChangeGeometricProbability
                                , placeholder "Pick the Probability Value"
                                ]
                                []
                            ]

                    Binomial mn mp ->
                        div []
                            [ input
                                [ type_ "number"
                                , placeholder "Pick n"
                                , value
                                    (case mn of
                                        Just n ->
                                            String.fromInt n

                                        Nothing ->
                                            ""
                                    )
                                , onInput ChangeBinomialN
                                ]
                                []
                            , input
                                [ type_ "number"
                                , placeholder "Pick Probability"
                                , value
                                    (case mp of
                                        Just (Probability p) ->
                                            String.fromFloat p

                                        Nothing ->
                                            ""
                                    )
                                , onInput ChangeBinomialP
                                ]
                                []
                            ]

                    Poission _ ->
                        div [] [ input [ type_ "number", placeholder "Pick Lambda" ] [] ]
                ]
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
