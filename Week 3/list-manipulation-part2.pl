separate_list([], [], []).

% recursive case 1: the head (H) is an integer.
separate_list([H|T], Atoms, [H|Integers]) :-
    integer(H),
    separate_list(T, Atoms, Integers).

% recursive case 2: the head (H) is an atom.
separate_list([H|T], [H|Atoms], Integers) :-
    atom(H),
    separate_list(T, Atoms, Integers).