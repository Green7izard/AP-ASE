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
data Role = Node | Start | End deriving (Show, Eq)
--Node is a list of possible exit points to specific locations, and a notify if its the start or the end
type Node = ([(Int, Int)],Role)
-- A maze is a collection of nodes in a two dimensional space
type Maze = [[Node]]

getNode ::Maze->(Int, Int)->Node
getNode [] loc = ([(-1, -1)], Node)
getNode maze (x, y) = (maze !! x)!!y

smallMaze = [
               [([(0::Int,1::Int), (1,0)],Start), ([(1,1)],Node)],
               [([],Node), ([],End)]
            ]

exampleMaze::Maze
exampleMaze = [
                 [([(0,1), (1,0)], Start), ([(2, 0)], Node),([(3,0)]       , Node)  ,([(3, 1)], Node)],
                 [([(1,1)]       , Node) , ([(1, 2)], Node),([]            , End)   ,([], Node)],
                 [([(0,3)]       , Node) , ([(0, 2)], Node),([(2,1)]       , Node)  ,([(3,1)], Node)],
                 [([(1,3)]       , Node) , ([(2, 3)], Node),([(3,3), (2,2)], Node)  ,([(3,2)], Node)]
              ]

--Solving it
--The solution is a path of nodes
type Path = [Node]


getNextNodes::Maze->Node->[Node]
getNextNodes [] nodes = []
getNextNodes maze (exits, role)=[getNode maze x| x<-exits]

findStart :: [[Node]]->Node
findStart list = head[node|subList<-list, node<-subList, isStart node]

isStart :: Node->Bool
isStart (list, role) = role==Start

isEnd::Node->Bool
isEnd (exits, role)= role==End

hasEnd::Path-> Bool
hasEnd path = isEnd(last path)

containsEnd::[Path]-> Bool
containsEnd [] = False;
containsEnd (h:t) = if(hasEnd h) then True else containsEnd t

possibleNext::Maze->Path->[Path]
possibleNext maze [] = []
possibleNext maze path = [path++[newNode]| newNode<-(getNextNodes maze (last path))]

nextPath::Maze->[Path]->Int->[Path]
nextPath maze [] numb = []
nextPath maze paths numb = [newPaths|path<-paths, newPaths<-possibleNext maze path, length newPaths>=numb||hasEnd newPaths ]

filterPaths::[Path]->[Path]
filterPaths [] = []
filterPaths paths = [enders|enders<-paths, hasEnd enders]


findPaths::Maze->[Path]->Int->[Path]
findPaths maze [] numb = []
findPaths maze paths numb = if containsEnd paths then filterPaths paths else findPaths maze (nextPath maze paths (numb)) (numb+1)

solveMaze::Maze->[Path]
solveMaze [] = []
solveMaze maze = findPaths maze [[findStart maze]] 2
