import System.Environment

main :: IO() 
main = do
     filePath:digits:[] <- getArgs
     unparsed <- readFile filePath
     let parsed = lines unparsed
     let integers = map read parsed :: [Integer]
     let output = show $ sum integers
     putStrLn $ take (read digits) output
