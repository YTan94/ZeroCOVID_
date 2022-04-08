clear all
clc
%using new estimation

runs=1000;
%PRCC_var={'gamma_I2','eta','T0','c_tra_prop','T','alpha'};%
PRCC_var={'T0','T','alpha','eta','gamma_I2','c_tra_prop'};%
Num_fit=60;

FJ_data = xlsread('Zero_Fujian_data');

FJ_case=FJ_data(:,4+1);
FJ_daily_case=FJ_data(:,3+1);
data0=length(FJ_case);
FJ_isolated=FJ_data(:,5+1);


%PRCC_var={'T0','T','alpha','eta','gamma_I2','c_tra_prop'};%

   gamma_I2_LHS=LHS_Call(1, 4, 5, 0 ,runs,'unif'); %1
%    alpha_2_LHS=LHS_Call(0.2    ,1,1, 0 ,runs,'unif'); %1
   eta_LHS=LHS_Call(0.1 ,0.5,1, 0 ,runs,'unif'); %2
   T0_LHS=LHS_Call(5,8,12 , 0 ,runs,'unif');%3
   c_tra_prop_LHS=LHS_Call(0.4  ,0.7, 1, 0 ,runs,'unif');%4
   T_LHS=LHS_Call(1, 3, 7, 0 ,runs,'unif');%5
   alpha_LHS=LHS_Call(0.4 , 0.6, 1, 0 ,runs,'unif'); %6


   LHSmatrix=[  T0_LHS T_LHS alpha_LHS eta_LHS gamma_I2_LHS  c_tra_prop_LHS  ];



 %     N   b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2        P_D


%least
par1=[ 0.0611   15.0220    8.7054 ];

beta=par1(1);
c1=par1(2);
c2=par1(3);


for x=1:runs   

    T_stage1=LHSmatrix(x,1);

N=222273276;
b=0.75;
tau_1=2;
tau_2=2;
a=0.8;
gamma_A=1/6;
T=LHSmatrix(x,2);
T_Q=28;
eta=LHSmatrix(x,4) ;
gamma_d=7;
gamma_H=11;
xi1=2.34;
xi2=1.32;
u1=7;
u2=15;
p_D=0.18;
p_H=0.01;
gamma_I2=LHSmatrix(x,5);
alpha_2=1;
alpha=LHSmatrix(x,3);
c_alpha = LHSmatrix(x,6);

par2=[N;b;tau_1;tau_2;a;gamma_A;T;T_Q;eta;p_H;gamma_d;gamma_H;xi1;xi2;u1;u2;p_D;gamma_I2;alpha_2;alpha;c_alpha];


%c_s=c_d*(c_d-1);
c_d=c_alpha*(c2*2-2.676);
c_s=c_d*(c_d-1);

S0=par2(1)-1;
E0=1;
I10=0;
A0=0;
I20=0;
R0=0;

tn0=0:0.1:T_stage1;

x0=[S0;E0;I10;A0;I20;R0];

options_ode = odeset('NonNegative',1:6,'RelTol',1e-8,'AbsTol',1e-8,'Refine',6);
[T0,X0] = ode45(@Zero_s1_Fujian,tn0,x0,[],par1, par2);

S_T1=X0(end,1);
E_T1=X0(end,2);
I1_T1=X0(end,3);
A_T1=X0(end,4);
I2_T1=X0(end,5);
R_T1=X0(end,6);



%% calculation of updated initial value at T1

     %M_Id  M_I1  M_I2  M_A  M_Q 
par3=[  5     3     1    1    0      ];
M_Id_T1=par3(1);  
M_I1_T1=par3(2);  
M_I2_T1=par3(3);  
M_A_T1=par3(4);  
M_Q_T1=par3(5); 

Z_s_T1=M_Id_T1*(c_d*(1-beta)); % only trace primary contacts on the first day
Z_E_T1=M_Id_T1*(c_d*beta)*tau_1/(tau_1+tau_2);
Z_I1_T1=M_Id_T1*(c_d*beta)*tau_2*a/(tau_1+tau_2);
Z_A_T1=M_Id_T1*(c_d*beta)*tau_2*(1-a)/(tau_1+tau_2);

S_T1=S_T1-Z_s_T1;
E_T1=E_T1-Z_E_T1;
I1_T1=I1_T1-Z_I1_T1-M_I1_T1;
A_T1=A_T1-Z_A_T1-M_A_T1;
I2_T1=I2_T1-M_I2_T1;
Q_s_T1=Z_s_T1;
Q_E_T1=Z_E_T1;
Q_I_T1=Z_A_T1+Z_I1_T1;
Id_T1=M_I1_T1+M_A_T1+M_I2_T1+M_Q_T1;
H_T1=0;
R_T1=0;
D_T1=0;
Q_T1=Z_s_T1+Z_E_T1+Z_I1_T1+Z_A_T1+M_I1_T1+M_A_T1+M_I2_T1;



T_Q=Z_s_T1+Z_E_T1+Z_I1_T1+Z_A_T1;
M_Id=M_Id_T1;
x1=[S_T1 E_T1 I1_T1 A_T1 I2_T1 Q_s_T1 Q_E_T1 Q_I_T1 Id_T1 H_T1 R_T1 D_T1 Q_T1 Id_T1 T_Q M_Id];


options_ode2 = odeset('NonNegative',1:16,'RelTol',1e-8,'AbsTol',1e-8);
[T1,X1] =ode45(@Zero_s2_Fujian,[1:0.1:Num_fit],x1,[],par1,par2);
%[T1,X1] = ode45(@Zero_s2,tn1,x1,options_ode2,par1, par2,c_d,c_s);

N_p=X1(:,1)+X1(:,2)+X1(:,3)+X1(:,4);
Z_PCR=1/T*(N-X1(:,13));

M_A=X1(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X1(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X1(:,5)*alpha_2/gamma_I2 /2;
M_Q=eta*X1(:,8);

daily_new_model_sim=M_A+M_I1+M_I2+M_Q;



Idnew=[X1(1,14);daily_new_model_sim];

z1=X1(end,14);
z2=X1(end,13);
z3=max(Idnew);

%  [maxinf1,ri1] = max(Idnew);      %finds row where peak number of infections occur ri = row
%         z4 = tt(ri1);      
% [mininf1,riinf]=min(Idnew(12:end));      %finds row where peak number of infections occur ri = row
%         z5 = tt(riinf);      


cumu_cases(:,x)=(z1);
cumu_quaran(:,x)=(z2);
peak_cases(:,x)=(z3);



end



y_var={'Cumulative Cases'};
PRCC_PLOT2(LHSmatrix,cumu_cases,PRCC_var,y_var)
% eval(['name_figure1 = ','''','cumu_cases_tot_nor_phase2_noW'''])
% eval(['print(','''', char(name_figure1),'''',',','''','-djpeg','''',',','''','-r0','''', ');'])
% eval(['saveas(gcf,','''',char(name_figure1),'.fig','''',')']) 

y_var={'Cumulative Quarantined'};
PRCC_PLOT2(LHSmatrix,cumu_quaran,PRCC_var,y_var)


y_var={'Peak of cases'};
PRCC_PLOT2(LHSmatrix,peak_cases,PRCC_var,y_var)
