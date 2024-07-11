#include('Draft_1_4.pl').

% Q: Decision Rules for negative/ undesired Outcome (’<=50K/yr’)
	#show lite_le_50K/3, not lite_le_50K/3.
    lite_le_50K(X,Y,Z) :- X = married_civ_spouse, Y #=< 5013.0, Z #=< 12.0.
    lite_le_50K(X,Y,_) :- X \= married_civ_spouse, Y #=< 6849.0.
	
% Function to check/generate if an instance receives the negative outcome
    get_org(A,B,C,D,E,F):-legal(1,A,B,C,D,E,F), constraint(A,_,_,D,E,F), lite_le_50K(A,B,C).

% Function to check/generate if an instance receives the positive outcome/ counterfactual
    is_counterfactual(A1,B1,C1,D1,E1,F1):-legal(1,A1,B1,C1,D1,E1,F1), constraint(A1,_,_,D1,E1,F1), not lite_le_50K(A1,B1,C1).



% Function to find the solution path to the counterfactual  

    get_path(_,_,_,_,_,_,T1,A,B,C,D,E,F,T1,A,B,C,D,E,F,Opt,Opt):-legal(T1,A,B,C,D,E,F), not lite_le_50K(A,B,C) , constraint(A,_,_,D,E,F).%constraint_reln_sex_age(D,E,F), constraint_ms_reln_age(A,D,F).
    
    get_path(Z1,Z2,Z3,Z4,Z5,Z6,T1,A,B,C,D,E,F,TN,A1,B1,C1,D1,E1,F1,Acc,Opt):- 
        geq(C,C2),geq(F,F2)
        ,intervene(Z1,Z2,Z3,Z4,Z5,Z6,T1,A,B,C,D,E,F,T2,A2,B2,C2,D2,E2,F2,Symbol)
        , anti_member([A2,B2,C2,D2,E2,F2],Acc) 
        , legal(T1,A,B,C,D,E,F)
        , lite_le_50K(A,B,C)
        %, no_possible_cf(mut(1,1,1,1,1,1),T2, A2,B2,C2,D2,E2,F2,_,_,_,_,_,_) % Checksif cfs are possible from that styate
        , get_path(Z1,Z2,Z3,Z4,Z5,Z6,T2,A2,B2,C2,D2,E2,F2,TN,A1,B1,C1,D1,E1,F1,[state(time(T2),[A2,B2,C2,D2,E2,F2]),Symbol|Acc], Opt).




% Added Constraints: Education num cannot decrease
geq(X,Y):- Y#>=X. 



% LPNMR

    % Check if the instance receives undesired outcome
    ?-A = never_married,B #= 6000,
        C #= 7, D = unmarried, E = male, F #= 28,get_org(A,B,C,D,E,F).

    % LPNMR, find path to CF % Works
    % Example: Set Path length to 3 to try and reach cf through 2 interventions
    % Make Sex, Marital_Status immutbale as a constraint. Done to utilize
    % The causal effect of `Relationship' on `Marital Status'
    ?- TN #=3, Z1 = 0, Z2 = 0, Z3 = 0, Z4 = 1, Z5=0, Z6 = 0, T1 #= 1, A = never_married,B #= 6000,
        C #= 7, D = unmarried, E = male, F #= 28, %no_possible_cf(mut(Z1,Z2,Z3,Z4,Z5,Z6),T1, A,B,C,D,E,F,_,_,_,_,_,_),
        get_path(Z1,Z2,Z3,Z4,Z5,Z6,T1,A,B,C,D,E,F,TN,A1,B1,C1,D1,E1,F1,[state(time(T1),[A,B,C,D,E,F])],Opt).

