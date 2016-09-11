module Types exposing
  ( Equipment (..)
  , Msg (..)
  )

type Equipment
  = UE
  | ENB
  | MME

type Msg
  = SetLivePanel Equipment
  | OpenNewMmeForm
