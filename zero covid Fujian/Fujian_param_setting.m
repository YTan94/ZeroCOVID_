% parameter setting for Fujian data
clear;
FJ_data = xlsread('Zero_Fujian_data');

FJ_case=FJ_data(:,4+1);
FJ_daily_case=FJ_data(:,3+1);
data0=length(FJ_case);
FJ_isolated=FJ_data(:,5+1);

%       %        b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2     P_D    gamma_I2  alpha_2 
% par2=[2222732767 0.75   2      2    0.8   1/6  3  28    0.67    1     7       11     2.34 1.32  7   15      0.18   2        1];

% fixed parameter
N=222273276;
b=0.75;
tau_1=2;
tau_2=2;
a=0.8;
gamma_A=1/6;
T=3;
T_Q=28;
eta=0.67;
gamma_d=7;
gamma_H=11;
xi1=2.34;
xi2=1.32;
u1=7;
u2=15;
p_D=0.18;
p_H=0.01;
gamma_I2=2;
alpha_2=1;

par2=[N;b;tau_1;tau_2;a;gamma_A;T;T_Q;eta;p_H;gamma_d;gamma_H;xi1;xi2;u1;u2;p_D;gamma_I2;alpha_2];

%initial state
S0=par2(1)-1;
E0=1;
I10=0;
A0=0;
I20=0;
R0=0;
