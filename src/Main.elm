module Main exposing (..)

import Browser

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random

-- MAIN
main =
  Browser.element { init = init, update = update, subscriptions = subscriptions, view = view}

-- MODEL
type alias Model = { length: Int , numbers : List Int}

init : () -> (Model, Cmd Msg)
init _ =
  ( Model -1 []
  , Cmd.none
  )

-- UPDATE
type Msg
  = GenerateLength
  | UpdateLength Int
  | PopulateList Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      GenerateLength ->
          ( model
          , Random.generate UpdateLength (Random.int 1 10)
          )

      UpdateLength newLength ->
          {model | length = newLength }
          |> update (PopulateList newLength)

      PopulateList number ->
          ( {model | numbers = number::model.numbers}
          , Cmd.none
          )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Model -> Html Msg
view model =
  div [] [
       button [onClick GenerateLength, class "mybutton"] [text "Generate name"]
      ,div [] [ text (String.fromInt model.length) ]
      ,text (printList model.numbers)
      ,randomString model
    ]

randomString model =
  text (generateString model.length)

-- HELPERS
generateString : Int -> String
generateString length =
    if(length > 1) then
        "a" ++ generateString (length-1)
    else
        "a"

printList : List Int -> String
printList list =
  case list of
    [] -> ""
    (head::tail) -> (String.fromInt head) ++ " " ++ (printList tail)
