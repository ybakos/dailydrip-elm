module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


-- MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    }



-- UPDATE


type Msg
    = RequestMore
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestMore ->
            ( model, getRandomGif model.topic )

        NewGif (Ok url) ->
            ( { model | gifUrl = url }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , div [] [ img [ src model.gifUrl ] [] ]
        , button [ onClick RequestMore ] [ text "More, better..." ]
        ]



-- MAIN


init : String -> ( Model, Cmd Msg )
init topic =
    let
        waitingUrl =
            "https://i.imgur.com/i6eXrfS.gif"
    in
        ( Model topic waitingUrl, getRandomGif topic )


main : Program Never Model Msg
main =
    Html.program
        { init = init "cats"
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
