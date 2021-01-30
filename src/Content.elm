module Content exposing (..)

-- import Axis
-- import Scale exposing (BandScale, ContinuousScale, defaultBandConfig)
-- import TypedSvg as TS exposing (g, rect, style, svg, text_)
-- import TypedSvg.Attributes exposing (class, textAnchor, transform, viewBox)
-- import TypedSvg.Attributes.InPx exposing (height, width, x, y)
-- import TypedSvg.Core exposing (Svg)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TypedSvg.Types exposing (AnchorAlignment(..), Transform(..))
import Types exposing (..)


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
            , table [ class "table-auto" ]
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
                    , td [] [ text "\\(n^r\\)" ]
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
                        [ li [] [ text "\\[ f(x) > 0, x \\in S; \\]" ]
                        , li [] [ text "\\[ \\sum_{x \\in S} f(x) = 1; \\]" ]
                        , li [] [ text "\\[ P(X \\in A) = \\sum_{x \\in A} f(x) \\], where \\(A \\subset S \\)" ]
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
            , h4 [] [ text "Properties of Expectation" ]
            , ol []
                [ li [] [ text " E[c] = c, for some constant c" ]
                , li [] [ text "if c is constant and u is a function: E[c * u(X)] = c E[u(X)]" ]
                , li [] [ text "if c1 and c2 are constants and u1 and u2 are functions then: E[c1 * u1(X) + c2 * u2(X)] = c1 * E[u1(X)] + c2 * E[u2(X)]" ]
                ]
            ]
        , div [ id "mean-of-X" ]
            [ h3 [] [ text "Mean of Random Variable X" ]
            , dl []
                [ dt []
                    [ text "Mean of X" ]
                , dd
                    []
                    [ p [] [ text "When u(X) = X" ]
                    , p [] [ text "E[X] = sum_{x in S} x f(x)" ]
                    , p [] [ text "also called mu" ]
                    ]
                ]
            ]
        , div [ id "variance-of-x" ]
            [ h3 [] [ text "Variance and Standard Deviation of X" ]
            , dl []
                [ dt [] [ text "Variance of x" ]
                , dd []
                    [ p [] [ text "u(X)  = [X - mu]^2" ]
                    , p [] [ text "E[(X-m)^2] = Sum_{x in S} (x-mu)^2 f(x)" ]
                    , p [] [ text "reffered to as simg^2 or Var(X)." ]
                    ]
                , dt [] [ text "Standard Deviation" ]
                , dd [] [ text "std = sigma = sqrt(sigma^2) = sqrt(Var(x))" ]
                ]
            , div []
                [ p [] [ text "Theorem: sigma^2 = E[X^2] - mu^2 can" ]
                , div []
                    [ p [] [ text "proof: TODO " ]
                    ]
                ]
            , div [ id "moment-generating-function" ]
                [ h3 [] [ text "Moment Generating Function" ]
                , dl []
                    [ dt []
                        [ text "Moment Generating Function" ]
                    , dd
                        []
                        [ text "M_{X} (t) = E[e^{tX}] = Sum_{x in S} e^{tx} f(x)" ]
                    ]
                , div []
                    [ p [] [ text "Theorem \\[ M_{X}^{(r)} (0) = E[X^r] \\]" ]
                    , div [] [ p [] [ text "Proof TODO" ] ]
                    ]
                ]
            , geometric_distribution
            , binomial_distribution
            , hyper_geometric_distribution
            , poission_distribution
            ]
        ]


pmf_poission_latex : String
pmf_poission_latex =
    "\\[ f(x) = \\frac {e^{-\\lambda} \\lambda^x} {x!}, \\quad \\lambda > 0 \\] or more generally for any time interval \\(t\\),  \\[f(x) = \\frac {e^{-t\\lambda} (\\lambda t)^x} {x!} \\]"


mgf_poission_latex : String
mgf_poission_latex =
    "\\[  M(t) = e^{\\lambda (e^t - 1)}, -\\infty < \\lambda < \\infty \\]"


mean_poission_latex : String
mean_poission_latex =
    "Mean: \\(\\lambda\\)"


variance_poission_latex : String
variance_poission_latex =
    "Variance: \\(\\lambda\\)"


poission_distribution : Html Msg
poission_distribution =
    section [ id "poission-distribution" ]
        [ h3 [] [ text "Poission Distribution" ]
        , p [] [ text "Let the discrte random variable \\(X\\) denote the number of times an event occurs at one time (or space) interval." ]
        , p [] [ text pmf_poission_latex, text mgf_poission_latex ]
        , p [] [ text mean_poission_latex, text " ", text variance_poission_latex ]
        ]


hyper_geometric_distribution : Html Msg
hyper_geometric_distribution =
    section [ id "hypter-geometric-distribution" ]
        [ h3 [] [ text "Hyper Geometric Distribution" ]
        , div []
            [ text "\\[ f(x) = \\frac {{m \\choose x} {N-m \\choose n-x}} {N \\choose n} \\]"
            , ul []
                [ li [] [ text "where \\(N\\) is the total number of objects belonging to two dichotomous classes;" ]
                , li [] [ text "\\(m\\) is the number of objects belonging to one certail class;" ]
                , li [] [ text "\\(n\\) is the number of objects to be selected without replacement;" ]
                , li [] [ text "\\(x\\) is number of selected objects belonging to one class." ]
                ]
            ]
        ]


geometric_distribution : Html Msg
geometric_distribution =
    section [ id "geometric-distribution" ]
        [ h3 [] [ text "The Geometric distribution" ]
        , ol []
            [ li [] [ text "mgf: \\( M(t) = pe^t / (1 - qe^t) \\)" ]
            , li [] [ text "First Moment:\\( E[X] = 1/p \\)" ]
            , li [] [ text "Second Moment: \\(E[X^2] = (1+q) / p^2//)" ]
            , li [] [ text "Variance: \\(q/p^2\\)" ]
            ]
        ]


w : Float
w =
    900


h : Float
h =
    450


padding : Float
padding =
    30


binomial_distribution : Html Msg
binomial_distribution =
    section [ id "binomial-distribution" ]
        [ h3 [] [ text "The Binomial Distribution" ]
        , dl []
            [ dt [] [ text "pmf of Binomial Distribution" ]
            , dd []
                [ p [] [ text "\\[ f(x)  = {n \\choose x} p^x(1-p)^{n-x} \\]" ]
                , p [] [ text "\\[ X \\thicksim b(n,p) \\]" ]
                , p [] [ text "\\( \\thicksim \\) means \"is distributed as\" and \\(n\\) and \\(p\\) are the parameters to the binomial distribution." ]
                ]
            ]
        , h4 [] [ text "The Binomial Setting" ]
        , ul []
            [ li [] [ text "A trial is performed the same way \\(n\\) times;" ]
            , li [] [ text "Each of the \\(n\\) trials has exactly two outcomes;" ]
            , li [] [ text "The \\(n\\) trials are independent" ]
            , li [] [ text "The probability of success, denoted \\(p\\), is the same for each trial. Probability of failure: \\(q=1-p\\)." ]
            ]
        , h4 [] [ text "MGF, Mean, Variance, and STD of Binomial Distribution" ]
        , ul []
            [ li [] [ text "\\[ M(t) = [(1-p) + pe^t]^n \\]" ]
            , li [] [ text "\\[ \\mu = np \\]" ]
            , li [] [ text "\\[\\sigma^2 = np(1-p) \\]" ]
            ]
        , p [] [ text "TODO: proof" ]
        , div []
            [ h4 [] [ text "Graph" ]

            -- TODO: make graph
            ]
        ]
