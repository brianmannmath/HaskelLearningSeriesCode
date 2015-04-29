module Main where

import Data.Char
import Data.List
import Control.Exception (catch, SomeException)

main :: IO()
main = do
    putStrLn "Text file:"
    filename <- getLine
    contents <- catch (readFile filename) $ \err -> print (err::SomeException) >> (readFile "CommonWords.hs")
    putStrLn "Top x? words:"
    top <- getLine
    let n = read top :: Int
    putStrLn "Most common words are:"
    putStrLn $ commonWords n contents

{-
Given a list of words, and an integer n, return a list of the n most common words in the list. Also return the number of times each word appears. 
-}

type Text = [Char]
type Word = [Char]

commonWords :: Int -> Text -> String
commonWords n = prettyPrint . take n . reverse . sort . countRuns . mapper. sort . words . map toLower
    where prettyPrint = concat . format

mapper :: [Word] -> [(Int,Word)]
mapper xs = map (\x -> (1,x)) xs

countRuns :: [(Int,Word)] -> [(Int,Word)]
countRuns [] = []
countRuns [x] = [x]
countRuns (x:xs)
    | (snd x) == (snd $ head xs) = countRuns $ ( (fst x) + (fst $ head xs), snd x ):(tail xs)
    | otherwise = x:(countRuns xs)

format :: [(Int,Word)] -> [String]
format xs = map (\(x,y) -> y ++ ['\t'] ++ (show x) ++ ['\n']) xs






