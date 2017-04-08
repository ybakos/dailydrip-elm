module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { counter : Int
    , decrements : Int
    , increments : Int
    }


initialModel : Model
initialModel =
    Model 0 0 0


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            ({ model | counter = model.counter + 1, increments = model.increments + 1 }, Cmd.none)

        Decrement ->
            ({ model | counter = model.counter - 1, decrements = model.decrements + 1 }, Cmd.none)


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model.counter) ]
        , button [ onClick Increment ] [ text "+" ]
        , h3 [] [ text ("# of increments: " ++ (toString model.increments)) ]
        , h3 [] [ text ("# of decrements: " ++ (toString model.decrements)) ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = (initialModel, Cmd.none)
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
