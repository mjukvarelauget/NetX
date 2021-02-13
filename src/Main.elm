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

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      GenerateLength ->
          ( model
          , Random.generate UpdateLength (Random.int 1 10)
          )

      UpdateLength newLength ->
          ( {model | length = newLength }
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
