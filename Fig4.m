
%plot cd & T
N=2222732767;
eta=0.67;    
alpha=1;

load('X_city_wide_cd100_T3.mat');
load('X_city_wide_cd80_T3.mat');
load('X_city_wide_cd60_T3.mat');
load('X_city_wide_cd70_T3.mat');

load('X_city_wide_cd100_T5.mat');
load('X_city_wide_cd80_T5.mat');
load('X_city_wide_cd60_T5.mat');
load('X_city_wide_cd50_T5.mat');
load('X_city_wide_cd70_T5.mat');


load('X_city_wide_cd100_T7.mat');
load('X_city_wide_cd70_T7.mat');
load('X_city_wide_cd60_T7.mat');

%% cd70_T3
T=3;


N_p=X_city_wide_cd70_T3(:,1)+X_city_wide_cd70_T3(:,2)+X_city_wide_cd70_T3(:,3)+X_city_wide_cd70_T3(:,4)+X_city_wide_cd70_T3(:,5);
Z_PCR=1/T*(N-X_city_wide_cd70_T3(:,13));

M_A=X_city_wide_cd70_T3(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd70_T3(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd70_T3(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd70_T3(:,8);

ode_testcd70_T3=M_A+M_I1+M_I2+M_Q;
ode_testcd70_T3=[X_city_wide_cd70_T3(1,14);ode_testcd70_T3(2:end)];
%plot(1:0.1:length(ode_testcd70_T3(1:10:end)),ode_testcd70_T3,'r','linewidth',1.5)

%% cd100_T3
T=3;


N_p=X_city_wide_cd100_T3(:,1)+X_city_wide_cd100_T3(:,2)+X_city_wide_cd100_T3(:,3)+X_city_wide_cd100_T3(:,4)+X_city_wide_cd100_T3(:,5);
Z_PCR=1/T*(N-X_city_wide_cd100_T3(:,13));

M_A=X_city_wide_cd100_T3(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd100_T3(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd100_T3(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd100_T3(:,8);

ode_testcd100_T3=M_A+M_I1+M_I2+M_Q;
ode_testcd100_T3=[X_city_wide_cd100_T3(1,14);ode_testcd100_T3(2:end)];
%plot(1:0.1:length(ode_testcd100_T3(1:10:end)),ode_testcd100_T3,'r','linewidth',1.5)


%% cd60_T3
T=3;


N_p=X_city_wide_cd60_T3(:,1)+X_city_wide_cd60_T3(:,2)+X_city_wide_cd60_T3(:,3)+X_city_wide_cd60_T3(:,4)+X_city_wide_cd60_T3(:,5);
Z_PCR=1/T*(N-X_city_wide_cd60_T3(:,13));

M_A=X_city_wide_cd60_T3(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd60_T3(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd60_T3(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd60_T3(:,8);

ode_testcd60_T3=M_A+M_I1+M_I2+M_Q;
ode_testcd60_T3=[X_city_wide_cd60_T3(1,14);ode_testcd60_T3(2:end)];
%plot(1:0.1:length(ode_testcd60_T3(1:10:end)),ode_testcd60_T3,'r','linewidth',1.5)
%% cd80_T3
T=3;


N_p=X_city_wide_cd80_T3(:,1)+X_city_wide_cd80_T3(:,2)+X_city_wide_cd80_T3(:,3)+X_city_wide_cd80_T3(:,4)+X_city_wide_cd80_T3(:,5);
Z_PCR=1/T*(N-X_city_wide_cd80_T3(:,13));

M_A=X_city_wide_cd80_T3(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd80_T3(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd80_T3(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd80_T3(:,8);

ode_testcd80_T3=M_A+M_I1+M_I2+M_Q;
ode_testcd80_T3=[X_city_wide_cd80_T3(1,14);ode_testcd80_T3(2:end)];
%plot(1:0.1:length(ode_testcd80_T3(1:10:end)),ode_testcd80_T3,'r','linewidth',1.5)

%% cd80_T5
T=5;


N_p=X_city_wide_cd80_T5(:,1)+X_city_wide_cd80_T5(:,2)+X_city_wide_cd80_T5(:,3)+X_city_wide_cd80_T5(:,4)+X_city_wide_cd80_T5(:,5);
Z_PCR=1/T*(N-X_city_wide_cd80_T5(:,13));

M_A=X_city_wide_cd80_T5(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd80_T5(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd80_T5(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd80_T5(:,8);

ode_testcd80_T5=M_A+M_I1+M_I2+M_Q;
ode_testcd80_T5=[X_city_wide_cd80_T5(1,14);ode_testcd80_T5(2:end)];
%plot(1:0.1:length(ode_testcd80_T5(1:10:end)),ode_testcd80_T5,'r','linewidth',1.5)
%% cd60_T5
T=5;


N_p=X_city_wide_cd60_T5(:,1)+X_city_wide_cd60_T5(:,2)+X_city_wide_cd60_T5(:,3)+X_city_wide_cd60_T5(:,4)+X_city_wide_cd60_T5(:,5);
Z_PCR=1/T*(N-X_city_wide_cd60_T5(:,13));

M_A=X_city_wide_cd60_T5(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd60_T5(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd60_T5(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd60_T5(:,8);

ode_testcd60_T5=M_A+M_I1+M_I2+M_Q;
ode_testcd60_T5=[X_city_wide_cd60_T5(1,14);ode_testcd60_T5(2:end)];
%plot(1:0.1:length(ode_testcd60_T5(1:10:end)),ode_testcd60_T5,'r','linewidth',1.5)
% %% cd50_T3
% T=3;
% 
% 
% N_p=X_city_wide_cd50_T3(:,1)+X_city_wide_cd50_T3(:,2)+X_city_wide_cd50_T3(:,3)+X_city_wide_cd50_T3(:,4)+X_city_wide_cd50_T3(:,5);
% Z_PCR=1/T*(N-X_city_wide_cd50_T3(:,13));
% 
% M_A=X_city_wide_cd50_T3(:,4)/N_p*Z_PCR*eta*alpha;
% M_I1=X_city_wide_cd50_T3(:,3)/N_p*Z_PCR*eta*alpha;
% M_I2=X_city_wide_cd50_T3(:,5)/N_p*Z_PCR*alpha;
% M_Q=eta*X_city_wide_cd50_T3(:,8);
% 
% ode_testcd50_T3=M_A+M_I1+M_I2+M_Q;
% ode_testcd50_T3=[X_city_wide_cd50_T3(1,14);ode_testcd50_T3(2:end)];
% %plot(1:0.1:length(ode_testcd50_T3(1:10:end)),ode_testcd50_T3,'r','linewidth',1.5)

%% cd100_T5
T=5;


N_p=X_city_wide_cd100_T5(:,1)+X_city_wide_cd100_T5(:,2)+X_city_wide_cd100_T5(:,3)+X_city_wide_cd100_T5(:,4)+X_city_wide_cd100_T5(:,5);
Z_PCR=1/T*(N-X_city_wide_cd100_T5(:,13));

M_A=X_city_wide_cd100_T5(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd100_T5(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd100_T5(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd100_T5(:,8);

ode_testcd100_T5=M_A+M_I1+M_I2+M_Q;
ode_testcd100_T5=[X_city_wide_cd100_T5(1,14);ode_testcd100_T5(2:end)];
%plot(1:0.1:length(ode_testcd100_T5(1:10:end)),ode_testcd100_T5,'r','linewidth',1.5)
%% cd50_T5
T=5;


N_p=X_city_wide_cd50_T5(:,1)+X_city_wide_cd50_T5(:,2)+X_city_wide_cd50_T5(:,3)+X_city_wide_cd50_T5(:,4)+X_city_wide_cd50_T5(:,5);
Z_PCR=1/T*(N-X_city_wide_cd50_T5(:,13));

M_A=X_city_wide_cd50_T5(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd50_T5(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd50_T5(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd50_T5(:,8);

ode_testcd50_T5=M_A+M_I1+M_I2+M_Q;
ode_testcd50_T5=[X_city_wide_cd50_T5(1,14);ode_testcd50_T5(2:end)];
%plot(1:0.1:length(ode_testcd50_T5(1:10:end)),ode_testcd50_T5,'r','linewidth',1.5)

%% cd70_T5
T=5;


N_p=X_city_wide_cd70_T5(:,1)+X_city_wide_cd70_T5(:,2)+X_city_wide_cd70_T5(:,3)+X_city_wide_cd70_T5(:,4)+X_city_wide_cd70_T5(:,5);
Z_PCR=1/T*(N-X_city_wide_cd70_T5(:,13));

M_A=X_city_wide_cd70_T5(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd70_T5(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd70_T5(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd70_T5(:,8);

ode_testcd70_T5=M_A+M_I1+M_I2+M_Q;
ode_testcd70_T5=[X_city_wide_cd70_T5(1,14);ode_testcd70_T5(2:end)];
%plot(1:0.1:length(ode_testcd70_T5(1:10:end)),ode_testcd70_T5,'r','linewidth',1.5)

%% cd100_T7
T=7;


N_p=X_city_wide_cd100_T7(:,1)+X_city_wide_cd100_T7(:,2)+X_city_wide_cd100_T7(:,3)+X_city_wide_cd100_T7(:,4)+X_city_wide_cd100_T7(:,5);
Z_PCR=1/T*(N-X_city_wide_cd100_T7(:,13));

M_A=X_city_wide_cd100_T7(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd100_T7(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd100_T7(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd100_T7(:,8);

ode_testcd100_T7=M_A+M_I1+M_I2+M_Q;
ode_testcd100_T7=[X_city_wide_cd100_T7(1,14);ode_testcd100_T7(2:end)];
%plot(1:0.1:length(ode_testcd100_T7(1:10:end)),ode_testcd100_T7,'r','linewidth',1.5)


%% cd70_T7
T=7;


N_p=X_city_wide_cd70_T7(:,1)+X_city_wide_cd70_T7(:,2)+X_city_wide_cd70_T7(:,3)+X_city_wide_cd70_T7(:,4)+X_city_wide_cd70_T7(:,5);
Z_PCR=1/T*(N-X_city_wide_cd70_T7(:,13));

M_A=X_city_wide_cd70_T7(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd70_T7(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd70_T7(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd70_T7(:,8);

ode_testcd70_T7=M_A+M_I1+M_I2+M_Q;
ode_testcd70_T7=[X_city_wide_cd70_T7(1,14);ode_testcd70_T7(2:end)];
%plot(1:0.1:length(ode_testcd70_T7(1:10:end)),ode_testcd70_T7,'r','linewidth',1.5)
%% cd60_T7
T=7;


N_p=X_city_wide_cd60_T7(:,1)+X_city_wide_cd60_T7(:,2)+X_city_wide_cd60_T7(:,3)+X_city_wide_cd60_T7(:,4)+X_city_wide_cd60_T7(:,5);
Z_PCR=1/T*(N-X_city_wide_cd60_T7(:,13));

M_A=X_city_wide_cd60_T7(:,4)/N_p*Z_PCR*eta*alpha;
M_I1=X_city_wide_cd60_T7(:,3)/N_p*Z_PCR*eta*alpha;
M_I2=X_city_wide_cd60_T7(:,5)/N_p*Z_PCR*alpha;
M_Q=eta*X_city_wide_cd60_T7(:,8);

ode_testcd60_T7=M_A+M_I1+M_I2+M_Q;
ode_testcd60_T7=[X_city_wide_cd60_T7(1,14);ode_testcd60_T7(2:end)];
%plot(1:0.1:length(ode_testcd60_T7(1:10:end)),ode_testcd60_T7,'r','linewidth',1.5)
%% plot
subplot(321)

% plot(1:0.1:length(ode_testcd50_T5(1:10:end)),ode_testcd50_T5,':','color',[0.6350 0.0780 0.1840],'linewidth',1.5)
% hold on
plot(1:0.1:length(ode_testcd70_T7(1:10:end)),ode_testcd70_T7,'color',[1 0.84 0 ],'linewidth',1.5)
hold on
plot(1:0.1:length(ode_testcd70_T5(1:10:end)),ode_testcd70_T5,'color',[0.63 0.40 0.83],'linewidth',1.5)%1 0 1
hold on
% plot(1:0.1:length(ode_testcd80_T4(1:10:end)),ode_testcd80_T4,'color',[0.63 0.40 0.83],'linewidth',1.5)%0.87 0.63 0.87
% hold on

plot(1:0.1:length(ode_testcd70_T3(1:10:end)),ode_testcd70_T3,'color',[0.53 0.81 0.92],'linewidth',1.5)%0.53 0.81 0.92
hold on
plot(1:0.1:length(ode_testcd100_T3(1:10:end)),ode_testcd100_T3,'-.','color',[0.4660 0.6740 0.1880],'linewidth',1.5)

legend('7 days/round, 70% tracing',...
   ' 5 days/round,  70% tracing',...
   '3 days/round, 70% tracing',...
   '3 days/round, 100% tracing')

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


ylabel('Daily new confirmed cases')
xlabel('2021')
title('(a)')

hxl1=xline(24,'-.','8 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(33,'-.','11 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(55,'-.','11 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(98,'-.','14 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
%hxl5=xline(205,'-.','41 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;
hxl4.FontSize = 10;
%hxl5.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hxl5, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

xticks([1 33 55 98])
xticklabels({'Sep 10','Oct 12','Nov 3', 'Dec 16'})
% xlim([0 150])
%% 
%% plot
subplot(322)
% plot(1:0.1:length(X_city_wide_cd60_T5(1:10:end,13)),X_city_wide_cd60_T5(:,13),':','color',[0.6350 0.0780 0.1840],'linewidth',1.5)
% hold on
plot(1:0.1:length(X_city_wide_cd70_T7(1:10:end,13)),X_city_wide_cd70_T7(:,13),'color',[1 0.84 0 ],'linewidth',2)
hold on
plot(1:0.1:length(X_city_wide_cd70_T5(1:10:end,13)),X_city_wide_cd70_T5(:,13),'color',[0.63 0.40 0.83],'linewidth',2)%0.87 0.63 0.87
hold on

plot(1:0.1:length(X_city_wide_cd70_T3(1:10:end,13)),X_city_wide_cd70_T3(:,13),'color',[0.53 0.81 0.92],'linewidth',2)
hold on
plot(1:0.1:length(X_city_wide_cd100_T3(1:10:end,13)),X_city_wide_cd100_T3(:,13),'-.','color',[0.4660 0.6740 0.1880],'linewidth',2)



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


title('(b)')

ylabel('Cumulative isolated people')
xlabel('2021')

hxl1=xline(24,'-.','8 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(33,'-.','11 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(55,'-.','11 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(98,'-.','14 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
%hxl5=xline(205,'-.','41 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;
hxl4.FontSize = 10;
%hxl5.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hxl5, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

xticks([1 33 55 98])
xticklabels({'Sep 10','Oct 12','Nov 3', 'Dec 16'})
% xlim([0 150])


%%
subplot(323)

% plot(1:0.1:length(ode_testcd50_T5(1:10:end)),ode_testcd50_T5,':','color',[0.6350 0.0780 0.1840],'linewidth',1.5)
% hold on

plot(1:0.1:length(ode_testcd60_T5(1:10:end)),ode_testcd60_T5,'color',[1 0 1],'linewidth',1.5)
hold on

plot(1:0.1:length(ode_testcd70_T5(1:10:end)),ode_testcd70_T5,'color',[0.63 0.40 0.83],'linewidth',1.5)
hold on


plot(1:0.1:length(ode_testcd80_T5(1:10:end)),ode_testcd80_T5,'color',[0.87 0.63 0.87],'linewidth',1.5)
hold on


plot(1:0.1:length(ode_testcd100_T3(1:10:end)),ode_testcd100_T3,'-.','color',[0.4660 0.6740 0.1880],'linewidth',1.5)
%xlim([0 215])

legend( '5 days/round, 60% tracing',...
   '5 days/round, 70% tracing',...
   ' 5 days/round, 80% tracing',...
   ' 3 days/round, 100% tracing')

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

title('(c)')

ylabel('Daily new confirmed cases')
xlabel('2021')

hxl1=xline(24,'-.','8 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(45,'-.','9 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl3=xline(55,'-.','11 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl4=xline(95,'-.','19 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
%hxl5=xline(205,'-.','41 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;
hxl4.FontSize = 10;
%hxl5.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hxl5, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

xticks([1 24 55  95])
xticklabels({'Sep 10','Oct 4','Nov 3','Dec 3'})
% xlim([0 72])
%%
subplot(324)

% plot(1:0.1:length(X_city_wide_cd60_T5(1:10:end,13)),X_city_wide_cd60_T5(:,13),':','color',[0.6350 0.0780 0.1840],'linewidth',1.5)
% hold on

plot(1:0.1:length(X_city_wide_cd60_T5(1:10:end,13)),X_city_wide_cd60_T5(:,13),'color',[1 0 1 ],'linewidth',2)%1 0.38 0
hold on

plot(1:0.1:length(X_city_wide_cd70_T5(1:10:end,13)),X_city_wide_cd70_T5(:,13),'color',[ 0.63 0.40 0.83],'linewidth',2)%0.87 0.63 0.87
hold on


plot(1:0.1:length(X_city_wide_cd80_T5(1:10:end,13)),X_city_wide_cd80_T5(:,13),'color',[0.87 0.63 0.87],'linewidth',2)
hold on


plot(1:0.1:length(X_city_wide_cd100_T3(1:10:end,13)),X_city_wide_cd100_T3(:,13),'-.','color',[0.4660 0.6740 0.1880],'linewidth',2)


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


ylabel('Cumulative isolated people')
xlabel('2021')
title('(d)')

hxl1=xline(24,'-.','8 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(45,'-.','9 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl3=xline(55,'-.','11 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl4=xline(95,'-.','19 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
%hxl5=xline(205,'-.','41 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;
hxl4.FontSize = 10;
%hxl5.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
%set( get( get( hxl5, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

xticks([1 24 55  95])
xticklabels({'Sep 10','Oct 4','Nov 3','Dec 3'})
% xlim([0 72])
%%
subplot(325)


plot(1:0.1:length(ode_testcd60_T7(1:10:end)),ode_testcd60_T7,'color',[1 0.38 0],'linewidth',2)
hold on

plot(1:0.1:length(ode_testcd60_T3(1:10:end)),ode_testcd60_T3,'-.','color',[0.87 0.63 0.87],'linewidth',2)
hold on

plot(1:0.1:length(ode_testcd100_T7(1:10:end)),ode_testcd100_T7,'--','color',[0.2 0.63 0.79],'linewidth',2)

legend( '7 days/round, 60% tracing',...
    '3 days/round, 60% tracing',...
   ' 7 days/round, 100% tracing')

set(gca,'FontSize',13,'linewidth',2)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
title('(e)')


ylabel('Daily new confirmed cases')
xlabel('2021')

hxl1=xline(35,'-.','5 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(42,'-.','14 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(301,'-.','43 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

xticks([1  42  301])
xticklabels({'Sep 10','Oct 21','July 7'})
% 
 xlim([0 320])
%%
subplot(326)


plot(1:0.1:length(X_city_wide_cd60_T7(1:10:end,13)),X_city_wide_cd60_T7(:,13),'color',[1 0.38 0],'linewidth',2)
hold on


plot(1:0.1:length(X_city_wide_cd60_T3(1:10:end,13)),X_city_wide_cd60_T3(:,13),'--','color',[0.87 0.63 0.87],'linewidth',2)
hold on



plot(1:0.1:length(X_city_wide_cd100_T7(1:10:end,13)),X_city_wide_cd100_T7(:,13),'-.','color',[0.2 0.63 0.79],'linewidth',2)

title('(f)')

set(gca,'FontSize',13,'linewidth',2)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)


ylabel('Cumulative isolated people')

hxl1=xline(35,'-.','5 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(42,'-.','14 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(301,'-.','43 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );


xticks([1  42  301])
xticklabels({'Sep 10','Oct 21','July 7'})
% 
 xlim([0 320])
