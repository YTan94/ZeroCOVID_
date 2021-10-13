clear all
clc

FJ_data = xlsread('Zero_China_data');

FJ_case=FJ_data(1:17+5,5);
FJ_daily_case=FJ_data(1:17+5,4);
data0=length(FJ_case);


     % beta                       c1   c2   P_H 
par1guess=[  0.0956475269453828   16    11.0244      0.0051];%tn0=0:0.1:6;
lb=[       0.0870                  14    9     0.0001];
ub=[       0.0977                    17     13      0.01] ;


%              b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2        P_D
par2=[2222732767 0.75   2      2    0.8   1/6  3  28    0.67    1     7       11     2.34 1.32  7   15      0.278   ];

options=optimset('Display','final','MaxIter', 20000, 'MaxFunEvals',1000000,'TolX',1e-6,'TolCon',1e-6,'Tolfun',1e-6);
[par1,fval] = fmincon(@lse_error_sol,par1guess,[],[],[],[],lb,ub,[],options,FJ_case,par2)

save par1 'par1'

beta=par1(1);
c1=par1(2);
c2=par1(3);

c_d=c1*2;
c_s=c1*(c1-1)*2;

p_H=par1(4);

N=par2(1);
b=par2(2);
tau_1=par2(3);
tau_2=par2(4);
a=par2(5);
gamma_A=par2(6);
T=par2(7);
T_Q=par2(8);
eta=par2(9);
alpha=par2(10);
gamma_d=par2(11);
gamma_H=par2(12);
xi1=par2(13);
xi2=par2(14);
u1=par2(15);
u2=par2(16);
p_D=par2(17);


S0=par2(1)-1;
E0=1;
I10=0;
A0=0;
I20=0;
R0=0;

tn0=0:0.1:6;

x0=[S0;E0;I10;A0;I20;R0];

options_ode = odeset('NonNegative',1:6,'RelTol',1e-8,'AbsTol',1e-8,'Refine',6);
[T0,X0] = ode45(@Zero_s1,tn0,x0,options_ode,par1, par2);

% X0=X0(1:10:end,1);
S_T1=X0(end,1);
E_T1=X0(end,2);
I1_T1=X0(end,3);
A_T1=X0(end,4);
I2_T1=X0(end,5);
R_T1=X0(end,6);



%% calculation of updated initial value at T1

     %M_Id  M_I1  M_I2  M_A  M_Q 
par3=[  2     1     1    0    3      ];
par3=[  5     3     1    1    0      ];


M_Id_T1=par3(1);  
M_I1_T1=par3(2);  
M_I2_T1=par3(3);  
M_A_T1=par3(4);  
M_Q_T1=par3(5); 

Z_s_T1=M_Id_T1*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);


Z_s_T1=M_Id_T1*(c_d*(1-beta)); % only trace primary contacts on the first day
Z_E_T1=M_Id_T1*(c_d*beta)*tau_1/(tau_1+tau_2);
Z_I1_T1=M_Id_T1*(c_d*beta)*tau_2*a/(tau_1+tau_2);
Z_A_T1=M_Id_T1*(c_d*beta)*tau_2*(1-a)/(tau_1+tau_2);

Z_s_T1+Z_E_T1+Z_I1_T1+Z_A_T1;

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


[T1,X1] =ode45(@Zero_s2,[0:1:length(FJ_case)-1],x1,[],par1, par2);

plot(1:1:length(X1(:,14)),X1(:,14),'r','linewidth',1.5)
hold on
plot(1:1:data0,FJ_case,'b')