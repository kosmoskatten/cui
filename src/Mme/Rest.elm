module Mme.Rest exposing
  ( createNewMme
  , deleteMme
  )

{-| Rest API routines for the Mme. -}

import Array exposing (Array)
import Http as Http
import Http.Extra as Http
import Json.Decode as Dec
import Json.Encode as Enc
import Task exposing (..)

import Types exposing (..)

{-| Create a new Mme with the given name. -}
createNewMme : String -> Cmd Msg
createNewMme name =
  Task.perform RestOpFailed NewMmeCreated <| newMmeTask name

{-| Delete the given Mme. -}
deleteMme : Mme -> Cmd Msg
deleteMme mme =
  Task.perform RestOpFailed MmeDeleted <| Http.delete mme.url
    `andThen` (\_ -> succeed mme)

newMmeTask : String -> Task Http.Error Mme
newMmeTask name =
  createMme name `andThen`
    (\url -> fetchMmeIpConfig url
      `andThen` (\xs -> succeed { name      = name
                                , url       = url
                                , addresses = xs
                                }))

createMme : String -> Task Http.Error String
createMme name =
  (Http.post urlRef "/api/0.1/mme" <| Http.string (nameToObj name))
      `andThen` (\ref -> succeed <| ref.url)

fetchMmeIpConfig : String -> Task Http.Error (Array String)
fetchMmeIpConfig url =
  Http.get (Dec.array Dec.string) <| url ++ "/ip_config"

nameToObj : String -> String
nameToObj name =
  Enc.encode 4 (Enc.object [("name", Enc.string name)])
