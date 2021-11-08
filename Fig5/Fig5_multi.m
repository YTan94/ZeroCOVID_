clear all
clc

% %for ON
par1=[0.064  4.8    14826276]; %14million
% par1=[0.0218  8    14826276]; %14million
% par1=[0.06  6    14826276]; %14million
par1=[0.038  8    14826276]; %14million China


      %b    tau_1  tau_2  a  gamma_A T   T_Q  eta    alpha gamma_d  gamma_H  xi1  xi2  u1  u2     P_H    P_D
par2=[0.75   2      2    0.8   1/6  7   10    0.67    1    7       11     2.34 1.32  7   15   0.0163   0.18   ]; %0.0163=%of hospital*0.32

beta=par1(1);
c=par1(2);
c_d=0.7*c*2;
c_s=c_d*(c-1);
N=par1(3);

eta=par2(8);
alpha=par2(9);
beta=par1(1);
tau_1=par2(2);
tau_2=par2(3);
a=par2(4);


% E0=100;
% I10=50;
% A0=2;
% I20=10;
% S0=par1(3)-E0-I10-A0-I20;
% Qs=0; 
% QE=0;
% QI=0;
% Id=0; 
% H=0; 
% R=0;
% D=0; 
% Q=0;
% Cum_Id=0; 
% Cum_T=0;
% Cum_MId=0;
% x0=[S0 E0 I10 A0 I20  R ];
% 
% 
% options = odeset('Events',@event_function);
% tn0=0:1:200;
% [T0,X0,TE,VE] = ode45(@Zero_s1,tn0,x0,options);
% X0(end,:)=[];
% %TE
% %daily_cases=[X0(1,5);diff(X0(:,5))];
% daily_cases=1/2*X0(:,3);
% plot(1:1:length(daily_cases),daily_cases,'r')

%% city-wide testing 2
%% calculation of updated initial value at T1
%beta=0.01
E_T1=1700;
I1_T1=760;
A_T1=200;
I2_T1=760;



H_T1=74;%445*0.014*12
R_T1=587344; %Nov 1
D_T1=9874;%Nov1

M_Id_T1=445;  
M_I1_T1=0;  
M_I2_T1=M_Id_T1;  
M_A_T1=0;  
M_Q_T1=0; 

S_T1=par1(3)-E_T1-I1_T1-A_T1-I2_T1-R_T1-H_T1-D_T1;

Q_s_T1=0;
Q_E_T1=0;
Q_I_T1=0;
Id_T1=445;

Q_T1=6230;%445*14


T_Q=0;

x1=[S_T1 E_T1 I1_T1 A_T1 I2_T1 Q_s_T1 Q_E_T1 Q_I_T1 Id_T1 H_T1 R_T1 D_T1 Q_T1 Id_T1 T_Q M_Id_T1];

%-------
%x1=X0(end,:);

T=par2(6);

l=0;
tn1=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[T1,X1] = ode45(@Zero_s2_T,tn1,x1,options_ode2,par1, par2,c_d,c_s);
%X1(1,:)=[];
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

    
    if newI_d>0.2*445
        tn2=tn2+T+1;
        x2=X2(end,:);
    else
        break
    end
end 


%X_city_wide_2=cell2mat(ode);

X_city_wide_2=cell2mat(ode);


 daily_cases2=[X_city_wide_2(1,14);diff(X_city_wide_2(:,14))];
%plot(1:1:length(X_city_wide_2(:,14)),daily_cases2,'r')
% plot(1:1:length(X_city_wide_2(:,10)),X_city_wide_2(:,10),'r')

%% citywide testing 3 relax
x3=X_city_wide_2(end,:);
c_d=0.5*c*2;
c_s=c_d*(c-1);

l3=0;
tn1=1:1:T;

options_ode2 = odeset('NonNegative',1:13);
[T31,X31] = ode45(@Zero_s3_T,tn1,x3,options_ode2,par1, par2,c_d,c_s);
%X31(1,:)=[];

% X_city_wide_3=[X_city_wide_2;X31];
%  daily_cases=diff(X_city_wide_3(:,14));
% plot(1:1:length(daily_cases),daily_cases,'r')

X31(1,:)=[];
x3=X31(end,:);
tn3=1:1:T+1;
ode3{1,:}=X31;

for i=2:113
    
    [T3,X3] = ode45(@Zero_s3_T,tn3,x3,options_ode2,par1, par2,c_d,c_s);
    X3(1,:)=[];
    ode3{i,:}=X3;
    newI_d=diff(X3(:,14));
    l3=l3+1

    if newI_d(end)<445
        tn3=tn3+T+1;
        x3=X3(end,:);
    else
        break
    end
end 

X_city_wide_31=cell2mat(ode3);
index3=find(diff(X_city_wide_31(:,14))<445);
X_city_wide_3=[X_city_wide_2;X_city_wide_31(index3,:)];

daily_cases=[X_city_wide_3(1,14);diff(X_city_wide_3(:,14))];
%plot(1:1:length(X_city_wide_3(:,14)),daily_cases,'r')

%% CTTI 
xc=X_city_wide_3(end,:);
par2(6)=7;
T=par2(6);
c_d=0.7*c*2;
c_s=c_d*(c-1);


l=0;
tn4=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[T41,Xc1] = ode45(@Zero_s2_T,tn4,xc,options_ode2,par1, par2,c_d,c_s);
Xc1(1,:)=[];

% X_city_wide_4=[X_city_wide_3;X41];
% daily_cases2=[X_city_wide_4(1,14);diff(X_city_wide_4(:,14))];
% plot(1:1:length(daily_cases2),daily_cases2,'r')

%X1(1,:)=[];
xc=Xc1(end,:);


tn2=1:1:T+1;
ode{1,:}=Xc1;

for i=2:113
    
    [Tc,Xc] = ode45(@Zero_s2_T,tn4,xc,options_ode2,par1, par2,c_d,c_s);
    Xc(1,:)=[];
    ode{i,:}=Xc;
    newI_d=diff(Xc(:,14));
    l=l+1

    
    if newI_d>0.2*445
        tn4=tn4+T+1;
        xc=Xc(end,:);
    else
        break
    end
end 


X_city_wide_c=cell2mat(ode);
X_city_wide_c=[X_city_wide_3;X_city_wide_c];

 daily_casesc=[X_city_wide_c(1,14);diff(X_city_wide_c(:,14))];
%plot(1:1:length(daily_casesc),daily_casesc,'r')
% plot(1:1:length(X_city_wide_4(:,10)),X_city_wide_4(:,10),'r')
%% citywide testing 5 relax
x5=X_city_wide_c(end,:);

c_d=0.5*c*2;
c_s=c_d*(c-1);

l5=0;
tn1=1:1:T;

options_ode2 = odeset('NonNegative',1:13);
[T51,X51] = ode45(@Zero_s3_T,tn1,x5,options_ode2,par1, par2,c_d,c_s);

 

X51(1,:)=[];
x5=X51(end,:);
tn5=1:1:T+1;
ode5{1,:}=X51;

for i=2:115
    
    [T5,X5] = ode45(@Zero_s3_T,tn5,x5,options_ode2,par1, par2,c_d,c_s);
    X5(1,:)=[];
    ode5{i,:}=X5;
    newI_d=diff(X5(:,14));
    l5=l5+1

    if newI_d(end)<445
        tn5=tn5+T+1;
        x5=X5(end,:);
    else
        break
    end
end 

X_city_wide_51=cell2mat(ode5);
index5=find(diff(X_city_wide_51(:,14))<445);
X_city_wide_5=[X_city_wide_c;X_city_wide_51(index5,:)];

daily_cases=[X_city_wide_5(1,14);diff(X_city_wide_5(:,14))];
%plot(1:1:length(X_city_wide_5(:,14)),daily_cases,'r')
 %plot(1:1:length(X_city_wide_5(:,10)),X_city_wide_5(:,10),'r')
%% CTTI 
x6=X_city_wide_5(end,:);
par2(6)=7;
T=par2(6);
c_d=0.7*c*2;
c_s=c_d*(c-1);


l=0;
tn6=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[T61,X61] = ode45(@Zero_s2_T,tn6,x6,options_ode2,par1, par2,c_d,c_s);
X61(1,:)=[];



%X1(1,:)=[];
x6=X61(end,:);


tn2=1:1:T+1;
ode{1,:}=X61;

for i=2:113
    
    [T6,X6] = ode45(@Zero_s2_T,tn6,x6,options_ode2,par1, par2,c_d,c_s);
    X6(1,:)=[];
    ode{i,:}=X6;
    newI_d=diff(X6(:,14));
    l=l+1

    
    if newI_d>0.2*445
        tn6=tn6+T+1;
        x6=X6(end,:);
    else
        break
    end
end 


X_city_wide_6=cell2mat(ode);
X_city_wide_6=[X_city_wide_5;X_city_wide_6];

 daily_cases6=[X_city_wide_6(1,14);diff(X_city_wide_6(:,14))];
%plot(1:1:length(daily_cases6),daily_cases6,'r')
% plot(1:1:length(X_city_wide_6(:,10)),X_city_wide_6(:,10),'r')

%% citywide testing 7 relax
x7=X_city_wide_6(end,:);

c_d=0.5*c*2;
c_s=c_d*(c-1);

l7=0;
tn1=1:1:T;

options_ode2 = odeset('NonNegative',1:13);
[T71,X71] = ode45(@Zero_s3_T,tn1,x7,options_ode2,par1, par2,c_d,c_s);

 

X71(1,:)=[];
x7=X71(end,:);
tn7=1:1:T+1;
ode7{1,:}=X71;

for i=2:117
    
    [T7,X7] = ode45(@Zero_s3_T,tn7,x7,options_ode2,par1, par2,c_d,c_s);
    X7(1,:)=[];
    ode7{i,:}=X7;
    newI_d=diff(X7(:,14));
    l7=l7+1

    if newI_d(end)<445
        tn7=tn7+T+1;
        x7=X7(end,:);
    else
        break
    end
end 

X_city_wide_71=cell2mat(ode7);
index7=find(diff(X_city_wide_71(:,14))<445);
X_city_wide_7=[X_city_wide_6;X_city_wide_71(index7,:)];

daily_cases=[X_city_wide_7(1,14);diff(X_city_wide_7(:,14))];
%plot(1:1:length(X_city_wide_7(:,14)),daily_cases,'r')
 %plot(1:1:length(X_city_wide_7(:,10)),X_city_wide_7(:,10),'r')

%% CTTI 
x8=X_city_wide_7(end,:);
par2(6)=7;
T=par2(6);
c_d=0.7*c*2;
c_s=c_d*(c-1);


l=0;
tn8=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[T81,X81] = ode45(@Zero_s2_T,tn8,x8,options_ode2,par1, par2,c_d,c_s);
X81(1,:)=[];



%X1(1,:)=[];
x8=X81(end,:);


tn2=1:1:T+1;
ode{1,:}=X81;

for i=2
    
    [T8,X8] = ode45(@Zero_s2_T,tn8,x8,options_ode2,par1, par2,c_d,c_s);
    X8(1,:)=[];
    ode{i,:}=X8;
    newI_d=diff(X8(:,14));
    l=l+1

    
    if newI_d>0.2*445
        tn8=tn8+T+1;
        x8=X8(end,:);
    else
        break
    end
end 


X_city_wide_8=cell2mat(ode);
X_city_wide_8=[X_city_wide_7;X_city_wide_8];

 daily_cases8=[X_city_wide_8(1,14);diff(X_city_wide_8(:,14))];
%plot(1:1:length(daily_cases8),daily_cases8,'r')
% plot(1:1:length(X_city_wide_8(:,10)),X_city_wide_8(:,10),'r')


%% city-wide testing clear cases
xx0=x1;
par2(6)=7;
T=par2(6);
c_d=0.7*c*2;
c_s=c_d*(c-1);


l=0;
tnc=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[Tc1,Xc1] = ode45(@Zero_s2_T,tnc,xx0,options_ode2,par1, par2,c_d,c_s);
%Xc1(1,:)=[];


xc=Xc1(end,:);


tnc=1:1:T+1;
ode{1,:}=Xc1;

for i=2:113
    
    [Tc,Xc] = ode45(@Zero_s2_T,tnc,xc,options_ode2,par1, par2,c_d,c_s);
    Xc(1,:)=[];
    ode{i,:}=Xc;
    newI_d=diff(Xc(:,14));
    l=l+1

    
    if floor(newI_d(end))~=0
        tnc=tnc+T+1;
        xc=Xc(end,:);
    else
        break
    end
end 


X_city_wide_c=cell2mat(ode);

 daily_casesc=[X_city_wide_c(1,14);diff(X_city_wide_c(:,14))];
%plot(1:1:length(daily_casesc),daily_casesc,'r')
 %plot(1:1:length(X_city_wide_c(:,10)),X_city_wide_c(:,10),'r')







%% one round of city-wide testing 
xx0=x1;
par2(6)=7;
T=par2(6);
c_d=0.7*c*2;
c_s=c_d*(c-1);


l=0;
tnc=1:1:T;

options_ode2 = odeset('NonNegative',1:14);
[Tc1,Xc1] = ode45(@Zero_s2_T,tnc,xx0,options_ode2,par1, par2,c_d,c_s);
%Xc1(1,:)=[];

xcr=Xc1(end,:);

c_d=0.5*c*2;
c_s=c_d*(c-1);

tn1=1:1:200;

options_ode2 = odeset('NonNegative',1:13);
[Tcr1,Xcr1] = ode45(@Zero_s3_T,tn1,xcr,options_ode2,par1, par2,c_d,c_s);
Xcr1(1,:)=[];

Xcr_tot=[Xc1;Xcr1];

daily_cases_r=[Xcr_tot(1,14);diff(Xcr_tot(:,14))];
%plot(1:1:length(diff(Xcr_tot(:,14))),diff(Xcr_tot(:,14)),'r')

% clear cases
% xc=Xc1(end,:);
% 
% 
% tnc=1:1:T+1;
% ode{1,:}=Xc1;
% 
% for i=2
%     
%     [Tc,Xc] = ode45(@Zero_s2_T,tnc,xc,options_ode2,par1, par2,c_d,c_s);
%     Xc(1,:)=[];
%     ode{i,:}=Xc;
%     newI_d=diff(Xc(:,14));
%     l=l+1
% 
%     
%     if floor(newI_d(end))~=0
%         tnc=tnc+T+1;
%         xc=Xc(end,:);
%     else
%         break
%     end
% end 
% 
% 
% X_city_wide_c=cell2mat(ode);
% 
%  daily_casesc=[X_city_wide_c(1,14);diff(X_city_wide_c(:,14))];
% plot(1:1:length(daily_casesc),daily_casesc,'r')
%  %plot(1:1:length(X_city_wide_c(:,10)),X_city_wide_c(:,10),'r')





%% plot

figure(2)


subplot(321)
x1=[4 43 43 4];
y1=[10 10 700 700];

x2=[43 404 404 43];
y2=[10 10 700 700];

x3=[404 442 442 404];
y3=[10 10 700 700];

x4=[442 500 500 442 ];
y4=[10 10 700 700];



hb1=patch(x1,y1,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on
hb2=patch(x2,y2,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
hold on
hb3=patch(x3,y3,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on
hb4=patch(x4,y4,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
hold on
% hb5=patch(x5,y5,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
% hold on
% hb6=patch(x6,y6,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
% hold on


h=plot(1:1:length(X_city_wide_8(1:500,14)),daily_cases8(1:500),'color',[0.98 0.50 0.45])
 set( get( get( h, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

% hxl1=yline(500,'-.','Escalated CTTI','DisplayName','Trigger')
% hxl2=yline(100,':','De-escalated CTTI','DisplayName','Trigger')
% % set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% % set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

legend('Escalated CTTI: 7 day/round and 70% tracing','De-escalation: 50% tracing')


% hxl1.FontSize = 12;
% hxl2.FontSize = 12;

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

% xticks([0 200 400 800])
% xticklabels({'0','200','400','600'  })

ylabel('Daily new diagnosed cases')
%xlabel('Days')
title('(a)')
xlim([0 500])
ylim([0 700])

 %%
subplot(322)
x1=[4 43 43 4];
y1=[3 3 200 200];

x2=[43 404 404 43];
y2=[3 3   200 200];

x3=[404 442 442 404];
y3=[3 3   200 200];

x4=[442 500 500 442 ];
y4=[3 3  200 200];



hb1=patch(x1,y1,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on
hb2=patch(x2,y2,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
hold on
hb3=patch(x3,y3,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on
hb4=patch(x4,y4,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
hold on
% hb5=patch(x5,y5,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
% hold on
% hb6=patch(x6,y6,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
% hold on

set( get( get( hb1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hb2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hb3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hb4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hb5, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hb6, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );


plot(1:1:length(X_city_wide_8(1:500,10)),X_city_wide_8(1:500,10),'color',[0.98 0.50 0.45])
% 
% hxl1=xline(353,'-.','Escalated CTTI','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')
% 
% hxl2=xline(68,':','De-escalated CTTI','DisplayName','Trigger','LabelVerticalAlignment','middle')
% 
% %hxl3=xline(91,'-.','100% clearance','DisplayName','Trigger','LabelVerticalAlignment','middle')
% 
% hxl1.FontSize = 12;
% hxl2.FontSize = 12;
% %hxl3.FontSize = 12;

legend('Repeated CTTI: 80% clearance','location','Northwest')

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
% xticks([0 200 400 600])
% xticklabels({'0','200','400','600'  })

ylabel('Cases in ICU')
%xlabel('Days')
title('(b)')
xlim([0 500])
ylim([0 200])

% 

%%
subplot(323)

x1=[4 119 119 4];
y1=[10 10 700 700];

p1=patch(x1,y1,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on

 plot(1:1:length(daily_casesc),daily_casesc,'color',[0.25 0.41 0.88])
 hold on
%hxl1=xline(42,':',' ','DisplayName','Trigger','LabelHorizontalAlignment','right','LabelVerticalAlignment','middle')
%hxl1=yline(445,':',' ','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

% hxl2=xline(189,':','Stop escalated CTTI','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

set( get( get( p1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% 
hxl1.FontSize = 12;
% hxl2.FontSize = 12;


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

legend('Repeated CTTI: 100% clearance','location','Northeast')

ylabel('Daily new diagnosed cases')
xlabel('Days')
title('(c)')
ylim([0 700])
xlim([0 500])

% xticks([0 200 400 600])
% xticklabels({'0','200','400','600'  })


 %%
subplot(324)
x1=[4 119 119 4];
y1=[3 3 200 200];
h4=patch(x1,y1,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on

 plot(1:1:length(X_city_wide_c(:,10)),X_city_wide_c(:,10),'color',[0.25 0.41 0.88])
set( get( get( h4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

%hxl1=xline(42,'-.','445 daily new cases','DisplayName','Trigger','LabelHorizontalAlignment','right','LabelVerticalAlignment','middle')
%hxl1=yline(445,'-.',' ','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

% hxl2=xline(189,':','Stop escalated CTTI','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')
%set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% 
%hxl1.FontSize = 12;
% hxl2.FontSize = 12;

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

%legend('Repeated CTTI: 100% clearance','location','Northwest')

ylabel('Cases in ICU')
xlabel('Days')
title('(d)')
xlim([0 500])

ylim([0 200])

% xticks([0 200 400 500])
% xticklabels({'0','200','400','600'  })

%% 
subplot(325)

x1=[2 7 7 2];
y1=[10 10 1300 1300];

x2=[7 200 200 7 ];
y2=[10 10 1300 1300];

p1=patch(x1,y1,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on
hb5=patch(x2,y2,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
hold on
 plot(1:1:length(daily_cases_r),daily_cases_r,'color',[0.69 0.19 0.38])
 hold on
hxl1=xline(42,':',' ','DisplayName','Trigger','LabelHorizontalAlignment','right','LabelVerticalAlignment','middle')
%hxl1=yline(445,':',' ','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

% hxl2=xline(189,':','Stop escalated CTTI','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

set( get( get( p1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hb5, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

hxl1.FontSize = 12;
% hxl2.FontSize = 12;


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

legend('One round of CTTI','Reach to the initial level','location','Northeast')

ylabel('Daily new diagnosed cases')
xlabel('Days')
title('(e)')
ylim([0 1300])
xlim([0 200])

% xticks([0 200 400 600])
% xticklabels({'0','200','400','600'  })


 %%
subplot(326)
x1=[2 7 7 2];
y1=[10 10 600 600];

x2=[7 200 200 7];
y2=[10 10 600 600];

h4=patch(x1,y1,[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86])
hold on
hb6=patch(x2,y2,[0.96 0.96 0.96],'EdgeColor',[0.96 0.96 0.96])
hold on
 plot(1:1:length(Xcr_tot(:,10)),Xcr_tot(:,10),'color',[0.69 0.19 0.38])
set( get( get( h4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

%hxl1=xline(42,'-.','445 daily new cases','DisplayName','Trigger','LabelHorizontalAlignment','right','LabelVerticalAlignment','middle')
%hxl1=yline(445,'-.',' ','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')

% hxl2=xline(189,':','Stop escalated CTTI','DisplayName','Trigger','LabelHorizontalAlignment','left','LabelVerticalAlignment','middle')
%set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
% 
%hxl1.FontSize = 12;
% hxl2.FontSize = 12;

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

%legend('100% clearance','location','Northwest')

ylabel('Cases in ICU')
xlabel('Days')
title('(f)')
xlim([0 200])

%ylim([0 200])

% xticks([0 200 400 500])
% xticklabels({'0','200','400','600'  })