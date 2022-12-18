import System.IO
import Control.Monad

main = do
    contents <- readFile "cases/input/1"
    print $ solve $ map readInt $ lines contents

readInt :: String -> Int
readInt = read

solve (x:[]) = 0
solve (x:y:zs) = solve (y:zs) + (cmp x y)

cmp x y = fromEnum $ x < y