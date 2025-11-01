% cars.pl file

% cars that exist
car(3, ford, 5000).
car(2, opel, 6000).
car(5, toyota, 1000).
car(2, ford, 2000).

% who has what car
has_car(joe, 3, ford, 5000).
has_car(joe, 2, opel, 6000).
has_car(mick, 5, toyota, 1000).
has_car(mick, 2, ford, 2000).

% a. what cars exist
car(Type).

% b. who has car less than 3000
car_less_than(Who, 3000).

% c. what cars does joe own
what_car(Joe,Car)




% Representation 1 - pegs and holes

% pegs
peg(p2, square).
peg(p1, round).

% holes
hole(h1, round).
hole(h2, square).
hole(h3, round).

% pegs fit into holes of same shape
fits(Peg, Hole)

% which round pegs fit into round holes
round_peg_round_hole(Peg, Hole)


% Representation 2 - lifting trunk

% facts about people
handed(fred, right).
handed(bill, left).
handed(mary, right).

% opposite hands
opposite(left, right).
opposite(right, left).

% trunk is heavy
heavy(trunk).

% who can lift trunk - need 2 people with opposite hands
can_lift(Object, Person1, Person2)