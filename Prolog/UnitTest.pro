%Unit Test for Prolog
%By Bas van Summeren<Bas van Summeren@hotmail.com>

%http://stackoverflow.com/questions/4097451/how-do-i-include-a-pl-file-in-prolog
%http://www.swi-prolog.org/pldoc/doc_for?object=section('packages/plunit.html')
:- consult('Day2.pro').
:- begin_tests(lists).

test(reverse) :-reverseList([a,b], [b,a]).
test(small) :- smallestElement([3,2,1,6565,3], 1).
test(sort) :- sortList([2,3,1], [1,2,3]).

:- end_tests(lists).
