clear all
clc

% load parameter setting
run JilinSheng_param_setting

runs=100000;
nSelectFitting=1000;
options=optimset('Display','final','MaxIter', 20000, 'MaxFunEvals',1000000,'TolX',1e-6,'TolCon',1e-6,'Tolfun',1e-6);


%% Setup random
rng('default');
rng(1234);

% beta_LHS=LHS_Call(0,0.13, 0, 0.03 ,runs,'norm'); %1
% c1_LHS=LHS_Call(0,13.8, 0, 3 ,runs,'norm'); %2
% c2_LHS=LHS_Call(0,10.5, 0, 2 ,runs,'norm'); %3
% alpha_LHS=abs(LHS_Call(0,0.5, 0, 0.1 ,runs,'norm')); %4
% alpha2_stage1_LHS=abs(LHS_Call(0,0.5, 0, 0.1 ,runs,'norm')); %5
% c_alpha_LHS=abs(LHS_Call(0,0.3, 0, 0.1 ,runs,'norm')); %6

%0.13   13.8   10.5125   0.7  0.41  0.3  9
beta_LHS=LHS_Call(0.09, 0.12, 0.15, 0 ,runs,'unif'); %1
c1_LHS=LHS_Call(10, 13.8, 20, 0 ,runs,'unif'); %2
c2_LHS=LHS_Call(5, 10.5, 10, 0 ,runs,'unif'); %3
alpha_LHS=abs(LHS_Call(0.3,0.5, 0.9, 0 ,runs,'unif')); %4
alpha2_stage1_LHS=abs(LHS_Call(0.3, 0.5, 0.9, 0 ,runs,'unif')); %5
c_alpha_LHS=abs(LHS_Call(0.3, 0.5, 1, 0,runs,'unif')); %6
c_alpha2_LHS=abs(LHS_Call(0.3, 0.5, 1, 0,runs,'unif')); %7
% T_stage1_LHS=3:1:12;
% T_stage1_LHS=repmat(T_stage1_LHS,1,runs/10);
par1guess=[beta_LHS c1_LHS c2_LHS alpha_LHS alpha2_stage1_LHS c_alpha_LHS c_alpha2_LHS];

lb=[0.05  5  4  0.05  0.05  0.1 0.1];
ub=[0.16  16 13 0.95 0.95 0.95 0.95];

%lb=par1guess*0.6;
%ub=par1guess*1.8;

par_N=length(lb);
PAR1=zeros(runs,par_N);
% 
% parfor i=1:runs
%      [par1,fval] = fmincon(@lse_error_sol_JLS,par1guess(i,:),[],[],[],[],lb,ub,[],options,JLS_data,par2);
%      PAR1(i,:)=par1;
% end


SSR=zeros(runs,1);
daily_case_sim=zeros(runs,length(JLS_case));
parfor i=1:runs
%     par1=PAR1(i,:);
    par1=par1guess(i,:); 
beta=par1(1);
c1=par1(2);
c2=par1(3);
alpha=par1(4);
alpha2_stage1=par1(5);
c_alpha=par1(6);

% c_d=c1*2;
% c_s=c_d*(c1-1);

c_d1=c_alpha*(c1*2-2.34);
c_s1=c_d1*(c_d1-1);

%% free transmission stage
tn0=0:0.1:T_stage1;

x0=[S0;E0;I10;A0;I20;R0];

options_ode = odeset('NonNegative',1:6,'RelTol',1e-8,'AbsTol',1e-8,'Refine',6);
[T0,X0] = ode45(@Zero_s1,tn0,x0,options_ode,par1, par2);

S_T1=X0(end,1);
E_T1=X0(end,2);
I1_T1=X0(end,3);
A_T1=X0(end,4);
I2_T1=X0(end,5);
R_T1=X0(end,6);

% %% calculation of updated initial value at T1
     %M_Id  M_I1  M_I2  M_A  M_Q 
par3=[  8     1     4    3    0      ];
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
[T1,X1_1] =ode45(@Zero_s2,[1:0.1:T_stage3],x1,[],par1,par2,options_ode2);

x2=X1_1(end,:);
par2_2=par2;
par2_2(7)=1;
[T1,X1_2] =ode45(@Zero_s2,[T1(end):0.1:length(JLS_case)],x2,[],par1,par2_2,options_ode2);
X1=[X1_1;X1_2(2:end,:)];

daily_new_model=[JLS_daily_case(1);diff(X1(1:10:end,14))];
size(daily_new_model)
size(JLS_daily_case)
daily_case_sim(i,:)=daily_new_model';
m = norm(daily_new_model-JLS_daily_case)^2;
2
SSR(i)=sum((daily_new_model-JLS_daily_case).^2)/(sum((JLS_daily_case-mean(JLS_daily_case)).^2));
    %RMSE = sqrt(mean(((x1-y1).^2)./std(x1))); % Only fit to Confirmed cases for now
    %[x,ind] = sort(RMSE);
end
 
[x,ind] = sort(SSR);
% select the best nSelectFitting (200) parameter sets based on the corresponding NMSE metric
id = ind(1:nSelectFitting); 

par_est=par1guess(id,:);

save PAR1_JLS_1000_1 'par_est'
save OLS_JLS_1

load OLS_JLS_1
% load PAR1_JLS_1000_1

daily_case_sim_select=daily_case_sim(id,:);

yy=quantile(daily_case_sim_select,[0.025 0.5 0.975],1);

figure(1);clf
plot(1:1:length(JLS_daily_case),yy(1,:),'linewidth',1.5)
hold on
plot(1:1:length(JLS_daily_case),yy(2,:),'linewidth',1.5)
hold on
plot(1:1:length(JLS_daily_case),yy(3,:),'linewidth',1.5)
hold on
plot(1:1:length(JLS_daily_case),JLS_daily_case,'ob')
set(gca,'FontSize',13,'linewidth',1.5)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
xticks([1 13 25])
xticklabels({'Mar 1','Mar 14','Mar 26'})
eval(['name_figure1 = ','''','Fitting_JilinSheng'''])
eval(['print(','''', char(name_figure1),'''',',','''','-djpeg','''',',','''','-r600','''', ');'])
eval(['saveas(gcf,','''',char(name_figure1),'.fig','''',')'])

 %% find mean
par1_mean=mean(par_est);
par1_CI=quantile(par_est,[0.025 0.5 0.975],1);
par1_var=var(par_est);
par1guess(id(1),:)
 save par1_JLS_mean_1 'par1_mean'
 save par1_JLS_var_1 'par1_var'
