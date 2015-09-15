module Day1 where

-- AllEven functions

allEven :: [Integer] -> [Integer]
allEven [] = []
allEven (h:t) = if even h then h:allEven t else allEven t

-- Use Guard
allEven2 :: [Integer] -> [Integer]
--        input     return      get values from    condition for adding
allEven2 numbers = [evens   |   evens<-numbers   , even evens]

-- https://wiki.haskell.org/How_to_work_on_lists#Deleting
allEven3 :: [Integer] -> [Integer]
allEven3 numbers= filter even numbers

-- Reverse

reverseList :: [a] -> [a]
reverseList [] = []
-- https://wiki.haskell.org/How_to_work_on_lists#Adding
reverseList(head:tail) = reverseList(tail) ++ [head]

-- Color Matching

colorMatching :: [String] -> [(String, String)]
--                                                      Compare list position
colorMatching colors = [(a, b) | a <-colors, b<-colors, a < b]


-- Lists multiplication

multiplyTuplet :: Integer -> Integer -> (Integer, Integer, Integer)
multiplyTuplet 0 y = (0, y, 0)
multiplyTuplet x 0 = (x, 0, 0)
multiplyTuplet x y = (x, y, x*y)

multiplyLists :: [Integer] -> [Integer] ->[(Integer, Integer, Integer)]
multiplyLists [] y = []
multiplyLists x [] = []
multiplyLists x y = [multiplyTuplet a b |a <-x , b <- y]

multiplyAuto :: [(Integer, Integer, Integer)]
multiplyAuto = multiplyLists[1..12][1..12]


putColors :: [String] -> [(String, String)]
putColors [] = []
putColors colors = [[("Alabama", colorAla),("Mississipi", colorMissi), ("Georgia", colorGeorg), ("Tennesee", colorTen), ("Florida", colorFlor)]|
    colorAla<- colors, colorMissi <- colors, colorGeorg <- colors, colorTen <-colors, colorFlor <- colors,
    colorMissi /= colorTen, colorMissi /= colorAla,
    colorAla /=colorTen, colorAla /= colorGeorg, colorAla /= colorFlor,
    colorGeorg /= colorFlor, colorGeorg /= colorTen]

-- Solve the map-coloring problem (Section 4.2, Map Coloring, on
-- page 101) using Haskell.
-- different(red, green). different(red, blue).
-- different(green, red). different(green, blue).
-- different(blue, red). different(blue, green).
-- coloring(Alabama, Mississippi, Georgia, Tennessee, Florida) :-
-- different(Mississippi, Tennessee),
-- different(Mississippi, Alabama),
-- different(Alabama, Tennessee),
-- different(Alabama, Mississippi),
-- different(Alabama, Georgia),
-- different(Alabama, Florida),
-- different(Georgia, Florida),
-- different(Georgia, Tennessee).
