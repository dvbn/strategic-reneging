

%% Price impacts
q_val = [];
mean_val = [];
mean_val2 = [];
kk = 1;
for ee=1:11
    for j=1:2
        if j==1
        idx_target = intersect(event(ee).index,find(events_d1==1));
        else
idx_target = intersect(event(ee).index,find(events_d==1));
        end
    
m0 = mean( mean(PRICE_draws5(idx_target,:),1) )';
m1 = mean(PRICE_hhc(idx_target));
q_val = [q_val,quantile( mean(PRICE(idx_target))'- (mean(PRICE_draws5(idx_target,:),1) -m0 + m1),[0.025 0.025 0.975 0.975])']; %[quantiles x events]
mean_val = [mean_val,mean(PRICE(idx_target))-m1] %[1 x events]
mean_val2 = [mean_val2,mean(PRICE(idx_target))-mean(PRICE_occ(idx_target))] %[1 x events]
tempP(kk).list = PRICE(idx_target)-PRICE_hhc(idx_target);
mean(tempP(kk).list)
kk=kk+1;
    end
end

x = (1:size(mean_val,2));
boxsize = 0.25;
x = (1:size(mean_val,2));


close all

figure(1)
for i=1:length(x)

    if x(i)/2~=round(x(i)/2)
% X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]+0.75*boxsize;
% Y = [q_val(1,i) q_val(1,i) q_val(4,i) q_val(4,i)]; 
% C = 1;
% p1 = fill(X,Y,C)
% p1.LineWidth = 1;
% p1.LineStyle = ':';
% p1.EdgeColor = [0 0.4470 0.7410];
% p1.FaceColor = [0.9 0.95 1];

hold on
X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]+0.75*boxsize;
Y = [q_val(2,i) q_val(2,i) q_val(3,i) q_val(3,i)]; 
C = 1;
p2 = fill(X,Y,C)
p2.LineWidth = 1;
p2.LineStyle = '-';
p2.EdgeColor = [0 0.4470 0.7410];
p2.FaceColor = [0.8 0.9 1];

hold on
X = [x(i)-boxsize*0.5 x(i)+boxsize*0.5]+0.75*boxsize;
Y = [mean_val(i) mean_val(i)]; 
p3 = plot(X,Y)
p3.LineWidth = 3;
p3.LineStyle = '-';
p3.Color = [0 0.4470 0.7410];

plot(x(i)+0.75*boxsize,mean_val2(i),'x','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerSize',5,'LineWidth',1)
%plot(x(i)+0.75*boxsize,tempP(i).list,'d','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerSize',5,'LineWidth',1)

    else
%       X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]-0.75*boxsize;
% Y = [q_val(1,i) q_val(1,i) q_val(4,i) q_val(4,i)]; 
% C = 1;
% p1 = fill(X,Y,C)
% p1.LineWidth = 1;
% p1.LineStyle = ':';
% p1.EdgeColor = [0.8500 0.3250 0.0980];
% p1.FaceColor = [1 0.8 0.8];

hold on
X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]-0.75*boxsize;
Y = [q_val(2,i) q_val(2,i) q_val(3,i) q_val(3,i)]; 
C = 1;
p2 = fill(X,Y,C)
p2.LineWidth = 1;
p2.LineStyle = '-';
p2.EdgeColor = [0.8500 0.3250 0.0980];
p2.FaceColor = [1 0.8 0.8];

hold on
X = [x(i)-boxsize*0.5 x(i)+boxsize*0.5]-0.75*boxsize;
Y = [mean_val(i) mean_val(i)]; 
p3 = plot(X,Y)
p3.LineWidth = 3;
p3.LineStyle = '-';
p3.Color = [0.8500 0.3250 0.0980];

plot(x(i)-0.75*boxsize,mean_val2(i),'x','MarkerEdgeColor',[0.8500 0.3250 0.0980],'MarkerSize',5,'LineWidth',1)
%plot(x(i)-0.75*boxsize,tempP(i).list,'d','MarkerEdgeColor',[0.8500 0.3250 0.0980],'MarkerSize',5,'LineWidth',1)

    end

xlim([0 length(mean_val)+1])
ylim([-100 600]) % PRICE
%ylim([-50 120]) % DISP
end

for ii =1:11
xline(-0.5+2*ii,':','LineWidth',0.1)
end

yline(0,':')
xline(8.5,'-')
hold off
box on
legend('First hours (95%CI)','First hours (mean)','First hours (MSA)','All hours (95%CI)','All hours (mean)','All hours (MSA)','Orientation','horizontal','Location','North','NumColumns',3)
xticks((1.5:2:25))
xticklabels({'Nov19','Nov23','Dec13','Feb16','Nov24','Nov26','Nov30','Jan15','Jan21','Apr12','Aug12'})
set(gca,'FontSize',12)
ylabel('Average Price Impact ($/MWh)')
%title('Average Price Impact')
grid off

%saveas(gcf,[figurepath,'/','priceimpacts',num2str(prefix),'.eps'],'epsc')
saveas(gcf,[figurepath,'/','fig_4.eps'],'epsc')
pause(0.1)

%% Quantity impacts
q_val = [];
mean_val = [];
mean_val2 = [];
for ee=1:11
    for j=1:2
        if j==1
        idx_target = intersect(event(ee).index,find(events_d1==1));
        else
idx_target = intersect(event(ee).index,find(events_d==1));
        end
    
m0 = mean( mean(DISP_draws5(idx_target,:),1) )';
m1 = mean(DISP_hhc(idx_target));
q_val = [q_val,quantile( mean(DISP_oo(idx_target))'- (mean(DISP_draws5(idx_target,:),1) -m0 + m1),[0.025 0.025 0.975 0.975])']; %[quantiles x events]
mean_val = [mean_val,mean(DISP_oo(idx_target))-m1] %[1 x events]
mean_val2 = [mean_val2,mean(DISP_oo(idx_target))-mean(DISP_occ(idx_target))] %[1 x events]
    end
end

x = (1:size(mean_val,2));
boxsize = 0.25;
x = (1:size(mean_val,2));


close all

figure(1)
for i=1:length(x)

    if x(i)/2~=round(x(i)/2)
% X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]+0.75*boxsize;
% Y = [q_val(1,i) q_val(1,i) q_val(4,i) q_val(4,i)]; 
% C = 1;
% p1 = fill(X,Y,C)
% p1.LineWidth = 1;
% p1.LineStyle = ':';
% p1.EdgeColor = [0 0.4470 0.7410];
% p1.FaceColor = [0.9 0.95 1];

hold on
X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]+0.75*boxsize;
Y = [q_val(2,i) q_val(2,i) q_val(3,i) q_val(3,i)]; 
C = 1;
p2 = fill(X,Y,C)
p2.LineWidth = 1;
p2.LineStyle = '-';
p2.EdgeColor = [0 0.4470 0.7410];
p2.FaceColor = [0.8 0.9 1];

hold on
X = [x(i)-boxsize*0.5 x(i)+boxsize*0.5]+0.75*boxsize;
Y = [mean_val(i) mean_val(i)]; 
p3 = plot(X,Y)
p3.LineWidth = 3;
p3.LineStyle = '-';
p3.Color = [0 0.4470 0.7410];

plot(x(i)+0.75*boxsize,mean_val2(i),'x','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerSize',5,'LineWidth',1)
    else
%       X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]-0.75*boxsize;
% Y = [q_val(1,i) q_val(1,i) q_val(4,i) q_val(4,i)]; 
% C = 1;
% p1 = fill(X,Y,C)
% p1.LineWidth = 1;
% p1.LineStyle = ':';
% p1.EdgeColor = [0.8500 0.3250 0.0980];
% p1.FaceColor = [1 0.8 0.8];

hold on
X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]-0.75*boxsize;
Y = [q_val(2,i) q_val(2,i) q_val(3,i) q_val(3,i)]; 
C = 1;
p2 = fill(X,Y,C)
p2.LineWidth = 1;
p2.LineStyle = '-';
p2.EdgeColor = [0.8500 0.3250 0.0980];
p2.FaceColor = [1 0.8 0.8];

hold on
X = [x(i)-boxsize*0.5 x(i)+boxsize*0.5]-0.75*boxsize;
Y = [mean_val(i) mean_val(i)]; 
p3 = plot(X,Y)
p3.LineWidth = 3;
p3.LineStyle = '-';
p3.Color = [0.8500 0.3250 0.0980];

plot(x(i)-0.75*boxsize,mean_val2(i),'x','MarkerEdgeColor',[0.8500 0.3250 0.0980],'MarkerSize',5,'LineWidth',1)

    end

xlim([0 length(mean_val)+1])
ylim([-50 110]) % DISP
end

for ii =1:11
xline(-0.5+2*ii,':','LineWidth',0.1)
end

yline(0,':')
xline(8.5,'-')
hold off
box on
legend('First hours (95%CI)','First hours (mean)','First hours (MSA)','All hours (95%CI)','All hours (mean)','All hours (MSA)','Orientation','horizontal','Location','North','NumColumns',3)
xticks((1.5:2:25))
xticklabels({'Nov19','Nov23','Dec13','Feb16','Nov24','Nov26','Nov30','Jan15','Jan21','Apr12','Aug12'})
set(gca,'FontSize',12)
ylabel('Average Quantity Impact (MWh)')
%title('Average Price Impact')
grid off
saveas(gcf,[figurepath,'/','fig_3.eps'],'epsc')
%saveas(gcf,[figurepath,'/','quantityimpacts',num2str(prefix),'.eps'],'epsc')
pause(0.1)

%% S and RD impacts
q_val = [];
mean_val = [];
mean_val2 = [];
for ee=1:11
    for j=1:2
        idx_target = intersect(event(ee).index,find(events_d1==1));
        if j==1
        m1 = nanmean(mQ(1,idx_target));
        m0 = nanmean( nanmean(mQ_draws(idx_target,:),1) )';
        q_val = [q_val,quantile( nanmean(mQ_draws(idx_target,:),1) -m0 + m1,[0.025 0.025 0.975 0.975])']; %[quantiles x events]
        mean_val = [mean_val,m1] %[1 x events]
        else
       m1 = nanmean(mRD(1,idx_target));
        m0 = nanmean( nanmean(mRD_draws(idx_target,:),1) )';
        q_val = [q_val,quantile( nanmean(mRD_draws(idx_target,:),1) -m0 + m1,[0.025 0.025 0.975 0.975])']; %[quantiles x events]
        mean_val = [mean_val,m1] %[1 x events]        
        end

    end
end


x = (1:size(mean_val,2));
boxsize = 0.25;
x = (1:size(mean_val,2));


close all

figure(1)
for i=1:length(x)

    if x(i)/2~=round(x(i)/2)
% X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]+0.75*boxsize;
% Y = [q_val(1,i) q_val(1,i) q_val(4,i) q_val(4,i)]; 
% C = 1;
% p1 = fill(X,Y,C)
% p1.LineWidth = 1;
% p1.LineStyle = ':';
% p1.EdgeColor = [0 0.4470 0.7410];
% p1.FaceColor = [0.9 0.95 1];

hold on
X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]+0.75*boxsize;
Y = [q_val(2,i) q_val(2,i) q_val(3,i) q_val(3,i)]; 
C = 1;
p2 = fill(X,Y,C)
p2.LineWidth = 1;
p2.LineStyle = '-';
p2.EdgeColor = [0 0.4470 0.7410];
p2.FaceColor = [0.8 0.9 1];

hold on
X = [x(i)-boxsize*0.5 x(i)+boxsize*0.5]+0.75*boxsize;
Y = [mean_val(i) mean_val(i)]; 
p3 = plot(X,Y)
p3.LineWidth = 3;
p3.LineStyle = '-';
p3.Color = [0 0.4470 0.7410];

%plot(x(i)+0.75*boxsize,mean_val2(i),'x','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerSize',5,'LineWidth',1)
    else
%       X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]-0.75*boxsize;
% Y = [q_val(1,i) q_val(1,i) q_val(4,i) q_val(4,i)]; 
% C = 1;
% p1 = fill(X,Y,C)
% p1.LineWidth = 1;
% p1.LineStyle = ':';
% p1.EdgeColor = [0.8500 0.3250 0.0980];
% p1.FaceColor = [1 0.8 0.8];

hold on
X = [x(i)-boxsize/2 x(i)+boxsize/2 x(i)+boxsize/2 x(i)-boxsize/2]-0.75*boxsize;
Y = [q_val(2,i) q_val(2,i) q_val(3,i) q_val(3,i)]; 
C = 1;
p2 = fill(X,Y,C)
p2.LineWidth = 1;
p2.LineStyle = '-';
p2.EdgeColor = [0.8500 0.3250 0.0980];
p2.FaceColor = [1 0.8 0.8];

hold on
X = [x(i)-boxsize*0.5 x(i)+boxsize*0.5]-0.75*boxsize;
Y = [mean_val(i) mean_val(i)]; 
p3 = plot(X,Y)
p3.LineWidth = 3;
p3.LineStyle = '-';
p3.Color = [0.8500 0.3250 0.0980];

%plot(x(i)-0.75*boxsize,mean_val2(i),'x','MarkerEdgeColor',[0.8500 0.3250 0.0980],'MarkerSize',5,'LineWidth',1)

    end

xlim([0 length(mean_val)+1])
ylim([-150 300]) % DISP
end

for ii =1:11
xline(-0.5+2*ii,':','LineWidth',0.1)
end

yline(0,':')
xline(8.5,'-')
hold off
box on
legend('Supply shift (95%CI)','Supply shift (mean)','RD shift (95%CI)','RD shift (mean)',...
    'Orientation','horizontal','Location','North','NumColumns',2)
xticks((1.5:2:25))
xticklabels({'Nov19','Nov23','Dec13','Feb16','Nov24','Nov26','Nov30','Jan15','Jan21','Apr12','Aug12'})
set(gca,'FontSize',12)
ylabel('Average Bid Impact (MWh)')
%title('Average Price Impact')
grid off
saveas(gcf,[figurepath,'/','fig_5.eps'],'epsc')
%saveas(gcf,[figurepath,'/','SRDimpacts',num2str(prefix),'.eps'],'epsc')

%% Profit impacts

q_val = [];
mean_val = [];
mean_val2 = [];
mean_val3 = [];
mean_val4 = [];
for ee=[1 2 3 4 7 8 10 11]
    for j=1:2
        if j==1
        idx_target = intersect(event(ee).index,find(events_d1==1));
        m0 = mean( sum(PROFIT_hhc_draws(idx_target,:),1) )';
m1 = sum(PROFIT_hhc(idx_target));
q_val = [q_val,1/1e6*quantile((sum(PROFIT_hhc_draws(idx_target,:),1) -m0 + m1),[0.025 0.025 0.975 0.975])']; %[quantiles x events]
mean_val = [mean_val,1/1e6*m1] %[1 x events]
mean_val2 = [mean_val2,1/1e6*sum(PROFIT_hh2(idx_target))] %[1 x events]
mean_val3 = [mean_val3,1/1e6*sum(PROFIT_occ(idx_target))] %[1 x events]   
mean_val4 = [mean_val4,1/1e6*sum(PROFIT_oo(idx_target)-PROFIT_hhc(idx_target))] %[1 x events]   
        else 
idx_target = intersect(event(ee).index,find(events_d==1));
m0 = mean( sum(PROFIT_hhc_draws(idx_target,:),1) )';
m1 = sum(PROFIT_hhc(idx_target));
q_val = [q_val,1/1e6*quantile((sum(PROFIT_hhc_draws(idx_target,:),1) -m0 + m1),[0.025 0.025 0.975 0.975])']; %[quantiles x events]
mean_val = [mean_val,1/1e6*m1] %[1 x events]
mean_val2 = [mean_val2,1/1e6*sum(PROFIT_hh2(idx_target))] %[1 x events]
mean_val3 = [mean_val3,1/1e6*sum(PROFIT_occ(idx_target))] %[1 x events]    
mean_val4 = [mean_val4,1/1e6*sum(PROFIT_oo(idx_target)-PROFIT_hhc(idx_target))] %[1 x events]   

        end
    end
end

VAL1 = [mean_val(1:2:end);mean_val3(1:2:end);mean_val2(1:2:end)];
VAL2 = [mean_val(2:2:end);mean_val3(2:2:end);mean_val2(2:2:end)];

BB = [[[VAL1(1,:);VAL1(2,:)./VAL1(1,:);1-VAL1(3,:)./VAL1(1,:)],[sum(VAL1(1,:),2);sum(VAL1(2,:),2)/sum(VAL1(1,:),2);1-sum(VAL1(3,:),2)/sum(VAL1(1,:),2)]];...
[[VAL2(1,:);VAL2(2,:)./VAL2(1,:);1-VAL2(3,:)./VAL2(1,:)],[sum(VAL2(1,:),2);sum(VAL2(2,:),2)/sum(VAL2(1,:),2);1-sum(VAL2(3,:),2)/sum(VAL2(1,:),2)]]];

BB
sum(mean_val(1:2:2*4))./sum(mean_val3(1:2:2*4)) %on trouve un effet 27% plus grand 
sum(mean_val(2:2:2*4))./sum(mean_val3(2:2:2*4)) %on trouve un effet 11% plus grand 

(mean_val(1:2:2*4))./(mean_val4(1:2:2*4))
(mean_val(2:2:2*4))./(mean_val4(2:2:2*4))

mean_val./mean_val4

%% Profit table

Labelx = repmat({'$\,$ Gains (M\$)','$\,$ MSA (\%)','$\,$ Direct (\%)',...
    '$\,$ Gains (M\$)','$\,$ MSA (\%)','$\,$ Direct (\%)',...
    },1,1);

clear BHAT2 SHAT2
BHAT = BB;

for ii=[1 4]
    for i=1:8
        BHAT2{ii,i} =  ['$',num2str( (BHAT(ii,i)) ,'%0.1f'),'$'];
    end
    BHAT2{ii,9} =  ['$',num2str( (BHAT(ii,9)) ,'%0.0f'),'$'];
end
for ii=[2 3 5 6]
    for i=1:9
        BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i)*100,'%0.0f'),'$'];
    end
end
    
BHAT2
    

TABLE2 = ['\begin{tabular*}{1\hsize}{@{\tabcolsep\extracolsep\fill}l*{9}{r}}',...
    ' \toprule & \multicolumn{1}{c}{Nov19} & \multicolumn{1}{c}{Nov23} & \multicolumn{1}{c}{Dec13} & \multicolumn{1}{c}{Feb16} & \multicolumn{1}{c}{Nov30} & \multicolumn{1}{c}{Jan15} & \multicolumn{1}{c}{Apr12} & \multicolumn{1}{c}{Aug12} & \multicolumn{1}{c}{Tot.}    \\',...
    ' \cmidrule(lr){2-10}  ',...
    ' \emph{First hours} & \multicolumn{8}{c}{ } \\ '];

for ii=1:3
    TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        BHAT2{ii,1},' & ',BHAT2{ii,2},' & ',BHAT2{ii,3},' & ',BHAT2{ii,4},' & ',BHAT2{ii,5},' & ',BHAT2{ii,6},' & ',BHAT2{ii,7},' & ',BHAT2{ii,8},' & ',BHAT2{ii,9}...
        '  \\ '];
end

TABLE2 = [TABLE2,...
    ' \cmidrule(lr){2-10}  ',...
    ' \emph{All hours} & \multicolumn{8}{c}{ } \\ '];

for ii=4:6
    TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        BHAT2{ii,1},' & ',BHAT2{ii,2},' & ',BHAT2{ii,3},' & ',BHAT2{ii,4},' & ',BHAT2{ii,5},' & ',BHAT2{ii,6},' & ',BHAT2{ii,7},' & ',BHAT2{ii,8},' & ',BHAT2{ii,9}...
        '  \\ '];
end



 TABLE2 = [TABLE2,...
        '\bottomrule \end{tabular*}'];

 results_struct(prefix+1).PROFIT = BB;

%if savetable==1
fileID = fopen([tablepath,'/table_8.tex'],'w');
fprintf(fileID,'%s',TABLE2);
fclose(fileID);
%end

%% Welfare impacts
q_val = [];
mean_val = [];
mean_val2 = [];
mean_val3 = [];
mean_val4 = [];
for ee=[1 2 3 4 7 8 10 11]
    for j=1:2
        if j==1
        idx_target = intersect(event(ee).index,find(events_d1==1));
        m0 = mean( sum(TCOST_hhc_draws(idx_target,:),1) )';
m1 = sum(TCOST_hhc(idx_target));
q_val = [q_val,1/1e6*quantile((sum(TCOST_hhc_draws(idx_target,:),1) -m0 + m1),[0.025 0.025 0.975 0.975])']; %[quantiles x events]
mean_val = [mean_val,1/1e6*m1] %[1 x events]
mean_val2 = [mean_val2,1/1e6*sum(TCOST_hh2(idx_target))] %[1 x events]
mean_val3 = [mean_val3,1/1e6*sum(TCOST_occ(idx_target))] %[1 x events]    
mean_val4 = [mean_val4,1/1e6*sum(TCOST_oo(idx_target) - TCOST_hhc(idx_target) )] %[1 x events]   
        else 
idx_target = intersect(event(ee).index,find(events_d==1));
m0 = mean( sum(TCOST_hhc_draws(idx_target,:),1) )';
m1 = sum(TCOST_hhc(idx_target));
q_val = [q_val,1/1e6*quantile((sum(TCOST_hhc_draws(idx_target,:),1) -m0 + m1),[0.025 0.025 0.975 0.975])']; %[quantiles x events]
mean_val = [mean_val,1/1e6*m1] %[1 x events]
mean_val2 = [mean_val2,1/1e6*sum(TCOST_hh2(idx_target))] %[1 x events]
mean_val3 = [mean_val3,1/1e6*sum(TCOST_occ(idx_target))] %[1 x events]   
mean_val4 = [mean_val4,1/1e6*sum(TCOST_oo(idx_target) - TCOST_hhc(idx_target))] %[1 x events]   
        end
    end
end


VAL1 = [mean_val(1:2:end);mean_val3(1:2:end);mean_val2(1:2:end)];
VAL2 = [mean_val(2:2:end);mean_val3(2:2:end);mean_val2(2:2:end)];

BB = [[[VAL1(1,:);VAL1(2,:)./VAL1(1,:);1-VAL1(3,:)./VAL1(1,:)],[sum(VAL1(1,:),2);sum(VAL1(2,:),2)/sum(VAL1(1,:),2);1-sum(VAL1(3,:),2)/sum(VAL1(1,:),2)]];...
[[VAL2(1,:);VAL2(2,:)./VAL2(1,:);1-VAL2(3,:)./VAL2(1,:)],[sum(VAL2(1,:),2);sum(VAL2(2,:),2)/sum(VAL2(1,:),2);1-sum(VAL2(3,:),2)/sum(VAL2(1,:),2)]]];

% relative values
sum(mean_val(1:2:2*4))./sum(mean_val3(1:2:2*4)) % first hours 4 main events
sum(mean_val(2:2:2*4))./sum(mean_val3(2:2:2*4)) % all hours 4 main events

sum(mean_val(1:2:end))./sum(mean_val4(1:2:end))
sum(mean_val(2:2:end))./sum(mean_val4(2:2:end))

mean_val./mean_val4

idx_target = find(DATE>=datetime(2010,11,1) & DATE<datetime(2011,9,1));
idx_target = find(DATE>=datetime(2010,11,1) & DATE<datetime(2011,3,1));
sum(mean_val(2:2:8))/(sum(PRICE(idx_target).*DISP(idx_target))/1e6-sum(mean_val(2:2:8)))
sum(mean_val(1:2:8))/(sum(PRICE(idx_target).*DISP(idx_target))/1e6-sum(mean_val(1:2:8)))

idx_target = find(DATE>=datetime(2010,9,1) & DATE<datetime(2011,9,1));
sum(mean_val(1:2:end))/(sum(PRICE(idx_target).*DISP(idx_target))/1e6 - sum(mean_val(1:2:end)))
sum(mean_val(2:2:end))/((sum(PRICE(idx_target).*DISP(idx_target))/1e6)-sum(mean_val(2:2:end)))

%% Welfare table

Labelx = repmat({'$\,$ Transfer (M\$)','$\,$ MSA (\%)','$\,$ Direct (\%)',...
    '$\,$ Gains (M\$)','$\,$ MSA (\%)','$\,$ Direct (\%)',...
    },1,1);

clear BHAT2 SHAT2
BHAT = BB;

for ii=[1 4]
    for i=1:8
        BHAT2{ii,i} =  ['$',num2str( (BHAT(ii,i)) ,'%0.1f'),'$'];
    end
    BHAT2{ii,9} =  ['$',num2str( (BHAT(ii,9)) ,'%0.0f'),'$'];
end
for ii=[2 3 5 6]
    for i=1:9
        BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i)*100,'%0.0f'),'$'];
    end
end
    
BHAT2
    

TABLE2 = ['\begin{tabular*}{1\hsize}{@{\tabcolsep\extracolsep\fill}l*{9}{r}}',...
    ' \toprule & \multicolumn{1}{c}{Nov19} & \multicolumn{1}{c}{Nov23} & \multicolumn{1}{c}{Dec13} & \multicolumn{1}{c}{Feb16} & \multicolumn{1}{c}{Nov30} & \multicolumn{1}{c}{Jan15} & \multicolumn{1}{c}{Apr12} & \multicolumn{1}{c}{Aug12} & \multicolumn{1}{c}{Tot.}    \\',...
    ' \cmidrule(lr){2-10}  ',...
    ' \emph{First hours} & \multicolumn{8}{c}{ } \\ '];

for ii=1:3
    TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        BHAT2{ii,1},' & ',BHAT2{ii,2},' & ',BHAT2{ii,3},' & ',BHAT2{ii,4},' & ',BHAT2{ii,5},' & ',BHAT2{ii,6},' & ',BHAT2{ii,7},' & ',BHAT2{ii,8},' & ',BHAT2{ii,9}...
        '  \\ '];
end

TABLE2 = [TABLE2,...
    ' \cmidrule(lr){2-10}  ',...
    ' \emph{All hours} & \multicolumn{8}{c}{ } \\ '];

for ii=4:6
    TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        BHAT2{ii,1},' & ',BHAT2{ii,2},' & ',BHAT2{ii,3},' & ',BHAT2{ii,4},' & ',BHAT2{ii,5},' & ',BHAT2{ii,6},' & ',BHAT2{ii,7},' & ',BHAT2{ii,8},' & ',BHAT2{ii,9}...
        '  \\ '];
end



 TABLE2 = [TABLE2,...
        '\bottomrule \end{tabular*}'];

results_struct(prefix+1).WELFARE = BB;

%if savetable==1
fileID = fopen([tablepath,'/table_9.tex'],'w');
fprintf(fileID,'%s',TABLE2);
fclose(fileID);
%end

