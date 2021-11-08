clear all
clc

FJ_data = xlsread('Zero_China_data');

FJ_case=FJ_data(1:25+3,5);
FJ_daily_case=FJ_data(1:25+3,4);

data0=length(FJ_case);

      %        b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2     P_D    gamma_I2  alpha_2 
par2=[2222732767 0.75   2      2    0.8   1/6  3  28    0.67    1     7       11     2.34 1.32  7   15      0.18   2        1];

%estimated


runs=1000;

load PAR1_1000_4
load par1_mean_4
load par1_var_4

%par1=[0.09   16.8043   10.6125    0.0029]
%par1=[0.09   18.8043   14.6125    0.0029]
%par1=[0.067   14.8043   10.6125    0.0029]%tn=0:1:7

par1_std=std(PAR1)

par1=par1_mean;


par1=par1_mean+1.96*par1_std/sqrt(runs);

par_est=[par1_mean-1.96*par1_std/sqrt(runs); par1_mean; par1_mean+1.96*par1_std/sqrt(runs)];


for i=2
    par1=par_est(i,:);
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
gamma_I2=par2(18);
alpha_2=par2(19);

c_d=c1*2;
c_s=c_d*(c1-1);

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

% %% calculation of updated initial value at T1
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

% Z_s_T1=M_Id_T1*(c_d*(1-beta)+c_s*(1-beta^2));
% Z_E_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
% Z_I1_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
% Z_A_T1=M_Id_T1*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

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
options_ode2 = odeset('NonNegative',1:16,'RelTol',1e-8,'AbsTol',1e-8);
[T1,X1] = ode45(@Zero_s2,tn1,x1,options_ode2,par1, par2,c_d,c_s);

x2=X1(end,:);
tn2=1:0.1:T+1;
ode{1,:}=X1;

for i=2:213
[T2,X2] = ode45(@Zero_s2,tn2,x2,options_ode2,par1, par2,c_d,c_s);
X2(1,:)=[];
ode{i,:}=X2;
l=l+1   
N_p=X2(:,1)+X2(:,2)+X2(:,3)+X2(:,4);
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

X_city_wide=cell2mat(ode);

X_city_wide(end,14);


N_p=X_city_wide(:,1)+X_city_wide(:,2)+X_city_wide(:,3)+X_city_wide(:,4);
Z_PCR=1/T*(N-X_city_wide(:,13));



M_A=X_city_wide(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide(:,5)*alpha_2/gamma_I2/2;
M_Q=eta*X_city_wide(:,8);

ode_test1=M_A+M_I1+M_I2+M_Q;


A=[2 1];
B=[ode_test1(1) 5];
h1=line(A,B,'color',[0.01 0.66 0.62]);
hold on
tr1=X_city_wide(end,13)*ones(10,1);
tr=[X_city_wide(:,13);tr1];
%plot((1:0.1:length(ode_test1(1:10:end)))+1,ode_test1)
[hAXTo,hLine1,hLine2]=plotyy((1:0.1:length(ode_test1(1:10:end)))+1,ode_test1,1:0.1:length(tr(1:10:end)),tr);
hold on
h2=plot(1:1:data0,FJ_daily_case,'ob')
hold on

% set(hAXTo(1),'XLim',[0 33])
% set(hAXTo(2),'XLim',[0 33])

set(hAXTo(1),'XColor','k','YColor',[0.01 0.66 0.62]);
set(hAXTo(2),'XColor','k','YColor',[1 0.5 0]);

HH1=get(hAXTo(1),'Ylabel');
set(HH1,'String','Daily new cases in Fujian');
set(HH1,'color',[0.01 0.66 0.62]);
set(HH1,'FontSize',20);

HH2=get(hAXTo(2),'Ylabel');
set(HH2,'String','Cumulative isolated people in Fujian');
set(HH2,'color',[1 0.5 0]);
set(hAXTo,'FontSize',14);


set(hAXTo(2),'ytick',[0 20000 40000 50000],'TickDir', 'out','YMinorTick', 'on','LineWidth', 1);

set(hLine1,'LineStyle','-','linewidth',2);
set(hLine1,'color',[0.01 0.66 0.62]);
set(hLine2,'LineStyle','-','linewidth',2);
set(hLine2,'color',[1 0.5 0]);

xlabel('2021')

set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
xticks([1 13 25  40])
xticklabels({'Sep 10','Sep 22','Oct 4','Oct 19'})

hxl1=xline(22,'-.','8^{th} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)
hxl2=xline(19,'-.','7^{th} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(16,'-.','6^{th} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(13,'-.','5^{th} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)
hxl5=xline(10,'-.','4^{th} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)
hxl6=xline(7,'-.','3^{rd} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)
hxl7=xline(4,'-.','2^{nd} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)
hxl8=xline(1,'-.','1^{st} round','DisplayName','Trigger','LabelVerticalAlignment','middle','linewidth',1.5)


%xlim([0 26]);
hxl1.FontSize = 12;
set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl5, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl6, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl7, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl8, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( h1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

legend('Estimated cases','Cases data','Estimated isolation')
set(gca,'YColor',[0.01 0.66 0.62]);
set(gca,'fontsize',14)


end

