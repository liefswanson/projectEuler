import System.Environment

main :: IO() 
main = do
     filePath:args <- getArgs
     unparsed <- readFile filePath
     let parsed = lines unparsed
     let integers = map read parsed :: [Integer]
     let output = show $ sum integers
     putStrLn $ take ( digits args output) output

digits :: [String] -> String -> Int
digits [] number = length number
digits (x:_) _ = read $ x :: Int

