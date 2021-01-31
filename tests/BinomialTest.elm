module BinomialTest exposing (..)

import Distribution exposing (..)
import Expect exposing (..)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe " The Binomial Distribution"
        [ test "n = 10 p = 0.5" <|
            \_ ->
                let
                    bd =
                        Binomial (Just 10) (Just (Probability 0.5))

                    maybe_p =
                        probability bd 10
                in
                case maybe_p of
                    Nothing ->
                        Expect.equal Nothing (Just 1)

                    Just p ->
                        p |> Expect.within (Absolute 0.00000001) 0.00097656
        , test "n = 10 p = 0.5 at x = 5" <|
            \_ ->
                let
                    bd =
                        Binomial (Just 10) (Just (Probability 0.5))

                    maybe_p =
                        probability bd 5
                in
                case maybe_p of
                    Nothing ->
                        Expect.equal Nothing (Just 1)

                    Just p ->
                        p |> Expect.within (Absolute 0.00000001) 0.24609375
        ]
