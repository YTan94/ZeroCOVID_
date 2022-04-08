%% Plot the residual of the partial regression of X (input - LHS matrix) and Y (output)
%% at column s (time points saved). PCC Coefficients are calculated on these
%% var: labels of the parameters varied in the X (as legend)
%% The Title of the plot is the Pearson correlation coefficient of the
%% transformed data, that is  the PRCC calculated on the original data.
%% The p-value is also showed in the title
%% by Simeone Marino, June 5 2007 %%

function PRCC_PLOT2(X,Y,PRCC_var,y_var)

%Y=Y(s,:);
[a k]=size(X); % Define the size of LHS matrix
Xranked=rankingN(X);
Yranked=ranking1(Y);
for i=1:k  % Loop for the whole submatrices, Zi
    c1=['LHStemp=Xranked;LHStemp(:,',num2str(i),')=[];Z',num2str(i),'=[ones(a,1) LHStemp];LHStemp=[];'];
    eval(c1);
end
for i=1:k
    c2=['[b',num2str(i),',bint',num2str(i),',r',num2str(i),']= regress(Yranked,Z',num2str(i),');'];
    c3=['[b',num2str(i),',bint',num2str(i),',rx',num2str(i),']= regress(Xranked(:,',num2str(i),'),Z',num2str(i),');'];
    eval(c2);
    eval(c3);
end
for i=1:k
    c4=['r',num2str(i)];
    c5=['rx',num2str(i)];
    [r(i) p(i)]=corr(eval(c4),eval(c5));
    a=['[PRCC , p-value] = ' '[' num2str(r(i)) ' , '  num2str(p(i)) '].'];% ' Time point=' num2str(s-1)];
%     figure,plot((eval(c4)),(eval(c5)),'.'),Title(a),...
%             legend(PRCC_var{i}),xlabel(PRCC_var{i}),ylabel(y_var);%eval(c
%             6); donot plot the subfigures out
% PRCC_var
% a
end

figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

barh(r)
set(gca,'YLim',[.5 6.5]);% This automatically sets the
% XLimMode to manual.

% Set XTick so that only the integer values that
% range from 0.5 - 12.5 are used.
set(gca,'YTick',[1:6]); % This automatically sets
% the XTickMode to manual.

% Set the XTickLabel so that abbreviations for the
% labels are used.
set(gca,'yticklabel',PRCC_var,'fontsize',14); % ,'fontweight','b')%for \bf
%title('PRCC with respect to' y_var);
xlabel('PRCC')
  
xlim([-1 1]);
    
    set(gca,'yticklabel',[]) %Remove xtick labels
    
    %% Get tick mark positions
    yTicks = get(gca,'ytick');
%PRCC_var={'gamma_I2','eta','T0','c_tra_prop','T','alpha'};%
% ylabel=['\alpha    ';'T         ';'c_{traced}';'T_0       ';'\eta      ';'\theta    ';'a         '];
%ylabel=['$\alpha    $';'$T         $';'$c_{traced}$';'$T_0$       ';'$\eta$      '];
ylabel=['Days from sympton onset to confirmed';'Testing efficiency                  '; 'Free transmission days              ';'Tracing percentage                  ';...
   'Days per round of testing           ';'CTTI        testing adherence rate  '];

%PRCC_var={'T0','T','alpha','eta','gamma_I2','c_tra_prop'};%
ylabel=['Free transmission days              '; 'Days per round of testing           '; 'CTTI        testing adherence rate  ';...
    'Testing efficiency                  ';'Days from sympton onset to confirmed'; 'Tracing percentage                  '];


set(gca,'Fontsize',16);

    ax = axis; %Get left most x-position
    HorizontalOffset = 0.05;
    
    %% Reset the ytick labels in desired font
    for i = 1:length(yTicks)
        %Create text box and set appropriate properties
        %    text(ax(1) - HorizontalOffset,yTicks(i),['$' num2str( yTicks(i)) '$'],'HorizontalAlignment','Right','interpreter', 'latex');
        text(ax(1) - HorizontalOffset,yTicks(i),[ylabel(i,:)],'HorizontalAlignment','Right','interpreter', 'latex','Fontsize',16);
        
    end
%   xlim([-1 1]);
%     
%     set(gca,'yticklabel',[]) %Remove xtick labels
%     
%     %% Get tick mark positions
%     yTicks = get(gca,'ytick');
%          
% %     ylabel=['$\beta_{w_1}$' ,'$\beta_{w_2}$', '$\tau_1$     ', '$a$'         ,'$\gamma_a$   ','$\tau_2$     ','$\gamma_2$   ','$d_w$         ',...
% %             '$b_1$        ','$k_1$        ','$\beta_h$    ','$\beta_{h_1}$' ,'$d$          ','$\gamma$     '];

%     
%     ax = axis; %Get left most x-position
%     HorizontalOffset = 0.05;
%     
%     %% Reset the ytick labels in desired font
%     for i = 1:length(yTicks)
%         %Create text box and set appropriate properties
%         %    text(ax(1) - HorizontalOffset,yTicks(i),['$' num2str( yTicks(i)) '$'],'HorizontalAlignment','Right','interpreter', 'latex');
%         text(ax(1) - HorizontalOffset,yTicks(i),[ylabel(i,:)],'HorizontalAlignment','Right','interpreter', 'latex','Fontsize',18);
%         
%     end
%     
   % set(gca,'Fontsize',16);



title(y_var,'Fontsize',14);
% figure
% bar(p);
% set(gca,'XLim',[.5 20.5]);
% set(gca,'XTick',[1:20])
% set(gca,'xticklabel',PRCC_var)
% %legend(y_var)
% ylabel('p-value');
% title(y_var);


% figure
% barh(r);
% set(gca,'yticklabel',PRCC_var)
% %title('PRCC with respect to' y_var);
% xlabel('PRCC')
% title(y_var);
% figure
% barh(p);
% set(gca,'yticklabel',PRCC_var)
% %legend(y_var)
% xlabel('p-value');
% title(y_var);