:- ['../prolog/clpq'].

:- begin_tests(derive_accessors_directive).

:- begin_tests(arithmetic_equality).

test(sum) :-
    1+2+3+4 :=: 10,
    1/1+2/2+3/3+4/4 :=: 4,
    1/2+2/2+3/2+4/2 :=: 5,
    1+2/2+3+4/2 :=: 7.

test(subtraction) :-
    1-2-3-4 :=: -8,
    1/1-2/2-3/3-4/4 :=: -2,
    1/2-2/2-3/2-4/2 :=: -4,
    1-2/2-3-4/2 :=: -5.

test(division) :-
     (1 + 2)/5 :=: 3/5,
     2/2/2/2/2 :=: 1/8.

test(multiplication) :-
     (1 + 2)*5 :=: 15,
     (1 * 2)*5 :=: 10,
     1 / 2 * 5/4 :=: 5/8,
     (1 / 2) * (5/4) :=: 5/8.

:- end_tests(arithmetic_equality).