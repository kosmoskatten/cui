module Types exposing
  ( Equipment (..)
  , Msg (..)
  , Mme
  , UrlRef
  , urlRef
  )

{-| Generic types, shared between the modules -}

import Http exposing (Error)
import Json.Decode exposing (..)

type Equipment
  = UE
  | ENB
  | MME

type Msg
  = SetLivePanel Equipment
  | OpenNewMmeForm
  | CancelNewMmeForm
  | OnInputNewMmeName String
  | SubmitNewMmeForm String
  | NewMmeCreated UrlRef
  | RestOpFailed Error

type alias Mme =
  { name : String
  , address : String
  }

type alias UrlRef =
  { url : String
  }

{-| Json decoder for UrlRef -}
urlRef : Decoder UrlRef
urlRef =
  object1 UrlRef
    ("url" := string)
