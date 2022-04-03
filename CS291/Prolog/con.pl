edge(a,b).
edge(a,c).
edge(c,d).
edge(c,e).
edge(b,d).
edge(d,a).

% con(X,Y) is true if there's a path from X to Y through the graph

con(X,Y) :- edge(X,Y).
con(X,Y) :- edge(X,Mid), con(Mid,Y).
