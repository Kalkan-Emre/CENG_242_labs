module PE4 where

import Data.List
import Data.Maybe

data Room = SeedStorage Int
          | Nursery Int Int
          | QueensChambers
          | Tunnel
          | Empty
          deriving Show

data Nestree = Nestree Room [Nestree] deriving Show

---------------------------------------------------------------------------------------------
------------------------- DO NOT CHANGE ABOVE OR FUNCTION SIGNATURES-------------------------
--------------- DUMMY IMPLEMENTATIONS ARE GIVEN TO PROVIDE A COMPILABLE TEMPLATE ------------
--------------------- REPLACE THEM WITH YOUR COMPILABLE IMPLEMENTATIONS ---------------------
---------------------------------------------------------------------------------------------

-- Note: undefined is a value that causes an error when evaluated. Replace it with
-- a viable definition! Name your arguments as you like by changing the holes: _

---------------------------------------------------------------------------------------------

-- Q1: Calculate the nutrition value of a given nest.
nestNutritionValue :: Nestree -> Int
nestNutritionValue tree = nestNutritionValueHelper 0 [tree] 

nestNutritionValueHelper nutrvalue []  = nutrvalue 
nestNutritionValueHelper total (a:b)  = nestNutritionValueHelper ((calculateNutrition a 0)+total) b 

calculateNutrition ( Nestree (QueensChambers) []) total = total
calculateNutrition ( Nestree (Tunnel) []) total = total
calculateNutrition ( Nestree Empty []) total = total
calculateNutrition ( Nestree (SeedStorage x) []) total = total + 3*x
calculateNutrition ( Nestree (Nursery x y) [] ) total = total + 7*x+ 10*y

calculateNutrition ( Nestree (QueensChambers) (a:b)) total = nestNutritionValueHelper total (a:b) 
calculateNutrition ( Nestree (Tunnel) (a:b)) total = nestNutritionValueHelper total (a:b) 
calculateNutrition ( Nestree Empty (a:b)) total = nestNutritionValueHelper total (a:b) 
calculateNutrition ( (Nestree (SeedStorage x) (a:b))) total = nestNutritionValueHelper (total + 3*x) (a:b) 
calculateNutrition ( Nestree (Nursery x y) (a:b) ) total = nestNutritionValueHelper (total + 7*x+ 10*y) (a:b) 


-- Q2: Calculate the nutrition value of each root-to-leaf path.
pathNutritionValues :: Nestree -> [Int]

pathNutritionValues tree = pathNutritionValuesHelper 0 [tree] []

pathNutritionValuesHelper prevPathVal [] resultList  = resultList 
pathNutritionValuesHelper prevPathVal (a:b) resultList = pathNutritionValuesHelper prevPathVal b (resultList++(calculateNutritionPath a prevPathVal)) 

calculateNutritionPath ( Nestree (QueensChambers) []) prevPathVal = [prevPathVal]
calculateNutritionPath ( Nestree (Tunnel) []) prevPathVal = [prevPathVal]
calculateNutritionPath ( Nestree Empty []) prevPathVal = [prevPathVal]
calculateNutritionPath ( Nestree (SeedStorage x) []) prevPathVal = [prevPathVal + 3*x]
calculateNutritionPath ( Nestree (Nursery x y) [] ) prevPathVal = [prevPathVal + 7*x+ 10*y]

calculateNutritionPath ( Nestree (QueensChambers) (a:b)) total = pathNutritionValuesHelper total (a:b) [] 
calculateNutritionPath ( Nestree (Tunnel) (a:b)) total = pathNutritionValuesHelper total (a:b) []
calculateNutritionPath ( Nestree Empty (a:b)) total = pathNutritionValuesHelper total (a:b) []
calculateNutritionPath ( (Nestree (SeedStorage x) (a:b))) total = pathNutritionValuesHelper (total + 3*x) (a:b) []
calculateNutritionPath ( Nestree (Nursery x y) (a:b) ) total = pathNutritionValuesHelper (total + 7*x+ 10*y) (a:b) []


-- Q3: Find the depth of the shallowest tunnel, if you can find one.
shallowestTunnel :: Nestree -> Maybe Int
shallowestTunnel a = if (tunnelSize == 0) then Nothing 
                            else Just tunnelSize where
                                    tunnelSize = shallowestTunnelHelper [a] 0 False
                                    
shallowestTunnelHelper _ tunnelSize True  = tunnelSize
shallowestTunnelHelper [] tunnelSize found = 0
shallowestTunnelHelper (a:b) tunnelSize found= if (((findShallowestTunnel a (tunnelSize))/=0)&&((shallowestTunnelHelper b tunnelSize found)/=0)) 
                                                then (if ((findShallowestTunnel a (tunnelSize))>(shallowestTunnelHelper b tunnelSize found)) 
                                                            then (shallowestTunnelHelper b tunnelSize found)
                                                                else (findShallowestTunnel a (tunnelSize)))
                                                        else (if ((findShallowestTunnel a (tunnelSize) )==0)then(shallowestTunnelHelper b tunnelSize found)
                                                                else (if ((shallowestTunnelHelper b tunnelSize found)==0)then(findShallowestTunnel a (tunnelSize))
                                                                    else 0))

findShallowestTunnel ( Nestree (QueensChambers) []) total = 0
findShallowestTunnel ( Nestree (Tunnel) []) total = total+1
findShallowestTunnel ( Nestree Empty []) total =  0 
findShallowestTunnel ( (Nestree (SeedStorage x) [])) total =  0
findShallowestTunnel ( Nestree (Nursery x y) [] ) total = 0

findShallowestTunnel ( Nestree (QueensChambers) (a:b)) total = shallowestTunnelHelper (a:b) (total+1) False
findShallowestTunnel ( Nestree (Tunnel) (a:b)) total = shallowestTunnelHelper (a:b) (total+1) True
findShallowestTunnel ( Nestree Empty (a:b)) total  = shallowestTunnelHelper (a:b) (total+1) False
findShallowestTunnel ( (Nestree (SeedStorage x) (a:b))) total = shallowestTunnelHelper (a:b) (total+1) False
findShallowestTunnel ( Nestree (Nursery x y) (a:b) ) total = shallowestTunnelHelper (a:b) (total+1) False

-- Q4: Find the path to the Queen's Chambers, if such a room exists.
pathToQueen :: Nestree -> Maybe [Room]
pathToQueen tree = pathToQueenHelper [tree] []

isEmpty = \list ->
  case list of
    [] -> True
    _ -> False  
    
pathToQueenHelper :: [Nestree] -> [Room] -> Maybe [Room]
pathToQueenHelper [] result = if (isEmpty result) then Nothing else Just result
pathToQueenHelper (a:b) result | (isNothing (findPath a result)) = if(isEmpty b) then Nothing else (pathToQueenHelper b result)
                               | otherwise = (findPath a result)
                               
findPath :: Nestree -> [Room] -> Maybe [Room]
findPath ( Nestree (QueensChambers) []) path = Just path
findPath ( Nestree (Tunnel) [])  path =  Nothing
findPath ( Nestree Empty [])  path =   Nothing
findPath ( Nestree (SeedStorage x) [])  path =   Nothing
findPath ( Nestree (Nursery x y) [] )  path =  Nothing

findPath ( Nestree (QueensChambers) (a:b)) path = Just path
findPath ( Nestree x (a:b)) path = pathToQueenHelper (a:b) (path++[x])

-- Q5: Find the quickest depth to the Queen's Chambers, including tunnel-portation :)
quickQueenDepth :: Nestree -> Maybe Int

quickQueenDepth tree =  if (isNothing (pathToQueen tree)) then Nothing else (
                            if ((isNothing (shallowestTunnel tree))||((length (fromMaybeList(pathToQueen tree)))<=(fromjust(shallowestTunnel tree)))) then Just ((length (fromMaybeList(pathToQueen tree)))+1)
                                else (if (finalLength >(length (fromMaybeList(pathToQueen tree)))) then Just ((length (fromMaybeList(pathToQueen tree)))+1) 
                                                else Just finalLength
                                            ) 
                            )where 
                            finalLength =  ((fromjust(shallowestTunnel tree))+((length (fromMaybeList(pathToQueen tree)))-(findTunnelIndex (pathToQueen tree) 0 0 )))
fromjust::Maybe Int -> Int
fromjust (Just x) = x
fromMaybeList::Maybe[Room]->[Room]
fromMaybeList  (Just x) = x
findTunnelIndex :: Maybe [Room] -> Int -> Int -> Int                           
findTunnelIndex (Just []) index result = result
findTunnelIndex (Just ((Tunnel):b)) index result = findTunnelIndex (Just b) (index+1) index
findTunnelIndex (Just(a:b)) index result = findTunnelIndex (Just b) (index+1) result

-- Example nest given in the PDF.
exampleNest :: Nestree
exampleNest = 
  Nestree Tunnel [
    Nestree (SeedStorage 15) [
      Nestree (SeedStorage 81) []
    ],
    Nestree (Nursery 8 16) [
      Nestree Tunnel [
        Nestree QueensChambers [
          Nestree (Nursery 25 2) []
        ]
      ]
    ],
    Nestree Tunnel [
      Nestree Empty [],
      Nestree (SeedStorage 6) [
        Nestree Empty [],
        Nestree Empty []
      ]
    ]
  ]

-- Same example tree, with tunnels replaced by Empty
exampleNestNoTunnel :: Nestree
exampleNestNoTunnel = 
  Nestree Empty [
    Nestree (SeedStorage 15) [
      Nestree (SeedStorage 81) []
    ],
    Nestree (Nursery 8 16) [
      Nestree Empty [
        Nestree QueensChambers [
          Nestree (Nursery 25 2) []
        ]
      ]
    ],
    Nestree Empty [
      Nestree Empty [],
      Nestree (SeedStorage 6) [
        Nestree Empty [],
        Nestree Empty []
      ]
    ]
  ]
