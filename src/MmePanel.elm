module MmePanel exposing
  ( MmeModel
  , initMme
  , viewMmePanel
  , openNewMmeForm
  )

import Html exposing (..)
import Html.Attributes as A
import Html.Events as E

import Types exposing (..)

-- Sub model for Mme.
type alias MmeModel =
  { newMmeFormOpen : Bool
  }

initMme : MmeModel
initMme = {newMmeFormOpen = False}

viewMmePanel : MmeModel -> Html Msg
viewMmePanel model =
  div [ A.class "w3-container" ]
    [ h4 [] [ text "MMEs" ]
    , viewMmeList model
    ]

viewMmeList : MmeModel -> Html Msg
viewMmeList model =
  table [ A.class "w3-table w3-striped w3-white" ]
    [mmeListTopRow model]

mmeListTopRow : MmeModel -> Html Msg
mmeListTopRow model =
  if model.newMmeFormOpen
    then newMmeForm model
    else addNewMme model

addNewMme : MmeModel -> Html Msg
addNewMme model =
  tr []
    [ td []
        [ i [ A.class "material-icons w3-padding-tiny"
            , A.style [("cursor", "pointer")]
            , E.onClick OpenNewMmeForm
            ]
            [ text "add" ]
        ]
    , td []
        [ text "Add new MME" ]
    ]

newMmeForm : MmeModel -> Html Msg
newMmeForm model =
  tr [] []

-- Update event callbacks.
openNewMmeForm : MmeModel -> MmeModel
openNewMmeForm model = {model | newMmeFormOpen = True}
