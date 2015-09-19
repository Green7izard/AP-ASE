module Day3 where

--Hash Map
-- https://wiki.haskell.org/Heterogenous_collections

import Data.Dynamic
type KeyValue = (String, Dynamic)
type Hash = [KeyValue]

createValue :: String->Dynamic->KeyValue
createValue key value = (key, value)

storeValue :: Hash->String->Dynamic->Hash
storeValue map key value = storePair map (key, value)

storePair :: Hash->KeyValue->Hash
storePair map pair = map ++[pair]

searchKey:: String -> Hash-> Maybe Dynamic
searchKey key [] = Nothing
searchKey [] map = Nothing
searchKey key ((k, value):rest) =
  if key == k  then Just value
   else searchKey key rest


pairOneA = createValue "Test2" (toDyn "Value")
pairOneSubHash = storePair [] pairOneA;
pairOneB = createValue "Test" (toDyn pairOneSubHash)
pairTwoA = createValue "TheAnswer" (toDyn "42")
pairTwoSubHash= storePair [] pairTwoA
pairTwoB = createValue "TheQuestion" (toDyn storePair)


exampleMap =  storePair(storePair [] pairOneB) pairTwoB  
--Can find a value, cant unwrap it properly to useable size



--Maze

-- Every part is a node, the start or the end
data Role = Node | Start | End deriving (Show)
--Node is a list of possible exit points to specific locations, and a notify if its the start or the end
type Node = ([(Int, Int)],Role)
-- A maze is a collection of nodes in a two dimensional space
type Maze = [[Node]]

getNode ::Maze->(Int, Int)->Node
getNode [] loc = ([(-1, -1)], Node)
getNode maze (x, y) = (maze !! x)!!y

exampleMaze = [
                 [([(0::Int,1::Int), (1::Int,0::Int)], Start), ([(0::Int, 2::Int)], Node),([(0::Int, 3::Int)], Node),([(1::Int, 3::Int)], Node)],
                 [([(1,2)], Node), ([(2, 2)], Node), ([], End), ([], Node)],
                 [([(3,0)], Node),([(2, 1)], Node),([(1,3)], Node),([(1,3)], Node)],
                 [([(3,1)], Node),([(3, 2)], Node),([(3,3), (2,3)], Node),([(2,3)], Node)]
              ]



