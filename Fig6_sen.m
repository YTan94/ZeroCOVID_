clear all
clc
runs=1000;
PRCC_var={'alpha','T','c_tra_prop','T0', 'eta'};%

% FJ_data = xlsread('Zero_China_data','Sheet2');
% 
% FJ_case=FJ_data(1:17,4);
% FJ_daily_case=FJ_data(1:17,3);
% FJ_q=FJ_data(1:13+4,6);
% data0=length(FJ_case);
% FJ_daily_q=FJ_data(1:16,5);
% 
%   alpha_LHS=LHS_Call(0.0001,0.6, 1, 0 ,runs,'unif'); %1
%   T_LHS=LHS_Call(2,3, 7, 0 ,runs,'unif');%2
%   c_tra_prop_LHS=LHS_Call(0.0001,0.5, 1, 0 ,runs,'unif');%3
%  T0_LHS=LHS_Call(6,10,14, 0 ,runs,'unif');%4
%    eta_LHS=LHS_Call(0.0001,0.5,1, 0 ,runs,'unif'); %5
% b_LHS=LHS_Call(0.74,0.75, 76, 0 ,runs,'unif');%6
% a_LHS=LHS_Call(0.78,0.8, 0.85, 0 ,runs,'unif');%7
% 
% alpha_LHS=LHS_Call(0.0001,0.6, 1, 0 ,runs,'unif'); %1
%   T_LHS=LHS_Call(2,3, 7, 0 ,runs,'unif');%2
%   c_tra_prop_LHS=LHS_Call(0.4,0.7, 1, 0 ,runs,'unif');%3
%   T0_LHS=LHS_Call(5,10,14, 0 ,runs,'unif');%4
%    eta_LHS=LHS_Call(0.2,0.5,1, 0 ,runs,'unif'); %5
% %  LHSmatrix=[alpha_LHS T_LHS c_tra_prop_LHS  T0_LHS eta_LHS b_LHS a_LHS];
%   LHSmatrix=[alpha_LHS T_LHS c_tra_prop_LHS T0_LHS  eta_LHS];

  alpha_LHS=LHS_Call(0.0001,0.6, 1, 0 ,runs,'unif'); %1
  T_LHS=LHS_Call(2,3, 7, 0 ,runs,'unif');%2
  c_tra_prop_LHS=LHS_Call(0.4,0.7, 1, 0 ,runs,'unif');%3
  T0_LHS=LHS_Call(5,10,14, 0 ,runs,'unif');%4
   eta_LHS=LHS_Call(0.2,0.5,1, 0 ,runs,'unif'); %5
%  LHSmatrix=[alpha_LHS T_LHS c_tra_prop_LHS  T0_LHS eta_LHS b_LHS a_LHS];
  LHSmatrix=[alpha_LHS T_LHS c_tra_prop_LHS T0_LHS  eta_LHS];



 %     N   b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2        P_D


%least
par1=[0.0977   16.1683   10.9893   17.9999    0.0036];

beta=par1(1);
c1=par1(2);
c2=par1(3);
%c_d=par1(4);
p_H=par1(5);
for x=1:runs   
   % x
%     par2=[4559797 LHSmatrix(x,6)  2      2    LHSmatrix(x,7)   1/6  LHSmatrix(x,2)  21    LHSmatrix(x,5)   LHSmatrix(x,1)     7       13     2.34 1.32  7   15      0.278   ];
     par2=[4559797 0.75  2      2    0.8   1/6  LHSmatrix(x,2)  21    LHSmatrix(x,5)   LHSmatrix(x,1)     7       13     2.34 1.32  7   15      0.278   ];
   
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
%c_s=c_d*(c_d-1);
c_tra_prop=LHSmatrix(x,3); %change LHS
c_d=c_tra_prop*c1*2;
c_s=c_d*(c1-1);

S0=par2(1)-1;
E0=1;
I10=0;
A0=0;
I20=0;
R0=0;

tn0=0:0.1:LHSmatrix(x,4);

x0=[S0;E0;I10;A0;I20;R0];

options_ode = odeset('NonNegative',1:6,'RelTol',1e-8,'AbsTol',1e-8,'Refine',6);
[T0,X0] = ode45(@Zero_s1,tn0,x0,options_ode,par1, par2);

S_T1=X0(end,1);
E_T1=X0(end,2);
I1_T1=X0(end,3);
A_T1=X0(end,4);
I2_T1=X0(end,5);
R_T1=X0(end,6);



%% calculation of updated initial value at T1

     %M_Id  M_I1  M_I2  M_A  M_Q 
% par3=[  5     3     1    1    0      ];
par3=[  1     0     1    0   0      ];

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

%% zero policy
T_Q=Z_s_T1+Z_E_T1+Z_I1_T1+Z_A_T1;
M_Id=M_Id_T1;
x1=[S_T1 E_T1 I1_T1 A_T1 I2_T1 Q_s_T1 Q_E_T1 Q_I_T1 Id_T1 H_T1 R_T1 D_T1 Q_T1 Id_T1 T_Q M_Id];

clear ode
clear Idnew
clear X_city_wide
l=0;
tn1=1:0.1:T;
options_ode2 = odeset('NonNegative',1:16,'RelTol',1e-8,'AbsTol',1e-8);
%options_ode2 = odeset('NonNegative',1:14);
[T1,X1] = ode45(@Zero_s2,tn1,x1,options_ode2,par1, par2,c_d,c_s);

x2=X1(end,:);
tn2=1:0.1:T+1;
ode{1,:}=X1;


for i=2:313
    
    [T2,X2] = ode45(@Zero_s2,tn2,x2,options_ode2,par1, par2,c_d,c_s);
    X2(1,:)=[];
    T2(1)=[];
    ode{i,:}=X2;
    l=l+1;  
N_p=X2(:,1)+X2(:,2)+X2(:,3)+X2(:,4)+X2(:,5);
Z_PCR=1/T*(N-X2(:,13));

M_A=X2(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X2(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X2(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X2(:,8);

M_Id=M_A+M_I1+M_I2;

Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

Qnew=M_A+M_I1+M_I2+Z_s+Z_E+Z_I1+Z_A;
    
Idnew=    M_A+M_I1+M_I2+M_Q;   
if floor(Qnew(end))-floor(Qnew(end-1))~=0 & floor(Idnew(end))~=0
        tn2=tn2+T+1;
        x2=X2(end,:);
else
    
        break
    end
end



X_city_wide=cell2mat(ode);

Idnew=diff(X_city_wide(:,14));

Idnew=[X_city_wide(1,14);Idnew];

z1=X_city_wide(end,14);
z2=X_city_wide(end,13);
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
