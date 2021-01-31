module ChooseTest exposing (..)

import Distribution exposing (..)
import Expect exposing (..)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe " The Binomial Distribution"
        [ test "n = 10 k = 5 choose" <|
            \_ ->
                Expect.equal 252 (choose 10 5)
        ]
