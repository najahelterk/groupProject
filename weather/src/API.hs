{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API (
  weatherByName
) where

import Data.Proxy (Proxy(..))
import Data.Text

import Servant.API ((:>), (:<|>)(..), JSON, Get, QueryParam)
import Servant.Client
import Network.HTTP.Client (newManager, defaultManagerSettings)

import Types.CurrentWeather (CurrentWeather)

type GetCurrentWeather = AppId :> Get '[JSON] CurrentWeather
type AppId = QueryParam "c75c1733561f1876eeaaca9c398b5bfd" String

type API
     = "weather" :> QueryParam "q" String :> GetCurrentWeather
                 :> GetCurrentWeather

-- | Request current weather in the city.
weatherByName
  :: Maybe String  -- ^ City name, e. g. \"Moscow\" or \"Moscow,ru\".
  -> Maybe String  -- ^ API key.
  -> ClientM CurrentWeather

weatherByName = client (Proxy :: Proxy API)


















import Data.Proxy
import Data.Text
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.API
import Servant.Client


type Book = Text

type MyApi = "books" :> Get '[JSON] [Book] -- GET /books
        :<|> "books" :> ReqBody '[JSON] Book :> Post '[JSON] Book -- POST /books

myApi :: Proxy MyApi
myApi = Proxy

-- 'client' allows you to produce operations to query an API from a client.
postNewBook :: Book -> ClientM Book
getAllBooks :: ClientM [Book]
(getAllBooks :<|> postNewBook) = client myApi


main :: IO ()
main = do
  manager' <- newManager defaultManagerSettings
  res <- runClientM getAllBooks (mkClientEnv manager' (BaseUrl Http "localhost" 8081 ""))
  case res of
    Left err -> putStrLn $ "Error: " ++ show err
    Right books -> print books
