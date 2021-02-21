module Main exposing (main)

import Browser
import Browser.Navigation as Nav exposing (Key)
import Debug exposing (toString)
import Distribution exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navbar exposing (navbar)
import Route exposing (..)
import String
import Types exposing (..)
import Url exposing (Url)
import Lessons exposing(..)

import Content exposing (..)

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- INIT
discrete_random_variables_lesson : Lesson 
discrete_random_variables_lesson = Lesson {name = "Discrete Random Variables",  next_lesson =  Nothing, content = discrete_random_variables}



methods_of_enumeration_lesson : Lesson 
methods_of_enumeration_lesson = Lesson {name = "Methods of Enumeration",  next_lesson =  Just discrete_random_variables_lesson, content = methods_of_enumeration}



introduction_lesson : Lesson 
introduction_lesson = Lesson {name = "Introduction",  next_lesson =  Just methods_of_enumeration_lesson, content = introduction}


-- 
-- mathematical_expectation

init : flags -> Url -> Key -> ( Model, Cmd msg )
init _ url key =
    ( { url = url
      , key = key
      , selected_distribution = Poission Nothing
      , current_lesson = introduction_lesson
      , lessons = [introduction_lesson, methods_of_enumeration_lesson, discrete_random_variables_lesson] }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangeCurrentLesson lesson -> 
            ({model | current_lesson = lesson}, Cmd.none)
        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        SelectBinomial ->
            ( { model | selected_distribution = Binomial Nothing Nothing }
            , Cmd.none
            )

        SelectGeometric ->
            ( { model | selected_distribution = Geometric Nothing }, Cmd.none )

        SelectPoission ->
            ( { model | selected_distribution = Poission Nothing }, Cmd.none )

        ChangeGeometricProbability str_val ->
            let
                maybe_float =
                    String.toFloat str_val
            in
            case maybe_float of
                Just float_val ->
                    ( { model | selected_distribution = Geometric (Just (Probability float_val)) }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model | selected_distribution = Geometric Nothing }
                    , Cmd.none
                    )

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
            ( { model
                | selected_distribution = Binomial maybe_int un_changed_p
              }
            , Cmd.none
            )

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
                    ( { model
                        | selected_distribution =
                            Binomial unchanged_n
                                (Just (Probability f))
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model
                        | selected_distribution =
                            Binomial unchanged_n
                                Nothing
                      }
                    , Cmd.none
                    )


view : Model -> Browser.Document Msg
view model =
    { title = "Statistics"
    , body =
        [ navbar
        , case parseLocation model.url of
            Home ->
                lessons_view model

            Lessons ->
                lessons_view model

            Calculator ->
                calc model

            NotFound ->
                div [] [ text "not found" ]
        ]
    }



calc model =
    div []
        [ p [] [ text "Selected Distribution" ]
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
