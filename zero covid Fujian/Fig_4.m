clear all
clc

%% c=70%
load X_city_wide_case_c70  
load X_city_wide_iso_c70  


X_case_c70 = X_city_wide_case;
X_iso_c70 =  X_city_wide_iso;



clear X_city_wide_case
clear X_city_wide_iso


%% c=80%
load X_city_wide_case_c80  
load X_city_wide_iso_c80 


X_case_c80 = X_city_wide_case;
X_iso_c80 =  X_city_wide_iso;



clear X_city_wide_case
clear X_city_wide_iso
%% c=90%
load X_city_wide_case_c90  
load X_city_wide_iso_c90  

X_case_c90 = X_city_wide_case;
X_iso_c90 =  X_city_wide_iso;



clear X_city_wide_case
clear X_city_wide_iso

%% c=100%
load X_city_wide_case_c100 
load X_city_wide_iso_c100  

X_case_c100 = X_city_wide_case;
X_iso_c100 =  X_city_wide_iso;

AA=cumsum(X_case_c100,1);
aa=AA(end,:);

clear X_city_wide_case
clear X_city_wide_iso

%%plot
%% sub1
subplot(321)
TT=1140;
%3 is T = 5;
%2 is T = 4;
%1 is T = 3;

plot((1:length(X_case_c80(1:1100,3)))+9,X_case_c80(1:1100,3),'color',[1 0.84 0],'linewidth',1.5)%1 0 1
hold on
plot((1:length(X_case_c80(1:720,2)))+9,X_case_c80(1:720,2),'color',[0.63 0.40 0.83],'linewidth',1.5)%0.87 0.63 0.87
hold on

plot((1:length(X_case_c80(1:450,1)))+9,X_case_c80(1:450,1),'color',[0.53 0.81 0.92],'linewidth',1.5)%0.53 0.81 0.92
hold on
plot((1:length(X_case_c80(1:300,1)))+9,X_case_c100(1:300,1),'-.','color',[0.4660 0.6740 0.1880],'linewidth',1.5)

legend('5 days/round, 80% tracing',...
   ' 4 days/round,  80% tracing',...
   '3 days/round, 80% tracing',...
   '3 days/round, 100% tracing')

set(gca,'FontSize',9,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',9);
set(get(gca,'YLabel'),'FontSize',9);
set(get(gca,'Children'),'linewidth',2.0);  
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

ylim([0 50])
yticks([0 25 50])
yticklabels({'0', '25', '50' })
ylabel('Daily new confirmed cases')
%xlabel('2021')
title('(a)')

hxl1=xline(300+9,'-.','10 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(450+9,'-.','15 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(720+9,'-.','18 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(1100+9,'-.','22 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
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

xlim([0 TT+9])

xticks([10 300+9 720+9 1100+9])
xticklabels({'Sep 10', 'Oct 9', 'Nov 20',  'Dec 28'})


%% sub 2
subplot(322)
TT=1140;
%3 is T = 5;
%2 is T = 4;
%1 is T = 3;

plot((1:length(X_iso_c80(1:1100,3)))+9,X_iso_c80(1:1100,3),'color',[1 0.84 0],'linewidth',1.5)%1 0 1
hold on
plot((1:length(X_iso_c80(1:720,2)))+9,X_iso_c80(1:720,2),'color',[0.63 0.40 0.83],'linewidth',1.5)%0.87 0.63 0.87
hold on

plot((1:length(X_iso_c80(1:450,1)))+9,X_iso_c80(1:450,1),'color',[0.53 0.81 0.92],'linewidth',1.5)%0.53 0.81 0.92
hold on
plot((1:length(X_iso_c80(1:300,1)))+9,X_iso_c100(1:300,1),'-.','color',[0.4660 0.6740 0.1880],'linewidth',1.5)

legend('5 days/round, 80% tracing',...
   ' 4 days/round,  80% tracing',...
   '3 days/round, 80% tracing',...
   '3 days/round, 100% tracing')

set(gca,'FontSize',9,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',9);
set(get(gca,'YLabel'),'FontSize',9);
set(get(gca,'Children'),'linewidth',2.0);  
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
% 
% ylim([0 50])
yticks([0 50000 100000])
yticklabels({'0', '50k', '100k' })
ylabel('Cumulative isolated people')
%xlabel('2021')
title('(b)')

hxl1=xline(300+9,'-.','10 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(450+9,'-.','15 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(720+9,'-.','18 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(1100+9,'-.','22 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
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

xlim([0 TT+9])

xticks([10 300+9 720+9 1100+9])
xticklabels({'Sep 10', 'Oct 9', 'Nov 20',  'Dec 28'})
%% sub 3
subplot(323)
TT=1300;



plot((1:length(X_case_c80(1:1280,2)))+9,X_case_c70(1:1280,2),'color',[1 0 1],'linewidth',1.5)%1 0 1
hold on
plot((1:length(X_case_c80(1:720,2)))+9,X_case_c80(1:720,2),'color',[0.63 0.40 0.83],'linewidth',1.5)%0.87 0.63 0.87
hold on

plot((1:length(X_case_c80(1:480,2)))+9,X_case_c90(1:480,2),'color',[0.87 0.63 0.87],'linewidth',1.5)%0.53 0.81 0.92
hold on
plot((1:length(X_case_c80(1:300,2)))+9,X_case_c100(1:300,1),'-.','color',[0.4660 0.6740 0.188],'linewidth',1.5)

legend('4 days/round, 70% tracing',...
   ' 4 days/round,  80% tracing',...
   '4 days/round, 90% tracing',...
   '3 days/round, 100% tracing')

set(gca,'FontSize',9,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',9);
set(get(gca,'YLabel'),'FontSize',9);
set(get(gca,'Children'),'linewidth',2.0);  
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

ylim([0 50])
ylabel('Daily new confirmed cases')
%xlabel('2021')
title('(c)')

hxl1=xline(300+9,'-.','10 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(480+9,'-.','12 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(720+9,'-.','18 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(1280+9,'-.','32 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
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

xlim([0 TT+9])

xticks([10 300+9 480+9   1280+9 ])
xticklabels({'Sep 10', 'Oct 9', 'Oct 27',  'Jan 15'})

yticks([0 25 50])
yticklabels({'0', '25', '50' })

%% sub 4
subplot(324)
TT=1300;



plot((1:length(X_iso_c80(1:1280,2)))+9,X_iso_c70(1:1280,2),'color',[1 0 1],'linewidth',1.5)%1 0 1
hold on
plot((1:length(X_iso_c80(1:720,2)))+9,X_iso_c80(1:720,2),'color',[0.63 0.40 0.83],'linewidth',1.5)%0.87 0.63 0.87
hold on

plot((1:length(X_iso_c80(1:480,2)))+9,X_iso_c90(1:480,2),'color',[0.87 0.63 0.87],'linewidth',1.5)%0.53 0.81 0.92
hold on
plot((1:length(X_iso_c80(1:300,2)))+9,X_iso_c100(1:300,1),'-.','color',[0.4660 0.6740 0.188],'linewidth',1.5)

legend('4 days/round, 70% tracing',...
   ' 4 days/round,  80% tracing',...
   '4 days/round, 90% tracing',...
   '3 days/round, 100% tracing')

set(gca,'FontSize',9,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',9);
set(get(gca,'YLabel'),'FontSize',9);
set(get(gca,'Children'),'linewidth',2.0);  
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)


ylabel('Cumulative isolated people')
%xlabel('2021')
title('(d)')

hxl1=xline(300+9,'-.','10 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(480+9,'-.','12 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(720+9,'-.','18 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(1280+9,'-.','32 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
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

xlim([0 TT+9])

xticks([10 300+9 480+9   1280+9 ])
xticklabels({'Sep 10', 'Oct 9', 'Oct 27',  'Jan 15'})

yticks([0 50000 100000])
yticklabels({'0', '50k', '100k' })

%% sub 5
subplot(325)
TT=4000;




plot((1:length(X_case_c70(1:3800,2)))+9,X_case_c70(1:3800,3),'color',[1 0.38 0],'linewidth',1.5)%1 0 1
hold on
plot((1:length(X_case_c70(1:630,2)))+9,X_case_c70(1:630,1),'-.','color',[0.87 0.63 0.87],'linewidth',1.5)%0.87 0.63 0.87
hold on

plot((1:length(X_case_c70(1:500,2)))+9,X_case_c100(1:500,3),'--','color',[0.2 0.63 0.79],'linewidth',1.5)%0.53 0.81 0.92


legend('5 days/round, 70% tracing',...
   ' 3 days/round,  70% tracing',...
   '5 days/round, 100% tracing')


ylim([0 50])
yticks([0 25 50])
yticklabels({'0', '25', '50' })

set(gca,'FontSize',9,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',9);
set(get(gca,'YLabel'),'FontSize',9);
set(get(gca,'Children'),'linewidth',2.0);  
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)


ylabel('Daily new confirmed cases')
%xlabel('2021')
title('(e)')

hxl1=xline(3800+9,'-.','76 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(630+9,'-.','21 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(500+9,'-.','10 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

xlim([0 TT+9])

xticks([10 630+9   3800+9 ])
xticklabels({'Sep 10',  'Nov 11',   'Sep 24'})

%% sub 6
subplot(326)
TT=4000;




plot((1:length(X_iso_c70(1:3800,2)))+9,X_iso_c70(1:3800,3),'color',[1 0.38 0],'linewidth',1.5)%1 0 1
hold on
plot((1:length(X_iso_c70(1:630,2)))+9,X_iso_c70(1:630,1),'-.','color',[0.87 0.63 0.87],'linewidth',1.5)%0.87 0.63 0.87
hold on

plot((1:length(X_iso_c70(1:500,2)))+9,X_iso_c100(1:500,3),'--','color',[0.2 0.63 0.79],'linewidth',1.5)%0.53 0.81 0.92


legend('5 days/round, 70% tracing',...
   ' 3 days/round,  70% tracing',...
   '5 days/round, 100% tracing')




set(gca,'FontSize',9,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',9);
set(get(gca,'YLabel'),'FontSize',9);
set(get(gca,'Children'),'linewidth',2.0);  
%set(get(gca,'Children'),'MarkerSize',10);
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)


ylabel('Cumulative isolated people')
%xlabel('2021')
title('(e)')

hxl1=xline(3800+9,'-.','76 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)
hxl2=xline(630+9,'-.','21 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(500+9,'-.','10 rounds','DisplayName',' ','LabelVerticalAlignment','middle','LabelHorizontalAlignment', 'left','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;

set( get( get( hxl1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

xlim([0 TT+9])
ylim([0 300000])

xticks([10 630+9   3800+9 ])
xticklabels({'Sep 10',  'Nov 11',   'Sep 24'})

yticks([0  100000  200000  300000])
yticklabels({'0',  '100k',  '200k',  '300k'})