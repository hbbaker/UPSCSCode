module Main where
import Data.List

trivialDict = ["ally", "beta", "cool", "deal", "else", "flew", "good", "hope", "ibex"]

mediumDict = ["abbe", "abed", "abet", "able", "abye", "aced", "aces", "ache", "acme", "acne", "acre", "adze", "aeon", "aero", "aery", "aged", "agee", "ager", "ages", "ague", "ahem", "aide", "ajee", "akee", "alae", "alec", "alee", "alef", "ales", "alme", "aloe", "amen", "amie", "anes", "anew", "ante", "aped", "aper", "apes", "apex", "apse", "area", "ares", "arse", "asea", "ates", "aver", "aves", "awed", "awee", "awes", "axed", "axel", "axes", "axle", "ayes", "babe", "bade", "bake", "bale", "bane", "bare", "base", "bate", "bead", "beak", "beam", "bean", "bear", "beat", "beau", "bema", "beta", "blae", "brae", "cade", "cafe", "cage", "cake", "came", "cane", "cape", "care", "case", "cate", "cave", "ceca", "dace", "dale", "dame", "dare", "date", "daze", "dead", "deaf", "deal", "dean", "dear", "deva", "each", "earl", "earn", "ears", "ease", "east", "easy", "eath", "eats", "eaux", "eave", "egad", "egal", "elan", "epha", "eras", "etas", "etna", "exam", "eyas", "eyra", "face", "fade", "fake", "fame", "fane", "fare", "fate", "faze", "feal", "fear", "feat", "feta", "flea", "frae", "gaed", "gaen", "gaes", "gage", "gale", "game", "gane", "gape", "gate", "gave", "gaze", "gear", "geta", "hade", "haed", "haem", "haen", "haes", "haet", "hake", "hale", "hame", "hare", "hate", "have", "haze", "head", "heal", "heap", "hear", "heat", "idea", "ilea", "jade", "jake", "jane", "jape", "jean", "kaes", "kale", "kame", "kane", "keas", "lace", "lade", "lake", "lame", "lane", "lase", "late", "lave", "laze", "lead", "leaf", "leak", "leal", "lean", "leap", "lear", "leas", "leva", "mabe", "mace", "made", "maes", "mage", "make", "male", "mane", "mare", "mate", "maze", "mead", "meal", "mean", "meat", "mesa", "meta", "nabe", "name", "nape", "nave", "neap", "near", "neat", "nema", "odea", "olea", "pace", "page", "pale", "pane", "pare", "pase", "pate", "pave", "peag", "peak", "peal", "pean", "pear", "peas", "peat", "plea", "race", "rage", "rake", "rale", "rare", "rase", "rate", "rave", "raze", "read", "real", "ream", "reap", "rear", "rhea", "sabe", "sade", "safe", "sage", "sake", "sale", "same", "sane", "sate", "save", "seal", "seam", "sear", "seas", "seat", "sera", "seta", "shea", "spae", "tace", "tael", "take", "tale", "tame", "tape", "tare", "tate", "teak", "teal", "team", "tear", "teas", "teat", "tela", "tepa", "thae", "toea", "twae", "urea", "uvea", "vale", "vane", "vase", "veal", "vela", "vena", "vera", "wade", "waes", "wage", "wake", "wale", "wame", "wane", "ware", "wave", "weak", "weal", "wean", "wear", "weka", "yare", "yeah", "yean", "year", "yeas", "zeal", "zeta", "zoea"]

main :: IO ()
main = 
  do
    -- Prompt user for inputs 
    putStrLn "Word Length?"
    x <- getLine
    let wLength = (read x) :: Int  
    putStrLn "Number of guesses?"
    y <- getLine 
    let numGuesses = (read y) :: Int 

    --Create the new word set based on 
    let wList = newDictionary (\x -> length x == wLength) mediumDict
    --putStrLn ("Dictionary we are using is: " ++ show wList)
    let startPat = concat (replicate wLength "-")
    --putStrLn (show startPat) 
    let startingGuess = ""
    gameFunc numGuesses wList startingGuess startPat 
    
-- Main Game Function 
gameFunc numG dict guesses pattern =  
  -- Base Cases
  if (('-' `elem` pattern) == False) then (putStrLn ("You won! The word was " ++ pattern)) else
  if (numG == 0) then (putStrLn "You ran out of guesses. Try again!") else
  -- Main Game Loop 
    do 
      -- Print interactive messages
      putStrLn ("You have " ++ (show numG) ++ " guesses left.")
      putStrLn ("You have guessed: " ++ (show guesses))
      putStrLn ("Word: " ++ pattern)
      putStrLn "Guess a letter: "
      --Get input 
      g <- getChar 
      putStrLn ""
      -- Add to list of guessed letters 
      let allGuesses = [g] ++ guesses
      -- Generate Patterns 
      let patterns = mapPattern dict allGuesses
      -- Print the patterns and their matches  
      printMapped patterns dict allGuesses
      -- Generate touples of the patterns and their associated words 
      -- so we can determine the winner
      let allFams = ((map (\pat -> wordsForPattern pat dict allGuesses)) patterns)
      let pairs = zip patterns allFams -- Should return [(pattern,length of fam),...]
      -- Find which is longest
      let winner = foldr1 (\x y -> if (length (snd x)) > (length(snd y)) then x else y) pairs 
      -- Pull pattern out of winning touple 
      let winPat = fst winner 
      let nextPattern = nextPat pattern winPat
      -- Output for the winning pattern and how many words it matched
      putStrLn ("Winner: " ++ (show winPat) ++ " which matches " ++ (show (length (snd winner))) ++ ".")
      -- Print output for correct / incorrect
      if g `elem` winPat then (putStrLn "Correct Guess!") else (putStrLn "Incorrect!")
      putStrLn ""
      -- If guess is in pattern, then recurse and keep numG and change guesses and make dict the winning list
      -- otherwise we will decrement numG and make the dict the winning patterns list of words again. 
      if g `elem` winPat then (gameFunc numG dict allGuesses nextPattern) else (gameFunc (numG - 1) (snd winner) allGuesses winPat)

--------------------------
-- Helper Functions 
--------------------------
-- Makes a new list dictionary based on input parameter
-- (mostly a helper to abstract detail from main)
newDictionary fn lst = filter fn lst

-- Makes the patterns from the guessed ltrs and word 
makePattern ltrs "" = ""
makePattern ltrs (x:xs)  
  | x `elem` ltrs = (x : makePattern ltrs xs)
  | otherwise = ('-' : makePattern ltrs xs)

-- Maps the pattern across a list of words 
mapPattern [] ltrs  = []
mapPattern lst ltrs =  nub (map (makePattern ltrs) lst)

-- Pulls the letters out of the pattern to help 
-- make the wordsForPattern easier
nubP pattern = filter (/='-') pattern

-- Creates a list of words for a unique pattern
-- from the pattern and dictionary
wordsForPattern pattern dict ltrs = filter (\c -> pattern == (makePattern ltrs c)) dict

-- Prints all of the patterns with the words that fit it 
printMapped patLst dict ltrs = 
  mapM_ putStrLn (map (\pat -> pat ++ " matches " ++ (show (wordsForPattern pat dict ltrs))) patLst)

-- Takes 2 patterns and combines them into one 
nextPat [] [] = []
nextPat (x:xs) (y:ys) 
  | x /= '-' = x : nextPat xs ys  
  | y /= '-' = y : nextPat xs ys 
  | otherwise = '-' : nextPat xs ys 
--------------------------  

    
