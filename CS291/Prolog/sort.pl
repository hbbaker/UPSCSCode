
sameItems([],_).
sameItems([X|Xs],Ys) :- member(X,Ys), sameItems(Xs,Ys).

%bradsort(List,Sorted) :- sameItems(List,Sorted), ordered(Sorted).

ordered([]).
ordered([X]).
ordered([X,Y|Ys]) :- X =< Y, ordered([Y|Ys]).

permutation([X|Xs], Zs) :- select(X,Zs,Smaller), permutation(Xs,Smaller).
permutation([],[]).

bradsort(List,Sorted) :- permutation(Sorted,List), ordered(Sorted).
