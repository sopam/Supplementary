#show lite_le_50K/3, not lite_le_50K/3.
lite_le_50K(X,Y,Z) :- X = married_civ_spouse, Y #=< 5013.0, Z #=< 12.0.
lite_le_50K(X,Y,_) :- X \= married_civ_spouse, Y #=< 6849.0.

