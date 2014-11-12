import System.Environment
import Data.List

main :: IO()
main = do
  args <- getArgs
  let n = read $ head args :: Int
  let collatzSeqs = maxCollatzSequences n
  let val = maximum collatzSeqs
  let index = elemIndex val collatzSeqs
  putStrLn $ show (val,index)
      
      
maxCollatzSequences :: Int -> [Int]
maxCollatzSequences n = map length $ map genCollatz [n,n-1..1]

genCollatz :: Int -> [Int]
genCollatz 1 = [1]
genCollatz n = n : genCollatz (collatz n) 

collatz :: Int -> Int
collatz n =
  if even n
  then div n 2
  else 3*n+1

