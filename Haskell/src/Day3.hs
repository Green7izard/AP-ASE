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

-- Gets a position, X is in the Main list (List of lists), Y is in the sublist (List of nodes)
getNode ::Maze->(Int, Int)->Node
getNode [] loc = ([(-1, -1)], Node)
getNode maze (x, y) = (maze !! x)!!y

-- Smaller maze for a simple demo
smallMaze::Maze
smallMaze = [
               [([(0,1), (1,0)],Start), ([(1,1)],Node)],
               [([],Node), ([],End)]
            ]

-- Larger maze with more dead ends
exampleMaze::Maze
exampleMaze = [
                 [([(0,1), (1,0)], Start), ([(0, 2)], Node),([(0,3)]       , Node)  ,([(1, 3)], Node)],
                 [([(1,1)]       , Node) , ([(2, 1)], Node),([]            , End)   ,([], Node)],
                 [([(3,0)]       , Node) , ([(2, 0)], Node),([(1,2)]       , Node)  ,([(1,3)], Node)],
                 [([(3,1)]       , Node) , ([(3, 2)], Node),([(3,3), (2,2)], Node)  ,([(2,3)], Node)]
              ]
-- Maze that goes back and forth and circlelike and all
loopMaze::Maze
loopMaze = [
                [([(0,1), (1,0)]     , Start), ([(0,0), (0,2)], Node),([(0,1), (0,3)], Node)         ,([(0,2), (1,3)], Node)],
                [([(2,0), (0,0)]     , Node) , ([(0,1)       ], Node),([]            , End)          ,([(2,3), (0,3)], Node)],
                [([(3,0), (1,0)]     , Node) , ([(1,1), (2,2)], Node),([(0,0), (2,1), (1,2)] ,Node) ,([(3,3), (1,3)], Node)],
                [([(2,0), (3,1)]     , Node) , ([(3,0), (3,2)], Node),([(3,1), (3,3)], Node)         ,([(3,2), (2,3), (2,2)], Node)]
           ]

--Solving it
--The solution is a path of nodes
type Path = [Node]

--Get the nodes that are cnnected to the given node
getNextNodes::Maze->Node->[Node]
getNextNodes [] nodes = []
getNextNodes maze (exits, role)=[getNode maze x| x<-exits]

--Find the start of the maze
findStart :: [[Node]]->Node
findStart list = head[node|subList<-list, node<-subList, isStart node]

--Is this node the start?
isStart :: Node->Bool
isStart (list, role) = role==Start

--Is this node the end?
isEnd::Node->Bool
isEnd (exits, role)= role==End

--Has the path reached an end?
hasEnd::Path-> Bool
hasEnd path = isEnd(last path)

--Does the list of paths have a end?
containsEnd::[Path]-> Bool
containsEnd [] = False;
containsEnd (h:t) = if(hasEnd h) then True else containsEnd t

--Get the following nodes in new path objects
possibleNext::Maze->Path->[Path]
possibleNext maze [] = []
possibleNext maze path = [path++[newNode]| newNode<-(getNextNodes maze (last path))]

--Get a set of next paths that are larger then the specified number
nextPath::Maze->[Path]->Int->[Path]
nextPath maze [] numb = []
nextPath maze paths numb = [newPaths|path<-paths, newPaths<-possibleNext maze path, length newPaths>=numb||hasEnd newPaths ]

--Only take paths that have a end
filterPaths::[Path]->[Path]
filterPaths [] = []
filterPaths paths = [enders|enders<-paths, hasEnd enders]

--Finds possible paths, quit if one path reached a end.
findPaths::Maze->[Path]->Int->[Path]
findPaths maze [] numb = []
findPaths maze paths numb = if containsEnd paths then filterPaths paths else findPaths maze (nextPath maze paths (numb)) (numb+1)

--Solve a maze!
solveMaze::Maze->Path
solveMaze [] = []
solveMaze maze = last (findPaths maze [[findStart maze]] 2)
