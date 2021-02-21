module Lessons  exposing(lessons_view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Icons exposing (..)
import Content exposing (..)


lesson_list : Lesson -> Html Msg
lesson_list (Lesson lesson) = button [ class "bg-indigo-100 font-thin text-indigo-900 hover:text-white hover:bg-indigo-700 py-2 px-2 rounded-lg"
                                       , onClick (ChangeCurrentLesson (Lesson lesson))
                                       ]  [ text lesson.name ] 

lessons_view : Model -> Html Msg
lessons_view model =
    main_ [ class "mt-3 grid grid-cols-4 gap-x-3" ]
          [ aside [ class "col-span-1 px-3 py-4 " ]
                [ ul [class "flex flex-col space-y-1"]
                (
                    List.map lesson_list model.lessons
                )
                ]
            , div [ class "col-span-3 prose prose-indigo lg:prose-lg" ]
                [ h1 []
                    [ text "Statistics and Probability" ]
                   , getLessonContent model.current_lesson
                   , case getNextLesson model.current_lesson of 
                        Just (Lesson next_lesson) ->
                            button [ onClick (ChangeCurrentLesson (Lesson next_lesson))
                                   , class "bg-indigo-700 text-white hover:bg-indigo-100 hover:text-indigo-900 px-3 py-2 rounded-lg shadow-lg font-semibold"
                                   ] [div [class "flex space-x-2 justify-between"] [text next_lesson.name], span [] [right_arrow "w-10 h-10"]]
                        Nothing -> 
                            span [class "mt-3 inline-block mr-auto px-3 py-2 rounded-lg text-gray-700 bg-gray-200 "] [text "Finished!"]
            
                ]
            ]


getLessonContent : Lesson -> Html Msg 
getLessonContent (Lesson l) = l.content

getNextLesson : Lesson -> Maybe Lesson 
getNextLesson (Lesson l) = l.next_lesson