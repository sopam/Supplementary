Pre_Requisite: Install s(CASP)- https://gitlab.software.imdea.org/ciao-lang/sCASP

1) Find Path:

	a) This is the proof of concept to show we can show the states from initial to final in a series.
	b) find_path.pl contains the function get_path() that will return the path to the counterfactual state for a given input.
	c) T1 must be specified to a integer value. Leaving it unassigned will cause the function to fail.
	d) To run, ensure that you are in the same directory as all the files, for e.g. in the adult dataset, navigate to the Folder `Adult' and run the following command in the terminal:

	scasp find_path.pl -s0
	e) The Return value will be all possible paths. The variables from Z1-ZN are the plausibility constraints: 0- Immutable through direct actions; 1- Direct Actions can change the value, for e.g., in the adult dataset, A and A1 correspond to Marital Status. If Z1 = 0, A direct actions cannot change the value of A i.e. if A has value `never_married', then no direct action can change the value.


2) is Counterfactual
	a) This is the proof of concept obtain all sets of counterfactuals. (You can use all the domain but we have restricted our domains to few value as the time taken to obtain solutions increases as the number of domain values increase.
	b) is_counterfactual.pl contains the function is_counterfactual() that will return the counterfactuals if the variables are unassigned
	c) If the vairables have a specific value provided,  is_counterfactual() returns TRUE if the instance is a counterfactual