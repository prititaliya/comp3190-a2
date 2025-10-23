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
% grandmother(liz, tom).
% grandfather(john, henry). 

% sibling relationships
sibling(X, Y) :- parent(Z, X), parent(Z, Y), parent(W, X), parent(W, Y), Z \= W, X \= Y.
brother(X, Y) :- male(X), sibling(X, Y).    
sister(X, Y) :- female(X), sibling(X, Y).
% brother(mike, henry).
% sister(ann, paula).   

% uncle and aunt relationships
uncle(X, Y) :- male(X), sibling(X, Z), parent(Z, Y).
aunt(X, Y) :- female(X), sibling(X, Z), parent(Z, Y).
% uncle(mike, bob).
% aunt(ann, sue).

% nephew and niece relationships
nephew(X, Y) :- male(X), parent(Z, Y), sibling(Z, W), parent(W, X).
niece(X, Y) :- female(X), parent(Z, Y), sibling(Z, W), parent(W, X).
% nephew(bob, mike).
% niece(sue, ann).

% uncle-in-law and aunt-in-law relationships
uncle_in_law(X, Y) :- married(X, Z), sibling(Z, W), parent(W, Y).
aunt_in_law(X, Y) :- married(X, Z), sibling(Z, W), parent(W, Y). 
% uncle_in_law(mike, bob).
% aunt_in_law(ann, sue).

% half-sibling relationships
half_sibling(X, Y) :- parent(Z, X), parent(Z, Y), parent(W, X), parent(V, Y), W \= V, X \= Y.   
% half_sibling(mike, henry).


% cousin relationships
cousin(X, Y) :- parent(Z, X), parent(W, Y), sibling(Z, W).
% cousin(john, mike).

% in-law relationships
father_in_law(X, Y) :- male(X), married(Y, Z), parent(X, Z).
mother_in_law(X, Y) :- female(X), married(Y, Z), parent(X, Z).
brother_in_law(X, Y) :- male(X), married(Y, Z), sibling(X, Z).
sister_in_law(X, Y) :- female(X), married(Y, Z), sibling(X, Z).
% father_in_law(john, bob).
% mother_in_law(liz, sue).
% brother_in_law(mike, sue).
% sister_in_law(ann, bob).

% age comparison
older(X, Y) :- birth_date(X, DX), birth_date(Y, DY), DX < DY.
younger(X, Y) :- birth_date(X, DX), birth_date(Y, DY), DX > DY. 
% older(john, mike).

current_year(2025).
age(X, Age) :- birth_date(X, BirthYear), current_year(CurrentYear), Age is CurrentYear - BirthYear.
% age(john, Age).


% divorce facts
divorced(mike, ann, 1920).
divorced(tom, pat, 1935).
divorced(david, mary, 1960).
% divorced(alex, kate, 1900).

% currently married predicate
currently_married(X, Y) :- married(X, Y), \+ divorced(X, Y, _).
currently_married(X, Y) :- married(Y, X), \+ divorced(Y, X, _).
% currently_married(bob, sue).

% alive predicate
alive(X) :- \+ dead(X).
% alive(john).

% widow/widower predicate
widow(X) :- female(X), (married(X, Y);married(Y, X)), dead(Y).
widower(X) :- male(X), (married(X, Y);married(Y, X)), dead(Y).
% widow(liz).
% widower(john).

% ancestor predicate
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(Z, Y), ancestor(X, Z).
% ancestor(john, bob).


% top level ancestors
top_level_ancestor(X) :- ancestor(X, _), \+ parent(_, X).
% top_level_ancestor(john).


% print list
print_list([H|T]) :-
    write(H), nl,
    print_list(T).

% print family members
print_family_members :-
    findall(X, (male(X); female(X)), Members),  print_list(Members).

% print male
print_males :-
    findall(X, male(X), Males), print_list(Males).

% print female
print_females :-    
    findall(X, female(X), Females), print_list(Females).

% print grandparents
print_grandparents :-
    findall(X, grandparent(X, _), Gparents), print_list(Gparents).

% print siblings
print_siblings :-
    findall((X, Y), sibling(X, Y), Siblings), print_list(Siblings).

% print uncales
print_uncales :-
    findall((X, Y), uncle(X, Y), Uncales), print_list(Uncales).

% print aunts
print_aunts :-
    findall((X, Y), aunt(X, Y), Aunts), print_list(Aunts).

% print cousins
print_cousins :-
    findall((X, Y), cousin(X, Y), Cousins), print_list(Cousins).

% print ancestors
print_ancestors :-  
    findall((X, Y), ancestor(X, Y), Ancestors), print_list(Ancestors).
% print top level ancestors
print_top_level_ancestors :-
    findall(X, top_level_ancestor(X), TopLevelAncestors), print_list(TopLevelAncestors).

% print currently married couples
print_currently_married :-
    findall((X, Y), currently_married(X, Y), MarriedCouples), print_list(MarriedCouples).

% print widows and widowers
print_widows_widowers :-
    findall(X, widow(X), Widows), print_list(Widows),
    findall(Y, widower(Y), Widowers), print_list(Widowers).

% print alive members
print_alive_members :-
    findall(X, alive(X), AliveMembers), print_list(AliveMembers).   

% print ages of membeers
print_ages :-
    findall((X, Age), age(X, Age), Ages), print_list(Ages).

% print divorced couples
print_divorced_couples :-
    findall((X, Y, Year), divorced(X, Y, Year), DivorcedCouples), print_list(DivorcedCouples).


% priny birthdates
print_birthdates :-
    findall((X, Year), birth_date(X, Year), Birthdates), print_list(Birthdates).

