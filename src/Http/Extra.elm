module Http.Extra exposing
  ( delete
  )

{-| Missing functions from the Http module. -}

import Http exposing (..)
import Task exposing (..)

delete : String -> Task Error ()
delete url =
  let request =
    { verb    = "DELETE"
    , headers = []
    , url     = url
    , body    = empty
    }
  in (mapError promoteError <| send defaultSettings request)
        `andThen` handleResponse

handleResponse : Response -> Task Error ()
handleResponse response =
  if response.status >= 200 && response.status < 300
    then succeed ()
    else fail (BadResponse response.status response.statusText)

promoteError : RawError -> Error
promoteError error =
  case error of
    RawTimeout      -> Timeout
    RawNetworkError -> NetworkError
