% Problem 1: write_list(List) - Writes elements on separate lines.
write_list([]).
write_list([H|T]) :-
    write(H),
    nl,
    write_list(T).