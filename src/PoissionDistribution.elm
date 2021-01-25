module PoissionDistribution exposing (Poission(..), mean, probability, variance)

import BinomialDistribution exposing (factorial)


e : Float
e =
    2.718281828459045


type Poission
    = Lambda Float


probability : Poission -> Int -> Float
probability (Lambda lambda) x =
    let
        c1 =
            lambda ^ toFloat x

        c2 =
            e ^ (-1 * lambda)
    in
    (c1 * c2) / toFloat (factorial x)


mean : Poission -> Float
mean (Lambda l) =
    l


variance : Poission -> Float
variance (Lambda l) =
    l
