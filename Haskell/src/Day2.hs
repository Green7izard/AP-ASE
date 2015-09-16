module Day2 where
-- Sort Lists
-- Need the sort function
-- https://hackage.haskell.org/package/base-4.8.1.0/docs/Data-List.html
import Data.List

easySort :: Ord a =>[a] -> [a]
easySort list = sort list


-- Sort Lists using function as parameter

 -- In the following signature, we are setting the "constraint"
 -- that all values of "a" must be of an "orderable" type. This
 -- is because we are using a comprator.
sortList :: Ord a => [a] -> (a -> a -> Ordering) -> [a]
sortList list condition = sortBy condition list

-- Sort by placing Evens first
evenCompare :: Integer -> Integer -> Ordering
evenCompare a b = if even a && not (even b)
                then LT
                 else if not (even a) && even b
                  then GT
                   else (compare a b)

evenSort :: [Integer]-> [Integer]
evenSort [] = []
evenSort list = sortList list evenCompare

-- Convert String to Number

toString :: String -> Integer
toString "" = 0

-- Lazy list with paramter X where every third number starts with X. 
-- Lazy list with paramter Y where every 5th number starts with y
-- Lazy list where every 8th number = x+y


-- Use a partially applied function to de?ne a function that will return half of a number and another that will append \n to the end of any string.

-- Write a function to determine the greatest common denominator of two integers.

-- Create a lazy sequence of prime numbers.

-- Break a long string into individual lines at proper word boundaries + Line Numbers + Text Margins

