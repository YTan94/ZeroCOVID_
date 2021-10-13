function [value,isterminal,direction] = event_function(t,X3)

%load('initial_I.mat')

% N_start=initial_I;
% value = X3(2)+X3(3)+X3(4)+X3(5) - N_start;  % when value = 0, an event is triggered

par1=[0.1  10    2956024];
      %b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2     P_H    P_D
par2=[0.75   2      2    0.7   1/6  3   21    0.77    0.5    6       13     2.34 1.32  7   15   0.289   0.278   ];

eta=par2(8);
alpha=0.5;

N_start=800;

value = X3(4)*eta*alpha+X3(3)*eta*alpha+X3(5)*alpha - N_start;  % when value = 0, an event is triggered
isterminal = 1; % terminate after the first event
direction = 0;  % get all the zeros
end
