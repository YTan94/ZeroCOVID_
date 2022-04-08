%% Omicron transmission, Jilin
clear
% load parameter setting
run JilinSheng_param_setting

% par1=[0.13   13.8   9.5125   0.6  0.2  0.3  9];
load PAR1_JLS_1000_1
load par1_JLS_mean_1
n_T=length(par_est);
Num_fit=61;

% Num_fit=100;
N_sim=length(1:0.1:Num_fit);
daily_new_model_sim=zeros(n_T,N_sim);
daily_new_model_day_sim=zeros(n_T,Num_fit);
daily_new_model_day_sim_2=zeros(n_T,Num_fit);

daily_new_model_2_sim=zeros(n_T,N_sim);
daily_new_model_2_day_sim=zeros(n_T,Num_fit);
daily_new_model_2_day_sim_2=zeros(n_T,Num_fit);
L_sim=zeros(n_T,1);

parfor j=1:n_T
    
par1=par_est(j,:);

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
[T1_2,X1_2] =ode45(@Zero_s2,[T1(end):0.1:length(JLS_case)],x2,[],par1,par2_2,options_ode2);

x3=X1_2(end,:);
[T1_3,X1_3] =ode45(@Zero_s2,[T1_2(end):0.1:Num_fit],x3,[],par1,par2_2,options_ode2);
X1=[X1_1;X1_2(2:end,:);X1_3(2:end,:)];

N_p=X1(:,1)+X1(:,2)+X1(:,3)+X1(:,4);
Z_PCR=1/T*(N-X1(:,13));

M_A=X1(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X1(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X1(:,5)*alpha_2/gamma_I2/2;
M_Q=eta*X1(:,8);

daily_new_model_2=M_A+M_I1+M_I2+M_Q;


daily_new_model_2_sim(j,:)=daily_new_model_2;
daily_new_model_2_day=[JLS_daily_case(1);daily_new_model_2(2:10:end)];
daily_new_model_2_day_sim(j,:)=daily_new_model_2_day;

% sim 2
par1_sim2=par1;
par1_sim2(4)=0.8;
par1_sim2(7)=0.8;
[T1_3_sim2,X1_3_sim2] =ode45(@Zero_s2,[T1_2(end):0.1:Num_fit],x3,[],par1_sim2,par2_2,options_ode2);

X1_sim2=[X1_1;X1_2(2:end,:);X1_3_sim2(2:end,:)];

daily_new_model=[JLS_daily_case(1);diff(X1(:,14))];
daily_new_model_day=[JLS_daily_case(1);diff(X1(1:10:end,14))];
daily_new_model_day_2=[JLS_daily_case(1);diff(X1_sim2(1:10:end,14))];
daily_new_model_day_sim(j,:)=daily_new_model_day;
daily_new_model_day_sim_2(j,:)=daily_new_model_day_2;
daily_new_model_sim(j,:)=daily_new_model;

N_p=X1_sim2(:,1)+X1_sim2(:,2)+X1_sim2(:,3)+X1_sim2(:,4);
Z_PCR=1/T*(N-X1_sim2(:,13));

M_A=X1_sim2(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X1_sim2(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X1_sim2(:,5)*alpha_2/gamma_I2/2;
M_Q=eta*X1_sim2(:,8);

daily_new_model_2=M_A+M_I1+M_I2+M_Q;


daily_new_model_2_day=[JLS_daily_case(1);daily_new_model_2(2:10:end)];
daily_new_model_2_day_sim_2(j,:)=daily_new_model_2_day;
end


ode_test1=quantile(daily_new_model_sim,0.5,1);
YY_daily_new=quantile(daily_new_model_sim,[ 0.025 0.5 0.975],1);
daily_new_model_sim_day=daily_new_model_sim(:,1:10:end);

YY_daily_new_day=quantile(daily_new_model_2_day_sim,[ 0.025 0.5 0.975],1);
% YY_daily_new_day=quantile(daily_new_model_day_sim,[ 0.025 0.5 0.975],1);
YY_daily_new_day_sim2=quantile(daily_new_model_2_day_sim_2,[0.025 0.5 0.975],1);
% YY_daily_new_day_sim2=quantile(daily_new_model_day_sim_2,[0.025 0.5 0.975],1);


figure(3);clf

time_plot=1:1:Num_fit;
time_plot_2=length(JLS_case):1:Num_fit;
xconf = [time_plot time_plot(end:-1:1)] ;%????         
yconf = [YY_daily_new_day(1,1:1:Num_fit) YY_daily_new_day(3,Num_fit:-1:1)];
p1 = fill(xconf,yconf,'r','FaceColor',[0.95686 0.64314 0.37647],'EdgeColor','none','FaceAlpha','0.5');
hold on
xconf2 = [time_plot_2 time_plot_2(end:-1:1)] ;%???? 
yconf2 = [YY_daily_new_day_sim2(1,length(JLS_case):1:Num_fit) YY_daily_new_day_sim2(3,Num_fit:-1:length(JLS_case))];
p2 = fill(xconf2,yconf2,'r','FaceColor',[0.28235 0.81961 0.8],'EdgeColor','none','FaceAlpha','0.5');
plot(1:1:data0,JLS_daily_case,'ob')
ylim([0 10000])
% hold on
% plot([22 22],get(gca,'ylim'),':k')
% hold on
% plot([12 12],get(gca,'ylim'),':k')
hold on
plot([length(JLS_case) length(JLS_case)],get(gca,'ylim'),':b')
xlabel('2022')
ylabel('每日新增，吉林省')
set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
hold on
plot(1:length(YY_daily_new_day(1,:)),YY_daily_new_day(2,:),'LineWidth', 3,'color',[0.8500 0.3250 0.0980])
hold on
plot(length(JLS_case):length(YY_daily_new_day_sim2(1,:)),YY_daily_new_day_sim2(2,length(JLS_case):end),'LineWidth', 3,'color',[0.18039 0.5451 0.34118])
% text(1,4500,'疫情初期','FontSize',10)
% text(12.5,4500,'管控阶段','FontSize',10)
% text(22.5,4500,'3.22, 核酸检测指南第三版，24小时内完成检测','FontSize',10)
text(37.5,2500,'吉林省停时，无','FontSize',12,'fontweight', 'bold','color',[0.8500 0.3250 0.0980]) %['90%核酸检测遵从度, sprintf('\n'),90%密接追踪,长春市停时,4.17(4.13,4.30)']
text(37.5,1500,['若核酸检测遵从度为90%，' newline '24小时内追踪90%密接，' newline '吉林省停时,4.21(4.17,4.25)'],'FontSize',10,'fontweight', 'bold','color',[0.18039 0.5451 0.34118])
xticks([1 13 25 40 61])
xticklabels({'Mar 1','Mar 13','Mar 25','Apr 9','Apr 30'})
xlim([0 63])
eval(['name_figure1 = ','''','Predicting_Jilin_Province_2'''])
eval(['print(','''', char(name_figure1),'''',',','''','-djpeg','''',',','''','-r600','''', ');'])
eval(['saveas(gcf,','''',char(name_figure1),'.fig','''',')'])

% A=[2 1];
% B=[ode_test1(1) 5];
% h1=line(A,B,'color',[0.01 0.66 0.62]);
% hold on
% tr1=X_city_wide(end,13)*ones(10,1);
% tr=[X_city_wide(:,13);tr1];
% %plot((1:0.1:length(ode_test1(1:10:end)))+1,ode_test1)
% [hAXTo,hLine1,hLine2]=plotyy((1:0.1:length(ode_test1(1:10:end)))+1,ode_test1,1:0.1:length(tr(1:10:end)),tr);
% % [hAXTo,hLine1,hLine2]=plotyy(1:length(daily_new_model),daily_new_model,1:0.1:length(tr(1:10:end)),tr);
% hold on
% h2=plot(1:1:data0,JLS_daily_case,'ob')
% hold on
% 
% % set(hAXTo(1),'XLim',[0 33])
% % set(hAXTo(2),'XLim',[0 33])
% 
% set(hAXTo(1),'XColor','k','YColor',[0.01 0.66 0.62]);
% set(hAXTo(2),'XColor','k','YColor',[1 0.5 0]);
% 
% HH1=get(hAXTo(1),'Ylabel');
% set(HH1,'String','Daily new cases in Jilin');
% set(HH1,'color',[0.01 0.66 0.62]);
% set(HH1,'FontSize',20);
% 
% HH2=get(hAXTo(2),'Ylabel');
% set(HH2,'String','Cumulative isolated people in Jilin');
% set(HH2,'color',[1 0.5 0]);
% set(hAXTo,'FontSize',14);
% 
% 
% % set(hAXTo(2),'ytick',[0 20000 40000 50000],'yticklabels',{'0', '20k', '40k', '50k'},'TickDir', 'out','YMinorTick', 'on','LineWidth', 1);
% %set(hAXTo(2),'TickDir', 'out','YMinorTick', 'on','LineWidth', 1);
% % ax = ancestor(hAXTo(2), 'axes')
% % ax.YAxis.TickLabelFormat = '%g K'
% 
% set(hLine1,'LineStyle','-','linewidth',2);
% set(hLine1,'color',[0.01 0.66 0.62]);
% set(hLine2,'LineStyle','-','linewidth',2);
% set(hLine2,'color',[1 0.5 0]);

