module Distribution exposing (..)


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
