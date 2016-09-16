module Http.Extra exposing
  ( promoteError
  )

{-| Missing functions from the Http module. -}

import Http exposing (..)
import Task exposing (..)


--delete : String -> Task RawError ()
--delete url =
--  let request =
--    { verb    = "DELETE"
--    , headers = []
--    , url     = url
--    , body    = empty
--    }
--  in send defaultSettings request `andThen` handleResponse succeed

promoteError : RawError -> Error
promoteError error =
  case error of
    RawTimeout      -> Timeout
    RawNetworkError -> NetworkError
