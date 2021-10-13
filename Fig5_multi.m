clear all
clc

% %for Toronto
par1=[0.1  10    2956024];
      %b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2     P_H    P_D
par2=[0.75   2      2    0.7   1/6  3   21    0.77    0.5    6       11     2.34 1.32  7   15   0.05   0.18   ];

c_d=18;
c_s=c_d*(c_d-1);
N=par1(3);
eta=par2(8);
alpha=par2(9);
beta=par1(1);
tau_1=par2(2);
tau_2=par2(3);
a=par2(4);

S0=par1(3)-1;
E0=1;
I10=0;
A0=0;
I20=0;
Qs=0; 
QE=0;
QI=0;
Id=0; 
H=0; 
R=0;
D=0; 
Q=0;
Cum_Id=0; 
Cum_T=0;
Cum_MId=0;
x0=[S0 E0 I10 A0 I20 Qs QE QI Id H R D Q Cum_Id Cum_T Cum_MId];


options = odeset('Events',@event_function);
tn0=0:1:200;
[T0,X0,TE,VE] = ode45(@Zero_s3_T,tn0,x0,options);
X0(end,:)=[];
%TE
daily_cases=[X0(1,14);diff(X0(:,14))];
%plot(1:1:length(X0(:,14)),daily_cases,'r')

%% city-wide testing 2
x1=X0(end,:);

T=par2(6);

l=0;
tn1=1:1:T

options_ode2 = odeset('NonNegative',1:14);
[T1,X1] = ode45(@Zero_s2_T,tn1,x1,options_ode2,par1, par2,c_d,c_s);
X1(1,:)=[];
x2=X1(end,:);


tn2=1:1:T+1;
%X1(1,:)=[];
ode{1,:}=X1;

for i=2:113
    
    [T2,X2] = ode45(@Zero_s2_T,tn2,x2,options_ode2,par1, par2,c_d,c_s);
    X2(1,:)=[];
    ode{i,:}=X2;
    newI_d=diff(X2(:,14));
    l=l+1

    
    if newI_d>0.2*800
        tn2=tn2+T+1
        x2=X2(end,:);
    else
        break
    end
end 


X_city_wide_2=cell2mat(ode);
%X_city_wide_2(1,:)=[];
X_city_wide_2=[X0;X_city_wide_2];

 daily_cases2=[X_city_wide_2(1,14);diff(X_city_wide_2(:,14))];
%plot(1:1:length(X_city_wide_2(:,14)),daily_cases2,'r')

%% do nothing 3
x3=X_city_wide_2(end,:);
x3(1)=x3(1)+x3(6); %send all the Qs to S
x3(6)=0;


%!!!!!change alpha
options = odeset('Events',@event_function);
tn3=0:1:50;
[T3,X3,TE,VE] = ode45(@Zero_s3_T,tn3,x3,options);
X3(1,:)=[];
X3(end,:)=[];%since the last point stop at 30.28, not atop at 30 or 31
X_city_wide_3=[X_city_wide_2;X3];

yy=X3(4)*eta*alpha+X3(3)*eta*alpha+X3(5)*alpha;

daily_cases3=[X_city_wide_3(1,14);diff(X_city_wide_3(:,14))];
 %plot(1:1:length(X_city_wide_3(:,14)),daily_cases3,'r')
%plot(1:1:length(yy),yy,'r')


%% citywide testing 4
x4=X_city_wide_3(end,:);

x4(13)=0; % clear Q
x4(15)=0; % clear cumulative traced 
l4=0;
tn1=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[T41,X41] = ode45(@Zero_s2_T,tn1,x4,options_ode2,par1, par2,c_d,c_s);
X41(1,:)=[];


x4=X41(end,:);
tn2=1:1:T+1;
ode4{1,:}=X41;

for i=2:113
    
    [T4,X4] = ode45(@Zero_s2_T,tn2,x4,options_ode2,par1, par2,c_d,c_s);
    X4(1,:)=[];
    ode4{i,:}=X4;
    newI_d=diff(X4(:,14));
    l4=l4+1

    
    if newI_d>0.2*800
        tn2=tn2+T+1
        x4=X4(end,:);
    else
        break
    end
end 


X_city_wide_4=[X_city_wide_3;cell2mat(ode4)];
% daily_cases=[X_city_wide_4(1,14);diff(X_city_wide_4(:,14))];
% plot(1:1:length(X_city_wide_4(:,14)),daily_cases,'r')


%% do nothing 5
x5=X_city_wide_4(end,:);
x5(1)=x5(1)+x5(6); %send all the Qs to S
x5(6)=0;
options = odeset('Events',@event_function);
tn5=0:1:100;
[T5,X5,TE,VE] = ode45(@Zero_s3_T,tn5,x5,options);
X5(1,:)=[];
X5(end,:)=[];%since the last point stop at 30.28, not atop at 30 or 31
X_city_wide_5=[X_city_wide_4;X5];


% daily_cases=[X_city_wide_5(1,14);diff(X_city_wide_5(:,14))];
% plot(1:1:length(X_city_wide_5(:,14)),daily_cases,'r')


%% citywide testing 6
x6=X_city_wide_5(end,:);

x6(13)=0; % clear Q
x6(15)=0; % clear cumulative traced 
l6=0;
tn1=1:1:T;


options_ode2 = odeset('NonNegative',1:14);
[T61,X61] = ode45(@Zero_s2_T,tn1,x6,options_ode2,par1, par2,c_d,c_s);
X61(1,:)=[];

x6=X61(end,:);
tn2=1:1:T+1;
ode6{1,:}=X61;

for i=2:113
    
    [T6,X6] = ode45(@Zero_s2_T,tn2,x6,options_ode2,par1, par2,c_d,c_s);
    X6(1,:)=[];
    ode6{i,:}=X6;
    newI_d=diff(X6(:,14));
    l6=l6+1

    
    if newI_d>0.2*800
        tn2=tn2+T+1
        x6=X6(end,:);
    else
        break
    end
end 


X_city_wide_6=[X_city_wide_5;cell2mat(ode6)];
% daily_cases=[X_city_wide_6(1,14);diff(X_city_wide_6(:,14))];
% plot(1:1:length(X_city_wide_6(:,14)),daily_cases,'r')

%% do nothing 7
x7=X_city_wide_6(end,:);
x7(1)=x7(1)+x7(6); %send all the Qs to S
x7(6)=0;
options = odeset('Events',@event_function);
tn7=0:1:100;
[T7,X7,TE,VE] = ode45(@Zero_s3_T,tn7,x7,options);
X7(1,:)=[];
X7(end,:)=[];%since the last point stop at 30.28, not atop at 30 or 31
X_city_wide_7=[X_city_wide_6;X7];


% daily_cases=[X_city_wide_7(1,14);diff(X_city_wide_7(:,14))];
% plot(1:1:length(X_city_wide_7(:,14)),daily_cases,'r')


%% citywide testing 8
x8=X_city_wide_7(end,:);

x8(13)=0; % clear Q
x8(15)=0; % clear cumulative traced 
l8=0;
tn1=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[T81,X81] = ode45(@Zero_s2_T,tn1,x8,options_ode2,par1, par2,c_d,c_s);
X81(1,:)=[];

x8=X81(end,:);
tn2=1:1:T+1;
ode8{1,:}=X81;

for i=2:113
    
    [T8,X8] = ode45(@Zero_s2_T,tn2,x8,options_ode2,par1, par2,c_d,c_s);
    X8(1,:)=[];
    ode8{i,:}=X8;
    newI_d=diff(X8(:,14));
    l8=l8+1

    
    if newI_d>0.2*800
        tn2=tn2+T+1
        x8=X8(end,:);
    else
        break
    end
end 


X_city_wide_8=[X_city_wide_7;cell2mat(ode8)];
daily_cases=[X_city_wide_8(1,14);diff(X_city_wide_8(:,14))];
%plot(1:1:length(X_city_wide_8(:,14)),daily_cases,'r')

%% do nothing 9
x9=X_city_wide_8(end,:);
x9(1)=x9(1)+x9(6); %send all the Qs to S
x9(6)=0;

options = odeset('Events',@event_function);
tn9=0:1:100;
[T9,X9,TE,VE] = ode45(@Zero_s3_T,tn9,x9,options);
X9(1,:)=[];
X9(end,:)=[];%since the last point stop at 30.28, not atop at 30 or 31
X_city_wide_9=[X_city_wide_8;X9];


daily_cases=[X_city_wide_9(1,14);diff(X_city_wide_9(:,14))];
% plot(1:1:length(X_city_wide_9(:,14)),daily_cases,'r')
% hold on
%% citywide testing 10
x10=X_city_wide_9(end,:);

x10(13)=0; % clear Q
x10(15)=0; % clear cumulative traced 
l10=0;
tn1=1:1:T;
options_ode2 = odeset('NonNegative',1:14);
[T101,X101] = ode45(@Zero_s2_T,tn1,x10,options_ode2,par1, par2,c_d,c_s);
X101(1,:)=[];


x10=X101(end,:);
tn2=1:1:T+1;
ode10{1,:}=X101;

for i=2:113
    
    [T10,X10] = ode45(@Zero_s2_T,tn2,x10,options_ode2,par1, par2,c_d,c_s);
    X10(1,:)=[];
    ode10{i,:}=X10;
    newI_d=diff(X10(:,14));
    l10=l10+1

    
    if newI_d>0.2*800
        tn2=tn2+T+1
        x10=X10(end,:);
    else
        break
    end
end 


X_city_wide_10=[X_city_wide_9;cell2mat(ode10)];
daily_cases=[X_city_wide_10(1,14);diff(X_city_wide_10(:,14))];
%plot(1:1:length(X_city_wide_10(:,14)),daily_cases,'r')
%% do nothing 11
x11=X_city_wide_10(end,:);
x11(1)=x11(1)+x11(6); %send all the Qs to S
x11(6)=0;

options = odeset('Events',@event_function);
tn11=0:1:100;
[T11,X11,TE,VE] = ode45(@Zero_s3_T,tn11,x11,options);
X11(1,:)=[];
X11(end,:)=[];%since the last point stop at 30.28, not atop at 30 or 31
X_city_wide_11=[X_city_wide_10;X11];

daily_cases=[X_city_wide_11(1,14);diff(X_city_wide_11(:,14))];
%plot(1:1:length(X_city_wide_11(:,14)),daily_cases,'r')

%% citywide testing 12
x12=X_city_wide_11(end,:);

x12(13)=0; % clear Q
x12(15)=0; % clear cumulative traced 
l12=0;
tn1=1:1:T;


options_ode2 = odeset('NonNegative',1:14);
[T121,X121] = ode45(@Zero_s2_T,tn1,x12,options_ode2,par1, par2,c_d,c_s);
X121(1,:)=[];

x12=X121(end,:);
tn2=1:1:T+1;
ode12{1,:}=X121;

for i=2:113
    
    [T12,X12] = ode45(@Zero_s2_T,tn2,x12,options_ode2,par1, par2,c_d,c_s);
    X12(1,:)=[];
    ode12{i,:}=X12;
    newI_d=diff(X12(:,14));
    
    l12=l12+1

    
    if newI_d>0.2*800
        tn2=tn2+T+1
        x12=X12(end,:);
    else
        break
    end
end 

X_city_wide_12=cell2mat(ode12);
X_city_wide_12(end,:)=[];
X_city_wide_12=[X_city_wide_11;X_city_wide_12];
daily_cases=[X_city_wide_12(1,14);diff(X_city_wide_12(:,14))];
%plot(1:1:length(X_city_wide_12(:,14)),daily_cases,'r')

%% plot

%% city-wide testing clear cases
xc1=X0(end,:);

T=par2(6);

lc=0;
tn1=1:1:T

options_ode2 = odeset('NonNegative',1:14);
[T1,Xc1] = ode45(@Zero_s2_T,tn1,xc1,options_ode2,par1, par2,c_d,c_s);

x2=Xc1(end,:);


tn2=1:1:T+1;

odec{1,:}=Xc1;

for i=2:30
    
    [T2,Xc2] = ode45(@Zero_s2_T,tn2,x2,options_ode2,par1, par2,c_d,c_s);
    Xc2(1,:)=[];
    odec{i,:}=Xc2;
%     newI_d=diff(Xc2(:,14));
%     if newI_d~=0
    lc=lc+1
        
N_p=Xc2(:,1)+Xc2(:,2)+Xc2(:,3)+Xc2(:,4)+Xc2(:,5);
Z_PCR=1/T*(N-Xc2(:,13));

M_A=Xc2(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=Xc2(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=Xc2(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*Xc2(:,8);

M_Id=M_A+M_I1+M_I2;

Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

Qnew=M_A+M_I1+M_I2+Z_s+Z_E+Z_I1+Z_A;
    
Idnew=    M_A+M_I1+M_I2+M_Q;

if floor(Qnew(end))-floor(Qnew(end-1))~=0 & floor(Idnew(end))~=0
    
        tn2=tn2+T+1
        x2=Xc2(end,:);
    else
        break
    end
end 


X_city_wide_c=cell2mat(odec);
X_city_wide_c(1,:)=[];
X_city_wide_clear=[X0;X_city_wide_c];

tnxx=1:1:60
xx=X_city_wide_clear(end,:);
[Txx,Xxx] = ode45(@Zero_s2_T,tnxx,xx,options_ode2,par1, par2,c_d,c_s);

 daily_cases_clear=[X_city_wide_clear(1,14);diff(X_city_wide_clear(:,14))];
% plot(1:1:length(X_city_wide_clear(:,14)),daily_cases_clear,'b')

XX_clearH=[ X_city_wide_clear;Xxx];


%% do nothing from starting
tn00=0:1:150;
[T00,X00] = ode45(@Zero_s3_T,tn00,x0,[]);
daily_cases_no=[X00(1,14);diff(X00(:,14))];
%plot(1:1:length(daily_cases_no),daily_cases_no,'b')


%% plot

figure(2)
subplot(221)
plot(1:1:length(X_city_wide_12(:,14)),daily_cases,'r')

hxl1=yline(800,'-.','Trigger citywide testing','DisplayName','Trigger')
hxl2=yline(160,':','Stop citywide testing','DisplayName','Trigger')
set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

legend('80% clearance','location','Northwest')

%hxl3=xline(91,'-.','100% clearance','DisplayName','Trigger','LabelVerticalAlignment','middle')

hxl1.FontSize = 12;
hxl2.FontSize = 12;
%hxl3.FontSize = 12;

%legend('80% clearance','100% clearance')

set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)


ylabel('Daily new confirmed cases')
%xlabel('Days')
title('(a)')

 %%
subplot(222)
plot(1:1:length(X_city_wide_12(:,10)),X_city_wide_12(:,10),'r')

hxl1=xline(41,'-.','Trigger citywide testing','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

hxl2=xline(60,':','Stop citywide testing','DisplayName','Trigger','LabelVerticalAlignment','middle')

%hxl3=xline(91,'-.','100% clearance','DisplayName','Trigger','LabelVerticalAlignment','middle')

hxl1.FontSize = 12;
hxl2.FontSize = 12;
%hxl3.FontSize = 12;

legend('80% clearance')

set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)


ylabel('Cases in ICU')
%xlabel('Days')
title('(b)')

% 

%%
subplot(223)

 plot(1:1:length(X_city_wide_clear(:,14)),daily_cases_clear,'b')
%hxl1=yline(800,'-.','Trigger citywide testing','DisplayName','Trigger')
 hxl1=xline(41,'-.','Trigger citywide testing','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

hxl2=xline(91,':','Stop citywide testing','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')
set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

hxl1.FontSize = 12;
hxl2.FontSize = 12;


set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

legend('100% clearance','location','Northwest')

ylabel('Daily new confirmed cases')
xlabel('Days')
title('(c)')
xlim([0 250])

 %%
subplot(224)

 plot(1:1:length(XX_clearH(:,10)),XX_clearH(:,10),'b')

 hxl1=xline(41,'-.','Trigger citywide testing','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')
 hxl2=xline(91,':','Stop citywide testing','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')
set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

hxl1.FontSize = 12;
hxl2.FontSize = 12;

%legend('80% clearance','100% clearance')

set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

legend('100% clearance','location','Northwest')

ylabel('Cases in ICU')
xlabel('Days')
title('(d)')
xlim([0 250])

