
module weatherParser where
import Data.Char
import Control.Monad
import Control.Applicative




data Parser newWeather = Parser { parse:: Weather -> [(newWeather, Weather)] } 
runParser:: Parser newWeather -> Weather -> newWeather
runParser [] = weather

data Parser newBase = Parser { parse:: String -> [(newBase, String)] }
runParser:: Parser newBase -> String -> newBase
runParser [] = base

data Parser newMain = Parser { parse:: Main -> [(newMain, Main)] }
runParser:: Parser newMain -> Main -> newMain
runParser [] = main

data Parser newWind = Parser { parse:: Wind -> [(newWind, Wind)] } 
runParser:: Parser newWind -> Wind -> newWind
runParser [] = wind

data Parser newDT = Parser { parse:: Int-> [(newDT, Int)] }
runParser:: Parser newDT -> Int -> newDT
runParser [] = dt

data Parser newID = Parser { parse:: Int -> [(newID, Int)] }
runParser:: Parser newID -> Int -> newID
runParser [] = id

data Parser newName = Parser {parse:: String -> [(newName, String)] }
runParser:: Parser newName -> String -> newName
runParser [] = name

data Parser newCod = Parser {parse:: Int -> [(newCod, Int)] }
runParser:: Parser newCod -> Int -> newCod
runParser [] = cod





instance MonadAndParse Parser where
wZero = fail
wPlus = concat


instance emptyweather Parser where
empty = wZero


concat:: Parser w -> Parser w -> Parser w
concat a b = Parser(\s->parse a s ++ parse b s)


fail:: Parser w
fail = Parser (\cs -> [])






