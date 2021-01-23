module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random

-- MAIN
main =
  Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }

-- MODEL
type alias Model = { counter : Int , dieFace : Int }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model 0 1
  , Cmd.none
  )

-- UPDATE
type Msg
  = Increment
  | Decrement
  | Generate
  | NewFace Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      ( { model | counter = model.counter + 1 }
      , Cmd.none
      )

    Decrement ->
      ( { model | counter = model.counter - 1 }
      , Cmd.none
      )

    Generate ->
      ( model
      , Random.generate NewFace (Random.int 1 6)
      )

    NewFace newFace ->
      ( Model model.counter newFace
      , Cmd.none
      )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement, class "mybutton" ] [ text "-" ]
    , div [] [ text (String.fromInt model.counter) ]
    , button [ onClick Increment ] [ text "+" ]
    , randomButton model
    ]

randomButton model =
  div []
    [ h1 [] [ text (String.fromInt model.dieFace) ]
    , button [ onClick Generate ] [ text "Generate" ]
    ]
