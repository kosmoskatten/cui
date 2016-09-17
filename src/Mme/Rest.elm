module Mme.Rest exposing
  ( createMme
  , deleteMme
  )

{-| Rest API routines for the Mme. -}

import Array exposing (Array)
import HttpBuilder exposing (..)
import Json.Decode as Dec
import Json.Encode as Enc
import Task exposing (..)

import Types exposing (..)

createMme : String -> Cmd Msg
createMme name =
  Task.perform RestOpFailed NewMmeCreated
    <| createMmeTask name `andThen` (\resp1 ->
         fetchMmeIpConfigTask resp1.data `andThen` (\resp2 ->
           succeed { name      = name
                   , url       = resp1.data.url
                   , addresses = resp2.data
                   }
         )
       )

deleteMme : Mme -> Cmd Msg
deleteMme mme =
  Task.perform RestOpFailed MmeDeleted
    <| deleteMmeTask mme `andThen` (\_ -> succeed mme)

createMmeTask : String -> Task (HttpBuilder.Error String)
                               (HttpBuilder.Response UrlRef)
createMmeTask name =
  HttpBuilder.post "/api/0.1/mme"
    |> withJsonBody (Enc.object [("name", Enc.string name)])
    |> withHeaders [ ("Content-Type", "application/json")
                   , ("Accept", "application/json")]
    |> HttpBuilder.send (jsonReader urlRef) stringReader

fetchMmeIpConfigTask : UrlRef -> Task (HttpBuilder.Error String)
                                      (HttpBuilder.Response (Array String))
fetchMmeIpConfigTask urlRef =
  HttpBuilder.get (urlRef.url ++ "/ip_config")
    |> withHeader "Accept" "application/json"
    |> HttpBuilder.send (jsonReader <| Dec.array Dec.string) stringReader

deleteMmeTask : Mme -> Task (HttpBuilder.Error String)
                         (HttpBuilder.Response ())
deleteMmeTask mme =
  HttpBuilder.delete mme.url
    |> HttpBuilder.send unitReader stringReader
