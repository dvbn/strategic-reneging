
for peak_d = 0:1
load(['Tempfiles/temp',num2str(prefix),'_CASE_',num2str(peak_d),'.mat'], 'CASE')
load(['Tempfiles/temp',num2str(prefix),'_CVM_',num2str(peak_d),'.mat'], 'CVM')
load(['Tempfiles/temp',num2str(prefix),'_',num2str(peak_d),'.mat'])
load(['Tempfiles/temp',num2str(prefix),'_',num2str(peak_d),'_bs.mat'])

%% Store inference results

SUMSTATS(9).REJ_i = zeros(5,4);
SUMSTATS(9).REJ_b = zeros(5,4);
SUMSTATS(1).REJ_i = zeros(5,4);
SUMSTATS(1).REJ_b = zeros(5,4);

SUMSTATS(10).CP_PRICE = zeros(5,4);
SUMSTATS(10).CP_PRICE0 = zeros(5,4);
SUMSTATS(10).CP_PRICE2 = zeros(5,4);
SUMSTATS(10).CP_DISP = zeros(5,4);
SUMSTATS(10).CP_DISP0 = zeros(5,4);
SUMSTATS(10).CP_DISP2 = zeros(5,4);

for ij=1:4
    %Rejection rate imhof test (entire function)
    SUMSTATS(9).REJ_i(1,ij) = nan; %mean(CVM(ij).ipvalQ(idx_train)<0.05);
    SUMSTATS(9).REJ_i(2,ij) = mean(CVM(ij).ipvalQ(idx_valid)<0.05);
    SUMSTATS(9).REJ_i(3,ij) = mean(CVM(ij).ipvalQ(idx_events)<0.05);
    SUMSTATS(9).REJ_i(4,ij) = mean(CVM(ij).ipvalQ(idx_events2)<0.05);
    SUMSTATS(9).REJ_i(5,ij) = mean(CVM(ij).ipvalQ(idx_events3)<0.05);

    %Rejection rate bootstrap test (entire function)
    SUMSTATS(9).REJ_b(1,ij) = nan; %mean(CVM(ij).bpvalQ(idx_train)<0.05);
    SUMSTATS(9).REJ_b(2,ij) = mean(CVM(ij).bpvalQ(idx_valid)<0.05);
    SUMSTATS(9).REJ_b(3,ij) = mean(CVM(ij).bpvalQ(idx_events)<0.05);
    SUMSTATS(9).REJ_b(4,ij) = mean(CVM(ij).bpvalQ(idx_events2)<0.05);
    SUMSTATS(9).REJ_b(5,ij) = mean(CVM(ij).bpvalQ(idx_events3)<0.05);

    %Rejection rate imhof test (entire function)
    SUMSTATS(1).REJ_i(1,ij) = nan; %mean(CVM(ij).ipvalRD(idx_train)<0.05);
    SUMSTATS(1).REJ_i(2,ij) = mean(CVM(ij).ipvalRD(idx_valid)<0.05);
    SUMSTATS(1).REJ_i(3,ij) = mean(CVM(ij).ipvalRD(idx_events)<0.05);
    SUMSTATS(1).REJ_i2(3,ij) = mean(CVM(1).ipvalRD2(idx_events)<0.05);
    SUMSTATS(1).REJ_i(4,ij) = mean(CVM(ij).ipvalRD(idx_events2)<0.05);
    SUMSTATS(1).REJ_i2(4,ij) = mean(CVM(1).ipvalRD2(idx_events2)<0.05);
    SUMSTATS(1).REJ_i(5,ij) = mean(CVM(ij).ipvalRD(idx_events3)<0.05);
    SUMSTATS(1).REJ_i2(5,ij) = mean(CVM(1).ipvalRD2(idx_events3)<0.05);

    %Rejection rate bootstrap test (entire function)
    SUMSTATS(1).REJ_b(1,ij) = nan; %mean(CVM(ij).bpvalRD(idx_train)<0.05);
    SUMSTATS(1).REJ_b(2,ij) = mean(CVM(ij).bpvalRD(idx_valid)<0.05);
    SUMSTATS(1).REJ_b(3,ij) = mean(CVM(ij).bpvalRD(idx_events)<0.05);
    SUMSTATS(1).REJ_b2(3,ij) = mean(CVM(1).ipvalRD2(idx_events)<0.05);
    SUMSTATS(1).REJ_b(4,ij) = mean(CVM(ij).bpvalRD(idx_events2)<0.05);
    SUMSTATS(1).REJ_b2(4,ij) = mean(CVM(1).ipvalRD2(idx_events2)<0.05);
    SUMSTATS(1).REJ_b(5,ij) = mean(CVM(ij).bpvalRD(idx_events3)<0.05);
    SUMSTATS(1).REJ_b2(5,ij) = mean(CVM(1).ipvalRD2(idx_events3)<0.05);
end


%% PRICE and OUTPUT predictions
% We look at whether the true values fall in the CI95% of our predictions based on both predictions of RD and S 
% Estim S, True RD
SUMSTATS(10).CP_PRICE0(1) = 1-mean((PRICE_oo(idx_train)>quantile(PRICE_draws3(idx_train,:)',0.975)')+(PRICE_oo(idx_train)<quantile(PRICE_draws3(idx_train,:)',0.025)'));
SUMSTATS(10).CP_PRICE0(2) = 1-mean((PRICE_oo(idx_valid)>quantile(PRICE_draws3(idx_valid,:)',0.975)')+(PRICE_oo(idx_valid)<quantile(PRICE_draws3(idx_valid,:)',0.025)'));
SUMSTATS(10).CP_PRICE0(3) = 1-mean((PRICE_oo(idx_events)>quantile(PRICE_draws3(idx_events,:)',0.975)')+(PRICE_oo(idx_events)<quantile(PRICE_draws3(idx_events,:)',0.025)'));
SUMSTATS(10).CP_PRICE0(4) = 1-mean((PRICE_oo(idx_events2)>quantile(PRICE_draws3(idx_events2,:)',0.975)')+(PRICE_oo(idx_events2)<quantile(PRICE_draws3(idx_events2,:)',0.025)'));
% Estim S, Construct. RD
SUMSTATS(10).CP_PRICE(1) = 1-mean((PRICE_oo(idx_train)>quantile(PRICE_draws(idx_train,:)',0.975)')+(PRICE_oo(idx_train)<quantile(PRICE_draws(idx_train,:)',0.025)'));
SUMSTATS(10).CP_PRICE(2) = 1-mean((PRICE_oo(idx_valid)>quantile(PRICE_draws(idx_valid,:)',0.975)')+(PRICE_oo(idx_valid)<quantile(PRICE_draws(idx_valid,:)',0.025)'));
SUMSTATS(10).CP_PRICE(3) = 1-mean((PRICE_oo(idx_events)>quantile(PRICE_draws(idx_events,:)',0.975)')+(PRICE_oo(idx_events)<quantile(PRICE_draws(idx_events,:)',0.025)'));
SUMSTATS(10).CP_PRICE(4) = 1-mean((PRICE_oo(idx_events2)>quantile(PRICE_draws(idx_events2,:)',0.975)')+(PRICE_oo(idx_events2)<quantile(PRICE_draws(idx_events2,:)',0.025)'));
% Estim S, Estim RD
SUMSTATS(10).CP_PRICE2(1) = 1-mean((PRICE_oo(idx_train)>quantile(PRICE_draws2(idx_train,:)',0.975)')+(PRICE_oo(idx_train)<quantile(PRICE_draws2(idx_train,:)',0.025)'));
SUMSTATS(10).CP_PRICE2(2) = 1-mean((PRICE_oo(idx_valid)>quantile(PRICE_draws2(idx_valid,:)',0.975)')+(PRICE_oo(idx_valid)<quantile(PRICE_draws2(idx_valid,:)',0.025)'));
SUMSTATS(10).CP_PRICE2(3) = 1-mean((PRICE_oo(idx_events)>quantile(PRICE_draws2(idx_events,:)',0.975)')+(PRICE_oo(idx_events)<quantile(PRICE_draws2(idx_events,:)',0.025)'));
SUMSTATS(10).CP_PRICE2(4) = 1-mean((PRICE_oo(idx_events2)>quantile(PRICE_draws2(idx_events2,:)',0.975)')+(PRICE_oo(idx_events2)<quantile(PRICE_draws2(idx_events2,:)',0.025)'));
% Estim S, True RD
SUMSTATS(10).CP_DISP0(1) = 1-mean((DISP_oo(idx_train)>quantile(DISP_draws3(idx_train,:)',0.975)')+(DISP_oo(idx_train)<quantile(DISP_draws3(idx_train,:)',0.025)'));
SUMSTATS(10).CP_DISP0(2) = 1-mean((DISP_oo(idx_valid)>quantile(DISP_draws3(idx_valid,:)',0.975)')+(DISP_oo(idx_valid)<quantile(DISP_draws3(idx_valid,:)',0.025)'));
SUMSTATS(10).CP_DISP0(3) = 1-mean((DISP_oo(idx_events)>quantile(DISP_draws3(idx_events,:)',0.975)')+(DISP_oo(idx_events)<quantile(DISP_draws3(idx_events,:)',0.025)'));
SUMSTATS(10).CP_DISP0(4) = 1-mean((DISP_oo(idx_events2)>quantile(DISP_draws3(idx_events2,:)',0.975)')+(DISP_oo(idx_events2)<quantile(DISP_draws3(idx_events2,:)',0.025)'));
% Estim S, Construct. RD
SUMSTATS(10).CP_DISP(1) = 1-mean((DISP_oo(idx_train)>quantile(DISP_draws(idx_train,:)',0.975)')+(DISP_oo(idx_train)<quantile(DISP_draws(idx_train,:)',0.025)'));
SUMSTATS(10).CP_DISP(2) = 1-mean((DISP_oo(idx_valid)>quantile(DISP_draws(idx_valid,:)',0.975)')+(DISP_oo(idx_valid)<quantile(DISP_draws(idx_valid,:)',0.025)'));
SUMSTATS(10).CP_DISP(3) = 1-mean((DISP_oo(idx_events)>quantile(DISP_draws(idx_events,:)',0.975)')+(DISP_oo(idx_events)<quantile(DISP_draws(idx_events,:)',0.025)'));
SUMSTATS(10).CP_DISP(4) = 1-mean((DISP_oo(idx_events2)>quantile(DISP_draws(idx_events2,:)',0.975)')+(DISP_oo(idx_events2)<quantile(DISP_draws(idx_events2,:)',0.025)'));
% Estim S, Estim RD
SUMSTATS(10).CP_DISP2(1) = 1-mean((DISP_oo(idx_train)>quantile(DISP_draws2(idx_train,:)',0.975)')+(DISP_oo(idx_train)<quantile(DISP_draws2(idx_train,:)',0.025)'));
SUMSTATS(10).CP_DISP2(2) = 1-mean((DISP_oo(idx_valid)>quantile(DISP_draws2(idx_valid,:)',0.975)')+(DISP_oo(idx_valid)<quantile(DISP_draws2(idx_valid,:)',0.025)'));
SUMSTATS(10).CP_DISP2(3) = 1-mean((DISP_oo(idx_events)>quantile(DISP_draws2(idx_events,:)',0.975)')+(DISP_oo(idx_events)<quantile(DISP_draws2(idx_events,:)',0.025)'));
SUMSTATS(10).CP_DISP2(4) = 1-mean((DISP_oo(idx_events2)>quantile(DISP_draws2(idx_events2,:)',0.975)')+(DISP_oo(idx_events2)<quantile(DISP_draws2(idx_events2,:)',0.025)'));




%% Table prediction accuracy - Table 5
clear BHAT2 BHAT3;

%Supply
for i=1:2
%Bias
BHAT2{1,i} =  ['$',num2str(SUMSTATS(9).BIAS(i),'%0.1f'),'$'];
%Absolute bias
BHAT2{2,i} =  ['$',num2str(SUMSTATS(9).ABIAS(i),'%0.1f'),'$'];
%Relative bias
BHAT2{3,i} =  ['$',num2str(100*SUMSTATS(9).ARBIAS(i),'%0.1f'),'\% $'];
%Std
BHAT2{4,i} =  ['$',num2str(SUMSTATS(9).STD(i),'%0.1f'),'$'];
%RMSE
BHAT2{5,i} =  ['$',num2str(SUMSTATS(9).RMSE(i),'%0.1f'),'$'];
%Rejection rate imhof entire function
BHAT2{6,i} =  ['$',num2str(SUMSTATS(9).REJ_i(i,1),'%0.3f'),'$'];
%Rejection rate bootstrap entire function
BHAT2{7,i} =  ['$',num2str(SUMSTATS(9).REJ_b(i,1),'%0.3f'),'$'];
end
i = 3
%Bias
BHAT2{1,i} =  ['$',num2str(SUMSTATS(9).BIAS(5),'%0.1f'),'$'];
%Absolute bias
BHAT2{2,i} =  ['$',num2str(SUMSTATS(9).ABIAS(5),'%0.1f'),'$'];
%Relative bias
BHAT2{3,i} =  ['$',num2str(100*SUMSTATS(9).ARBIAS(5),'%0.1f'),'\% $'];
%Std
BHAT2{4,i} =  ['$',num2str(SUMSTATS(9).STD(5),'%0.1f'),'$'];
%RMSE
BHAT2{5,i} =  ['$',num2str(SUMSTATS(9).RMSE(5),'%0.1f'),'$'];
%Rejection rate imhof entire function
BHAT2{6,i} =  ['$',num2str(SUMSTATS(9).REJ_i(5,1),'%0.3f'),'$'];
%Rejection rate bootstrap entire function
BHAT2{7,i} =  ['$',num2str(SUMSTATS(9).REJ_b(5,1),'%0.3f'),'$'];

%Parameters
BHAT2{11,1} =  ['$',num2str(size(Xg,2),'%0.0f'),'$'];
BHAT2{11,2} =  [' '];
BHAT2{11,3} =  [' '];
%Zero parameters
BHAT2{12,1} =  ['$',num2str(size(Xg,2)-SUMSTATS(9).PARAMS,'%0.0f'),'$'];
BHAT2{12,2} =  [' '];
BHAT2{12,3} =  [' '];
%Tuning parameter
BHAT2{13,1} =  ['$',num2str(LAMBDA_Q_min,'%0.3f'),'$'];
BHAT2{13,2} =  [' '];
BHAT2{13,3} =  [' '];

%Residual demand
%Bias
BHAT3{1,1} =  ['$',num2str(SUMSTATS(1).BIAS(1),'%0.1f'),'$'];
BHAT3{1,2} =  ['$',num2str(SUMSTATS(1).BIAS(2),'%0.1f'),'$'];
BHAT3{1,3} =  ['$',num2str(SUMSTATS(1).BIAS(5),'%0.1f'),'$'];
BHAT3{1,4} =  ['$',num2str(SUMSTATS(1).BIAS2(5),'%0.1f'),'$'];
%Absolute bias
BHAT3{2,1} =  ['$',num2str(SUMSTATS(1).ABIAS(1),'%0.1f'),'$'];
BHAT3{2,2} =  ['$',num2str(SUMSTATS(1).ABIAS(2),'%0.1f'),'$'];
BHAT3{2,3} =  ['$',num2str(SUMSTATS(1).ABIAS(5),'%0.1f'),'$'];
BHAT3{2,4} =  ['$',num2str(SUMSTATS(1).ABIAS2(5),'%0.1f'),'$'];
%Std
BHAT3{4,1} =  ['$',num2str(SUMSTATS(1).STD(1),'%0.1f'),'$'];
BHAT3{4,2} =  ['$',num2str(SUMSTATS(1).STD(2),'%0.1f'),'$'];
BHAT3{4,3} =  ['$',num2str(SUMSTATS(1).STD(5),'%0.1f'),'$'];
BHAT3{4,4} =  ['$',num2str(SUMSTATS(1).STD2(5),'%0.1f'),'$'];
%Relative bias
BHAT3{3,1} =  ['$',num2str(100*SUMSTATS(1).ARBIAS(1),'%0.1f'),'\% $'];
BHAT3{3,2} =  ['$',num2str(100*SUMSTATS(1).ARBIAS(2),'%0.1f'),'\% $'];
BHAT3{3,3} =  ['$',num2str(100*SUMSTATS(1).ARBIAS(5),'%0.1f'),'\% $'];
BHAT3{3,4} =  ['$',num2str(100*SUMSTATS(1).ARBIAS2(5),'%0.1f'),'\% $'];
%RMSE
BHAT3{5,1} =  ['$',num2str(SUMSTATS(1).RMSE(1),'%0.1f'),'$'];
BHAT3{5,2} =  ['$',num2str(SUMSTATS(1).RMSE(2),'%0.1f'),'$'];
BHAT3{5,3} =  ['$',num2str(SUMSTATS(1).RMSE(5),'%0.1f'),'$'];
BHAT3{5,4} =  ['$',num2str(SUMSTATS(1).RMSE2(5),'%0.1f'),'$'];

%Rejection rate imhof entire function
BHAT3{6,1} =  ['$',num2str(SUMSTATS(1).REJ_i(1,1),'%0.3f'),'$'];
BHAT3{6,2} =  ['$',num2str(SUMSTATS(1).REJ_i(2,1),'%0.3f'),'$'];
BHAT3{6,3} =  ['$',num2str(SUMSTATS(1).REJ_i(5,1),'%0.3f'),'$'];
%BHAT3{6,4} =  ['$',num2str(SUMSTATS(1).REJ_i2(3,1),'%0.3f'),'$'];
BHAT3{6,4} =  ['$','1','$'];
%Rejection rate bootstrap entire function
BHAT3{7,1} =  ['$',num2str(SUMSTATS(1).REJ_b(1,1),'%0.3f'),'$'];
BHAT3{7,2} =  ['$',num2str(SUMSTATS(1).REJ_b(2,1),'%0.3f'),'$'];
BHAT3{7,3} =  ['$',num2str(SUMSTATS(1).REJ_b(5,1),'%0.3f'),'$'];
%BHAT3{7,4} =  ['$',num2str(SUMSTATS(1).REJ_b2(3,1),'%0.3f'),'$'];
BHAT3{7,4} =  ['$','1','$'];

%Parameters
BHAT3{11,1} =  ['$',num2str(size(Xg,2),'%0.0f'),'$'];
BHAT3{11,2} =  [' '];
BHAT3{11,3} =  [' '];
%Zero parameters
BHAT3{12,1} =  ['$',num2str(size(Xg,2)-SUMSTATS(1).PARAMS,'%0.0f'),'$'];
BHAT3{12,2} =  [' '];
BHAT3{12,3} =  [' '];
%Tuning parameter
BHAT3{13,1} =  ['$',num2str(LAMBDA_RD_min,'%0.3f'),'$'];
BHAT3{13,2} =  [' '];
BHAT3{13,3} =  [' '];
%Price coverage prob
BHAT3{14,1} =  ['$',num2str(SUMSTATS(10).CP_PRICE(1),'%0.2f'),'$'];
BHAT3{14,2} =  ['$',num2str(SUMSTATS(10).CP_PRICE(2),'%0.2f'),'$'];
BHAT3{14,3} =  ['$',num2str(SUMSTATS(10).CP_PRICE0(3),'%0.2f'),'$'];
BHAT3{15,1} =  ['$',num2str(SUMSTATS(10).CP_DISP(1),'%0.2f'),'$'];
BHAT3{15,2} =  ['$',num2str(SUMSTATS(10).CP_DISP(2),'%0.2f'),'$'];
BHAT3{15,3} =  ['$',num2str(SUMSTATS(10).CP_DISP0(3),'%0.2f'),'$'];
BHAT3{16,1} =  ['$',num2str(SUMSTATS(10).CP_PRICE2(1),'%0.2f'),'$'];
BHAT3{16,2} =  ['$',num2str(SUMSTATS(10).CP_PRICE2(2),'%0.2f'),'$'];
BHAT3{16,3} =  ['$',num2str(SUMSTATS(10).CP_PRICE2(3),'%0.2f'),'$'];
BHAT3{17,1} =  ['$',num2str(SUMSTATS(10).CP_DISP2(1),'%0.2f'),'$'];
BHAT3{17,2} =  ['$',num2str(SUMSTATS(10).CP_DISP2(2),'%0.2f'),'$'];
BHAT3{17,3} =  ['$',num2str(SUMSTATS(10).CP_DISP2(3),'%0.2f'),'$'];
BHAT3{18,3} =  ['$',num2str(SUMSTATS(10).CP_PRICE(3),'%0.2f'),'$'];
BHAT3{19,3} =  ['$',num2str(SUMSTATS(10).CP_DISP(3),'%0.2f'),'$'];


Labelx = {'Mean Int. Bias','Mean Int. Abs. Bias',...
    'Mean Int. Rel. Abs. Bias','Int. Standard Deviation','RIMSE','Rejection Rate (Imhof) $H_0$',... %,'Int. Standard Deviation'
    'Rejection Rate (BS) $H_0$',...
    'Rejection Rate (BS) $H_{01}$','Rejection Rate (BS) $H_{02}$','Rejection Rate (BS) $H_{03}$',...
    'Parameters',...
    'Zero parameters','$\lambda_{CV}$','Price','Output',...
    };

TABLE2 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{8}{c}}',...
    ' \toprule  & \multicolumn{2}{c}{Training set} & \multicolumn{2}{c}{Testing set} & \multicolumn{3}{c}{Reneging set}   \\',...
    ' \hline ',...
    ];

TABLE2 = [TABLE2,...
    ' n & \multicolumn{2}{c}{$',num2str(length(idx_train),'%0.0f'),'$} & ',...
    '\multicolumn{2}{c}{$',num2str(length(idx_valid),'%0.0f'),'$} & ',...
    '\multicolumn{3}{c}{$',num2str(length(idx_events3),'%0.0f'),'$} \\',...
    Labelx{11},' & ',...
    '\multicolumn{2}{c}{',BHAT2{11,1},'} & ',...
    '\multicolumn{2}{c}{',BHAT2{11,2},'} & ',...
    '\multicolumn{3}{c}{',BHAT2{11,3},'}  \\ ',...
    '  \hline ',...
    '  & $S$ & $RS$ & $S$ & $RS$ & $S$ & $RS$ & $\overline{RS}$  \\ '];

for ii=setdiff((1:13),[4,(8:11)])
    TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        '\multicolumn{1}{c}{',BHAT2{ii,1},'} & ','\multicolumn{1}{c}{',BHAT3{ii,1},'} & ',...
        '\multicolumn{1}{c}{',BHAT2{ii,2},'} & ','\multicolumn{1}{c}{',BHAT3{ii,2},'} & ',...
        '\multicolumn{1}{c}{',BHAT2{ii,3},'} & ','\multicolumn{1}{c}{',BHAT3{ii,4},'} & ',BHAT3{ii,3},'  \\ '];
end


TABLE2 = [TABLE2,...
    ' \hline ',' \emph{Coverage probabilities} & $RS$ & $\hat{RS}$ & $RS$ & $\hat{RS}$ & $RS$ &  $\hat{RS}$ & $\overline{RS}$  \\ '];

for ii=14:15
    TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        BHAT3{ii,1},' & ',BHAT3{ii+2,1},' & ',...
        BHAT3{ii,2},' & ',BHAT3{ii+2,2},' & ',...
        BHAT3{ii,3},' & ',BHAT3{ii+2,3},' & ',BHAT3{ii+4,3},'  \\  '];
end

TABLE2 = [TABLE2,...
    ' \bottomrule \end{tabular*}'];

if peak_d==1
    fileID = fopen([tablepath,'/table_6.tex'],'w'); %PRED_PEAK
else
    fileID = fopen([tablepath,'/table_B2.tex'],'w'); %PRED_OFFPEAK
end
fprintf(fileID,'%s',TABLE2);
fclose(fileID);

if peak_d==1
    %% Prep Table with S & RD results

    for ij=1:3
        ENTRY(ij).B = reshape(CVM(ij+1).mQ(intersect(intersect(idx_events,find(HOUR>=18 & HOUR<=19)),[idx_event1_1;idx_event2_1;idx_event3_1;idx_event4_1])),[2 4]);
        ENTRY(ij).PVAL = reshape(CVM(ij+1).bpvalQ(intersect(intersect(idx_events,find(HOUR>=18 & HOUR<=19)),[idx_event1_1;idx_event2_1;idx_event3_1;idx_event4_1])),[2 4]);

    end

BHAT =[ENTRY(1).B(:,1),ENTRY(2).B(:,1),ENTRY(3).B(:,1),ENTRY(1).B(:,2),ENTRY(2).B(:,2),ENTRY(3).B(:,2);...
    ENTRY(1).B(:,3),ENTRY(2).B(:,3),ENTRY(3).B(:,3),ENTRY(1).B(:,4),ENTRY(2).B(:,4),ENTRY(3).B(:,4)];

SHAT =[ENTRY(1).PVAL(:,1),ENTRY(2).PVAL(:,1),ENTRY(3).PVAL(:,1),ENTRY(1).PVAL(:,2),ENTRY(2).PVAL(:,2),ENTRY(3).PVAL(:,2);...
    ENTRY(1).PVAL(:,3),ENTRY(2).PVAL(:,3),ENTRY(3).PVAL(:,3),ENTRY(1).PVAL(:,4),ENTRY(2).PVAL(:,4),ENTRY(3).PVAL(:,4)];


    Labelx = {'18:00','19:00',...
        };

    clear BHAT2 SHAT2
    %Putting stars
        for i=1:6
            for ii=1:4
                if SHAT(ii,i)>0.1
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if SHAT(ii,i)<=0.1
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star}$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if SHAT(ii,i)<=0.05
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star\star}$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if SHAT(ii,i)<=0.01
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star\star\star}$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if isnan(SHAT(ii,i))
                    BHAT2{ii,i} =  ' ';
                    SHAT2{ii,i} =  ' ';
                end

            end
        end


    % TABLE2 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{12}{c}}',...
    %     ' & \multicolumn{3}{c}{Nov 19} & \multicolumn{3}{c}{Nov 23} & \multicolumn{3}{c}{Dec 13} & \multicolumn{3}{c}{Feb 16}   \\',...
    %     ' & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$ & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$ & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$ & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$   \\',...
    %     ' \hline ',...
    %     ];

    TABLE2 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{12}{c}}',...
        ' \toprule & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$ & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$   \\',...
        ' \cmidrule(lr){2-4} \cmidrule(lr){5-7} & \multicolumn{3}{c}{Nov 19} & \multicolumn{3}{c}{Nov 23}   \\',...
        '  ',...
        ];

    for ii=1:2
        TABLE2 = [TABLE2,...
            Labelx{ii},' & ',...
            BHAT2{ii,1},' & ',...
            BHAT2{ii,2},' & ',...
            BHAT2{ii,3},' & ',...
            BHAT2{ii,4},' & ',...
            BHAT2{ii,5},' & ',...
            BHAT2{ii,6},'  \\ ', ...
            '  & ',SHAT2{ii,1},' & ',...
            SHAT2{ii,2},' & ',...
            SHAT2{ii,3},' & ',...
            SHAT2{ii,4},' & ',...
            SHAT2{ii,5},' & ',...
            SHAT2{ii,6},'  \\ '];
    end

    TABLE2 = [TABLE2,...
        ' \cmidrule(lr){2-4} \cmidrule(lr){5-7} ',...
        ' & \multicolumn{3}{c}{Dec 13} & \multicolumn{3}{c}{Feb 16}   \\',...
        '  ',...
        ];


    for ii=3:4
        TABLE2 = [TABLE2,...
            Labelx{ii-2},' & ',...
            BHAT2{ii,1},' & ',...
            BHAT2{ii,2},' & ',...
            BHAT2{ii,3},' & ',...
            BHAT2{ii,4},' & ',...
            BHAT2{ii,5},' & ',...
            BHAT2{ii,6},'  \\ ', ...
            '  & ',SHAT2{ii,1},' & ',...
            SHAT2{ii,2},' & ',...
            SHAT2{ii,3},' & ',...
            SHAT2{ii,4},' & ',...
            SHAT2{ii,5},' & ',...
            SHAT2{ii,6},'  \\ '];
    end

    TABLE2 = [TABLE2,...
        '\bottomrule \end{tabular*}'];

    %if savetable==1
    fileID = fopen([tablepath,'/table_appendix_MAIN.tex'],'w');
    fprintf(fileID,'%s',TABLE2);
    fclose(fileID);
    %end

    %% Prep Table with RD results.rdq_c

   for ij=1:3
        ENTRY(ij).B = reshape(CVM(ij+1).mRD(intersect(intersect(idx_events,find(HOUR>=18 & HOUR<=19)),[idx_event1_1;idx_event2_1;idx_event3_1;idx_event4_1])),[2 4]);
        ENTRY(ij).PVAL = reshape(CVM(ij+1).bpvalRD(intersect(intersect(idx_events,find(HOUR>=18 & HOUR<=19)),[idx_event1_1;idx_event2_1;idx_event3_1;idx_event4_1])),[2 4]);

    end

BHAT =[ENTRY(1).B(:,1),ENTRY(2).B(:,1),ENTRY(3).B(:,1),ENTRY(1).B(:,2),ENTRY(2).B(:,2),ENTRY(3).B(:,2);...
    ENTRY(1).B(:,3),ENTRY(2).B(:,3),ENTRY(3).B(:,3),ENTRY(1).B(:,4),ENTRY(2).B(:,4),ENTRY(3).B(:,4)];

SHAT =[ENTRY(1).PVAL(:,1),ENTRY(2).PVAL(:,1),ENTRY(3).PVAL(:,1),ENTRY(1).PVAL(:,2),ENTRY(2).PVAL(:,2),ENTRY(3).PVAL(:,2);...
    ENTRY(1).PVAL(:,3),ENTRY(2).PVAL(:,3),ENTRY(3).PVAL(:,3),ENTRY(1).PVAL(:,4),ENTRY(2).PVAL(:,4),ENTRY(3).PVAL(:,4)];


    Labelx = {'18:00','19:00',...
        };

    clear BHAT2 SHAT2
    %Putting stars
        for i=1:6
            for ii=1:4
                if SHAT(ii,i)>0.1
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if SHAT(ii,i)<=0.1
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star}$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if SHAT(ii,i)<=0.05
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star\star}$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if SHAT(ii,i)<=0.01
                    BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star\star\star}$'];
                    SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
                end
                if isnan(SHAT(ii,i))
                    BHAT2{ii,i} =  ' ';
                    SHAT2{ii,i} =  ' ';
                end

            end
        end


    % TABLE2 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{12}{c}}',...
    %     ' & \multicolumn{3}{c}{Nov 19} & \multicolumn{3}{c}{Nov 23} & \multicolumn{3}{c}{Dec 13} & \multicolumn{3}{c}{Feb 16}   \\',...
    %     ' & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$ & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$ & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$ & $\widehat{\Delta S_{l}}$ & $\widehat{\Delta S_{m}}$ & $\widehat{\Delta S_{h}}$   \\',...
    %     ' \hline ',...
    %     ];

    TABLE2 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{12}{c}}',...
        ' \toprule & $\widehat{\Delta RD_{l}}$ & $\widehat{\Delta RD_{m}}$ & $\widehat{\Delta RD_{h}}$ & $\widehat{\Delta RD_{l}}$ & $\widehat{\Delta RD_{m}}$ & $\widehat{\Delta RD_{h}}$   \\',...
        ' \cmidrule(lr){2-4} \cmidrule(lr){5-7} & \multicolumn{3}{c}{Nov 19} & \multicolumn{3}{c}{Nov 23}   \\',...
        '  ',...
        ];

    for ii=1:2
        TABLE2 = [TABLE2,...
            Labelx{ii},' & ',...
            BHAT2{ii,1},' & ',...
            BHAT2{ii,2},' & ',...
            BHAT2{ii,3},' & ',...
            BHAT2{ii,4},' & ',...
            BHAT2{ii,5},' & ',...
            BHAT2{ii,6},'  \\ ', ...
            '  & ',SHAT2{ii,1},' & ',...
            SHAT2{ii,2},' & ',...
            SHAT2{ii,3},' & ',...
            SHAT2{ii,4},' & ',...
            SHAT2{ii,5},' & ',...
            SHAT2{ii,6},'  \\ '];
    end

    TABLE2 = [TABLE2,...
        ' \cmidrule(lr){2-4} \cmidrule(lr){5-7} ',...
        ' & \multicolumn{3}{c}{Dec 13} & \multicolumn{3}{c}{Feb 16}   \\',...
        '  ',...
        ];


    for ii=3:4
        TABLE2 = [TABLE2,...
            Labelx{ii-2},' & ',...
            BHAT2{ii,1},' & ',...
            BHAT2{ii,2},' & ',...
            BHAT2{ii,3},' & ',...
            BHAT2{ii,4},' & ',...
            BHAT2{ii,5},' & ',...
            BHAT2{ii,6},'  \\ ', ...
            '  & ',SHAT2{ii,1},' & ',...
            SHAT2{ii,2},' & ',...
            SHAT2{ii,3},' & ',...
            SHAT2{ii,4},' & ',...
            SHAT2{ii,5},' & ',...
            SHAT2{ii,6},'  \\ '];
    end

    TABLE2 = [TABLE2,...
        '\bottomrule \end{tabular*}'];

    %if savetable==1
    fileID = fopen([tablepath,'/table_appendix_MAIN_RD.tex'],'w');
    fprintf(fileID,'%s',TABLE2);
    fclose(fileID);
    %end
end
end