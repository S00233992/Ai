% Test file for cars.pl
% Load this file in Prolog to test all queries

% First, make sure cars.pl is loaded
:- ['cars.pl'].

% Test queries that show ALL solutions automatically

% Test a: what cars exist
test_cars_exist :-
    write('=== Test a: What cars exist? ==='), nl,
    findall(Type, car(Type), AllCars),
    write('All cars (with duplicates): '), write(AllCars), nl,
    setof(Type, car(Type), UniqueCars),
    write('Unique cars: '), write(UniqueCars), nl, nl.

% Test b: who has car less than 3000
test_car_less_than :-
    write('=== Test b: Who has car less than 3000? ==='), nl,
    findall(Who, car_less_than(Who, 3000), People),
    write('People with cars < 3000: '), write(People), nl,
    setof(Who, car_less_than(Who, 3000), UniquePeople),
    write('Unique people: '), write(UniquePeople), nl, nl.

% Test c: what cars does joe own
test_joe_cars :-
    write('=== Test c: What cars does joe own? ==='), nl,
    findall(Car, what_car(joe, Car), JoeCars),
    write('Joe''s cars: '), write(JoeCars), nl, nl.

% Run all tests
run_all_tests :-
    test_cars_exist,
    test_car_less_than,
    test_joe_cars,
    write('=== All tests completed ==='), nl.
