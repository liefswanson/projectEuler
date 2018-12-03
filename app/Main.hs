module Main where

import Lib
import System.Environment
import System.Exit
import Text.Read
import Data.Maybe
import Control.Exception

main :: IO ()
main = do
    args <- getArgs
    let (n, remaining) = problemNumber args
    case n of
        Just num -> delegate num remaining
        _        -> notEnoughArgs

delegate :: Int -> [String] -> IO()
delegate num args = do
    let delegated = getProblemDelegate num
    case delegated of
        Just fn -> fn args
        _       -> invalidProblemNumber num


notEnoughArgs :: IO ()
notEnoughArgs = do
    putStrLn "Please supply a question number and matching arguments"
    exitFailure

invalidProblemNumber :: Int -> IO ()
invalidProblemNumber num = do
    putStrLn $ (show num) ++ " is not a valid question"
    exitFailure

problemNumber :: [String] -> (Maybe Int, [String])
problemNumber [] = (Nothing, [])
problemNumber (num:remaining) = (readMaybe num, remaining)

getProblemDelegate :: Int -> (Maybe ([String] -> IO ()))
getProblemDelegate n = do
    let result = filter (\(x, f) -> x == n) problemMap
    case length result of
        1 -> Just $ snd $ head result
        0 -> Nothing
        _ -> error "Two or more functions in the problem map have the same key..."

problemMap :: [(Int, ([String] -> IO ()))]
problemMap =
    [
        (1, someFunc),
        (2, someFunc),
        (2, someFunc)
    ]