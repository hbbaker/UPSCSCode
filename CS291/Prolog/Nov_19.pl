prefix([],_). 
prefix([X|Xs],[X|Ys]) :- prefix(Xs,Ys).

sum([],0).
sum([N|Ns],Sum) :- sum(Ns,NsSum), plus(NsSum,N,Sum).

prefixSum(Pre,Sum,List) :- prefix(Pre,List), sum(Pre,Sum).

% suffix([],_).  % Redundant
suffix(Xs,Xs).
suffix(Suf,[_|Xs]) :- suffix(Suf,Xs).

/*
sublist([],_).

sublist(Sub,List) :- suffix(Sub,List).
sublist(Sub,List) :- prefix(Sub,List).
sublist(Sub,List) :- sublist(Sub,Suf), suffix(Suf,List).
sublist(Sub,List) :- sublist(Sub,Pre), prefix(Pre,List).
*/

% This works, and is efficient:

sublist(Sub,List) :- prefix(Sub,List).
sublist(Sub,[_|Xs]) :- sublist(Sub,Xs).


% Here's a more declarative version:

sublistDecl(Sub,List) :- prefix(Sub,Suf), suffix(Suf,List).

% Our own definition of append

%append([],Ys,Ys).
%append([X|Xs],Ys,[X|Tail]) :- append(Xs,Ys,Tail).

prefix2(Pre,List) :- append(Pre,_,List).
suffix2(Suf,List) :- append(_,Suf,List).
sublist2(Sub,List) :- append(_,Sub,Front), append(Front,_,List).
%append([X|Xs],Ys,Result) :- append(Xs,Ys,Tail), Result = [X|Tail].


% It's well past time to write a sorting algorithm!

bradsort(List,Sorted) :-
  sameItems(Sorted,List),
  ordered(Sorted).

ordered([]).
ordered([_]).
ordered([X,Y|Ys]) :- X =< Y, ordered([Y|Ys]).


sameItems([],[]).
sameItems([X|Xs],Ys) :- select(X,Ys,Zs), sameItems(Xs,Zs).



