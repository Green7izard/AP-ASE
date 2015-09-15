module Main where

-- https://wiki.haskell.org/Introduction_to_Haskell_IO/Actions

import Day1

main :: IO ()
main = do
    line <- getLine
    putStr line
