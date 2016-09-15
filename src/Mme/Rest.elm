module Mme.Rest exposing
  ( createNewMme
  )

{-| Rest API routines for the Mme. -}

import Array exposing (Array)
import Http as Http
import Json.Decode as Dec
import Json.Encode as Enc
import Task exposing (..)

import Types exposing (..)

createNewMme : String -> Cmd Msg
createNewMme newMme =
  Task.perform RestOpFailed
               (\xs -> NewMmeCreated {name = newMme, addresses = xs})
               <| restCreateNewMme newMme `andThen` restFetchMmeIps

restCreateNewMme : String -> Task Http.Error UrlRef
restCreateNewMme newMme =
  Http.post urlRef "/api/0.1/mme" <| Http.string (nameToObj newMme)

restFetchMmeIps : UrlRef -> Task Http.Error (Array String)
restFetchMmeIps url =
  let endPoint = url.url ++ "/ip_config"
  in Http.get (Dec.array Dec.string) endPoint

nameToObj : String -> String
nameToObj name =
  Enc.encode 4 (Enc.object [("name", Enc.string name)])
