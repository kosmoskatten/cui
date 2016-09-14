module Types exposing
  ( Equipment (..)
  , Msg (..)
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
