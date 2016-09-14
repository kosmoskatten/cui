module Mme.Rest exposing
  ( createNewMme
  )

{-| Rest API routines for the Mme. -}

import Http as Http
import Json.Encode as Json
import Task exposing (..)

import Types exposing (..)

createNewMme : String -> Cmd Msg
createNewMme newMme =
  Task.perform RestOpFailed NewMmeCreated
               (Http.post urlRef "/api/0.1/mme" (Http.string (nameToObj newMme)))

nameToObj : String -> String
nameToObj name =
  Json.encode 4 (Json.object [("name", Json.string name)])
