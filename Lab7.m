clc
clear
close all

%% Task 1

%this is multi objective programming
%either define a priority for lexiographic approch or weighted average

model_lab05_1.varnames = {'x1'; 'x2';};

Objectives = [2 -1; 0 1];
SetObjPriority = [1; 1]; %both have the same prio, when changing to 1; 2 - different result, higher prio = 2
SetObjWeight = [0.7; 0.3];

for m = 1:size(Objectives, 1) %structured array for m from 1 to 2 (obj functions)
    model_lab05_1.multiobj(m).objn      = Objectives(m, :);
    model_lab05_1.multiobj(m).priority  = SetObjPriority(m);
    model_lab05_1.multiobj(m).weight    = SetObjWeight(m);
end

model_lab05_1.modelsense = 'max';
model_lab05_1.A = sparse([-1 1; 2 1; 0 1]);
model_lab05_1.rhs = [4; 14; 6];
model_lab05_1.sense = repmat('<', 1, 3);
gurobi_write(model_lab05_1, 'model_lab05_1.lp');

params.outputflag = 0;
MOP = gurobi(model_lab05_1, params);

% We solved the model U = 0.7 * g1 + 0.3 * g2 = 
% 0.7(2*x1 - x2) + 0.3(x2)
% the prio is the same, so we are using weights 

%objval have 2 values - for g1 and g2
%x have 2 values - x1 and x2

%% Task 2 - g1

%Let t(x1+3x2+4)=1 -> x1*t+3x2*t+4t=1 -> y1+3y2+4t=1 -> s.t
%g1' = 2x1*t - x2*t - 2t
%g1' = 2y1 - y2 - 2t -> max

%rest of constraints we should multiply by t
% -y1+y2-4t <= 0
% 2y1+y2-14t <= 0
% y2-6t <= 0
% y1,y2,t >= 0

model_lab05_2.varnames = {'y1'; 'y2'; 't';};

Objectives = [2 -1 -2];
SetObjPriority = 1; %both have the same prio, when changing to 1; 2 - different result, higher prio = 2
SetObjWeight = 1;

for m = 1:size(Objectives, 1) %structured array for m from 1 to 2 (obj functions)
    model_lab05_2.multiobj(m).objn      = Objectives(m, :);
    model_lab05_2.multiobj(m).priority  = SetObjPriority(m);
    model_lab05_2.multiobj(m).weight    = SetObjWeight(m);
end

model_lab05_2.modelsense = 'max';
model_lab05_2.A = sparse([1 3 4; -1 1 -4; 2 1 -14; 0 1 -6]);
model_lab05_2.rhs = [1; 0; 0; 0];
model_lab05_2.sense = '=<<<';
gurobi_write(model_lab05_2, 'model_lab05_2.lp');

params.outputflag = 0;
MOP = gurobi(model_lab05_2, params);

%y1 = x1*t -> x1 = y1/t
%y2 = x2*t -> x2 = y2/t

x1 = MOP.x(1)/MOP.x(3);
x2 = MOP.x(2)/MOP.x(3);

%% Task 2 - g2

%Let t(x2+1)=1 -> x2*t+t=1 -> y2+t=1 -> s.t
%g2' = x1*t
%g2' = y1 -> max

%rest of constraints we should multiply by t
% -y1+y2-4t <= 0
% 2y1+y2-14t <= 0
% y2-6t <= 0
% y1,y2,t >= 0

model_lab05_3.varnames = {'y1'; 'y2'; 't';};

Objectives = [1 0 0];
SetObjPriority = 1; %both have the same prio, when changing to 1; 2 - different result, higher prio = 2
SetObjWeight = 1;

for m = 1:size(Objectives, 1) %structured array for m from 1 to 2 (obj functions)
    model_lab05_3.multiobj(m).objn      = Objectives(m, :);
    model_lab05_3.multiobj(m).priority  = SetObjPriority(m);
    model_lab05_3.multiobj(m).weight    = SetObjWeight(m);
end

model_lab05_3.modelsense = 'max';
model_lab05_3.A = sparse([0 1 1; -1 1 -4; 2 1 -14; 0 1 -6]);
model_lab05_3.rhs = [1; 0; 0; 0];
model_lab05_3.sense = '=<<<';
gurobi_write(model_lab05_3, 'model_lab05_3.lp');

params.outputflag = 0;
MOP = gurobi(model_lab05_3, params);

%y1 = x1*t -> x1 = y1/t
%y2 = x2*t -> x2 = y2/t

x1 = MOP.x(1)/MOP.x(3);
x2 = MOP.x(2)/MOP.x(3);

%% Task 2 - g1 and g2

%I(I1, I2)
%min delta
%(I1-g1)/I1 <= delta 
%(I2-g2)/I2 <= delta

%delta => z

% g1: -I1zx1 - 3I1zx2 + (I1 - 2)x1 + (3I1 + 1)x2 - 4I1z <= - 4I1 - 2
% g2: I2x2 - x1 - zI2x2 - zI2 <= -I2

model_lab07d.varnames = {'x1'; 'x2'; 'z'};

model_lab07d.obj = [0 0 1];

I = [7, 0]; %from previous task

% −𝑥1+𝑥2≤4 2𝑥1+𝑥2≤14 𝑥2≤6
a1=[-1 1 0]; 
a2=[2 1 0];
a3=[0 1 0];
model_lab07d.A = sparse([a1;a2;a3]);

model_lab07d.rhs = [4 14 6];
model_lab07d.sense = repmat('<',1,3);
model_lab07c.modelsense = 'min';

model_lab07d.quadcon(1).Qc = sparse([0 0 -I(1); 0 0 -3*I(1); 0 0 0]); %we can also do [0 0 -0.5*I1; 0 0 -1.5*I1; -0.5*I1 -1.5*I1 0] or cumulate -I1 and -3*I1 like we did here
model_lab07d.quadcon(1).q = [I(1)-2 3*I(1)+1 -4*I(1)]; %x1, x2, z
model_lab07d.quadcon(1).rhs = -4*I(1)-2;

model_lab07d.quadcon(2).Qc = sparse([0 0 0; 0 0 -I(2); 0 0 0]);
model_lab07d.quadcon(2).q = [-1 I(2) -I(2)];
model_lab07d.quadcon(2).rhs = -I(2);

gurobi_write(model_lab07d, 'lab07d.lp');

params.outputflag = 0;
%non convex problem = 2
params.NonConvex = 2; %By setting NonConvex to 2, you're instructing the solver to prioritize finding globally optimal solutions, even if it requires more computational resources
result_d = gurobi(model_lab07d, params);
