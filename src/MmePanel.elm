module MmePanel exposing
  ( MmeModel
  , initMme
  , viewMmePanel
  , openNewMmeForm
  , cancelNewMmeForm
  , onInputNewMmeName
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
    , if model.newMmeFormOpen
        then newMmeForm model
        else addNewMme
    , viewMmeList model
    ]

addNewMme : Html Msg
addNewMme =
  div [ A.class "w3-blue-grey" ]
      [ div [ A.class "w3-left" ]
          [ i [ A.class "material-icons w3-padding-tiny"
          , A.style [("cursor", "pointer")]
          , E.onClick OpenNewMmeForm
          ] [ text "add"]
      ]
      , h5 [] [ text "Add new MME" ]
      ]

newMmeForm : MmeModel -> Html Msg
newMmeForm model =
  div []
    [ div [ A.class "w3-container w3-blue-grey" ]
        [ h4 [] [ text "Add new MME"] ]
    , form [ A.class "w3-container", A.style [("padding-bottom", "20px")] ]
        [ p [] []
        , label [] [ text "New MME Name" ]
        , input [ A.class "w3-input w3-light-grey"
                , A.type' "text"
                , A.placeholder "Name for the new MME (e.g. mme1)"
                , A.value model.newMmeName
                , E.onInput OnInputNewMmeName
                ] []
        ]
    , button [ A.class "w3-btn w3-green"
             , A.disabled True
             , E.onClick CancelNewMmeForm
             ]
             [ text "Submit" ]
    , button [ A.class "w3-btn w3-red"
             , E.onClick CancelNewMmeForm
             ]
             [ text "Cancel" ]
    ]

viewMmeList : MmeModel -> Html Msg
viewMmeList model =
  table [ A.class "w3-table w3-striped w3-white" ]
    []

-- Update event callbacks.
openNewMmeForm : MmeModel -> MmeModel
openNewMmeForm model =
  {model | newMmeFormOpen = True}

cancelNewMmeForm : MmeModel -> MmeModel
cancelNewMmeForm model =
  {model | newMmeFormOpen = False
         , newMmeName = ""
  }

onInputNewMmeName : MmeModel -> String -> MmeModel
onInputNewMmeName model newName =
  {model | newMmeName = newName}
