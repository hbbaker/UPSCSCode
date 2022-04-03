% cons describes the relationship between a head, tail, and the
% list they came from.

cons(Head, Tail, node(Head,Tail)).


% elem(Item,List) is true if Item occurs in List. This is the same
% as the built-in member predicate.

elem(Item, [Item|_]).
elem(Item, [_|Tail]) :- elem(Item,Tail).

% len(List,Len) is true if Len is the length of List

len([],0).
% len([_|Xs],L) :- len(Xs,TailLen), plus(TailLen,1,L).
len([_|Xs],L) :- len(Xs,TailLen), L is TailLen + 1.

prefix([],_). 
prefix([X|Xs],[X|Ys]) :- prefix(Xs,Ys).

sum([],0).
sum([N|Ns],Sum) :- sum(Ns,NsSum), plus(NsSum,N,Sum).

prefixSum(Pre,Sum,List) :- prefix(Pre,List), sum(Pre,Sum).




