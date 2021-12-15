-- Let and Where 
circleArea r = upsPi * r * r 
  where 
    upsPi = 3.1415926

--Generates a list of all evens from 0 to n 
evens n = result 
  where 
    candidates = [0..n]
    result = [ num | num <- candidates, even num]

evens' n = 
  let
    candidates = [0..n]
    result = [ num | num <- candidates, even num]
  in result

--QuickSort 
qsort [] = []
qsort (pivot:rest) = qsort smalls ++ [pivot] ++ qsort bigs 
  where 
    smalls = [ n | n <- rest, n <= pivot ]
    bigs = [ n | n <- rest, n >= pivot ] 