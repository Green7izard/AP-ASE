module Day1 where

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

reverseList :: [a] -> [a]
reverseList [] = []
-- https://wiki.haskell.org/How_to_work_on_lists#Adding
reverseList(head:tail) = reverseList(tail) ++ [head]

colorMatching :: [String] -> [(String, String)]
--                                                      Compare list position
colorMatching colors = [(a, b) | a <-colors, b<-colors, a < b]

--• Write a list comprehension to build a childhood multiplication
--table. The table would be a list of three-tuples where the first two
--are integers from 1–12 and the third is the product of the first two.
--• Solve the map-coloring problem (Section 4.2, Map Coloring, on
--page 101) using Haskell.
