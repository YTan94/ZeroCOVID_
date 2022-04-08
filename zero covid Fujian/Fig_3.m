load X_city_wide_T11
load X_city_wide_T10
load X_city_wide_T9
load X_city_wide_T8

cumsum(X_city_wide_T8(:,1))

TT=500;
%%
subplot(121)
plot( (1:length(X_city_wideT11(1:460,1)))+9,X_city_wideT11(1:460,1),'color',[0.98 0.50 0.45],'linewidth',1.5)
hold on
plot((1:length(X_city_wideT10(1:410,1)))+9, X_city_wideT10(1:410,1) ,'color',[0.4940 0.1840 0.5560],'linewidth',1.5)
hold on
plot((1:length(X_city_wideT9(1:360,1)))+9, X_city_wideT9(1:360,1) ,'color',[0 0.4470 0.7410],'linewidth',1.5)
hold on
plot((1:length(X_city_wideT8(1:290,1)))+9, X_city_wideT8(1:290,1) ,'color',[0.4660 0.6740 0.1880],'linewidth',1.5)

legend('Free transmission, 11 days','Free transmission, 10 days',...
    'Free transmission, 9 days','Free transmission, 8 days','Location','northwest','NumColumns',4)


ylabel('Daily new confirmed cases')
xlabel('2021')
title('(a)')
xlim([0 TT])

xticks([1 150 290  460])
xticklabels({'Sep 10','Sep 24','Oct 8','Oct 25'})


set(gca,'FontSize',13,'linewidth',1.5)
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'

set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

hxl1=xline(460+9,'-.','16 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl2=xline(410+9,'-.','14 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(360+9,'-.','12 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(290+9,'-.','10 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)

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
plot((1:length(X_city_wideT11(1:460,1)))+9,  X_city_wideT11(1:460,2),'color',[0.98 0.50 0.45],'linewidth',1.5)
hold on
plot((1:length(X_city_wideT10(1:410,1)))+9,  X_city_wideT10(1:410,2) ,'color',[0.4940 0.1840 0.5560],'linewidth',1.5)
hold on
plot((1:length(X_city_wideT9(1:360,1)))+9,  X_city_wideT9(1:360,2) ,'color',[0 0.4470 0.7410],'linewidth',1.5)
hold on
plot((1:length(X_city_wideT8(1:290,1)))+9,  X_city_wideT8(1:290,2) ,'color',[0.4660 0.6740 0.1880],'linewidth',1.5)



ylabel('Cumulative isolated people')
xlabel('2021')
ylim([0 450000])

xlim([0 TT])

xticks([1 150 290  460])
xticklabels({'Sep 10','Sep 24','Oct 8','Oct 25'})
title('(b)')

yticks([0 50000 150000   250000 350000  450000])
yticklabels({'0','50k','150k','250k','350k' ,'450k'})

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

hxl1=xline(460+9,'-.','16 rounds','DisplayName','Clear cases ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl2=xline(410+9,'-.','14 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl3=xline(360+9,'-.','12 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)
hxl4=xline(290+9,'-.','10 rounds','DisplayName',' ','LabelVerticalAlignment','middle','linewidth',1.5)

hxl1.FontSize = 10;
hxl2.FontSize = 10;
hxl3.FontSize = 10;
hxl4.FontSize = 10;
set( get( get( hxl2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
set( get( get( hxl4, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );