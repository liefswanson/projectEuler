module Sets (
    powerset
) where

import Control.Monad

powerset :: [a] -> [[a]]
powerset set = filterM (const [True, False]) set