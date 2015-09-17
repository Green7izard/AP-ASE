module Day2 where
-- Sort Lists
-- Need the sort function
-- https://hackage.haskell.org/package/base-4.8.1.0/docs/Data-List.html
import Data.List
import Data.Char

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
-- http://stackoverflow.com/questions/2468410/convert-string-to-integer-float-in-haskell

toNumber :: String -> Float
toNumber [] = 0
toNumber text = read text ::Float

-- Lazy list with paramter X with every third number, starts with X. 
lazy3 :: Integer -> [Integer]
lazy3 x = [x, (x+3) ..]
-- Lazy list with paramter Y with every 5th number, starts with y
lazy5 :: Integer -> [Integer]
lazy5 y = [y, y+5 ..]
-- Lazy list where every 8th number = x+y
-- http://hackage.haskell.org/package/base-4.8.1.0/docs/Prelude.html#v:zipWith
lazy8 :: Integer -> Integer -> [Integer]
lazy8 x y = zipWith(+) (lazy3 x) (lazy5 y)


-- Use a partially applied function to define a function that will return half of a number and another that will append \n to the end of any string.
-- https://wiki.haskell.org/Partial_application
half = (/2)
ln = (++"\n")

-- Write a function to determine the greatest common denominator of two integers.
greatestDenominator :: Integer -> Integer -> Integer
greatestDenominator 0 y = 0
greatestDenominator x 0 = 0
greatestDenominator 1 y = 1
greatestDenominator x 1 = 1
-- http://zvon.org/other/haskell/Outputprelude/mod_f.html
greatestDenominator x y = if x>y
                           then maximum [ z | z<-[1 .. y], (mod x z) ==0, (mod y z) ==0]
                            else greatestDenominator y x

-- Create a lazy sequence of prime numbers.

primes :: [Integer]
primes = [value| value<-[1..], ((value ==2) || (not (even value))), (highestDenominator value)==1]

highestDenominator :: Integer -> Integer
highestDenominator 0 = 0
highestDenominator 1 = 1
highestDenominator number = maximum[greatestDenominator z number | z <-[1..number-1]]

-- Break a long string into individual lines at proper word boundaries + Line Numbers + Text Margins
-- Kan geen punt vinden om te beginnen zonder muteerbare variabelen
