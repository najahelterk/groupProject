{-|
High-level client functions perfoming requests to OpenWeatherMap API.
-}
module Client (
  Location(..),
  getWeather
) where

import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.Client (ClientEnv(..), runClientM, ServantError)
import Servant.Common.BaseUrl (BaseUrl(..), Scheme(..))
import Servant.Common.Req (ClientM)

import Types.CurrentWeather (CurrentWeather)
import qualified API as API


-- | Various way to specify location.
data Location
  = Name String          -- ^ City name.

-- | Make a request to OpenWeatherMap API
--   and return current weather in given location.
getWeather
  :: String -- ^ API key.
  -> Location
  -> IO (Either ServantError CurrentWeather)
getWeather appid loc =
  defaultEnv >>= runClientM (api loc appid)

api
  :: Location
  -> String                  -- ^ API key.
  -> ClientM CurrentWeather
api (Name city) = API.weatherByName (Just city) . Just

defaultEnv :: IO ClientEnv
defaultEnv = do
  manager <- newManager defaultManagerSettings
  return $ ClientEnv manager baseUrl

-- XXX openweathermap.org does not support HTTPS,
-- XXX appid is passed in clear text. Oops.
baseUrl :: BaseUrl
baseUrl = BaseUrl Http "api.openweathermap.org" 80 "/data/2.5"
