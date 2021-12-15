--Recursion Practice 
countEvens [] = 0
countEvens (x:xs) = (if even x then 1 else 0) + countEvens xs

keepEvens [] = []
keepEvens (x:xs) = if even x then x:keepEvens xs else keepEvens xs

allEven [] = True  
allEven (x:xs) = if even x then allEven xs else False

allEven' [] = True 
allEven' (x:xs) = even x && allEven' xs 

removeFirstEven [] = [] 
removeFirstEven (n:ns)
  | even n = ns  
  | otherwise = n : removeFirstEven ns

largestDiff [x,y] = abs(x - y)
largestDiff (x:y:xs) = max (abs(x-y)) (largestDiff(y:xs))
