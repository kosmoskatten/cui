module CharExtra exposing
  ( isAlpha
  , isSpace
  )

import Char exposing (toLower)

{-| Check if the given character is alphabetic -}
isAlpha : Char -> Bool
isAlpha c =
  let c' = toLower c
  in c' >= 'a' && c' <= 'z'

{-| Check if the given character is a whitespace -}
isSpace : Char -> Bool
isSpace c = c == ' ' || c == '\n' || c == '\r' || c == '\t'
