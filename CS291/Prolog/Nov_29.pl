% setMember(Item, Set, Set') is true if Set' is Set + Item 
setMember(Item, Set, Set) :- member(Item,Set).
setMember(Item, Set, [Item|Set]) :- \+ member(Item,Set).

edge(a,b).
edge(a,c).
edge(b,d).
edge(c,e).
edge(d,e).

con(X,Y) :- edge(X,Y).
con(X,Y) :- edge(X,Z), write(X), write('-->'), write(Z), nl, con(Z,Y).

len(X,Y) :- write('finding length of '), write(X), nl, fail.
len([],0).
len([_|Xs],N) :- len(Xs,N1), plus(N1,1,N).

printEdges() :- edge(A,B), write(A),write('-->'),write(B),nl, fail.
printEdges(). % So it eventually succeeds instead of failing
