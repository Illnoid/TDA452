import Data.Maybe

newtype Sudoku = Sudoku {rows :: [[Maybe Int]]}
    deriving (Show, Eq)

-- A1

-- | Returns a blank 9x9 sudoku grid
allBlankSudoku :: Sudoku
allBlankSudoku = 
    Sudoku replicate 9 (replicate 9 Nothing)

-- A2

-- | Tests if a sudoku confirms to the 9x9 dimensions
isSudoku :: Sudoku -> Bool
isSudoku sudoku = 
    and [length x == 9 | x <- rows sudoku] && length (rows sudoku) == 9

example :: Sudoku
example =
    Sudoku
    [ [Just 3, Just 6, Nothing,Nothing,Just 7, Just 1, Just 2, Nothing,Nothing]
    , [Nothing,Just 5, Nothing,Nothing,Nothing,Nothing,Just 1, Just 8, Nothing]
    , [Nothing,Nothing,Just 9, Just 2, Nothing,Just 4, Just 7, Nothing,Nothing]
    , [Nothing,Nothing,Nothing,Nothing,Just 1, Just 3, Nothing,Just 2, Just 8]
    , [Just 4, Nothing,Nothing,Just 5, Nothing,Just 2, Nothing,Nothing,Just 9]
    , [Just 2, Just 7, Nothing,Just 4, Just 6, Nothing,Nothing,Nothing,Nothing]
    , [Nothing,Nothing,Just 5, Just 3, Nothing,Just 8, Just 9, Nothing,Nothing]
    , [Nothing,Just 8, Just 3, Nothing,Nothing,Nothing,Nothing,Just 6, Nothing]
    , [Nothing,Nothing,Just 7, Just 6, Just 9, Nothing,Nothing,Just 4, Just 3]
    ]    

-- A3
isEmpty :: Sudoku -> Bool
isEmpty sudoku = 
    and [and [isNothing x | x <- row] | row <- rows sudoku]

isFilled :: Sudoku -> Bool
isFilled sudoku = 
    and [and [isJust x | x <- row] | row <- rows sudoku]