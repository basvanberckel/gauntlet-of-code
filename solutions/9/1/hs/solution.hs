import System.IO
import Control.Monad
import qualified Data.Set as Set

main = do
    contents <- readFile "cases/input/1"
    print $ solve $ lines contents

readInt :: String -> Int
readInt = read

data Coord = Coord Integer Integer deriving (Show, Eq, Ord)
orig = Coord 0 0
move "U" (Coord x y) = Coord x (y+1)
move "D" (Coord x y) = Coord x (y-1)
move "L" (Coord x y) = Coord (x-1) y
move "R" (Coord x y) = Coord (x+1) y

solve xs = do_solve xs orig orig (Set.singleton orig)

do_solve [] _ _ seen = Set.size seen
do_solve (x:xs) h t seen = do_solve xs h' t' seen'
    where (h', t', seen') = steps x h t seen

steps (d:' ':n) h t seen = do_steps [d] (read n) h t seen

do_steps d 0 h t seen = (h, t, seen)
do_steps d n h t seen = do_steps d (n-1) h' t' seen'
    where (h', t', seen') = do_step d h t seen

do_step d h t seen = let
        h' = move d h
        t' = if adjacent t h' then t else follow t h'
        seen' = Set.insert t' seen
    in (h', t', seen')

adjacent (Coord ax ay) (Coord bx by) = (abs $ ax - bx) <= 1 && (abs $ ay - by) <= 1

follow (Coord tx ty) (Coord hx hy) = let 
        tx' = tx + (signum $ hx - tx)
        ty' = ty + (signum $ hy - ty)
    in Coord tx' ty'