module Types exposing
  ( Equipment (..)
  , Msg (..)
  , Mme
  )

{-| Generic types, shared between the modules -}

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

type alias Mme =
  { name : String
  , address : String
  }
