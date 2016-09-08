module CsimControlBoard exposing
  ( init
  , view
  , update
  , subscriptions
  )

import Html exposing (..)

-- | Model
type alias Model =
  { foo : String
  }

-- | Msg
type Msg = NoOp

init : (Model, Cmd Msg)
init = ({foo = "hello"}, Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [ text model.foo ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
