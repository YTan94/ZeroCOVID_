clear all
clc

      %        b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2     P_D    gamma_I2  alpha_2 
par2=[2222732767 0.75   2      2    0.8   1/6  7  28    0.67    1     7       11     2.34 1.32  7   15      0.18   2        1];


load par1_mean_4
par1=par1_mean;

beta=par1(1);
c1=par1(2);
c2=par1(3);
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
c_d=1*c1*2;
c_s=c_d*(c1-1);
gamma_I2=par2(18);
alpha_2=par2(19);

S0=par2(1)-1;
E0=1;
I10=0;
A0=0;
I20=0;
R0=0;

tn0=0:0.1:8;

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
par3=[  5     3     1    1    0      ];
M_Id_T1=par3(1);  
M_I1_T1=par3(2);  
M_I2_T1=par3(3);  
M_A_T1=par3(4);  
M_Q_T1=par3(5); 
% Z_s_T1=M_Id_T1*(c_d*(1-beta)+c_s*(1-beta^2));
% Z_E_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
% Z_I1_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
% Z_A_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);
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

%% zero policy
T_Q=Z_s_T1+Z_E_T1+Z_I1_T1+Z_A_T1;
M_Id=M_Id_T1;
x1=[S_T1 E_T1 I1_T1 A_T1 I2_T1 Q_s_T1 Q_E_T1 Q_I_T1 Id_T1 H_T1 R_T1 D_T1 Q_T1 Id_T1 T_Q M_Id];

l=0;
tn1=1:0.1:T;
options_ode2 = odeset('NonNegative',1:14,'RelTol',1e-8,'AbsTol',1e-8);
[T1,X1] = ode45(@Zero_s2,tn1,x1,options_ode2,par1, par2,c_d,c_s);

x2=X1(end,:);
tn2=1:0.1:T+1;
ode{1,:}=X1;

for i=2:213
[T2,X2] = ode45(@Zero_s2,tn2,x2,options_ode2,par1, par2,c_d,c_s);
X2(1,:)=[];
ode{i,:}=X2;
l=l+1   
N_p=X2(:,1)+X2(:,2)+X2(:,3)+X2(:,4)+X2(:,5);
Z_PCR=1/T*(N-X2(:,13));

M_A=X2(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X2(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X2(:,5)*alpha_2/gamma_I2;
M_Q=eta*X2(:,8);

p_t=Z_PCR./N_p;
M_Id=M_A+M_I1+M_I2;

Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

Qnew=M_A+M_I1+M_I2+Z_s+Z_E+Z_I1+Z_A;
    
Idnew= M_A+M_I1+M_I2+M_Q;    
if floor(Qnew(end)-Qnew(end-1))~=0 & floor(Idnew(end))~=0   
        tn2=tn2+T+1;
        x2=X2(end,:);
    else
        break
    end
end 

%X_city_wideT12=cell2mat(ode);
%save X_city_wide_T12 X_city_wideT12

X_city_wide_cd70_T5=cell2mat(ode);
X_city_wide_cd70_T5(end,14)
X_city_wide_cd70_T5(end,13)

%save X_city_wide_cd70_T5 X_city_wide_cd70_T5
 %% plot
load('X_city_wide_T9.mat');
load('X_city_wide_T10.mat');
load('X_city_wide_T11.mat');
load('X_city_wide_T12.mat');

% %% calculate T6
% N_p=X_city_wideT6(:,1)+X_city_wideT6(:,2)+X_city_wideT6(:,3)+X_city_wideT6(:,4)+X_city_wideT6(:,5);
% Z_PCR=1/T*(N-X_city_wideT6(:,13));
% 
% M_A=X_city_wideT6(:,4)/N_p*Z_PCR*eta*alpha;
% M_I1=X_city_wideT6(:,3)/N_p*Z_PCR*eta*alpha;
% M_I2=X_city_wideT6(:,5)/N_p*Z_PCR*alpha;
% M_Q=eta*X_city_wideT6(:,8);
% 
% ode_testT6=M_A+M_I1+M_I2+M_Q;
% ode_testT6=[X_city_wideT6(1,14);ode_testT6(2:end)];
% M_Id=M_A+M_I1+M_I2;
% Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
% Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
% Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
% Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);
% 
% ode_tracedT6=Z_s+Z_E+Z_I1+Z_A;
% ode_tracedT6=[X_city_wideT6(1,14);ode_tracedT6(2:end)];
% %% calculate T7
% N_p=X_city_wideT7(:,1)+X_city_wideT7(:,2)+X_city_wideT7(:,3)+X_city_wideT7(:,4)+X_city_wideT7(:,5);
% Z_PCR=1/T*(N-X_city_wideT7(:,13));
% 
% M_A=X_city_wideT7(:,4)/N_p*Z_PCR*eta*alpha;
% M_I1=X_city_wideT7(:,3)/N_p*Z_PCR*eta*alpha;
% M_I2=X_city_wideT7(:,5)/N_p*Z_PCR*alpha;
% M_Q=eta*X_city_wideT7(:,8);
% 
% ode_testT7=M_A+M_I1+M_I2+M_Q;
% ode_testT7=[X_city_wideT7(1,14);ode_testT7(2:end)];
% M_Id=M_A+M_I1+M_I2;
% Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
% Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
% Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
% Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);
% 
% ode_tracedT7=Z_s+Z_E+Z_I1+Z_A;
% ode_tracedT7=[X_city_wideT7(1,14);ode_tracedT7(2:end)];
% %% calculate T8
% N_p=X_city_wideT8(:,1)+X_city_wideT8(:,2)+X_city_wideT8(:,3)+X_city_wideT8(:,4)+X_city_wideT8(:,5);
% Z_PCR=1/T*(N-X_city_wideT8(:,13));
% 
% M_A=X_city_wideT8(:,4)/N_p*Z_PCR*eta*alpha;
% M_I1=X_city_wideT8(:,3)/N_p*Z_PCR*eta*alpha;
% M_I2=X_city_wideT8(:,5)/N_p*Z_PCR*alpha;
% M_Q=eta*X_city_wideT8(:,8);
% 
% ode_testT8=M_A+M_I1+M_I2+M_Q;
% ode_testT8=[X_city_wideT8(1,14);ode_testT8(2:end)];
% M_Id=M_A+M_I1+M_I2;
% Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
% Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
% Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
% Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);
% 
% ode_tracedT8=Z_s+Z_E+Z_I1+Z_A;
% ode_tracedT8=[X_city_wideT8(1,14);ode_tracedT8(2:end)];


%% calculate T9
N_p=X_city_wideT9(:,1)+X_city_wideT9(:,2)+X_city_wideT9(:,3)+X_city_wideT9(:,4)+X_city_wideT9(:,5);
Z_PCR=1/T*(N-X_city_wideT9(:,13));

M_A=X_city_wideT9(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wideT9(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wideT9(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wideT9(:,8);

ode_testT9=M_A+M_I1+M_I2+M_Q;
ode_testT9=[X_city_wideT9(1,14);ode_testT9(2:end)];
M_Id=M_A+M_I1+M_I2;
Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

ode_tracedT9=Z_s+Z_E+Z_I1+Z_A;
ode_tracedT9=[X_city_wideT9(1,14);ode_tracedT9(2:end)];
%% calculate T10
N_p=X_city_wideT10(:,1)+X_city_wideT10(:,2)+X_city_wideT10(:,3)+X_city_wideT10(:,4)+X_city_wideT10(:,5);
Z_PCR=1/T*(N-X_city_wideT10(:,13));

M_A=X_city_wideT10(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wideT10(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wideT10(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wideT10(:,8);

ode_testT10=M_A+M_I1+M_I2+M_Q;
ode_testT10=[X_city_wideT10(1,14);ode_testT10(2:end)];
M_Id=M_A+M_I1+M_I2;
Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

ode_tracedT10=Z_s+Z_E+Z_I1+Z_A;
ode_tracedT10=[X_city_wideT10(1,14);ode_tracedT10(2:end)];
%% calculate T11
N_p=X_city_wideT11(:,1)+X_city_wideT11(:,2)+X_city_wideT11(:,3)+X_city_wideT11(:,4)+X_city_wideT11(:,5);
Z_PCR=1/T*(N-X_city_wideT11(:,13));

M_A=X_city_wideT11(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wideT11(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wideT11(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wideT11(:,8);

ode_testT11=M_A+M_I1+M_I2+M_Q;
ode_testT11=[X_city_wideT11(1,14);ode_testT11(2:end)];
M_Id=M_A+M_I1+M_I2;
Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

ode_tracedT11=Z_s+Z_E+Z_I1+Z_A;
ode_tracedT11=[X_city_wideT11(1,14);ode_tracedT11(2:end)];
%% calculate T12
N_p=X_city_wideT12(:,1)+X_city_wideT12(:,2)+X_city_wideT12(:,3)+X_city_wideT12(:,4)+X_city_wideT12(:,5);
Z_PCR=1/T*(N-X_city_wideT12(:,13));

M_A=X_city_wideT12(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wideT12(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wideT12(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wideT12(:,8);

ode_testT12=M_A+M_I1+M_I2+M_Q;
ode_testT12=[X_city_wideT12(1,14);ode_testT12(2:end)];
M_Id=M_A+M_I1+M_I2;
Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

ode_tracedT12=Z_s+Z_E+Z_I1+Z_A;
ode_tracedT12=[X_city_wideT12(1,14);ode_tracedT12(2:end)];

%% 
subplot(121)
plot(1:0.1:length(ode_testT12(1:10:end)),ode_testT12,'color',[0.98 0.50 0.45],'linewidth',1.5)
hold on
plot(1:0.1:length(ode_testT11(1:10:end)),ode_testT11,'color',[0.4940 0.1840 0.5560],'linewidth',1.5)
hold on
plot(1:0.1:length(ode_testT10(1:10:end)),ode_testT10,'color',[0 0.4470 0.7410],'linewidth',1.5)
hold on
plot(1:0.1:length(ode_testT9(1:10:end)),ode_testT9,'color',[0.4660 0.6740 0.1880],'linewidth',1.5)

legend('Free transmission, 12 days','Free transmission, 11 days',...
    'Free transmission, 10 days','Free transmission, 9 days','Location','northwest','NumColumns',4)


ylabel('Daily new confirmed cases')
xlabel('2021')
title('(a)')

xticks([1 12 24  33])
xticklabels({'Sep 10','Sep 21','Oct 4','Oct 12'})


set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

hxl1=xline(33,'-.','11 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','top','linewidth',1.5)
hxl2=xline(30,'-.','10 rounds','DisplayName',' ','LabelVerticalAlignment','top','linewidth',1.5)
hxl3=xline(27,'-.','9 rounds','DisplayName',' ','LabelVerticalAlignment','top','linewidth',1.5)
hxl4=xline(24,'-.','8 rounds','DisplayName',' ','LabelVerticalAlignment','top','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;
hxl4.FontSize = 10;
set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

%% 
subplot(122)

plot(1:0.1:length(X_city_wideT12(1:10:end,13)),X_city_wideT12(:,13),'color',[0.98 0.50 0.45],'linewidth',1.5)
hold on
plot(1:0.1:length(X_city_wideT11(1:10:end,13)),X_city_wideT11(:,13),'color',[0.4940 0.1840 0.5560],'linewidth',1.5)
hold on
plot(1:0.1:length(X_city_wideT10(1:10:end,13)),X_city_wideT10(:,13),'color',[0 0.4470 0.7410],'linewidth',1.5)
hold on
plot(1:0.1:length(X_city_wideT9(1:10:end,13)),X_city_wideT9(:,13),'color',[0.4660 0.6740 0.1880],'linewidth',1.5)

ylabel('Cumulative isolated people')
xlabel('2021')

xticks([1 12 24  33])
xticklabels({'Sep 10','Sep 21','Oct 4','Oct 12'})
title('(b)')

set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

hxl1=xline(33,'-.','11 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','top','linewidth',1.5)
hxl2=xline(30,'-.','10 rounds','DisplayName',' ','LabelVerticalAlignment','top','linewidth',1.5)
hxl3=xline(27,'-.','9 rounds','DisplayName',' ','LabelVerticalAlignment','top','linewidth',1.5)
hxl4=xline(24,'-.','8 rounds','DisplayName',' ','LabelVerticalAlignment','top','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;
hxl4.FontSize = 10;
set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

