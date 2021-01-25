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


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Statistics and Probability Calculator" ]
        , span [] [ text "Selected Distribution" ]
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
