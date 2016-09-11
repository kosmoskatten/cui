module CsimControlApp exposing
  ( init
  , view
  , update
  , subscriptions
  )

import Html exposing (..)
import Html.Attributes as A
import Html.Events as E

import MmePanel exposing (..)
import Types exposing (..)

-- Main model.
type alias Model =
  { livePanel : Equipment
  , mmeModel  : MmeModel
  }

init : (Model, Cmd Msg)
init = ({livePanel = UE, mmeModel = initMme}, Cmd.none)

-- Main view.
view : Model -> Html Msg
view model =
  div [ A.class "w3-container"
      , A.style [("padding-top", "20px")]
      ]
    [ viewEquipmentSelectors model
    , viewEquipmentPanel model
    ]

viewEquipmentSelectors : Model -> Html Msg
viewEquipmentSelectors model =
  div [ A.class "w3-row-padding w3-margin-bottom" ]
      [ viewEquipmentSelector UE 0
      , viewEquipmentSelector ENB 0
      , viewEquipmentSelector MME 0
      ]

viewEquipmentSelector : Equipment -> Int -> Html Msg
viewEquipmentSelector eq count =
  let (color, icon, label) = equipmentSelectorParams eq
      countStr             = toString count
  in
    div [ A.class "w3-third"
        , A.style [("cursor", "pointer")]
        , E.onClick (SetLivePanel eq)
        ]
      [ div [ A.class ("w3-container w3-padding-16 " ++ color) ]
          [ div [ A.class "w3-left" ]
              [ i [ A.class "material-icons", A.style [("font-size", "36px")]]
                  [ text icon ]
              ]
          , div [ A.class "w3-right" ]
              [ h3 [] [ text countStr ]
              ]
          , div [ A.class "w3-clear" ] []
          , h4 [] [ text label ]
          ]
      ]

equipmentSelectorParams : Equipment -> (String, String, String)
equipmentSelectorParams eq =
  case eq of
    UE  -> ("w3-blue", "phone_iphone", "UEs")
    ENB -> ("w3-teal", "router", "ENBs")
    MME -> ("w3-red", "gamepad", "MMEs")

viewEquipmentPanel : Model -> Html Msg
viewEquipmentPanel model =
  case model.livePanel of
        UE  -> viewUePanel model
        ENB -> viewEnbPanel model
        MME -> viewMmePanel model.mmeModel

viewUePanel : Model -> Html Msg
viewUePanel model =
  div [ A.class "w3-container" ]
    [ h4 [] [ text "UEs" ]
    ]

viewEnbPanel : Model -> Html Msg
viewEnbPanel model =
  div [ A.class "w3-container" ]
    [ h4 [] [ text "ENBs" ]
    ]

-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetLivePanel newEquipment ->
      ({model | livePanel = newEquipment}, Cmd.none)

    OpenNewMmeForm            ->
      ({model | mmeModel = openNewMmeForm model.mmeModel}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
