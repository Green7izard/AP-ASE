
reverseList([], []).
reverseList([X], [X]).
reverseList([Head|Tail], Y) :- reverseList(Tail, Z), append(Z, [Head], Y).

smallestElement([A], A).
smallestElement([Head|Tail], Z) :- smallestElement(Tail, X), Z=X, X<Head.
smallestElement([Head|Tail], Z) :- smallestElement(Tail, X), Z=Head, X>=Head.

inOrder([]).
inOrder([_]).
inOrder([First, Second| Tail]) :-  Second >= First, inOrder([Second|Tail]).

% http://stackoverflow.com/questions/4578755/permuted-combinations-of-the-elements-of-a-list-prolog
% http://stackoverflow.com/questions/15065663/exclamation-mark-in-prolog
sortList(X,Y):-permutation(X,Y),inOrder(Y).
