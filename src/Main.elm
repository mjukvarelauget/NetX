module Main exposing (..)

import Browser

import Char exposing (fromCode)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random

letterRangeLow = 97
letterRangeHigh = 122

-- MAIN
main =
  Browser.element { init = init, update = update, subscriptions = subscriptions, view = view}

-- MODEL
type alias Model = { length: Int , name: List Char}

init : () -> (Model, Cmd Msg)
init _ =
  ( Model -1 []
  , Cmd.none
  )

-- UPDATE
type Msg
  = GenerateNameLength Int Int
  | GenerateLetterCode
  | AppendNewLetter Int
  | UpdateNameLength Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      GenerateLetterCode ->
          ( model
          , Random.generate AppendNewLetter (Random.int letterRangeLow letterRangeHigh)
          )

      AppendNewLetter letterCode ->
          ({model | name = fromCode(letterCode)::model.name}
          , Cmd.none)
          
      GenerateNameLength minLength maxLength ->
          ( model
          , Random.generate UpdateNameLength (Random.int minLength maxLength)
          )

      UpdateNameLength newLength ->
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
       button [onClick (GenerateNameLength 1 10), class "mybutton"] [text "Generate name"]
      ,button [onClick (GenerateLetterCode), class "mybutton"] [text "Append to string"]
      ,div [] [ text (String.fromInt model.length) ]
      ,text (printName model.name)
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
            
printName : List Char -> String
printName chars =
  case chars of
    [] -> ""
    (head::tail) -> String.fromChar head ++ (printName tail)
