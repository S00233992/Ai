:- dynamic square/3.

% board stuff from slides
createBoard(N) :-
    createBoard(N,N).

createBoard(0,_).
createBoard(Row,Col) :-
    createCol(Row,Col),
    NextRow is Row - 1,
    createBoard(NextRow,Col).

createCol(_,0).
createCol(CurrentRow,CurrentCol) :-
    assertz(square(CurrentRow,CurrentCol,e)),
    NextCol is CurrentCol - 1,
    createCol(CurrentRow,NextCol).

place(Piece,N) :-
    Row1 is random(N) + 1,
    Col1 is random(N) + 1,
    place(Piece,Row1,Col1).

place(Symbol,Row,Col) :-
    retract(square(Row,Col,e)),
    assertz(square(Row,Col,Symbol)).

% put player in middle
place_player_middle :-
    place(player, 2, 2).

% adjacent squares thing
adjacent_to_player(Row, Col, Value) :-
    square(PlayerRow, PlayerCol, player),
    adjacent(PlayerRow, PlayerCol, Row, Col),
    square(Row, Col, Value).

adjacent(Row, Col, AdjRow, Col) :-
    AdjRow is Row - 1.
adjacent(Row, Col, AdjRow, Col) :-
    AdjRow is Row + 1.
adjacent(Row, Col, Row, AdjCol) :-
    AdjCol is Col - 1.
adjacent(Row, Col, Row, AdjCol) :-
    AdjCol is Col + 1.

get_adjacent_squares(Adjacents) :-
    findall([Row,Col,Value], adjacent_to_player(Row,Col,Value), Adjacents).

% moving the player
move(north) :-
    square(Row, Col, player),
    NewRow is Row - 1,
    retract(square(Row, Col, player)),
    retract(square(NewRow, Col, e)),
    assertz(square(Row, Col, e)),
    assertz(square(NewRow, Col, player)).

move(south) :-
    square(Row, Col, player),
    NewRow is Row + 1,
    retract(square(Row, Col, player)),
    retract(square(NewRow, Col, e)),
    assertz(square(Row, Col, e)),
    assertz(square(NewRow, Col, player)).

move(east) :-
    square(Row, Col, player),
    NewCol is Col + 1,
    retract(square(Row, Col, player)),
    retract(square(Row, NewCol, e)),
    assertz(square(Row, Col, e)),
    assertz(square(Row, NewCol, player)).

move(west) :-
    square(Row, Col, player),
    NewCol is Col - 1,
    retract(square(Row, Col, player)),
    retract(square(Row, NewCol, e)),
    assertz(square(Row, Col, e)),
    assertz(square(Row, NewCol, player)).

% non empty squares
non_empty_squares(NonEmpty) :-
    findall([Row,Col,Val], (square(Row,Col,Val), Val \= e), NonEmpty).

% random placement
place_random_items([], _).
place_random_items([Item|Rest], N) :-
    place(Item, N),
    place_random_items(Rest, N).

% print board
print_board(N) :-
    print_board(1, N, N).

print_board(Row, N, _) :-
    Row > N, !.
print_board(Row, N, MaxCol) :-
    print_row(Row, 1, MaxCol),
    nl,
    NextRow is Row + 1,
    print_board(NextRow, N, MaxCol).

print_row(_, Col, MaxCol) :-
    Col > MaxCol, !.
print_row(Row, Col, MaxCol) :-
    square(Row, Col, Value),
    write(Value), write(' '),
    NextCol is Col + 1,
    print_row(Row, NextCol, MaxCol).

% user input for movement
user_move :-
    write('enter direction (north/south/east/west) or stop game: '),
    read(Direction),
    process_direction(Direction).

process_direction(quit) :-
    write('adios'), nl, !.
process_direction(Direction) :-
    member(Direction, [north, south, east, west]),
    (move(Direction) ->
        write('move successful!'), nl,
        print_board(3),
        user_move
    ;
        write('cant move in that direction!'), nl,
        user_move
    ).
process_direction(_) :-
    write('invalid direction!'), nl,
    user_move.