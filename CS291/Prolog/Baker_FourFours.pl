%----------------------------------------------
% Four Fours Problem in Prolog
% - The Four Fours problem deals with rearranging operations and parens between four 4's 
% - to come up with as many numbers as possible. This program is able to generate all possible
% - expressions that will evaluate to an input FLOAT, as well as being able to take an input
% - FLOAT and generate all solutions from 0.0 to the input. 
% ---------------------------------------------
% -- Written by Henry Baker 
% -- Date: 12/8/2021
% -- CSCI 291 Programming Paradigms 
% -- Prof. Brad Richards
%----------------------------------------------

% Operation Facts: 
% Contains each operation to be used in the expression tree. 
op(+). 
op(-). 
op(*). 
op(/). 

% Determines if an expression is safe to evaluate, i.e. contains no divide by zero.
% (Helper fact for Tree) 
% -- The first fact will be true if the op is not /.  
% -- The Second fact will evaluate the tree and return false only if op = / and Tree 
% 		evaluates to 0. 
% Op - Operation to be checked against expression. 
% Tree - The expression tree to be evaluated.  
safe(Op, _) :- (Op \== /).

safe(Op,Tree) :- 
    (Op == /),
    Val is Tree, 
    (Val \== 0). 

% Tree Facts:
% -----------
% Generates the 5 different expression tree structures.
% Also returns if an input expression tree is of valid structure. 
% T - The expression tree being generated. 

% Even Tree
% Generates an expression tree that is even in nature. 
% EX: (4 op 4) op (4 op 4)
tree(T) :- 
    op(X), 
    op(Y), 
    op(Z), 
    Right =.. [X,4,4], 
    Left =.. [Y,4,4], 
    T =.. [Z,Left,Right],
    safe(Z,Right).

% All Left Tree
% Generates an expression tree that is all left in nature. 
% EX: ((4 op 4) op 4) op 4
tree(T) :- 
    op(X), 
    op(Y), 
    op(Z),
    LeftMost =.. [X,4,4], 
    Left =.. [Y,LeftMost,4], 
    T =.. [Z,Left,4]. 

% All Right Tree
% Generates an expression tree that is all right in nature. 
% EX: 4 op (4 op (4 op 4))
tree(T) :- 
    op(X), 
    op(Y), 
    op(Z),
    RightMost =.. [X,4,4], 
    Right =.. [Y,4,RightMost], 
    T =.. [Z,4,Right],
    safe(Y,RightMost), 
    safe(Z,Right). 

% Left Right Zigzag 
% Generates an expression tree that is left right zigzag in nature. 
% EX: (4 op (4 op 4)) op 4
tree(T) :- 
    op(X), 
    op(Y), 
    op(Z),
    BottomRight =.. [X,4,4], 
    Left =.. [Y,4,BottomRight],
    T =.. [Z,Left,4],
    safe(Y,BottomRight). 

% Right Left Zigzag
% Generates an expression tree that is right left zigzag in nature. 
% EX: 4 op ((4 op 4) op 4)
tree(T) :- 
    op(X), 
    op(Y), 
    op(Z),
    BottomLeft =.. [X,4,4], 
    Right =.. [Y,BottomLeft,4],
    T =.. [Z,4,Right],
    safe(Z,Right).

% Expr generates all possible expression trees for an input value, 
% or generates the value of an input expression tree. 
% E - The expression tree.  
% Val - The evaluated value of E. 
expr(E, Val) :- 
    tree(E), V is float(E), Val = V. 

% PrintExpr (Helper fact for solve) prints the following output: 
% 	-- "I found (Sols) solutions for (Num), one of which is: (Expression)"
% 	-- Where Expression is the first generated expression for value Num.
% Sols - The number of possible solutions for Num.  
% Num - The number being evaluated for solutions.
% -----------
% Base Case: 
printExpr(0,Num) :- 
    write('I found 0 solutions for '), 
    write(Num), 
    write('.'), 
    nl.

% Recursive Case: 
printExpr(Sols,Num) :-
    Sols \== 0,
    write('I found '),
    write(Sols), 
    write(' solutions for '),
    write(Num), 
    write(', one of which is: '), 
    expr(E, Num),!, 
    write(E),
    nl. 

% Solve takes an input Bound and returns PrintExpr's output for all numbers from 0 --> Bound. 
% Bound - The number to be evaluated to. 
% -----------
% Base Case: 
solve(0.0) :- 
    aggregate_all(count, expr(_,0.0), Count),
    printExpr(Count, 0.0). 

% Recursive Case: 
solve(Bound) :- 
    Bound >= 0,
    X is Bound - 1.0, 
    solve(X),
    aggregate_all(count, expr(_,Bound), Count),
    printExpr(Count, Bound).










