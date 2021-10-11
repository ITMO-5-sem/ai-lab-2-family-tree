% Задаем пол людям (мальчик / девочка)
% --- Genders
% группировка по полу
% --- Males
% ### Уровень 1
male(дмитрий).
male(василий).
male(виктор).
% ### Уровень 2
male(максим).
male(матвей).
male(михаил).
male(мишель).
% ### Уровень 3
male(антон).
% ### Уровень 4
male(глеб).
male(григорий).
% ### Уровень 5
male(святослав).
male(сергей).
male(семен).
% ### Уровень 6
male(ренат).
male(родион).
male(роман).
% 
% --- Females
% ### Уровень 1
female(дарья).
female(вероника).
% ### Уровень 2
female(мария).
female(милана).
female(микаэла).
% ### Уровень 3
female(алена).
female(арина).
female(антонина).
% ### Уровень 4
female(галина).
% ### Уровень 5
female(светлана).
female(соня).
female(софия).
% ### Уровень 6
female(регина).
female(рита).



% Указываем супружеские пары
% --- Spouses
% группировка по слоям в графе
spouse(дмитрий, дарья).
spouse(василий, вероника).
% ---
spouse(матвей, мария).
spouse(милана, михаил).
spouse(микаэла, мишель).
% ---
spouse(алена, григорий).
spouse(арина, антон).
% ---
spouse(светлана, святослав).
spouse(соня, сергей).
spouse(софия, семен).

% Супружеских пар как-то мало оказалось. 
% Ох уж этот 21 век...

% Если женшина - жена мужчине, то
% и этот мужчина - муж этой женщине.
% Объясняем прологу, 
% что супружестов работает в обе стороны.
spouse(Wife, Husband) :-
    spouse(Husband, Wife), !.


% Указываем родителей (задаем родство)
% --- Parents
% группировка по общему родителю
% ### Уровень 1
parent(дмитрий, максим).
parent(дмитрий, мария).
parent(дмитрий, милана).
% ---
parent(дарья, максим).
parent(дарья, мария).
parent(дарья, милана).
% ---
parent(василий, михаил).
parent(василий, микаэла).
% ---
parent(вероника, михаил).
parent(вероника, микаэла).
% ---
parent(виктор, мишель).
% ---
% ### Уровень 2
parent(матвей, алена).
% ---
parent(мария, алена).
% ---
parent(милана, арина).
parent(милана, антонина).
% ---
parent(михаил, антонина).
% ---
parent(микаэла, антон).
% ---
parent(мишель, антон).
% ---
% ### Уровень 3
parent(алена, святослав).
parent(алена, сергей).
% ---
parent(арина, глеб).
parent(арина, галина).
% ---
parent(антон, глеб).
parent(антон, галина).
parent(антон, григорий).
% ---
% ### Уровень 4
parent(григорий, святослав).
parent(григорий, сергей).
% ---
% ### Уровень 5
parent(светлана, регина).
parent(светлана, ренат).
% ---
parent(святослав, регина).
parent(святослав, ренат).
% ---
parent(соня, родион).
% ---
parent(сергей, родион).
% ---
parent(софия, рита).
parent(софия, роман).
% ---
parent(семен, роман).




% ===============
% Правила родства разных форм и размеров
% --- Rules


% Ребенок
child(Child, Parent) :-
    parent(Parent, Child).


% Сын - ребенок мужского пола
son(Son, Person) :-
    child(Son, Person),
    male(Son).


% Дочь - ребенок женского пола
daughter(Daughter, Person) :-
	child(Daughter, Person),
    female(Daughter).


% Мама - родитель женского пола
mother(Mother, Person) :-
    parent(Mother, Person),
    female(Mother).


% Папа - родитель мужского пола
father(Father, Person) :-
    parent(Father, Person),
    male(Father).


% Являеься ли человек родителем
% (есть ли у него дети)
isparent(Person) :-
    parent(Person, _). 
	% нам подходит любой ребенок


% Брат или сестра
% Есть общий родитель
sibling(Sibling, Person) :- 
    parent(Parent, Person),
    parent(Parent, Sibling), 
    Sibling \== Person. % Это шоб Пролог не прологал...
	% В действительности, последняя строчка
	% позволяет избежать самого Person 
	% в результате резолюции правила


% Сестра - сиблинг женского пола
sister(Sister, Person) :-
    sibling(Sister, Person),
    female(Sister).
% "- Сестрааа, брооось
%  - ...
%  - Да не меняя!!, автомат ...
% "


% Брат - сиблинг мужского пола
brother(Person, Brother) :-
    sibling(Person, Brother),
    male(Brother).


% Дядя или тетя
% Сиблинг любого родителя
uncle_or_aunt(Uncle_or_aunt, Person) :- 
    parent(Parent, Person), 
    sibling(Uncle_or_aunt, Parent).

% Дядя
% Брат любого родителя
uncle(Uncle, Person) :- 
    uncle_or_aunt(Uncle, Person),
    male(Uncle).

% Тетя
% Жена любого родителя
aunt(Aunt, Person) :- 
    uncle_or_aunt(Aunt, Person),
    female(Aunt).


% Дедушка или бабушка
% Родитель лбюого из родителей
grandparent(GrandParent, Person) :- 
	parent(Parent, Person),
    parent(GrandParent, Parent).

% Or we can determine 
% granparent this way:
% ---
% grandparent(Grandparent, Person) :- 
%	child(Child, Grandparent),
%   child(Person, Child).
% ---


% Дедушка
% Бабушка/дедушка мужского пола
% или папа любого из родителей
grandfather(Grandfather, Person) :-
    grandparent(Grandfather, Person),
    male(Grandfather).

% Or we can determine 
% granfather this way:
% ---
% grandfather(Grandfather, Person) :-
%    father(Grandfather, Father_or_mother),
%    parent(Father_or_mother, Person).
% ---


% Бабушка
% Бабушка/дедушка женского пола
% или мама любого из родителей
grandmother(Grandmother, Person) :-
    grandparent(Grandmother, Person),
    female(Grandmother).


% Прабабушка
% Мама любого дедушки или бабушки
greatgrandmother(Greatgrandmother, Person) :-
    grandparent(Grandmother, Person),
    mother(Greatgrandmother, Grandmother).


% Прадедушка
% Папа любого дедушки или бабушки
greatgrandfather(Greatgrandfather, Person) :-
    grandparent(Grandfather, Person),
    mother(Greatgrandfather, Grandfather).
    
% Внучок или внучка
% ребенок одного из детей
grandchild(Grandchild, Person) :-
    parent(Person, Child),
    parent(Child, Grandchild).

% Or we can determine 
% grandchild this way:
% ---
% grandchild(Grandchild, Person) :-
%    child(Child, Person),
%    child(Grandchild, Child).
% ---


% Внучка
granddaughter(Granddaughter, Person) :-
	grandchild(Granddaughter, Person),
    female(Granddaughter).


% Внук
grandson(Grandson, Person) :-
	grandchild(Grandson, Person),
    male(Grandson).


% Двоюродный брат/сестра
% Ребенок любого из дядь/теть
cousin(Cousin, Person) :-% двоюродный брат / сестра
	uncle_or_aunt(Uncle_or_aunt, Person),
    child(Cousin, Uncle_or_aunt).
