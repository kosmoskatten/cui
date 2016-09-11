module MmePanel exposing
  ( MmeModel
  , initMme
  , viewMmePanel
  )

import Html exposing (..)
import Html.Attributes as A

import Types exposing (..)

-- Sub model for Mme.
type alias MmeModel =
  { isAddingNewMme : Bool
  }

initMme : MmeModel
initMme = {isAddingNewMme = False}

viewMmePanel : MmeModel -> Html Msg
viewMmePanel model =
  div [ A.class "w3-container" ]
    [ h4 [] [ text "MMEs" ]
    , viewMmeList model
    ]

viewMmeList : MmeModel -> Html Msg
viewMmeList model =
  table [ A.class "w3-table w3-striped w3-white" ]
    [addNewMme model]

addNewMme : MmeModel -> Html Msg
addNewMme model =
  tr [ A.style [("cursor", "pointer")] ]
    [ td []
        [ i [ A.class "material-icons w3-padding-tiny" ]
            [ text "add" ]
        ]
    , td []
        [ text "Add new MME" ]
    ]
