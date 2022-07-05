module PE1 where

import Text.Printf
import Data.List

-- Type synonyms --
type Point = (Double, Double)
type Signal = (Double, Double, Double, Double)

-- This function takes a Double and rounds it to 2 decimal places as requested in the PE --
getRounded :: Double -> Double
getRounded x = read s :: Double
               where s = printf "%.2f" x

-------------------------------------------------------------------------------------------
----------------------- DO NOT CHANGE ABOVE OR FUNCTION SIGNATURES-------------------------
------------- DUMMY IMPLEMENTATIONS ARE GIVEN TO PROVIDE A COMPILABLE TEMPLATE ------------
------------------- REPLACE THEM WITH YOUR COMPILABLE IMPLEMENTATIONS ---------------------
-------------------------------------------------------------------------------------------

getDistance :: Point -> Point -> Double
getDistance (x1, y1) (x2, y2) = getRounded (((difference_square x1 x2)+(difference_square y1 y2))**0.5)
difference_square a b =  (a-b)^2
-------------------------------------------------------------------------------------------

findAllDistances :: Point -> [Point] -> [Double]
findAllDistances b [] = []
findAllDistances b (a:r) = ((getDistance b a):(findAllDistances b r))
-------------------------------------------------------------------------------------------

findExtremes :: Point -> [Point] -> (Point, Point)

findExtremes b l = (l!!(findMin (distList!!0) 0 0 distList), l!!(findMax (distList!!0) 0 0 distList)) where
                                distList = findAllDistances b l
findMin minP minIndex currIndex [] = minIndex
findMin minP minIndex currIndex (a:b) = if a<minP then findMin a currIndex (currIndex+1) b else findMin minP minIndex (currIndex+1) b
findMax maxP maxIndex currIndex [] = maxIndex
findMax maxP maxIndex currIndex (a:b) = if a>maxP then findMax a currIndex (currIndex+1) b else findMax maxP maxIndex (currIndex+1) b

-------------------------------------------------------------------------------------------

getSingleAction :: Signal -> String
getSingleAction signal =  case horizontal of
                            "Stay" -> vertical
                            otherwise -> case vertical of
                                            "Stay" -> horizontal
                                            otherwise -> horizontal++vertical
                          where
                          horizontal = horizontalWay (getNorth signal) (getSouth signal)
                          vertical = verticalWay (getEast signal) (getWest signal)
--(if (horizontal=="Stay") then ((if vertical=="Stay") then "Stay" else vertical) else ((if vertical=="Stay" ) then horizontal else horizontal++vertical))
getNorth (n,e,s,w) = n
getEast (n,e,s,w) = e
getSouth (n,e,s,w) = s
getWest (n,e,s,w) = w
horizontalWay n s = if n>s then "North" else (if n==s then "Stay" else "South")
verticalWay e w = if e>w then "East" else (if e==w then "Stay" else "West")

-------------------------------------------------------------------------------------------

getAllActions :: [Signal] -> [String]
getAllActions [] = []
getAllActions (a:b) = ((getSingleAction a):(getAllActions b))

-------------------------------------------------------------------------------------------

numberOfGivenAction :: Num a => [Signal] -> String -> a
numberOfGivenAction signals action = numberOfGivenActionHelper (getAllActions signals) action 0
numberOfGivenActionHelper [] action result = result
numberOfGivenActionHelper (a:b) action result = (if a==action then (numberOfGivenActionHelper b action (result+1)) else (numberOfGivenActionHelper b action result))
