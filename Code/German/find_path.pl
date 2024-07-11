#include('Draft_1_4.pl').

% Q: Decision Rules for negative/ undesired Outcome (’<=50K/yr’)
    lite_good_credit(A,_,_,_,_):- A = 'no_checking_account'.
    lite_good_credit(A,B,C,D,E):- A \= 'no_checking_account', B \= 'all credits at this bank paid back duly', 
                                    D #=<21,E #> 428,not ab1(C,E).
    ab1(C,E):- C = 'car or other', E #=<1345. 


% Function to check/generate if an instance receives the negative outcome
    get_org(T1, A,B,C,D,E,F,G):-legal(T1,A,B,C,D,E,F,G), constraint(F,G), lite_good_credit(A,B,C,D,E).


% Function to check/generate if an instance receives the positive outcome/ counterfactual
    is_counterfactual(T1, A,B,C,D,E,F,G):-legal(T1,A,B,C,D,E,F,G), constraint(F,G), not lite_good_credit(A,B,C,D,E).

% ?-is_counterfactual(1, A,B,C,D,E,F,G).



% Function to find the solution path to the counterfactual  
    
#show intervention/3.
    get_path(_,_,_,_,_,_,_,T1,A,B,C,D,E,F,G,T1,A,B,C,D,E,F,G,Opt,Opt):-legal(T1,A,B,C,D,E,F,G), constraint(F,G), not lite_good_credit(A,B,C,D,E).
    
    get_path(Z1,Z2,Z3,Z4,Z5,Z6,Z7,T1,A,B,C,D,E,F,G,TN,A1,B1,C1,D1,E1,F1,G1,Acc,Opt):- 
        %geq(C,C2),geq(F,F2)
        intervene(Z1,Z2,Z3,Z4,Z5,Z6,Z7,T1,A,B,C,D,E,F,G,T2,A2,B2,C2,D2,E2,F2,G2,Symbol)
        , anti_member([A2,B2,C2,D2,E2,F2,G2],Acc) 
        , legal(T1,A,B,C,D,E,F,G)
        , lite_good_credit(A,B,C,D,E)
        , get_path(Z1,Z2,Z3,Z4,Z5,Z6,Z7,T2,A2,B2,C2,D2,E2,F2,G2,TN,A1,B1,C1,D1,E1,F1,G1,[state(time(T2),[A2,B2,C2,D2,E2,F2,G2]),Symbol|Acc], Opt).


% LPNMR

    % Check if the instance receives undesired outcome
    ?-  T1 #= 1, A ='>=200', B = 'no credits taken/ all credits paid back duly',
        C = 'real estate', D = 7, E = 500, F =  'unemployed', G = 'unemployed/unskilled-non-resident', %legal(1, A,B,C,D,E,F,G).
        get_org(1, A,B,C,D,E,F,G).


    % LPNMR, find path to CF % Works
    % Example: Set Path length (TN) to 2 to try and reach cf through 1 intervention
    % Constraint all features except for `Property' from change due to a Direct action, 
    % i.e. only `Property' can change its value through a direct action

    ?-  TN #=2, T1 #= 1, A ='>=200', B = 'no credits taken/ all credits paid back duly',
        C = 'real estate', D = 7, E = 500, F =  'unemployed', G = 'unemployed/unskilled-non-resident',
         get_path(0,0,1,0,0,0,0,T1,A,B,C,D,E,F,G,TN,A1,B1,C1,D1,E1,F1,G1,[state(time(T1),[A,B,C,D,E,F,G])],Opt).


