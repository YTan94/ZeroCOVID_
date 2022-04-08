clear all
clc

% load parameter setting
run Fujian_param_setting


Num_fit=405;
runs=100000;
nSelectFitting=1000;
options=optimset('Display','final','MaxIter', 20000, 'MaxFunEvals',1000000,'TolX',1e-6,'TolCon',1e-6,'Tolfun',1e-6);

par1=[0.0611   15.0220    8.7054 1]; %change par1(4) to change percentage of tracing
paraT=[   3  4 5];

for j=1:length(paraT) 

par2(7) = paraT(j);



SSR=zeros(runs,1);
daily_case_sim=zeros(runs,length(FJ_case));



beta=par1(1);
c1=par1(2);
c2=par1(3);
alpha=1;
c_alpha=par1(4);


c_d1=c_alpha*(c2*2-2.676);
c_s1=c_d1*(c_d1-1);



T_stage1=8;
%% free transmission stage
tn0=0:0.1:T_stage1;

x0=[S0;E0;I10;A0;I20;R0];

options_ode = odeset('NonNegative',1:6,'RelTol',1e-8,'AbsTol',1e-8,'Refine',6);
[T0,X0] = ode45(@Zero_s1_Fujian,tn0,x0,options_ode,par1, par2);

S_T1=X0(end,1);
E_T1=X0(end,2);
I1_T1=X0(end,3);
A_T1=X0(end,4);
I2_T1=X0(end,5);
R_T1=X0(end,6);

% %% calculation of updated initial value at T1
     %M_Id  M_I1  M_I2  M_A  M_Q 
par3=[  5     3     1    1    0      ];
M_Id_T1=par3(1);  
M_I1_T1=par3(2);  
M_I2_T1=par3(3);  
M_A_T1=par3(4);  
M_Q_T1=par3(5); 

Z_s_T1=M_Id_T1*(c_d1*(1-beta)); % only trace primary contacts on the first day
Z_E_T1=M_Id_T1*(c_d1*beta)*tau_1/(tau_1+tau_2);
Z_I1_T1=M_Id_T1*(c_d1*beta)*tau_2*a/(tau_1+tau_2);
Z_A_T1=M_Id_T1*(c_d1*beta)*tau_2*(1-a)/(tau_1+tau_2);

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
[T1,X1] =ode45(@Zero_s2_Fujian,[1:0.1:Num_fit],x1,[],par1,par2,options_ode2);

N_p=X1(:,1)+X1(:,2)+X1(:,3)+X1(:,4);
Z_PCR=1/T*(N-X1(:,13));

M_A=X1(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X1(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X1(:,5)*alpha_2/gamma_I2/2;
M_Q=eta*X1(:,8);

daily_new_model_sim=M_A+M_I1+M_I2+M_Q;
%%

X_city_wide_case(:,j)=[5;daily_new_model_sim];
X_city_wide_iso(:,j)=[0;X1(:,13)];

TT=Num_fit*10-10;
plot((1:length(X_city_wide_case(1:TT,j)))+9, X_city_wide_case(1:TT,j) ,'color',[0.4940 0.1840 0.5560],'linewidth',1.5)
hold on
end

legend('T=3', 'T=4','T=5')

save X_city_wide_case_c100 X_city_wide_case
save X_city_wide_iso_c100 X_city_wide_iso






