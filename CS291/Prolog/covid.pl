% This is a simple way to "read in" all of the subject/pool pairings. We could
% read these from a file, but we don't have time to cover Prolog file I/O. 
% Instead, just do pairings(Ps) to bind Ps to this list of pairs.

pairings([in(0, a), in(2, a), in(3, a), in(7, a), in(4, b), in(5, b), in(6, b), 
  in(1, b), in(0, c), in(3, c), in(4, c), in(1, c), in(5, d), in(6, d), in(7, d), 
  in(2, d), in(0, e), in(4, e), in(5, e), in(2, e), in(6, f), in(7, f), in(1, f), 
  in(3, f)]).
    
% This predicate succeeds if a subject, ID, is Covid negative given the pool
% assignments in Pairs, and the list of positive pools, Pos. It's assumed that
% both Pairs and Pos are bound. A subject is negative if they're in a non-
% positive pool.

negative(ID, Pairs, Pos) :- 
    member(in(ID,Pool), Pairs),    % Find a pool containing ID,
    \+ member(Pool, Pos).		   % but that's not positive
    
% This predicate succeeds if a subject, ID, is Covid positive given the Pool
% assignments in Pairs, and the list of positive pools, Pos. It's assumed that
% both Pairs and Pos are bound.

positive(ID, Pairs, Pos) :- 
    member(in(ID,_), Pairs),       % Make sure ID is really a valid subject,
    \+ negative(ID, Pairs, Pos).   % and that ID isn't negative
    
allPositive(Subs, Pos) :- pairings(Ps), setof(S,positive(S,Ps,Pos),Subs).