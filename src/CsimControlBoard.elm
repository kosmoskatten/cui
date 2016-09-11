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
  { equipment : Equiment
  }

type Equiment
  = UE
  | ENB
  | MME

-- | Msg
type Msg = NoOp

init : (Model, Cmd Msg)
init = ({equipment = UE}, Cmd.none)

-- | Main view, render the main window and delegating the detailed rendering
-- to subviews.
view : Model -> Html Msg
view model =
  div [ A.class "w3-container"
      , A.style [("padding-top", "20px")]
      ]
    [ viewEquipmentSelectors model ]

viewEquipmentSelectors : Model -> Html Msg
viewEquipmentSelectors model =
  div [ A.class "w3-row-padding w3-margin-bottom" ]
      [ viewEquipmentSelector "w3-blue" "phone_iphone" "0" "UEs"
      , viewEquipmentSelector "w3-teal" "router" "0" "ENBs"
      , viewEquipmentSelector "w3-red" "gamepad" "0" "MMEs"
      ]

viewEquipmentSelector : String -> String -> String -> String -> Html Msg
viewEquipmentSelector color icon count label =
  div [ A.class "w3-third" ]
    [ div [ A.class ("w3-container w3-padding-16 " ++ color) ]
        [ div [ A.class "w3-left" ]
            [ i [ A.class "material-icons", A.style [("font-size", "36px")]]
                [text icon]
            ]
        , div [ A.class "w3-right" ]
            [ h3 [] [text count]
            ]
        , div [ A.class "w3-clear" ] []
        , h4 [] [ text label ]
        ]
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
