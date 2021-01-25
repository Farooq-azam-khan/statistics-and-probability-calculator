module BinomialDistribution exposing (Binomial, create_binomial, factorial, mean, probability, variance)


type alias Binomial =
    { n : Int
    , p : Float
    }


create_binomial : Int -> Float -> Binomial
create_binomial n p =
    Binomial n p


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


probability : Binomial -> Int -> Float
probability b x =
    let
        c1 =
            toFloat (choose b.n x)

        c2 =
            b.p ^ toFloat x

        c3 =
            (1 - b.p) ^ toFloat (b.n - x)
    in
    c1 * c2 * c3


mean : Binomial -> Float
mean b =
    b.p


variance : Binomial -> Float
variance b =
    (1 - b.p) * b.p
