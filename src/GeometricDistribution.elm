module GeometricDistribution exposing (Geometric, mean, probability, variance)


type alias Geometric =
    { p : Float }


probability : Geometric -> Int -> Float
probability g x =
    let
        c1 =
            (1 - g.p) ^ (toFloat x - 1)
    in
    c1 * g.p


mean : Geometric -> Float
mean g =
    1 / g.p


variance : Geometric -> Float
variance g =
    (1 - g.p) / (g.p * g.p)
