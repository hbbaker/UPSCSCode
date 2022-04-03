%
% Start with some facts drawn from my family tree
%

father(david, holly).
father(david, heather).
father(durkee, brad).
father(durkee, trevor).
father(leverett, durkee).
father(leverett, elmo).
father(brad, charlie).
father(brad, flora).
father(reuben, virginia).
father(reuben, dorothy).

mother(nancy, holly).
mother(nancy, heather).
mother(mary, brad).
mother(mary, trevor).
mother(holly, charlie).
mother(holly, flora).
mother(virginia, durkee).
mother(virginia, elmo).

male(david).
male(durkee).
male(leverett).
male(brad).
male(charlie).
male(trevor).
male(elmo).
male(reuben).

female(nancy).
female(mary).
female(virginia).
female(dorothy).
female(holly).
female(flora).
female(heather).


% The daughter relation holds if D is the daughter of Parent
daughter(D,Parent) :- female(D), father(Parent,D).
daughter(D,Parent) :- female(D), mother(Parent,D).

parent(P,Kid) :- mother(P,Kid).
parent(P,Kid) :- father(P,Kid).

grandmother(Grannie,Person) :- 
  female(Grannie), parent(Grannie,Mid), parent(Mid,Person).

brother(Bro,Person) :- 
  parent(Parent,Bro), parent(Parent,Person), male(Bro), Bro \= Person.



