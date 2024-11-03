clc
clear
close all

%% Task 1

%weight U = w1*g1 + w2*g2
%0.7*(3x1 + 5x2) + 0.3x1
%2.4x1 + 3.5x2 = U

namesa = {'X1'; 'X2'};
model_lab06a.obj = [2.4 3.5];

a1 = [2 1];
a2 = [1 2]; 
a3 = [0 1];
model_lab06a.A = sparse([a1;a2;a3]);

model_lab06a.rhs = [230 250 120];
model_lab06a.sense = '<<<'; %in/equality in all of 3 constraints, eq. <==, <>=

model_lab06a.vtype = 'I'; %Integers

% Definition of notation
% 'C' -> Continuous
% 'B' -> Binary
% 'I' -> Integers
% 'S' -> Semi-continuous
% 'N' -> Semi-integers

model_lab06a.modelsense = 'max'; %minimization or maximization

model_lab06a.varnames = namesa;

% The following command saves the model in a lp format file
gurobi_write(model_lab06a, 'lab06a.lp');

params.outputflag = 0;

resulta = gurobi(model_lab06a, params);

%% Task 2

% 1st scenario - prio to g1
%max 𝑔1 = 3𝑥1 + 5𝑥2

namesb = {'X1'; 'X2'};
model_lab06b.obj = [3 5];

a1 = [2 1];
a2 = [1 2]; 
a3 = [0 1];
model_lab06b.A = sparse([a1;a2;a3]);

model_lab06b.rhs = [230 250 120];
model_lab06b.sense = '<<<'; %in/equality in all of 3 constraints, eq. <==, <>=

model_lab06b.vtype = 'I'; %Integers

model_lab06b.modelsense = 'max'; %minimization or maximization

model_lab06b.varnames = namesb;

gurobi_write(model_lab06b, 'lab06b.lp');

params.outputflag = 0;

resultb = gurobi(model_lab06b, params);


namesc = {'X1'; 'X2'};
model_lab06c.obj = [1 0];

a1 = [2 1];
a2 = [1 2]; 
a3 = [0 1];
a4 = [3 5];
model_lab06c.A = sparse([a1;a2;a3;a4]);

model_lab06c.rhs = [230 250 120 resultb.objval];
model_lab06c.sense = '<<<>'; %in/equality in all of 3 constraints, eq. <==, <>=

model_lab06c.vtype = 'I'; %Integers

model_lab06c.modelsense = 'max'; %minimization or maximization

model_lab06c.varnames = namesc;

gurobi_write(model_lab06c, 'lab06c.lp');

params.outputflag = 0;

resultc = gurobi(model_lab06c, params);


% 2nd scenario - prio to g2
%max 𝑔2 = 𝑥1

namesd = {'X1'; 'X2'};
model_lab06d.obj = [1 0];

a1 = [2 1];
a2 = [1 2]; 
a3 = [0 1];
model_lab06d.A = sparse([a1;a2;a3]);

model_lab06d.rhs = [230 250 120];
model_lab06d.sense = '<<<'; %in/equality in all of 3 constraints, eq. <==, <>=

model_lab06d.vtype = 'I'; %Integers

model_lab06d.modelsense = 'max'; %minimization or maximization

model_lab06d.varnames = namesd;

gurobi_write(model_lab06d, 'lab06d.lp');

params.outputflag = 0;

resultd = gurobi(model_lab06d, params);


namesc = {'X1'; 'X2'};
model_lab06e.obj = [3 5];

a1 = [2 1];
a2 = [1 2]; 
a3 = [0 1];
a4 = [1 0];
model_lab06e.A = sparse([a1;a2;a3;a4]);

model_lab06e.rhs = [230 250 120 resultd.objval];
model_lab06e.sense = '<<<>'; %in/equality in all of 3 constraints, eq. <==, <>=

model_lab06e.vtype = 'I'; %Integers

model_lab06e.modelsense = 'max'; %minimization or maximization

model_lab06e.varnames = namesb;

gurobi_write(model_lab06e, 'lab06e.lp');

params.outputflag = 0;

resulte = gurobi(model_lab06e, params);

%% Task 3

%Ideal point is 660 for g1, 115 for g2, H = (660, 115)
%Nadir point is 345 and 70, L = (345, 70)

%% Task 4

%unweighted = equal weights, w1 = w2 = 0.5
%0.5((660-3x1-5x2)/660) - z <= 0
%0.5((115-x1)/115) - z <= 0

namesf = {'X1'; 'X2'; 'z'};
model_lab06f.obj = [0 0 1];

w1 = 0.5;
w2 = 0.5;
%w1 + w2 = 1

a1 = [2 1 0];
a2 = [1 2 0]; 
a3 = [0 1 0];
a4 = [-w1*3 -w1*5 -660*1];
a5 = [-w2*1 -w2*0 -115*1];
model_lab06f.A = sparse([a1;a2;a3;a4;a5]);

model_lab06f.rhs = [230 250 120 -w1*660 -w2*115];
model_lab06f.sense = '<<<<<'; %in/equality in all of 3 constraints, eq. <==, <>=

model_lab06f.modelsense = 'min'; %minimization or maximization

model_lab06f.varnames = namesf;

gurobi_write(model_lab06f, 'lab06f.lp');

params.outputflag = 0;

resultf = gurobi(model_lab06f, params);
criteria = [3*resultf.x(1,1)+5*resultf.x(2,1); resultf.x(1,1)];

%% Task 5

%for loop for each value of value w1 and w2, step 100

step = 0:100:1000; % Define a range of values for w1, assuming step size 100

Pareto_points = zeros(2, numel(step)); % Preallocate Pareto_points

for i = 1:numel(step)
    w1 = step(i)/1000; 
    w2 = 1 - w1;
    model_lab06g.obj = [0 0 1];
    a1 = [2 1 0];
    a2 = [1 2 0]; 
    a3 = [0 1 0];
    a4 = [-w1*3 -w1*5 -660*1];
    a5 = [-w2*1 -w2*0 -115*1];
    model_lab06g.A = sparse([a1; a2; a3; a4; a5]);
    model_lab06g.rhs = [230 250 120 -w1*660 -w2*115];
    model_lab06g.sense = '<<<<<';
    model_lab06g.modelsense = 'min'; 
    params.outputflag = 0;
    resultg = gurobi(model_lab06g, params);
    Pareto_points(:,i) = [3*resultg.x(1,1) + 5*resultg.x(2,1); resultg.x(1,1)];
end

% Plot Pareto points
plot(Pareto_points(1,:), Pareto_points(2,:), '-o');
xlabel('g1');
ylabel('g2');
title('Pareto Points');
grid on;

%you can add here Nadir and Ideal and optimal points using scatter
