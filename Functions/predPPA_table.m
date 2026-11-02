%% Table prediction accuracy - PPA Plants

load('Tempfiles/temp0.mat')
clear BHAT2 BHAT3;

%Supply PPA
for jj = 1:7
    ff = INDX(1,jj);
    a = INDX(2,jj);
    Labelxx{jj} = firm(ff).asset(a).id{1};
    %Bias
    BHAT2{1,1,jj} =  ['$',num2str(SUMSTATS(1+jj).BIAS(1),'%0.1f'),'$'];
    BHAT2{1,2,jj} =  ['$',num2str(SUMSTATS(1+jj).BIAS(2),'%0.1f'),'$'];
    BHAT2{1,3,jj} =  ['$',num2str(SUMSTATS(1+jj).BIAS(5),'%0.1f'),'$'];
    %Absolute bias
    BHAT2{2,1,jj} =  ['$',num2str(SUMSTATS(1+jj).ABIAS(1),'%0.1f'),'$'];
    BHAT2{2,2,jj} =  ['$',num2str(SUMSTATS(1+jj).ABIAS(2),'%0.1f'),'$'];
    BHAT2{2,3,jj} =  ['$',num2str(SUMSTATS(1+jj).ABIAS(5),'%0.1f'),'$'];
    % %Relative bias
    % BHAT2{3,1,jj} =  ['$',num2str(100*SUMSTATS(1+jj).ABIAS(1)/mean(firm(ff).k_asset(idx_train,a)),'%0.1f'),'\% $'];
    % BHAT2{3,2,jj} =  ['$',num2str(100*SUMSTATS(1+jj).ABIAS(2)/mean(firm(ff).k_asset(idx_valid,a)),'%0.1f'),'\% $'];
    % BHAT2{3,3,jj} =  ['$',num2str(100*SUMSTATS(1+jj).ABIAS(3)/mean(firm(ff).k_asset(idx_events,a)),'%0.1f'),'\% $'];
    %Mean available cap
    BHAT2{3,1,jj} =  ['$',num2str(mean(firm(ff).k_asset(idx_train,a)),'%0.1f'),'$'];
    BHAT2{3,2,jj} =  ['$',num2str(mean(firm(ff).k_asset(idx_valid,a)),'%0.1f'),'$'];
    BHAT2{3,3,jj} =  ['$',num2str(mean(firm(ff).k_asset(idx_events3,a)),'%0.1f'),'$'];
    %RMSE
    BHAT2{4,1,jj} =  ['$',num2str(SUMSTATS(1+jj).RMSE(1),'%0.1f'),'$'];
    BHAT2{4,2,jj} =  ['$',num2str(SUMSTATS(1+jj).RMSE(2),'%0.1f'),'$'];
    BHAT2{4,3,jj} =  ['$',num2str(SUMSTATS(1+jj).RMSE(5),'%0.1f'),'$'];
end
BHAT2(2:3,:,:) = [];
%%
%load('temp0.mat')
%Supply PPA
for jj = 1:7
    ff = INDX(1,jj);
    a = INDX(2,jj);
    Labelxx{jj} = firm(ff).asset(a).id{1};
    %Bias
    BHAT3{1,1,jj} =  ['$',num2str(SUMSTATS(1+jj).BIAS(1),'%0.1f'),'$'];
    BHAT3{1,2,jj} =  ['$',num2str(SUMSTATS(1+jj).BIAS(2),'%0.1f'),'$'];
    BHAT3{1,3,jj} =  ['$',num2str(SUMSTATS(1+jj).BIAS(5),'%0.1f'),'$'];
    %Absolute bias
    BHAT3{2,1,jj} =  ['$',num2str(SUMSTATS(1+jj).ABIAS(1),'%0.1f'),'$'];
    BHAT3{2,2,jj} =  ['$',num2str(SUMSTATS(1+jj).ABIAS(2),'%0.1f'),'$'];
    BHAT3{2,3,jj} =  ['$',num2str(SUMSTATS(1+jj).ABIAS(5),'%0.1f'),'$'];
    % %Relative bias
    % BHAT3{3,1,jj} =  ['$',num2str(100*SUMSTATS(1+jj).ABIAS(1)/mean(firm(ff).k_asset(idx_train,a)),'%0.1f'),'\% $'];
    % BHAT3{3,2,jj} =  ['$',num2str(100*SUMSTATS(1+jj).ABIAS(2)/mean(firm(ff).k_asset(idx_valid,a)),'%0.1f'),'\% $'];
    % BHAT3{3,3,jj} =  ['$',num2str(100*SUMSTATS(1+jj).ABIAS(3)/mean(firm(ff).k_asset(idx_events,a)),'%0.1f'),'\% $'];
    %Mean available cap
    BHAT3{3,1,jj} =  ['$',num2str(mean(firm(ff).k_asset(idx_train,a)),'%0.1f'),'$'];
    BHAT3{3,2,jj} =  ['$',num2str(mean(firm(ff).k_asset(idx_valid,a)),'%0.1f'),'$'];
    BHAT3{3,3,jj} =  ['$',num2str(mean(firm(ff).k_asset(idx_events3,a)),'%0.1f'),'$'];
    %RMSE
    BHAT3{4,1,jj} =  ['$',num2str(SUMSTATS(1+jj).RMSE(1),'%0.1f'),'$'];
    BHAT3{4,2,jj} =  ['$',num2str(SUMSTATS(1+jj).RMSE(2),'%0.1f'),'$'];
    BHAT3{4,3,jj} =  ['$',num2str(SUMSTATS(1+jj).RMSE(5),'%0.1f'),'$'];
end
BHAT3(2:3,:,:) = [];



Labelx = {'Mean Int. Bias',...'Mean Int. Abs. Bias','Mean Avail. Cap (MW)'... %'Mean Int. Rel. Abs. Bias',
    'RIMSE',...
    };

TABLE2 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{7}{c}}',...
    ' \toprule ',...
    '& \multicolumn{2}{c}{Training set} & \multicolumn{2}{c}{Testing set} & \multicolumn{2}{c}{Reneging set}   \\',...
    ' \cmidrule(lr){2-3} \cmidrule(lr){4-5} \cmidrule(lr){6-7} ',...
    ];

TABLE2 = [TABLE2,...
    '  & Peak & Off-Peak & Peak & Off-Peak & Peak & Off-Peak  \\ '];
for jj=1:7
    TABLE2 = [TABLE2,...
        Labelxx{jj}, '  &   &   &   &   &   &    \\  '];
    for ii=1:2
        TABLE2 = [TABLE2,...
            Labelx{ii},' & ',...
            '\multicolumn{1}{c}{',BHAT2{ii,1,jj},'} & ','\multicolumn{1}{c}{',BHAT3{ii,1,jj},'} & ',...
            '\multicolumn{1}{c}{',BHAT2{ii,2,jj},'} & ','\multicolumn{1}{c}{',BHAT3{ii,2,jj},'} & ',...
            '\multicolumn{1}{c}{',BHAT2{ii,3,jj},'} & ','\multicolumn{1}{c}{',BHAT3{ii,3,jj},'} &  \\ '];
    end
end

%     TABLE2 = [TABLE2,...
%         ' \hline ',' \emph{Residual supply $\hat{RS}$} &   &   &   &   & $\overline{RS}$ & $RS$ \\ '];
%
%     for ii=setdiff((1:13),(8:11))
%         TABLE2 = [TABLE2,...
%         Labelx{ii},' & ',...
%         '\multicolumn{1}{c}{',BHAT3{ii,1},'} & ',...
%         '\multicolumn{1}{c}{',BHAT3{ii,2},'} & ',...
%         BHAT3{ii,3},' & ',BHAT3{ii,4},'  \\ '];
%     end

TABLE2 = [TABLE2,...
    ' \bottomrule \end{tabular*}'];

%%if savetable==1
fileID = fopen([tablepath,'/table_B3.tex'],'w'); %Pred PPA
fprintf(fileID,'%s',TABLE2);
fclose(fileID);
%%end