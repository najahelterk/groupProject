{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module Types.CurrentWeather (
  CurrentWeather(..)
) where

import Prelude hiding (id)
import GHC.Generics (Generic)

import Data.Aeson (FromJSON)

import Types.Main (Main)
import Types.Weather (Weather)
import Types.Wind (Wind)

-- | Response to requests for current weather.
-- Refer to <https://openweathermap.org/current>.
data CurrentWeather = CurrentWeather
  { weather :: [Weather]
  , base :: String
  , main :: Main
  , wind :: Wind
  , dt :: Int
  , id :: Int
  , name :: String
  , cod :: Int
  } deriving (Show, Generic, FromJSON)
