%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Helpers

%isin(X,L) is true if X appears in L
isin(X,[X|_]).
isin(X,[_|T]) :- isin(X,T).

% zip(L1,L2,L3) is true if L3 is the result of interleaving L1 and L2
% e.g. zip([1,2],[3,4],[1,3,2,4])   is true
zip([],[],[]).
zip([H1|T1],[H2|T2],[H1,H2|T]) :- zip(T1,T2,T).

% assoc(L,K,V) is true if L is a list of 2-element lists and one of them is [K,V]
% e.g. assoc([[key1,value1],['a',1],[3,4]], 3, 4) is true
assoc([[X,Y]|_],X,Y).
assoc([_|T],X,Y) :- assoc(T,X,Y).

% remove_duplicates(L1,L2) is true if L2 is the result of removing all duplicate elements from L1.
% The remaining elements should be in the original order.
% e.g. remove_duplicates([1,1,2,2,3,3,4,4],[1,2,3,4]) is true
clean([],Soln,Y) :- reverse(Y,Soln).
clean([H|T],Soln,Y) :- isin(H,Y),!,clean(T,Soln,Y).
clean([H|T],Soln,Y) :- clean(T,Soln,[H|Y]).
remove_duplicates(L1,L2) :- clean(L1,L2,[]).

% union(L1,L2,L3) is true if L3 is the set union of L1 and L2.
% There should be no duplicates in L3.
% e.g. union([1,2,3],[2,3,4],[1,2,3,4]) is true
union(L1,L2,L3) :- append(L1,L2,L),remove_duplicates(L,L3).

% intersection(L1,L2,L3) is true if L3 is the set intersection of L1 and L2.
% There should be no duplicates in L3.
% e.g. intersection([1,2,3],[2,3,4],[2,3]) is true
its([],_,X,Y) :- reverse(X,Y).
its([H|T],L,X,Y) :- isin(H,L),!,its(T,L,[H|X],Y).
its([_|T],L,X,Y) :- its(T,L,X,Y).
intersection(L1,L2,L3) :- its(L1,L2,[],L3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1: Facts

cost(carne_asada,3).
cost(lengua,2).
cost(birria,2).
cost(carnitas,2).
cost(adobado,2).
cost(al_pastor,2).
cost(guacamole,1).
cost(rice,1).
cost(beans,1).
cost(salsa,1).
cost(cheese,1).
cost(sour_cream,1).
cost(taco,1).
cost(tortilla,1).
cost(sopa,1).


ingredients(carnitas_taco, [taco,carnitas, salsa, guacamole]).
ingredients(birria_taco, [taco,birria, salsa, guacamole]).
ingredients(al_pastor_taco, [taco,al_pastor, salsa, guacamole, cheese]).
ingredients(guacamole_taco, [taco,guacamole, salsa,sour_cream]).
ingredients(al_pastor_burrito, [tortilla,al_pastor, salsa]).
ingredients(carne_asada_burrito, [tortilla,carne_asada, guacamole, rice, beans]).
ingredients(adobado_burrito, [tortilla,adobado, guacamole, rice, beans]).
ingredients(carnitas_sopa, [sopa,carnitas, guacamole, salsa,sour_cream]).
ingredients(lengua_sopa, [sopa,lengua,beans,sour_cream]).
ingredients(combo_plate, [al_pastor, carne_asada,rice, tortilla, beans, salsa, guacamole, cheese]).
ingredients(adobado_plate, [adobado, guacamole, rice, tortilla, beans, cheese]).

taqueria(el_cuervo, [ana,juan,maria],
        [carnitas_taco, combo_plate, al_pastor_taco, carne_asada_burrito]).

taqueria(la_posta,
        [victor,maria,carla], [birria_taco, adobado_burrito, carnitas_sopa, combo_plate, adobado_plate]).

taqueria(robertos, [hector,carlos,miguel],
        [adobado_plate, guacamole_taco, al_pastor_burrito, carnitas_taco, carne_asada_burrito]).

taqueria(la_milpas_quatros, [jiminez, martin, antonio, miguel],
        [lengua_sopa, adobado_plate, combo_plate]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1: Rules

/* Checks whether item X is offered at Taqueria Y */
available_at(X,Y) :- taqueria(Y, _, Z), isin(X, Z).

/* Taken from class notes, compares the length of a list with N */
list_len([],0).
list_len([_|T],N) :- list_len(T,Nt), N is Nt + 1.

/* Gets a list of all taquerias where X is available */
multi_available_helper(X, L) :- setof(Y, available_at(X, Y), L).

/* Checks whether item X is available at multiple taquerias */
multi_available(X) :- multi_available_helper(X, L), list_len(L, N), not(N=0), not(N=1).

/* Helper function to match workers to taqueria */
works_at(X, _) :- taqueria(_, B, _), isin(X, B).

/* Gets list of all locations a worker works at */
overworked_helper(X, L) :- setof(Y, works_at(X, Y), L).

/* Checks whether a worker works at more than one taqueria */
overworked(X) :- overworked_helper(X, L), list_len(L, N), not(N=0), not(N=1).

/* Methodology: Get list of ingredients. Add cost of each ingredient recursively */

/* Gets the cost of a list of ingredients */
ingredient_cost([], 0).
ingredient_cost([H|T],P) :- cost(H, P_1), ingredient_cost(T, P_2), P is P_1 + P_2.

/* K is the combined cost of the ingredients to make item X */
total_cost(X,K) :- ingredients(X, L), ingredient_cost(L, K).

/* Go through all ingredients in list, match each one to isin ingredients(X), if any false then false */

/* Given item X and ingredient L, determines whether X's ingredients contains all of L */
has_ingredients(X,[]) :- ingredients(X, _).
has_ingredients(X,L) :- L=[H|T], ingredients(X, Y), isin(H, Y), has_ingredients(X, T).

/* Given item X and ingredient list L, determines whether X's ingredients excludes all of L */
avoids_ingredients(X,L) :- ingredients(X, Y), intersection(L, Y, []).

/* L1 is list of items containing ingredients X
 *  L2 is list of items not containing ingredients Y
 */

/* Gets the set of all items that contain ingredients X*/
p1(L,X) :- setof(A, has_ingredients(A,X), L).

/* Gets the set of all items that exclude ingredients Y */
p2(L,Y) :- setof(A, avoids_ingredients(A, Y), L).

find_items(L,X,Y) :- p1(L1,X),p2(L2,Y),intersection(L1,L2,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
