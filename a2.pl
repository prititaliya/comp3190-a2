% Facts about family relationships
% males of family
male(john).
male(mike).
male(tom).
male(bob).  
male(alex). 
male(charlie).
male(david).    
male(george).
male(henry).
male(ian).


% females of family
female(liz).
female(ann).
female(pat).
female(sue).
female(kate).
female(mary).
female(nina).   
female(olivia).
female(paula).
female(rachel).
female(sophia).
female(tina).
female(uma).

% birth date facts
birth_date(john, 1860).
birth_date(liz, 1862).
birth_date(alex, 1863).
birth_date(kate, 1865).
birth_date(mike, 1885).
birth_date(ann, 1887).
birth_date(tom, 1905).
birth_date(pat, 1907).
birth_date(henry, 1910).
birth_date(paula, 1912).
birth_date(bob, 1930).
birth_date(sue, 1930).
birth_date(david, 1902).
birth_date(mary, 1905).
birth_date(charlie,1880).
birth_date(olivia, 1882).
birth_date(george, 1935).
birth_date(nina, 1938).

birth_date(ian, 1960).
birth_date(rachel, 1962).

birth_date(sophia, 1990).
birth_date(tina, 1992).
birth_date(uma, 1995).

% dead or alive facts
dead(john).
dead(liz).
dead(mike).
dead(ann).
dead(tom).
dead(pat).
dead(david).
dead(mary).
dead(charlie).
dead(olivia).   
dead(alex).
dead(kate).
dead(henry).
dead(paula).
dead(bob).


% marriage facts
married(john, liz).
married(mike, ann).
married(tom, pat).
married(david, mary).
married(bob, sue).
married(alex, kate).
married(charlie, olivia).
married(henry, paula).
married(george,nina).
married(ian, rachel).

% parent-child relationships
parent(john, mike).
parent(liz, mike).

parent(mike, tom).
parent(ann, tom).

parent(tom, bob).
parent(pat, bob).

parent(david, nina).
parent(mary, nina).

parent(david, george).
parent(mary, george).

parent(alex, ann).
parent(kate, ann).

parent(david, sue).
parent(mary, sue).

parent(charlie, pat).
parent(olivia, pat).

parent(john, henry).
parent(liz, henry).

parent(alex, paula).
parent(kate, paula).

parent(henry, ian).
parent(paula, ian).

parent(david, george).
parent(mary, george).

parent(bob, sophia).
parent(sue, sophia).

parent(george, tina).
parent(nina, tina).

parent(george, uma).
parent(nina, uma).



% grandparent relationships
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandmother(X, Y) :- female(X), grandparent(X, Y).
grandfather(X, Y) :- male(X), grandparent(X, Y).

% sibling relationships
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
brother(X, Y) :- male(X), sibling(X, Y).
sister(X, Y) :- female(X), sibling(X, Y).   

% uncle and aunt relationships
uncle(X, Y) :- male(X), sibling(X, Z), parent(Z, Y).
aunt(X, Y) :- female(X), sibling(X, Z), parent(Z, Y).

% cousin relationships
cousin(X, Y) :- parent(Z, X), parent(W, Y), sibling(Z, W).

% in-law relationships
father_in_law(X, Y) :- male(X), married(Y, Z), parent(X, Z).
mother_in_law(X, Y) :- female(X), married(Y, Z), parent(X, Z).

% age comparison
older(X, Y) :- birth_date(X, DX), birth_date(Y, DY), DX < DY.
younger(X, Y) :- birth_date(X, DX), birth_date(Y, DY), DX > DY. 

current_year(2025).
age(X, Age) :- birth_date(X, BirthYear), current_year(CurrentYear), Age is CurrentYear - BirthYear.


% divorce facts
divorced(mike, ann, 1920).
divorced(tom, pat, 1935).
divorced(david, mary, 1960).

% currently married predicate
currently_married(X, Y) :- married(X, Y), \+ divorced(X, Y, _).
currently_married(X, Y) :- married(Y, X), \+ divorced(Y, X, _).

% alive predicate
alive(X) :- \+ dead(X).

% widow/widower predicate
widow(X) :- female(X), (married(X, Y);married(Y, X)), dead(Y).
widower(X) :- male(X), (married(X, Y);married(Y, X)), dead(Y).