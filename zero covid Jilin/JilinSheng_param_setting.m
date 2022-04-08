% parameter setting for Jilin Sheng data
clear;
JLS_data = xlsread('Zero_JilinSheng_data'); % start from Mar. 4

JLS_case=JLS_data(:,4);
JLS_daily_case=JLS_data(:,3);
data0=length(JLS_case);

%% Stage setting
T_stage1=9; % free transmission stage
T_stage2=14; % March 14, 2022
T_stage3=23;  % March 23

% fixed parameter
N=24073453;
b=0.75;
tau_1=1.5;
tau_2=1.5;
a=0.6;
gamma_A=1/6.5;
T=2;
T_Q=14;
eta=0.67;
gamma_d=5;
gamma_H=7;
xi1=1;
xi2=1;
u1=8;
u2=10;
p_D=0.00008;
p_H=0.001;
gamma_I2=1;
alpha_2=1;

par2=[N;b;tau_1;tau_2;a;gamma_A;T;T_Q;eta;p_H;gamma_d;gamma_H;xi1;xi2;u1;u2;p_D;gamma_I2;alpha_2;T_stage2];

%initial state
S0=par2(1)-1;
E0=1;
I10=0;
A0=0;
I20=0;
R0=0;
