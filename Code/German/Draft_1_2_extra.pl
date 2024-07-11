#include('Draft_1_2.pl').


% Domain: 
    % We have restricted the domain to- present_employment_since:  { 'unemployed', '<1_year'}
        f_domain(present_employment_since, 'unemployed').
        f_domain(present_employment_since, '<1_year').
        
        %f_domain(present_employment_since, '1=<_and_<4_years').
        %f_domain(present_employment_since, '4=<_and_<7_years').
        %f_domain(present_employment_since, '>=7_years').


    % We have restricted the domain to- job: {'unemployed/unskilled-non-resident', 'official/skilled-employee'}
        f_domain(job, 'unemployed/unskilled-non-resident').
        f_domain(job, 'official/skilled-employee').
        
        %f_domain(job, 'unskilled-resident'). 
        %f_domain(job, 'management/self-employed/highly qualified employee/officer').





% Properties:
    
    % present_employment_since
        %   #show lite_present_employment_since/2, not lite_present_employment_since/2.
           #show present_employment_since/3.
        % Produces a binding for every timestamp so we remove the domain of time declaration

        not_lite_present_employment_since(X,Y):- f_domain(present_employment_since,Z) , lite_present_employment_since(X, Z), Z\=Y.
        lite_present_employment_since(X,Y):- not not_lite_present_employment_since(X,Y).
        present_employment_since(X,Y):-f_domain(present_employment_since,Y) ,lite_present_employment_since(X,Y).
        %?- present_employment_since(1,Y).



    % job
        %   #show lite_job/2, not lite_job/2.
        %   #show job/2.
        % Produces a binding for every timestamp so we remove the domain of time declaration

        not_lite_job(X,Y):- f_domain(job,Z) , lite_job(X, Z), Z\=Y.
        lite_job(X,Y):- not not_lite_job(X,Y).
        job(X,Y):-f_domain(job,Y) ,lite_job(X,Y).
        %?- job(1,Y).
