%% Omicron transmission, Fujian
clear
% load parameter setting
run Fujian_param_setting

% par1=[0.13   13.8   9.5125   0.6  0.2  0.3  9];
load PAR1_FJ_1000_1
load par1_FJ_mean_1
n_T=length(par_est);
Num_fit=29;
% Num_fit=100;

N_sim=length(1:0.1:Num_fit);
daily_new_model_sim=zeros(n_T,N_sim);
daily_new_model_day_sim=zeros(n_T,Num_fit);
L_sim=zeros(n_T,1);
Isolated_sim=zeros(n_T,Num_fit);
Isolated_sim_2=zeros(n_T,N_sim);
parfor j=1:n_T
    
par1=par_est(j,:);

beta=par1(1);
c1=par1(2);
c2=par1(3);
alpha=1;
c_alpha=1;
% c_d=c1*2;
% c_s=c_d*(c1-1);

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

Isolated_sim(j,:)=X1(1:10:end,13);
daily_new_model=[FJ_daily_case(1);diff(X1(:,14))];
daily_new_model_day=[FJ_daily_case(1);diff(X1(1:10:end,14))];
daily_new_model_day_sim(j,:)=daily_new_model_day;

Isolated_sim_2(j,:)=X1(:,13);

N_p=X1(:,1)+X1(:,2)+X1(:,3)+X1(:,4);
Z_PCR=1/T*(N-X1(:,13));

M_A=X1(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X1(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X1(:,5)*alpha_2/gamma_I2/2;
M_Q=eta*X1(:,8);

daily_new_model_sim(j,:)=M_A+M_I1+M_I2+M_Q;

end


ode_test1=quantile(daily_new_model_sim,0.5,1);
YY_daily_new=quantile(daily_new_model_sim,[ 0.025 0.5 0.975],1);
daily_new_model_sim_day=daily_new_model_sim(:,1:10:end);


% YY_daily_new_day=quantile(daily_new_model_day_sim,[ 0.025 0.5 0.975],1);
% Isolated_quantile=quantile(Isolated_sim,[ 0.025 0.5 0.975],1);

Isolated_quantile_2=quantile(Isolated_sim_2,[ 0.025 0.5 0.975],1);


% A=[5;5;5];
% YY_daily_new = [A, YY_daily_new];

figure(1);clf
subplot(211);
time_plot=1:1:N_sim;


xconf = [time_plot time_plot(end:-1:1)] ;%????         
yconf = [ YY_daily_new(1,1:1:N_sim) YY_daily_new(3,N_sim:-1:1)];




p = fill(xconf+9,yconf,'r','FaceColor',[0.28235 0.81961 0.8],'EdgeColor','none','FaceAlpha','0.5');
hold on

A=[5;5;5]
YY_daily_new=[A,YY_daily_new]

plot((1:length(YY_daily_new(1,:)))+9,YY_daily_new(2,:),'LineWidth', 3,'color',[0.18039 0.5451 0.34118])


hold on
for j=1:29
    plot(j*10,FJ_daily_case(j),'ob','color',[0.13333 0.5451 0.13333])
end


length(FJ_daily_case)

% xlim([0 30])
% ylim([0 80])

%xlabel('2022')
ylabel('Daily new reported cases')
set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
xticks([1 91 191 291])
xticklabels({'Sep 10','Sep 19','Sep 29','Oct 9'})
xlim([0 291])

% xticks([1 10 20 30 59])
% xticklabels({'Sep 10','Sep 19','Sep 29','Oct 9','Nov 7'})


title('Fujian Province')


subplot(212)

yyconf = [Isolated_quantile_2(1,1:1:N_sim) Isolated_quantile_2(3,N_sim:-1:1)];


p = fill(xconf+9,yyconf,'r','FaceColor',[0.95686 0.64314 0.37647],'EdgeColor','none','FaceAlpha','0.5');
hold on

% hold on
% plot(1:1:data0,FJ_isolated,'ob')

for j=1:29
    plot(j*10,FJ_isolated(j),'ob','color',[0.82353 0.41176 0.11765])
end


xlim([0 291])
xlabel('2022')
ylabel('Cumulative isolated people')

B=[0;0;0]
Isolated_quantile_2 = [B,Isolated_quantile_2]

hold on
plot((1:length(Isolated_quantile_2(1,:)))+9,Isolated_quantile_2(2,:),'LineWidth', 3,'color',[0.8500 0.3250 0.0980])

xticks([1 91 191 291])
xticklabels({'Sep 10','Sep 19','Sep 29','Oct 9'})

yticks([0 10000 20000   30000 40000 50000])
yticklabels({'0','10k','20k','30k','40k','50k'})

set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)


% eval(['name_figure1 = ','''','Predicting_Fujian'''])
% eval(['print(','''', char(name_figure1),'''',',','''','-djpeg','''',',','''','-r600','''', ');'])
% eval(['saveas(gcf,','''',char(name_figure1),'.fig','''',')'])








