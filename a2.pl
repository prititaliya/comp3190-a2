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
birth_date(john, 1950).
birth_date(liz, 1952).
birth_date(mike, 1975).
birth_date(ann, 1978).
birth_date(tom, 1980).
birth_date(pat, 1982).
birth_date(bob, 2005).
birth_date(sue, 2007).
birth_date(alex, 2010).
birth_date(kate, 2012).
birth_date(charlie, 2008).
birth_date(mary, 1985).
birth_date(david, 1983).
birth_date(nina, 2015).
birth_date(george, 2018).
birth_date(olivia, 2020).
birth_date(henry, 2013).
birth_date(paula, 1988).
birth_date(rachel, 1990).
birth_date(ian, 2016).
birth_date(sophia, 2019).
birth_date(tina, 2021).
birth_date(uma, 2022).

% marriage facts
married(john, liz).
married(mike, ann).
married(tom, pat).
married(david, mary).
married(bob, sue).
married(alex, kate).

% parent-child relationships
parent(john, mike).
parent(liz, mike).
parent(john, ann).
parent(liz, ann).
parent(mike, tom).
parent(ann, tom).
parent(mike, pat).
parent(ann, pat).
parent(tom, bob).
parent(pat, bob).
parent(tom, sue).
parent(pat, sue).
parent(david, nina).
parent(mary, nina).
parent(david, george).
parent(mary, george).

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

