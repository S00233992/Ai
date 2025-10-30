% family.pl

% facts about gender
male(tom).
male(bob).
female(pam).
female(liz).
female(anne).
female(pat).

% parent relationships
parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, anne).
parent(bob, pat).
parent(pat, jim).

% rule 1: two siblings have the same parent
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% rule 2: a sibling is a sister if they have a sibling and the first sibling is female
sister(X, Y) :- sibling(X, Y), female(X).

% rule 3: an aunt of a niece or nephew is a sister of the parent of the niece or nephew
aunt(X, Y) :- parent(Z, Y), sister(X, Z).