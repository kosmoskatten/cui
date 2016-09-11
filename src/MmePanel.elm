module MmePanel exposing
  ( MmeModel
  , initMme
  , viewMmePanel
  , openNewMmeForm
  , cancelNewMmeForm
  )

import Html exposing (..)
import Html.Attributes as A
import Html.Events as E

import Types exposing (..)

-- Sub model for Mme.
type alias MmeModel =
  { newMmeFormOpen : Bool
  , newMmeName : String
  }

initMme : MmeModel
initMme =
  { newMmeFormOpen = False
  , newMmeName = ""
  }

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
  tr []
    [ div [ A.class "w3-container w3-red" ]
        [ h2 [] [ text "New MME" ] ]
    , form [ A.class "w3-container" ]
        [ p [] []
        , label [] [ text "MME Name" ]
        , input [ A.class "w3-input"
                , A.placeholder "Name for the MME, e.g. mme1"
                , A.value model.newMmeName
                ] []
        , button [ E.onClick CancelNewMmeForm
                 ] [ text "Cancel" ]
        ]
    ]

-- Update event callbacks.
openNewMmeForm : MmeModel -> MmeModel
openNewMmeForm model = {model | newMmeFormOpen = True}

cancelNewMmeForm : MmeModel -> MmeModel
cancelNewMmeForm model = {model | newMmeFormOpen = False
                                , newMmeName = ""
                         }
