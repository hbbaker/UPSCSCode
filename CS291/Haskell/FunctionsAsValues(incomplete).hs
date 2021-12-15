--These functions takes a function as an input and 
--and arg to pass into that function 
silly fn arg = fn arg 
silly' fn arg = "The result is " ++ (show(fn arg))

--In case fn doesn't like negative values, we will always take 
--the absolute value of the arg before we apply fn
applyToPos fn arg = fn (abs arg)
safeApply fn arg 
  |arg < 0 = error "Can't apply function to negative values"
  |otherwise = fn arg 

--Picks and applies the right function for the input
pickAndApply fn1 fn2 arg 
  | arg < 0 = fn1 arg
  | otherwise = fn2 arg 

--Returns the max of 2 inputs to a fn 
maxOutput fn arg1 arg2 = max (fn arg1) (fn arg2)

--Applies the fn to an output of the same fn and an arg
twice fn arg = fn (fn arg)

--Recursive to square all elements of a list
square n = n^2 

squareAll [] = []
squareAll (n:ns) = (square n) : squareAll ns 

--Using functions lets us abstract away the specifics 
--and build a function that can do anything to each item in the list 
--We've encoded a computational pattern! 
--Map already exists in Haskell 
map' _ [] = []
map' fn (x:xs) = (fn x) : map' fn xs  

--Another computational pattern: define examples and then abstract
keepEvens [] = [] 
keepEvens (n:ns)
  | even n = n : keepEvens ns 
  | otherwise = keepEvens ns 

--
keepShortStrings [] = [] 
keepShortStrings (s:ss) 
  | length s < 3 = s : keepShortStrings ss 
  | otherwise = keepShortStrings ss 

--Abstracted version
--Filter already exists in Haskell 
filter' _ [] = [] 
filter' p (x:xs)
  | p x = x : filter' p xs 
  | otherwise = filter' p xs 

--Another pattern: define examples and then abstract
largest [] = error "Need at least one item in the list"
largest [n] = n
largest (n:ns) = max n (largest ns) 

smallest [] = error "Need at least one item in the list"
smallest [n] = n 
smallest (n:ns) = min n (smallest ns)

--Only difference between those two is max vs min 
--Function that takes two values form the list and picks a "winner"
--Haskells built in name for this function is: Foldr1 (fold operation from --right to left, base case is a 1 item list)
reduce _ [] = error "Need at least one item in the list"
reduce _ [x] = x 
reduce fn (x:xs) = fn x (reduce fn xs) 
