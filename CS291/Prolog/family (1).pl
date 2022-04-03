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


coParent(P1,P2) :- parent(P1,Kid), parent(P2,Kid), P1 \= P2.

grandparent(GP,Kid) :- parent(GP,Mid), parent(Mid,Kid).

% ancestor(Old,Young) is Young is a descendant of Old
ancestor(Old,Young) :- parent(Old,Young).
ancestor(Old,Young) :- grandparent(Old,Young).
ancestor(Old,Young) :- parent(Old,Mid), grandparent(Mid,Young).

ancestorRec(Old,Young) :- parent(Old,Young).
ancestorRec(Old,Young) :- parent(Old,Mid), ancestorRec(Mid,Young).

% This version, with reordered goals, sometimes runs forever...
ancestorRec2(Old,Young) :- parent(Old,Young).
ancestorRec2(Old,Young) :- ancestorRec2(Mid,Young), parent(Old,Mid).







