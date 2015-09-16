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
-- colorMatching ["Rood", "Blauw", "Frietvet"]

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

-- Paint the states

putColors :: [String] -> [[ ([Char], String) ]]
putColors [] = []
-- Use the fact that we have specified states
-- Get a list of all possible combinations
putColors colors = [ [ ("Alabama", alabama) , ("Mississipi", mississipi) , ("Georgia", georgia), ("Tennesee", tennesee), ("Florida", florida) ] |
    alabama<- colors, mississipi <- colors, georgia <- colors, tennesee <-colors, florida <- colors,
    mississipi /= tennesee, mississipi /= alabama,
    alabama /=tennesee, alabama /= georgia, alabama /= florida,
   georgia /= florida, georgia /= tennesee]
