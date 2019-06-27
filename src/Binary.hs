module Binary (
    stringsOfLength,
    buildIsolationMask,
) where

stringsOfLength :: Int -> [[Bool]]
stringsOfLength n = results !! n
    where
        results = iterate helper [[]]
        helper accumulator = [x:xs | x <- [False, True],
                                     xs <- accumulator]

buildIsolationMask :: Eq a => a -> [a] -> [Bool]
buildIsolationMask target items = map (==target) items