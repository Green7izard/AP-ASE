module Day3 where

--Hash Map
type KeyValue = (String, String)
type Hash = [KeyValue]

storeValue :: Hash->String->String->Hash
storeValue map key value = storePair map (key, value)

storePair :: Hash->KeyValue->Hash
storePair map pair = map ++[pair]

searchKey:: String -> Hash-> Maybe String
searchKey key [] = Nothing
searchKey [] map = Nothing
searchKey key ((k, value):rest) =
  if key == k  then Just value
   else searchKey key rest

exampleMap = [("Test",  "Value"), ("TheAnswer",  "42")]

