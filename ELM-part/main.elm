import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode

type Msg
  = NewGif (Result Http.Error Int)
  | Get

type alias Model
  = { counter : Int }

view : Model -> Html Msg
view model =
    div []
      [ button [ onClick Get ] [ text "Get counter"]
      , h2 [] [ text (toString model.counter) ] ]

decodeGifUrl : Decode.Decoder Int
decodeGifUrl = Decode.at ["counter"] Decode.int

getCounter : Cmd Msg
getCounter =
  let
    url = "http://localhost:3000/counter"
  in
    Http.send NewGif (Http.get url decodeGifUrl)

update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case message of
    NewGif (Ok value) -> (Model value, Cmd.none)
    NewGif (Err _) -> (model, Cmd.none)
    Get -> (model, getCounter)

main =
  Html.program
    { init = (Model 0, Cmd.none)
    , view = view
    , update = update
    , subscriptions = \x -> Sub.none }