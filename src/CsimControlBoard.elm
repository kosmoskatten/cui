module CsimControlBoard exposing
  ( init
  , view
  , update
  , subscriptions
  )

import Html exposing (..)
import Html.Attributes as A

-- | Model
type alias Model =
  { foo : String
  }

-- | Msg
type Msg = NoOp

init : (Model, Cmd Msg)
init = ({foo = "hello"}, Cmd.none)

-- | Main view, render the main window and delegating the detailed rendering
-- to subviews.
view : Model -> Html Msg
view model =
  div [ A.class "w3-container"
      , A.style [("padding-top", "20px")]
      ]
    [ viewTopPanels model ]

viewTopPanels : Model -> Html Msg
viewTopPanels model =
  div [ A.class "w3-row-padding w3-margin-bottom" ]
      [ viewUePanel model
      , viewEnbPanel model
      , viewMmePanel model
      ]

viewUePanel : Model -> Html Msg
viewUePanel model =
  div [ A.class "w3-third" ]
    [ div [ A.class "w3-container w3-blue w3-padding-16" ]
        [ h4 [] [ text model.foo ]
        ]
    ]

viewEnbPanel : Model -> Html Msg
viewEnbPanel model =
  div [ A.class "w3-third" ]
    [ div [ A.class "w3-container w3-teal w3-padding-16" ]
        [ h4 [] [ text model.foo ]
        ]
    ]

viewMmePanel : Model -> Html Msg
viewMmePanel model =
  div [ A.class "w3-third" ]
    [ div [ A.class "w3-container w3-orange w3-padding-16" ]
        [ h4 [] [ text model.foo ]
        ]
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
