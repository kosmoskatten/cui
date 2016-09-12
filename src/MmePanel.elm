module MmePanel exposing
  ( MmeModel
  , initMme
  , viewMmePanel
  , numMmes
  , openNewMmeForm
  , cancelNewMmeForm
  , onInputNewMmeName
  , submitNewMmeForm
  )

import Html exposing (..)
import Html.Attributes as A
import Html.Events as E
import List exposing (head, map)
import Maybe exposing (withDefault)
import String exposing (length, toList, left, any)

import CharExtra exposing (isAlpha, isSpace)
import Types exposing (..)

-- Sub model for Mme.
type alias MmeModel =
  { newMmeFormOpen : Bool -- Flag to tell if the new mme form is open.
  , newMmeName : String -- The value of the new mme form's input field.
  , mmes : List Mme
  }

type alias Mme =
  { name : String
  , address : String
  }

initMme : MmeModel
initMme =
  { newMmeFormOpen = False
  , newMmeName = ""
  , mmes = []
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

numMmes : MmeModel -> Int
numMmes model = List.length model.mmes

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
             , A.disabled (shallNewMmeSubmitBeDisabled model.newMmeName)
             , E.onClick (SubmitNewMmeForm model.newMmeName)
             ]
             [ text "Submit" ]
    , button [ A.class "w3-btn w3-red"
             , E.onClick CancelNewMmeForm
             ]
             [ text "Cancel" ]
    ]

viewMmeList : MmeModel -> Html Msg
viewMmeList model =
  table [ A.class "w3-table-all" ]
    (map viewMmeListItem model.mmes)

viewMmeListItem : Mme -> Html Msg
viewMmeListItem mme =
  tr []
    [ td [] [ text mme.name ]
    , td [] [ text mme.address ]
    ]

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

-- Kind of dummy right now.
submitNewMmeForm : MmeModel -> String -> MmeModel
submitNewMmeForm model newName =
  let mme = {name = newName, address = "10.10.10.2"}
  in {model | newMmeFormOpen = False
            , newMmeName = ""
            , mmes = mme :: model.mmes}

shallNewMmeSubmitBeDisabled : String -> Bool
shallNewMmeSubmitBeDisabled newMme =
    length newMme < 1 || not (isFirstCharAlpha newMme) || any isSpace newMme

isFirstCharAlpha : String -> Bool
isFirstCharAlpha str =
  case firstChar str of
    Just c  -> isAlpha c
    Nothing -> False

firstChar : String -> Maybe Char
firstChar = head << toList << left 1
