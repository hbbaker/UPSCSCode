--1
mostFrequent lst = head winningList
  where 
    groups = map (\item -> filter (==item) lst) lst
    winningList = foldr1 (\l1 l2 -> if length l1 >= length l2 then l1 else l2) groups
 
--2.1
findRoot delta epsilon fn x 
  | abs(fn x) < epsilon = x 
  | otherwise = findRoot delta epsilon fn betterX
    where 
      betterX = x - ((fn x)*delta)/((fn x)-(fn (x - delta)))

--2.2
simpleFindRoot fn x = shortFind fn x
  where shortFind = (findRoot 0.001 0.00001) 

--(\x -> (x^3) - (3*(x^2)) + x + 5)




