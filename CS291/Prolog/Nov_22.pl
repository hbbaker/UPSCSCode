% It's well past time to write a sorting algorithm!

bradsort(List,Sorted) :-
  sameItems(Sorted,List),
  ordered(Sorted).

% Define what it means for a list to be ordered

ordered([]).
ordered([_]).
ordered([X,Y|Ys]) :- X =< Y, ordered([Y|Ys]).

% The two lists also have to have the same contents, including the
% same number of duplicates, etc.

sameItems([],[]).
sameItems([X|Xs],Ys) :- select(X,Ys,Zs), sameItems(Xs,Zs).


% We could do quicksort too, if we wanted to be more specific about
% how to find solutions.

quicksort([],[]).
quicksort([X|Xs],Sorted) :-
  partition(Xs,X,Smalls,Bigs),
  quicksort(Smalls,SS),
  quicksort(Bigs,SB),
  append(SS,[X|SB],Sorted).

partition([],_,[],[]).
partition([X|Xs],P,[X|Smalls],Bigs) :- X =< P, partition(Xs,P,Smalls,Bigs).
partition([X|Xs],P,Smalls,[X|Bigs]) :- X > P, partition(Xs,P,Smalls,Bigs).

edge(a,b).
edge(a,c).
edge(b,d).
