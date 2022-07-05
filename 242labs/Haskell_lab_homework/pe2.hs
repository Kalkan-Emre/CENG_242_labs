module PE2 where

import Text.Printf

type Point = (Int, Int)
type Dimensions = (Int, Int)
type Vector = (Int, Int)

getRounded :: Double -> Double
getRounded x = read s :: Double
               where s = printf "%.2f" x

castIntToDouble x = (fromIntegral x) :: Double

-------------------------------------------------------------------------------------------
----------------------- DO NOT CHANGE ABOVE OR FUNCTION SIGNATURES-------------------------
------------- DUMMY IMPLEMENTATIONS ARE GIVEN TO PROVIDE A COMPILABLE TEMPLATE ------------
------------------- REPLACE THEM WITH YOUR COMPILABLE IMPLEMENTATIONS ---------------------
-------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
getVector :: String -> Vector
getVector d = case d of
                 "Stay" -> (0,0)
                 "North" -> (0,1)
                 "South" -> (0,-1)
                 "East" -> (1,0)
                 "West" -> (-1,0)
                 "NorthEast" -> (1,1)
                 "NorthWest" -> (-1,1)
                 "SouthEast" -> (1,-1)
                 "SouthWest" -> (-1,-1)

-------------------------------------------------------------------------------------------------------------------------------
getAllVectors :: [String] -> [Vector]
getAllVectors [] = []
getAllVectors (a:b) = ((getVector a):(getAllVectors b)) 

-------------------------------------------------------------------------------------------------------------------------------

producePath :: Point -> [String] -> [Point]
producePath (a,b) [] = []
producePath (a,b) (c:d) = producePathHelper (a,b) (c:d) []
producePathHelper (a,b) [] [] = [(a,b)]
producePathHelper (a,b) [] ["a"] = [(a,b)]
producePathHelper (a,b) (c:d) [] = ((a,b):(producePathHelper (new_a,new_b) d ["a"])) where
                                                  new_a = a+ (horizontal (getVector c))
                                                  new_b = b+ (vertical (getVector c)) 
                                                          
producePathHelper (a,b) (c:d) ["a"] = ((a,b):(producePathHelper (new_a,new_b) d ["a"])) where
                                                  new_a = a+ (horizontal (getVector c))
                                                  new_b = b+ (vertical (getVector c))
horizontal (aa,bb) = aa
vertical (aa,bb) = bb
-------------------------------------------------------------------------------------------------------------------------------
takePathInArea :: [Point] -> Dimensions -> [Point]
takePathInArea [] (bx, by) = []
takePathInArea (a:b) (bx, by) = if ((horizontal a)<bx) then 
                                                        if ((vertical a)<by) then
                                                                if ((horizontal a)>(-1)) then
                                                                   if ((vertical a)>(-1)) then
                                                                        (a:(takePathInArea b (bx, by))) 
                                                                    else []
                                                                else []                             
                                                        else [] 
                                else [] 
-------------------------------------------------------------------------------------------------------------------------------

remainingObjects :: [Point] -> Dimensions -> [Point] -> [Point]
remainingObjects [] border objects = objects
remainingObjects (a:b) border objects = if ((takePathInArea [a] border)==[a]) then (remainingObjects (takePathInArea b border) border (isOnLocation a objects []))
                                                else (remainingObjects (takePathInArea b border) border objects)

isOnLocation (a,b) [] l = l
isOnLocation (a,b) (c:d) l = if (c==(a,b)) then (isOnLocation (a,b) d l) else (isOnLocation (a,b) d (l++[c]))

-------------------------------------------------------------------------------------------------------------------------------
averageStepsInSuccess :: [[Point]] -> Dimensions -> [Point] -> Double
averageStepsInSuccess paths border objects = getRounded ((castIntToDouble totalStepNumber)/(castIntToDouble totalSuccessNumber)) where
                                                                totalStepNumber = totalSteps paths border objects 0
                                                                totalSuccessNumber = totalSuccess paths border objects 0

isSuccessful path border object = if (((remainingObjects path border object)==[])&& ((takePathInArea path border)==path)) then 1 else 0

totalSteps [] border objects count = count
totalSteps (a:b) border objects count = if ((isSuccessful a border objects)==1) then 
                                                    let new_count = count+(stepCount a 0) in (totalSteps b border objects new_count) 
                                        else totalSteps b border objects count

totalSuccess [] border objects total = total
totalSuccess (a:b) border objects total = totalSuccess b border objects (total+(isSuccessful a border objects))

stepCount [] count = count
stepCount (a:b) count= stepCount b (count+1)



















