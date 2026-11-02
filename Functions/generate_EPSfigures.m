%% Figure descriptive bids
% Figures 1 and 2


%% Figure 1
prefix = 0;
load(['Tempfiles/temp',num2str(prefix),'.mat'])
load(['Tempfiles/temp',num2str(prefix),'_1_bs.mat'])

%% Figure 1 to 8
for jj=1:6
close all
if jj==1
idx_target = find(datetime(2010,11,19,18,0,0,0)==DATE);
elseif jj==2
idx_target = find(datetime(2010,11,23,16,0,0,0)==DATE);
elseif jj==3
idx_target = find(datetime(2010,12,13,17,0,0,0)==DATE);
elseif jj==4
idx_target = find(datetime(2011,2,16,18,0,0,0)==DATE);
elseif jj==5
idx_target = find(datetime(2011,1,15,17,0,0,0)==DATE);
elseif jj==6
idx_target = find(datetime(2011,4,12,14,0,0,0)==DATE);
end

XX = [PRICE_draws5(idx_target,:)',DISP_draws5(idx_target,:)'];

%all combinations of variables stacked into nx2 matrix
%gen a matrix
nP = 500;
PTS = [linspace(min(PRICE_draws5(idx_target,:)'),max(PRICE_draws5(idx_target,:)'),nP);linspace(min(DISP_draws5(idx_target,:)'),max(DISP_draws5(idx_target,:)'),nP)]';
PTSi = [];
for i=1:nP
    PTSi = [PTSi;[repmat(PTS(i,1),nP,1),PTS(:,2)]];
end
if jj==6
f = mvksdensity(XX,PTSi,'Bandwidth',[std(PRICE_draws5(idx_target,:))/7 std(DISP_draws5(idx_target,:))/7]);
else
f = mvksdensity(XX,PTSi,'Bandwidth',[std(PRICE_draws5(idx_target,:))/3 std(DISP_draws5(idx_target,:))/3]); 
end

if sum(f<0)~=0
mean(f<0)
end

f0 = f./sum(f);
%find f_a such that
f_a = linspace(min(f),max(f),1000);
quant_a = f_a;

for i=1:length(f_a)
    i
    quant_a(i) = sum(f0(f>f_a(i)));
end
%plot(f_a,quant_a)

[~,b95] = min(abs(quant_a-0.95));
[~,b90] = min(abs(quant_a-0.9));
[~,b50] = min(abs(quant_a-0.5));
[~,b0] = sort((abs(f-f_a(b95))));
pts = PTSi(b0(1),:);

xlimfixed = [firm(id+1).k(idx_target)-400 firm(id+1).k(idx_target)+50];
DATE(idx_target)

figure(2)
figure1 = figure;

hold on
X = [DRAWS0(idx_target).quants_Q(2,:) DRAWS0(idx_target).quants_Q(8,end:-1:1)]; 
Y = [P_grid' P_grid(end:-1:1)']; 
C = 1;
p2 = fill(X,Y,C,'FaceAlpha',0.3) %Object 1
p2.LineWidth = 1;
p2.LineStyle = '-';
p2.EdgeColor = [0.8 0.9 1];
p2.FaceColor = [0.8 0.9 1];
hold on
X = [DRAWS0(idx_target).quants_RD(2,:)-corr_factor(idx_target,:) DRAWS0(idx_target).quants_RD(8,end:-1:1)-corr_factor(idx_target,end:-1:1)]; 
Y = [P_grid' P_grid(end:-1:1)']; 
C = 1;
p2 = fill(X,Y,C,'FaceAlpha',0.3) %Object 2
p2.LineWidth = 1;
p2.LineStyle = '-';
% p2.EdgeColor = [1 0.9 0.9];
% p2.FaceColor = [1 0.9 0.9];
p2.EdgeColor = [0.8 0.9 1];
p2.FaceColor = [0.8 0.9 1];
hold on
[~, hContour] = contourf(PTS(:,2),PTS(:,1),reshape(log(f*100),[nP nP])',[log(f_a(b95)*100) log(f_a(b50)*100)],'-w','LineWidth',0.00001) %Object 3
hold on
colormap(flipud(hot))
caxis([log(f_a(b95)*1) log(f_a(b50)*1000)])
hold on
stairs(firm(id+1).q(idx_target,:),P_grid,'k-','LineWidth',1.5) %Object 4
stairs(firm(id+1).rdq(idx_target,:)-corr_factor(idx_target,:),P_grid,'-','color',[0, 0.4470, 0.7410],'LineWidth',1.5) %Object 5
plot(Qt(idx_target,:),P_grid,'k--','LineWidth',1.5) %Object 6
stairs(firm(id+1).rdq_c(idx_target,:)-corr_factor(idx_target,:),P_grid,':','color',[0, 0.4470, 0.7410],'LineWidth',1.5) %Object 7
plot(RD_c(idx_target,:)-corr_factor(idx_target,:),P_grid,'--','color',[0, 0.4470, 0.7410],'LineWidth',1.5) %Object 8
plot(RD(idx_target,:)-corr_factor(idx_target,:),P_grid,'-.','color',[0, 0.4470, 0.7410],'LineWidth',1.5) %Object 9

if jj==1
    plot([DISP_oo(idx_target) DISP_oo(idx_target)],[392.157 392.157],'ko','MarkerSize',6,'LineWidth',3) %Bid functions are approximate on the price grid so sometimes intersection gives a slighltly off value
elseif jj==8
plot([DISP_oo(idx_target) DISP_oo(idx_target)],[78.43 78.43],'ko','MarkerSize',6,'LineWidth',3) %Bid functions are approximate on the price grid so sometimes intersection gives a slighltly off value
else
plot([DISP_oo(idx_target) DISP_oo(idx_target)],[PRICE(idx_target) PRICE(idx_target)],'ko','MarkerSize',6,'LineWidth',3) %Object 10
end
plot([DISP_hhc(idx_target) DISP_hhc(idx_target)],[PRICE_hhc(idx_target) PRICE_hhc(idx_target)],'gx','MarkerSize',6,'LineWidth',3) %Object 11

%plot(DISP_draws5(idx_target,:)',PRICE_draws5(idx_target,:)','o')

hold off
title(datestr(DATE(idx_target)))
if jj==4
xlim([500 1300])
else
xlim([0 1100])    
end
set(gca,'FontSize',12)
ylabel('Price ($/MWh)')
xlabel('Quantity (MW)')

plots=get(gca, 'Children')

if jj==1
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','North','Interpreter','Latex','box','off');
elseif jj==2
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','Best','Interpreter','Latex','box','off');
elseif jj==3
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','North','Interpreter','Latex','box','off');
elseif jj==4
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','Best','Interpreter','Latex','box','off');
elseif jj==5
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','Best','Interpreter','Latex','box','off');
elseif jj==6
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','Best','Interpreter','Latex','box','off');
elseif jj==7
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','North','Interpreter','Latex','box','off');
elseif jj==8
legend(plots([8, 7, 6, 5, 4, 3, 2, 1, 9, 10]),...
    {'Supply ($S^{\dagger}$)','RD ($RD^{\dagger}$)',...
    'Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq','Cf Eq HDR (50\%, 95\%)','95\% CI',...
    },'Location','Best','Interpreter','Latex','box','off');
end
box on

saveas(gcf,['Figures/','fig_2_',num2str(jj),'.eps'],'epsc')
pause(0.1)

style = hgexport('factorystyle');
style.Color = 'gray';
hgexport(gcf,['Figures/','fig_2_',num2str(jj),'gray.eps'],style)
pause(0.1)
end

%% Figure 4
%close all
idx_target = find(datetime(2011,2,16,18,0,0,0)==DATE);
%idx_target = find(datetime(2011,4,12,19,0,0,0)==DATE);
%idx_target = find(datetime(2011,1,15,18,0,0,0)==DATE);
%idx_target = find(datetime(2010,11,23,7,0,0,0)==DATE);
%idx_target = find(datetime(2010,11,19,18,0,0,0)==DATE);


XX = [PRICE_draws5(idx_target,:)',DISP_draws5(idx_target,:)'];

 figure1 = figure;
 %figure(19)
% [~, hContour] = contourf(PTS(:,2),PTS(:,1),reshape(log(f*100),[nP nP])',[log(f_a(b95)*100) log(f_a(b90)*100) log(f_a(b50)*100)],'-w','LineWidth',0.1)
% %hold on
%plot(DISP_draws2_(idx_target,:),PRICE_draws2_(idx_target,:),'.')
% 
% colormap(flipud(hot))
% caxis([log(f_a(b95)*1) log(f_a(b50)*1000)])
hold on
stairs(firm(id+1).q(idx_target,:),P_grid,'k-','LineWidth',1.5)
%stairs(firm(id+1).rdq(idx_target,:)-corr_factor(idx_target,:),P_grid,'-','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
stairs(firm(id+1).rdq(idx_target,:),P_grid,'-','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
plot(Qt(idx_target,:),P_grid,'k--','LineWidth',1.5)
%stairs(firm(id+1).rdq_c(idx_target,:)-corr_factor(idx_target,:),P_grid,':','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
stairs(firm(id+1).rdq_c(idx_target,:),P_grid,':','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
%plot(RD_c(idx_target,:)-corr_factor(idx_target,:),P_grid,'--','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
%plot(RD(idx_target,:)-corr_factor(idx_target,:),P_grid,'-.','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
plot(RD_c(idx_target,:),P_grid,'--','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
plot(RD(idx_target,:),P_grid,'-.','color',[0, 0.4470, 0.7410],'LineWidth',1.5)
plot([DISP_oo(idx_target) DISP_oo(idx_target)],[PRICE(idx_target) PRICE(idx_target)],'ko','MarkerSize',6,'LineWidth',3)
plot([DISP_occ(idx_target) DISP_occ(idx_target)],[824 824],'co','MarkerSize',6,'LineWidth',3)
plot([DISP_hhc(idx_target) DISP_hhc(idx_target)],[PRICE_hhc(idx_target) PRICE_hhc(idx_target)],'gx','MarkerSize',6,'LineWidth',3)
plot([DISP_hh2(idx_target) DISP_hh2(idx_target)],[PRICE_hh2(idx_target) PRICE_hh2(idx_target)],'rd','MarkerSize',6,'LineWidth',3)
hold off
title(datestr(DATE(idx_target)))
xlim([min(firm(id+1).rdq_c(idx_target,:)) 1300])
set(gca,'FontSize',12)
ylabel('Price ($/MWh)')
xlabel('Quantity (MW)')
box on

plots=get(gca, 'Children');
legend( {'Actual Supply ($S^{\dagger}$)',...
    'Actual RD ($RD^{\dagger}$)','Cf Supply ($S^{\star}$)','Cf RD ($\overline{RD}$)','Cf RD 2 ($RD^{\star}$)','Cf RD 3 ($\widetilde{RD}$)',...
    'Observed Eq','Cf Eq 1', 'Cf Eq 2','Cf Eq 3'},'Location','Best','Interpreter','Latex','box','off');

saveas(gcf,['Figures/','fig_1.eps'],'epsc')
pause(0.1)

