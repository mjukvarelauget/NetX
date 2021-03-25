module Main exposing (..)

import Browser

import String exposing (fromChar, fromList)
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
type alias Model = { length: Int , name: String, randomPart: List Char}

init : () -> (Model, Cmd Msg)
init _ =
  ( Model -1 "" []
  , Cmd.none
  )

-- UPDATE
type Msg
  = GenerateNameLength Int Int
  | GenerateLetterCode
  | AppendNewLetter Int
  | UpdateNameLength Int
  | GenerateName

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      GenerateName ->
          let
              nameBase = "Net"
              randomPart = "X"
          in
              ({model | name = nameBase ++ randomPart}
              , Cmd.none)
              
      
      GenerateLetterCode ->
          ( model
          , Random.generate AppendNewLetter (Random.int letterRangeLow letterRangeHigh)
          )

      AppendNewLetter letterCode ->
          ({model | randomPart = fromCode(letterCode) :: model.randomPart}
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
       button [onClick (GenerateNameLength 1 10), class "mybutton"] [text "Generate length"]
      ,button [onClick (GenerateLetterCode), class "mybutton"] [text "Append to string"]
      ,button [onClick (GenerateName), class "mybutton"] [text "Name"]
      ,div [] [ text (String.fromInt model.length) ]
      ,text model.name
      ,text (String.fromList model.randomPart)
    ]
      
-- HELPERS
generateRandomPart: List Char
generateRandomPart =
    ['a']
