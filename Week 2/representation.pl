lecturer(paul).
lecturer(viv).
lecturer(francis).

% modules
module(ai).
module(csharp101).
module(maths101).

% who teaches what
teaches(paul, ai).
teaches(viv, csharp101).
teaches(francis, maths101).

% students and their class
in_class(ursula, bsc4).
in_class(fred, bsc4).
in_class(mary, bsc1).

% what modules each class takes
takes_module(bsc4, ai).
takes_module(bsc4, software_engineering).
takes_module(bsc1, csharp101).