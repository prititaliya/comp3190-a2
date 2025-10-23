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
male(jack).


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
female(victoria).

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
birth_date(jack, 1940).
birth_date(victoria, 1915).

birth_date(ian, 1935).
birth_date(rachel, 1932).

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
married(henry, victoria).

% parent-child relationships
parent(john, mike).
parent(liz, mike).

parent(henry, jack).
parent(victoria, jack).

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
% this define grandparent relationship X is grandparent of Y if X is parent of Z and Z is parent of Y
% No special cases.
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandmother(X, Y) :- female(X), grandparent(X, Y).
grandfather(X, Y) :- male(X), grandparent(X, Y).
% grandmother(liz, tom).
% grandfather(john, henry). 

% sibling relationships
% defines sibling relationshiop X is sibling of Y if X and Y share both parents Z and W, and X is not Y
% No special cases.
sibling(X, Y) :- parent(Z, X), parent(Z, Y), parent(W, X), parent(W, Y), Z \= W, X \= Y.
brother(X, Y) :- male(X), sibling(X, Y).    
sister(X, Y) :- female(X), sibling(X, Y).
% brother(mike, henry).
% sister(ann, paula).   

% uncle and aunt relationships
% this predicate defines uncle relationship X is uncle of Y if X is male, X is sibling of Z, and Z is parent of Y
% No special cases.
uncle(X, Y) :- male(X), sibling(X, Z), parent(Z, Y).
uncle(X, Y) :- male(X), married(X, W), aunt(W, Y).

% this predicate defines aunt relationship X is aunt of Y if X is female, X is sibling of Z, and Z is parent of Y
% No special cases.
aunt(X, Y) :- female(X), sibling(X, Z), parent(Z, Y).
aunt(X, Y) :- female(X), married(X, W), uncle(W, Y).
% uncle(mike, bob).
% aunt(ann, sue).


% nephew and niece relationships
% X is nephew of Y if X is male, Y is sibling of Z, and Z is parent of X
% No special cases.
nephew(X, Y) :- male(X), sibling(Y,Z), parent(Z, X).
niece(X, Y) :- female(X), sibling(Y,Z), parent(Z, X).
% nephew(bob, mike).
% niece(sue, ann).

% uncle-in-law and aunt-in-law relationships
% X is uncle-in-law of Y if X is married to Z, Z is sibling of W, and W is parent of Y
% X is aunt-in-law of Y if X is married to Z, Z is sibling of W, and W is parent of Y
% No special cases.
uncle_in_law(X, Y) :- married(X, Z), sibling(Z, W), parent(W, Y).
aunt_in_law(X, Y) :- married(X, Z), sibling(Z, W), parent(W, Y). 
% uncle_in_law(mike, bob).
% aunt_in_law(ann, sue).

% half-sibling relationships
% X is half-sibling of Y if X and Y share one parent Z, but have different other parents W and V, and X is not Y
% No special cases.
half_sibling(X, Y) :- 
    parent(Z, X), parent(Z, Y),
    parent(W, X), parent(V, Y),
    W \= V, Z \= W, Z \= V, X \= Y.
% half_sibling(jack, henry).

% cousin relationships
% X is cousin of Y if parent Z of X and parent W of Y are siblings
cousin(X, Y) :- parent(Z, X), parent(W, Y), sibling(Z, W).
% cousin(john, mike).

% in-law relationships
% this predicate defines father-in-law relationship X is father-in-law of Y if X is male, Y is married to Z, and X is parent of Z
% No special cases.
father_in_law(X, Y) :- male(X), married(Y, Z), parent(X, Z).
mother_in_law(X, Y) :- female(X), married(Y, Z), parent(X, Z).
brother_in_law(X, Y) :- male(X), married(Y, Z), sibling(X, Z).
brother_in_law(X,Y):-male(X),married(X,Z),sibling(Y,Z).
sister_in_law(X, Y) :- female(X), married(Y, Z), sibling(X, Z).
sister_in_law(X,Y):-female(X),married(X,Z),sibling(Y,Z).
% father_in_law(john, bob).
% mother_in_law(liz, sue).
% brother_in_law(mike, sue).
% sister_in_law(ann, bob).

% age comparison
% this predicate defines older relationship X is older than Y if birth date DX of X is less than birth date DY of Y
% X is younger than Y if birth date DX of X is greater than birth date DY of Y
% No special cases.
older(X, Y) :- birth_date(X, DX), birth_date(Y, DY), DX < DY.
younger(X, Y) :- birth_date(X, DX), birth_date(Y, DY), DX > DY. 
% older(john, mike).

% age predicate 
% X is age yers old if current year is CY and birth date of X is BY and Age is CY - BY
% No special cases.
current_year(2025).
age(X, Age) :- birth_date(X, BirthYear), current_year(CurrentYear), Age is CurrentYear - BirthYear.
% age(john, Age).


% divorce facts
% divorced facts with year of divorce
divorced(mike, ann, 1920).
divorced(tom, pat, 1935).
divorced(david, mary, 1960).
divorced(henry, paula, 1934).
% divorced(alex, kate, 1900).

% currently married predicate
% X is currently married to Y if X is married to Y and there is no divorced fact for X and Y
currently_married(X, Y) :- married(X, Y), \+ divorced(X, Y, _).
currently_married(X, Y) :- married(Y, X), \+ divorced(Y, X, _).
% currently_married(bob, sue).

% alive predicate
% this predicate defines alive relationship X is alive if there is no dead fact for X
% No special cases.
alive(X) :- \+ dead(X).
% alive(john).

% widow/widower predicate
% this predicate defines widow rekationship X is widow if X is female, X is married to Y, and Y is dead
% this predicate defines widower rekationship X is widower if X is male, X is married to Y, and Y is dead
% No special cases.
widow(X) :- female(X), (married(X, Y);married(Y, X)), dead(Y).
widower(X) :- male(X), (married(X, Y);married(Y, X)), dead(Y).
% widow(liz).
% widower(john).

% ancestor predicate
% this predicate defines ancestor relationship X is ancestor of Y if X is parent of Y or X is parent of Z and Z is ancestor of Y
% No special cases.
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(Z, Y), ancestor(X, Z).
% ancestor(john, bob).


% top level ancestors
% this predicate defines top level ancestor relationship X is top level ancestor if X is ancestor of Y and X has no parent
% No special cases.
top_level_ancestor(X) :- ancestor(X, _), \+ parent(_, X).
% top_level_ancestor(john).


% print list
% helper predicate to print list elements
print_list([H|T]) :-
    write(H), nl,
    print_list(T).

% print family members
% this predicate defines family members as all individuals who are related by blood or marriage
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


% related by blkood
% tgis predicate defines related relationship X is related to Y if X is parent of Y or X is parent of Z and Z is related to Y or X is child of Z and Z is related to Y  
related(X, Y) :- parent(X, Y).
related(X, Y) :- parent(Z, Y), related(X, Z).
related(X, Y) :- parent(Z, X), related(Z, Y).
% related(john, bob).

% related by marriage
% this predicate defines related by marriage relationship X is related to Y if X is married to Y or X is married to Z and Z is related by marriage to Y or X is child of Z and Z is related by marriage to Y
:- table related_by_marriage/2.

related_by_marriage(X, Y) :- married(X, Y).
related_by_marriage(X, Y) :- married(Y, X).
related_by_marriage(X, Y) :- married(X, Z), related_by_marriage(Z, Y).
related_by_marriage(X, Y) :- married(Z, X), related_by_marriage(Z, Y).
% related_by_marriage(mike, sue).


% print familty tree
print_fam(X, Level) :-
    tab(Level), write(X), nl,
    findall(Y, parent(X, Y), Children),
    NewLevel is Level + 4,
    print_children(Children, NewLevel).
print_children([], _).
print_children([H|T], Level) :-
    print_fam(H, Level),
    print_children(T, Level).   
% source https://www.tutorialspoint.com/prolog/prolog_recursion_and_structures.htm




% TEST CASES 
% ?- print_family_members.
% john
% mike
% tom
% bob
% alex
% charlie
% david
% george
% henry
% ian
% jack
% liz
% ann
% pat
% sue
% kate
% mary
% nina
% olivia
% paula
% rachel
% sophia
% tina
% uma
% victoria
% false.



% ?- half_sibling(jack, ian).
% true.

% ?- cousin(sophia, tina).
% true.

% ?- older(john, mike).
% true.

% ?- age(john, Age).
% Age = 165.    

% ?- alive(john).
% false.    

% ?- widow(liz).
% true. 

% ?- widower(john). 
% true.

% ?- ancestor(john, bob).   
% true.


% ?- top_level_ancestor(john).
% true.

% ?- print_fam(john, 0).
% john
%     mike
%         tom
%             bob
%                 sophia
%     henry
%         jack
%         ian
% true.

% ?- related(john, bob).
% true.

% ?- related_by_marriage(mike, ann).
% true.

% ?- uncle_in_law(mike, bob).
% false.

% ?- aunt_in_law(ann, sue).
% false.

% ?- grandparent(liz, tom).
% true.

% ?- grandfather(john, ian).  
% true.


% ?- brother(mike, henry).
% true.

% ?- sister(ann, paula).
% true.

% ?- uncle(mike, ian).
% true.

% ?- aunt(ann, ian).
% true.

% ?- nephew(ian, mike).
% true.

% ?- niece(jack, ann).
% false.

% ?- father_in_law(alex, mike).
% true.

% ?- mother_in_law(kate, mike).
% true.


% variabless queries 
% ?- half_sibling(X, Y).
% X = jack, Y = ian ;

% ?- cousin(X, Y).
% X = jack,
% Y = tom ;
% X = jack,
% Y = tom ;
% X = tom,
% Y = jack ;
% X = tom,
% Y = jack ;
% X = tom,
% Y = ian ;
% X = tom,
% Y = ian ;
% X = tom,
% Y = ian ;
% X = tom,
% Y = ian ;
% X = ian,
% Y = tom ;
% X = ian,
% Y = tom ;
% X = ian,
% Y = tom ;
% X = ian,
% Y = tom ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = sophia,
% Y = uma ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = sophia ;
% X = tina,
% Y = sophia ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = Y, Y = tina ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = tina,
% Y = uma ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = sophia ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = uma,
% Y = tina ;
% X = Y, Y = uma 
% Unknown action: ' (h for help)
% Action? ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% X = Y, Y = uma ;
% false.

% ?- ;;;

% ?- older(X, Y).
% X = john,
% Y = liz ;
% X = john,
% Y = alex ;
% X = john,
% Y = kate ;
% X = john,
% Y = mike ;
% X = john,
% Y = ann ;
% X = john,
% Y = tom ;
% X = john,
% Y = pat ;
% X = john,
% Y = henry ;
% X = john,
% Y = paula ;
% X = john,
% Y = bob ;
% X = john,
% Y = sue ;
% X = john,
% Y = david ;
% X = john,
% Y = mary ;
% X = john,
% Y = charlie ;
% X = john,
% Y = olivia ;
% X = john,
% Y = george ;
% X = john,
% Y = nina ;
% X = john,
% Y = jack ;
% X = john,
% Y = victoria ;
% X = john,
% Y = ian ;
% X = john,
% Y = rachel ;
% X = john,
% Y = sophia ;
% X = john,
% Y = tina ;
% X = john,
% Y = uma ;
% X = liz,
% Y = alex ;
% X = liz,
% Y = kate ;
% X = liz,
% Y = mike ;
% X = liz,
% Y = ann ;
% X = liz,
% Y = tom ;
% X = liz,
% Y = pat ;
% X = liz,
% Y = henry ;
% X = liz,
% Y = paula ;
% X = liz,
% Y = bob ;
% X = liz,
% Y = sue ;
% X = liz,
% Y = david ;
% X = liz,
% Y = mary ;
% X = liz,
% Y = charlie ;
% X = liz,
% Y = olivia ;
% X = liz,
% Y = george ;
% X = liz,
% Y = nina ;
% X = liz,
% Y = jack ;
% X = liz,
% Y = victoria ;
% X = liz,
% Y = ian ;
% X = liz,
% Y = rachel ;
% X = liz,
% Y = sophia ;
% X = liz,
% Y = tina ;
% X = liz,
% Y = uma ;
% X = alex,
% Y = kate ;
% X = alex,
% Y = mike ;
% X = alex,
% Y = ann ;
% X = alex,
% Y = tom ;
% X = alex,
% Y = pat ;
% X = alex,
% Y = henry ;
% X = alex,
% Y = paula ;
% X = alex,
% Y = bob ;
% X = alex,
% Y = sue ;
% X = alex,
% Y = david ;
% X = alex,
% Y = mary ;
% X = alex,
% Y = charlie ;
% X = alex,
% Y = olivia ;
% X = alex,
% Y = george ;
% X = alex,
% Y = nina ;
% X = alex,
% Y = jack ;
% X = alex,
% Y = victoria ;
% X = alex,
% Y = ian ;
% X = alex,
% Y = rachel ;
% X = alex,
% Y = sophia ;
% X = alex,
% Y = tina ;
% X = alex,
% Y = uma ;
% X = kate,
% Y = mike ;
% X = kate,
% Y = ann ;
% X = kate,
% Y = tom ;
% X = kate,
% Y = pat ;
% X = kate,
% Y = henry ;
% X = kate,
% Y = paula ;
% X = kate,
% Y = bob ;
% X = kate,
% Y = sue ;
% X = kate,
% Y = david ;
% X = kate,
% Y = mary ;
% X = kate,
% Y = charlie ;
% X = kate,
% Y = olivia ;
% X = kate,
% Y = george ;
% X = kate,
% Y = nina ;
% X = kate,
% Y = jack ;
% X = kate,
% Y = victoria ;
% X = kate,
% Y = ian ;
% X = kate,
% Y = rachel ;
% X = kate,
% Y = sophia ;
% X = kate,
% Y = tina ;
% X = kate,
% Y = uma ;
% X = mike,
% Y = ann ;
% X = mike,
% Y = tom ;
% X = mike,
% Y = pat ;
% X = mike,
% Y = henry ;
% X = mike,
% Y = paula ;
% X = mike,
% Y = bob ;
% X = mike,
% Y = sue ;
% X = mike,
% Y = david ;
% X = mike,
% Y = mary ;
% X = mike,
% Y = george ;
% X = mike,
% Y = nina ;
% X = mike,
% Y = jack ;
% X = mike,
% Y = victoria ;
% X = mike,
% Y = ian ;
% X = mike,
% Y = rachel ;
% X = mike,
% Y = sophia ;
% X = mike,
% Y = tina ;
% X = mike,
% Y = uma ;
% X = ann,
% Y = tom ;
% X = ann,
% Y = pat ;
% X = ann,
% Y = henry ;
% X = ann,
% Y = paula ;
% X = ann,
% Y = bob ;
% X = ann,
% Y = sue ;
% X = ann,
% Y = david ;
% X = ann,
% Y = mary ;
% X = ann,
% Y = george ;
% X = ann,
% Y = nina ;
% X = ann,
% Y = jack ;
% X = ann,
% Y = victoria ;
% X = ann,
% Y = ian ;
% X = ann,
% Y = rachel ;
% X = ann,
% Y = sophia ;
% X = ann,
% Y = tina ;
% X = ann,
% Y = uma ;
% X = tom,
% Y = pat ;
% X = tom,
% Y = henry ;
% X = tom,
% Y = paula ;
% X = tom,
% Y = bob ;
% X = tom,
% Y = sue ;
% X = tom,
% Y = george ;
% X = tom,
% Y = nina ;
% X = tom,
% Y = jack ;
% X = tom,
% Y = victoria ;
% X = tom,
% Y = ian ;
% X = tom,
% Y = rachel ;
% X = tom,
% Y = sophia ;
% X = tom,
% Y = tina ;
% X = tom,
% Y = uma ;
% X = pat,
% Y = henry ;
% X = pat,
% Y = paula ;
% X = pat,
% Y = bob ;
% X = pat,
% Y = sue ;
% X = pat,
% Y = george ;
% X = pat,
% Y = nina ;
% X = pat,
% Y = jack ;
% X = pat,
% Y = victoria ;
% X = pat,
% Y = ian ;
% X = pat,
% Y = rachel ;
% X = pat,
% Y = sophia ;
% X = pat,
% Y = tina ;
% X = pat,
% Y = uma ;
% X = henry,
% Y = paula ;
% X = henry,
% Y = bob ;
% X = henry,
% Y = sue ;
% X = henry,
% Y = george ;
% X = henry,
% Y = nina ;
% X = henry,
% Y = jack ;
% X = henry,
% Y = victoria ;
% X = henry,
% Y = ian ;
% X = henry,
% Y = rachel ;
% X = henry,
% Y = sophia ;
% X = henry,
% Y = tina ;
% X = henry,
% Y = uma ;
% X = paula,
% Y = bob ;
% X = paula,
% Y = sue ;
% X = paula,
% Y = george ;
% X = paula,
% Y = nina ;
% X = paula,
% Y = jack ;
% X = paula,
% Y = victoria ;
% X = paula,
% Y = ian ;
% X = paula,
% Y = rachel ;
% X = paula,
% Y = sophia ;
% X = paula,
% Y = tina ;
% X = paula,
% Y = uma ;
% X = bob,
% Y = george ;
% X = bob,
% Y = nina ;
% X = bob,
% Y = jack ;
% X = bob,
% Y = ian ;
% X = bob,
% Y = rachel ;
% X = bob,
% Y = sophia ;
% X = bob,
% Y = tina ;
% X = bob,
% Y = uma ;
% X = sue,
% Y = george ;
% X = sue,
% Y = nina ;
% X = sue,
% Y = jack ;
% X = sue,
% Y = ian ;
% X = sue,
% Y = rachel ;
% X = sue,
% Y = sophia ;
% X = sue,
% Y = tina ;
% X = sue,
% Y = uma ;
% X = david,
% Y = tom ;
% X = david,
% Y = pat ;
% X = david,
% Y = henry ;
% X = david,
% Y = paula ;
% X = david,
% Y = bob ;
% X = david,
% Y = sue ;
% X = david,
% Y = mary ;
% X = david,
% Y = george ;
% X = david,
% Y = nina ;
% X = david,
% Y = jack ;
% X = david,
% Y = victoria ;
% X = david,
% Y = ian ;
% X = david,
% Y = rachel ;
% X = david,
% Y = sophia ;
% X = david,
% Y = tina ;
% X = david,
% Y = uma ;
% X = mary,
% Y = pat ;
% X = mary,
% Y = henry ;
% X = mary,
% Y = paula ;
% X = mary,
% Y = bob ;
% X = mary,
% Y = sue ;
% X = mary,
% Y = george ;
% X = mary,
% Y = nina ;
% X = mary,
% Y = jack ;
% X = mary,
% Y = victoria ;
% X = mary,
% Y = ian ;
% X = mary,
% Y = rachel ;
% X = mary,
% Y = sophia ;
% X = mary,
% Y = tina ;
% X = mary,
% Y = uma ;
% X = charlie,
% Y = mike ;
% X = charlie,
% Y = ann ;
% X = charlie,
% Y = tom ;
% X = charlie,
% Y = pat ;
% X = charlie,
% Y = henry ;
% X = charlie,
% Y = paula ;
% X = charlie,
% Y = bob ;
% X = charlie,
% Y = sue ;
% X = charlie,
% Y = david ;
% X = charlie,
% Y = mary ;
% X = charlie,
% Y = olivia ;
% X = charlie,
% Y = george ;
% X = charlie,
% Y = nina ;
% X = charlie,
% Y = jack ;
% X = charlie,
% Y = victoria ;
% X = charlie,
% Y = ian ;
% X = charlie,
% Y = rachel ;
% X = charlie,
% Y = sophia ;
% X = charlie,
% Y = tina ;
% X = charlie,
% Y = uma ;
% X = olivia,
% Y = mike ;
% X = olivia,
% Y = ann ;
% X = olivia,
% Y = tom ;
% X = olivia,
% Y = pat ;
% X = olivia,
% Y = henry ;
% X = olivia,
% Y = paula ;
% X = olivia,
% Y = bob ;
% X = olivia,
% Y = sue ;
% X = olivia,
% Y = david ;
% X = olivia,
% Y = mary ;
% X = olivia,
% Y = george ;
% X = olivia,
% Y = nina ;
% X = olivia,
% Y = jack ;
% X = olivia,
% Y = victoria ;
% X = olivia,
% Y = ian ;
% X = olivia,
% Y = rachel ;
% X = olivia,
% Y = sophia ;
% X = olivia,
% Y = tina ;
% X = olivia,
% Y = uma ;
% X = george,
% Y = nina ;
% X = george,
% Y = jack ;
% X = george,
% Y = sophia ;
% X = george,
% Y = tina ;
% X = george,
% Y = uma ;
% X = nina,
% Y = jack ;
% X = nina,
% Y = sophia ;
% X = nina,
% Y = tina ;
% X = nina,
% Y = uma ;
% X = jack,
% Y = sophia ;
% X = jack,
% Y = tina ;
% X = jack,
% Y = uma ;
% X = victoria,
% Y = bob ;
% X = victoria,
% Y = sue ;
% X = victoria,
% Y = george ;
% X = victoria,
% Y = nina ;
% X = victoria,
% Y = jack ;
% X = victoria,
% Y = ian ;
% X = victoria,
% Y = rachel ;
% X = victoria,
% Y = sophia ;
% X = victoria,
% Y = tina ;
% X = victoria,
% Y = uma ;
% X = ian,
% Y = nina ;
% X = ian,
% Y = jack ;
% X = ian,
% Y = sophia ;
% X = ian,
% Y = tina ;
% X = ian,
% Y = uma ;
% X = rachel,
% Y = george ;
% X = rachel,
% Y = nina ;
% X = rachel,
% Y = jack ;
% X = rachel,
% Y = ian ;
% X = rachel,
% Y = sophia ;
% X = rachel,
% Y = tina ;
% X = rachel,
% Y = uma ;
% X = sophia,
% Y = tina ;
% X = sophia,
% Y = uma ;
% X = tina,
% Y = uma ;
% false.


% now i m just gonna print first output of above query to save space

% ?- younger(X, Y).
% X = liz,
% Y = john

% ?- age(X, Age).
% X = john,
% Age = 165 ;

% ?- alive(X).
% false.    

% ?- widow(X).
% X = liz ;

% ?- widower(X). 
% X = john ;

% ?- ancestor(X, Y).
% X = john,
% Y = mike ;

