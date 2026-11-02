if constrained_d == 1
    %Constrained residuals (testing set)
    VAREPS =  firm(5).q(idx_valid,:)-Qt(idx_valid,:);
    VARKSI =  firm(5).rdq(idx_valid,:)-RD_c(idx_valid,:);

    %As above but for PPA plants
    VARKSI_2=[];
    for jj=1:length(INDX)
        ff = INDX(1,jj);
        a = INDX(2,jj);

        VARKSI_2 = [VARKSI_2,firm(ff).asset(a).Q(idx_valid,:)-firm(ff).asset(a).Qs(idx_valid,:)];
    end


else
    %Unconstrained residuals(testing set)
    VAREPS =  firm(5).q(idx_valid,:)-Qhat(idx_valid,:);
    VARKSI =  firm(5).rdq(idx_valid,:)-RD_c2(idx_valid,:);

    %As above but for PPA plants
    VARKSI_2=[];
    for jj=1:length(INDX)
        ff = INDX(1,jj);
        a = INDX(2,jj);

        VARKSI_2 = [VARKSI_2,firm(ff).asset(a).Q(idx_valid,:)-firm(ff).asset(a).Qhat(idx_valid,:)];
    end

end

%Estimated covariance
ERR = [VAREPS,VARKSI,VARKSI_2];
ECOV = cov(ERR);
ECOV(:,length(P_grid):length(P_grid):end) = 0; %sanity check: capacity limits should not be stochastic.
ECOV(length(P_grid):length(P_grid):end,:) = 0;

DRAWS(n).id = [];
idx_00 = idx;
idx = setdiff(idx,idx_train);

for j=1:length(idx) %for each hour in sample idx -except training sample to save time
    %if ~isempty(intersect((j-1)/length(idx),linspace(0,1,11)))
    fprintf([newline,' j: ',num2str((j-1)/length(idx)*100),'%%']);
    %end
    j
    tic

    %Estimated mean
    if constrained_d == 0
        MU = [Qhat(idx(j),:),RD_c2(idx(j),:)];
        for jj=1:length(INDX)
            ff = INDX(1,jj);
            a = INDX(2,jj);
            MU = [MU,firm(ff).asset(a).Qhat(idx(j),:)];
        end
    else
        MU = [Qt(idx(j),:),RD_c(idx(j),:)];
        for jj=1:length(INDX)
            ff = INDX(1,jj);
            a = INDX(2,jj);
            MU = [MU,firm(ff).asset(a).Qs(idx(j),:)];
        end
    end

    XX = mvnrnd(MU,ECOV,ndraws); %Joint distribution of bid functions (52 points for each)

    tic
    % Unconstrained draws
    pp = length(P_grid);
    DRAWS0(idx(j)).Q_dist = XX(:,1:pp);
    DRAWS0(idx(j)).RDQ_dist = XX(:,pp+1:2*pp);
    DRAWS0(idx(j)).PPA1_dist = XX(:,2*pp+1:3*pp);
    DRAWS0(idx(j)).PPA2_dist = XX(:,3*pp+1:4*pp);
    DRAWS0(idx(j)).PPA3_dist = XX(:,4*pp+1:5*pp);
    DRAWS0(idx(j)).PPA4_dist = XX(:,5*pp+1:6*pp);
    DRAWS0(idx(j)).PPA5_dist = XX(:,6*pp+1:7*pp);
    DRAWS0(idx(j)).PPA6_dist = XX(:,7*pp+1:8*pp);
    DRAWS0(idx(j)).PPA7_dist = XX(:,8*pp+1:9*pp);

    if constrained_d ==1
        % (ex-post) Constrained draws
        DRAWS0(idx(j)).Q_dist = mon_smooth_f(DRAWS0(idx(j)).Q_dist);
        DRAWS0(idx(j)).RDQ_dist = mon_smooth_f2(DRAWS0(idx(j)).RDQ_dist);
        DRAWS0(idx(j)).PPA1_dist = mon_smooth_f(DRAWS0(idx(j)).PPA1_dist);
        DRAWS0(idx(j)).PPA2_dist = mon_smooth_f(DRAWS0(idx(j)).PPA2_dist);
        DRAWS0(idx(j)).PPA3_dist = mon_smooth_f(DRAWS0(idx(j)).PPA3_dist);
        DRAWS0(idx(j)).PPA4_dist = mon_smooth_f(DRAWS0(idx(j)).PPA4_dist);
        DRAWS0(idx(j)).PPA5_dist = mon_smooth_f(DRAWS0(idx(j)).PPA5_dist);
        DRAWS0(idx(j)).PPA6_dist = mon_smooth_f(DRAWS0(idx(j)).PPA6_dist);
        DRAWS0(idx(j)).PPA7_dist = mon_smooth_f(DRAWS0(idx(j)).PPA7_dist);
    end

    %Compute corresponding price and output
    for i=1:ndraws

        %     if ~isempty(intersect(i/ndraws,linspace(0,1,11)))
        %     fprintf([newline,'        i: ',num2str(i/ndraws*100),'% ']);
        %     pause(0.001)
        %     end

        RD_temp = RD_hat_c(idx(j),:); %constructed counterf
        RD_temp2 = DRAWS0(idx(j)).RDQ_dist(i,:); %draws of estimated counterf (bootstrap)
        RD_temp3 = RD_hat(idx(j),:); %observed

        Q_temp = DRAWS0(idx(j)).Q_dist(i,:); %draws of estimated counterf (bootstrap)

        % Look for counterfactual prices and quantities corresponding to random
        %         % draws
        %Estim. Cf Q Construct. Cf RD (hc)
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_temp,Q_temp,P_grid,p_grid);
        DISP_draws(idx(j),i) = QUANTITY_temp;
        PRICE_draws(idx(j),i) = PRICE_temp;

        %Estim. Cf Q Estim. Cf RD (hh)
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_temp2,Q_temp,P_grid,p_grid);
        DISP_draws2(idx(j),i) = QUANTITY_temp;
        PRICE_draws2(idx(j),i) = PRICE_temp;

        %Estim. Cf Q Obs RD (oh)
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_temp3,Q_temp,P_grid,p_grid);
        DISP_draws3(idx(j),i) = QUANTITY_temp;
        PRICE_draws3(idx(j),i) = PRICE_temp;

        %Account for PPA plant bid function uncertainty
        temp = 0;
        if ~isempty(intersect(idx(j),find(firm(3).k_asset_c(:,10)-firm(3).k_asset(:,10))))
            ff=3;
            a=10;
            proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
            temp =  temp +  proportion(idx(j)).*DRAWS0(idx(j)).PPA1_dist(i,:);
        end
        if ~isempty(intersect(idx(j),find(firm(3).k_asset_c(:,11)-firm(3).k_asset(:,11))))
            ff=3;
            a=11;
            proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
            temp =  temp + proportion(idx(j)).*DRAWS0(idx(j)).PPA2_dist(i,:);
        end
        if ~isempty(intersect(idx(j),find(firm(4).k_asset_c(:,10)-firm(4).k_asset(:,10))))
            ff=4;
            a=10;
            proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
            temp =  temp + proportion(idx(j)).*DRAWS0(idx(j)).PPA3_dist(i,:);
        end
        if ~isempty(intersect(idx(j),find(firm(4).k_asset_c(:,11)-firm(4).k_asset(:,11))))
            ff=4;
            a=11;
            proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
            temp =  temp + proportion(idx(j)).*DRAWS0(idx(j)).PPA4_dist(i,:);
        end
        if ~isempty(intersect(idx(j),find(firm(6).k_asset_c(:,8)-firm(6).k_asset(:,8))))
            ff=6;
            a=8;
            proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
            temp =  temp + proportion(idx(j)).*DRAWS0(idx(j)).PPA5_dist(i,:);
        end
        if ~isempty(intersect(idx(j),find(firm(6).k_asset_c(:,9)-firm(6).k_asset(:,9))))
            ff=6;
            a=9;
            proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
            temp =  temp + proportion(idx(j)).*DRAWS0(idx(j)).PPA6_dist(i,:);
        end
        if ~isempty(intersect(idx(j),find(firm(6).k_asset_c(:,10)-firm(6).k_asset(:,10))))
            ff=6;
            a=10;
            proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
            temp =  temp + proportion(idx(j)).*DRAWS0(idx(j)).PPA7_dist(i,:);
        end

        CASE(1).RD_temp = DRAWS0(idx(j)).RDQ_dist(i,:) + temp; %(hh2)
        if constrained_d == 1
            CASE(1).RD_temp = mon_smooth_f2(DRAWS0(idx(j)).RDQ_dist(i,:) + temp);
        end

        %Estim. Cf Q Estim. Cf RD
        [PRICE_temp,QUANTITY_temp] = QPEQ(CASE(1).RD_temp,Q_temp,P_grid,p_grid);
        CASE(1).DISP_draws(idx(j),i) = QUANTITY_temp; %(hh2 no c)        
        CASE(1).PRICE_draws(idx(j),i) = PRICE_temp; %(hh2 no c)

        %Estim. Cf Q Construct. Cf RD (hcc)
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_temp-corr_factor(idx(j),:),Q_temp,P_grid,p_grid);
        DISP_draws4(idx(j),i) = QUANTITY_temp;
        PRICE_draw4(idx(j),i) = PRICE_temp;

        %Estim. Cf Q Estim. Cf RD (hhc)
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_temp2-corr_factor(idx(j),:),Q_temp,P_grid,p_grid);
        DISP_draws5(idx(j),i) = QUANTITY_temp;
        PRICE_draws5(idx(j),i) = PRICE_temp;

        %Estim. Cf Q Obs RD (hh2)
        [PRICE_temp,QUANTITY_temp] = QPEQ(CASE(1).RD_temp-corr_factor(idx(j),:),Q_temp,P_grid,p_grid);
        DISP_draws6(idx(j),i) = QUANTITY_temp;
        PRICE_draws6(idx(j),i) = PRICE_temp;

        %PROFIT
        PROFIT_hhc_draws(idx(j),i) = PRICE(idx(j)).*DISP_oo(idx(j)) - PRICE_draws5(idx(j),i).*DISP_draws5(idx(j),i);
        PROFIT_hh_draws(idx(j),i) = PRICE(idx(j)).*DISP_oo(idx(j)) - PRICE_draws2(idx(j),i).*DISP_draws2(idx(j),i);
        PROFIT_hh2_draws(idx(j),i) = PRICE(idx(j)).*DISP_oo(idx(j)) - PRICE_draws6(idx(j),i).*DISP_draws6(idx(j),i);

        %WELFARE
        TCOST_hhc_draws(idx(j),i) = PRICE(idx(j)).*DISP(idx(j)) - PRICE_draws5(idx(j),i).*DISP(idx(j));
        TCOST_hh_draws(idx(j),i) = PRICE(idx(j)).*DISP(idx(j)) - PRICE_draws2(idx(j),i).*DISP(idx(j));
        TCOST_hh2_draws(idx(j),i) = PRICE(idx(j)).*DISP(idx(j)) - PRICE_draws6(idx(j),i).*DISP(idx(j));

        % Supply strategy shifts
        mQ_draws(idx(j),i) = trapz(linspace(0,1,pp),firm(5).q(idx(j),1:end)'-DRAWS0(idx(j)).Q_dist(i,1:end)')';

        % RD strategy shifts
        mRD_draws(idx(j),i) = trapz(linspace(0,1,pp),firm(5).rdq_c(idx(j),1:end)'-DRAWS0(idx(j)).RDQ_dist(i,1:end)')';

    end

    

    %Compute CVM stats for each draw and subparts of the bid functions
    options.eps = 1e-8;
    options.iter = 100;
    level = 0.05;
    pp1 = round(length(P_grid)*9/52);
    pp2 = round(length(P_grid)*26/52);

    stat0 = CVMtest2(DRAWS0(idx(j)).Q_dist(:,1:end)',Qt(idx(j),1:end)',1,[],linspace(0,1,pp),level,options);
    stat1 = CVMtest2(DRAWS0(idx(j)).Q_dist(:,1:pp1)',Qt(idx(j),1:pp1)',1,[],linspace(0,1,pp1),level,options);
    stat2 = CVMtest2(DRAWS0(idx(j)).Q_dist(:,pp1+1:pp2)',Qt(idx(j),pp1+1:pp2)',1,[],linspace(0,1,pp2-pp1),level,options);
    stat3 = CVMtest2(DRAWS0(idx(j)).Q_dist(:,pp2+1:end)',Qt(idx(j),pp2+1:end)',1,[],linspace(0,1,pp-pp2),level,options);
    CVM(1).statQ(:,idx(j)) = stat0';
    CVM(2).statQ(:,idx(j)) = stat1';
    CVM(3).statQ(:,idx(j)) = stat2';
    CVM(4).statQ(:,idx(j)) = stat3';

    stat0 = CVMtest2(DRAWS0(idx(j)).RDQ_dist(:,1:end)',RD_c(idx(j),1:end)',1,[],linspace(0,1,pp),level,options);
    stat1 = CVMtest2(DRAWS0(idx(j)).RDQ_dist(:,1:pp1)',RD_c(idx(j),1:pp1)',1,[],linspace(0,1,pp1),level,options);
    stat2 = CVMtest2(DRAWS0(idx(j)).RDQ_dist(:,pp1+1:pp2)',RD_c(idx(j),pp1+1:pp2)',1,[],linspace(0,1,pp2-pp1),level,options);
    stat3 = CVMtest2(DRAWS0(idx(j)).RDQ_dist(:,pp2+1:end)',RD_c(idx(j),pp2+1:end)',1,[],linspace(0,1,pp-pp2),level,options);
    CVM(1).statRD(:,idx(j)) = stat0';
    CVM(2).statRD(:,idx(j)) = stat1';
    CVM(3).statRD(:,idx(j)) = stat2';
    CVM(4).statRD(:,idx(j)) = stat3';




    %Compute CVM stat and imhof pvalue for each obs
    [pvalue0,~,stat0,~] = CVMtest(Qt(idx(j),1:end)',firm(5).q(idx(j),1:end)',1,cov(VAREPS(1:end,1:end)),linspace(0,1,pp),level,options);
    [pvalue1,~,stat1,~] = CVMtest(Qt(idx(j),1:pp1)',firm(5).q(idx(j),1:pp1)',1,cov(VAREPS(2:9,2:9)),linspace(0,1,pp1),level,options);
    [pvalue2,~,stat2,~] = CVMtest(Qt(idx(j),pp1+1:pp2)',firm(5).q(idx(j),pp1+1:pp2)',1,cov(VAREPS(pp1+1:pp2,pp1+1:pp2)),linspace(0,1,pp2-pp1),level,options);
    [pvalue3,~,stat3,~] = CVMtest(Qt(idx(j),pp2+1:end)',firm(5).q(idx(j),pp2+1:end)',1,cov(VAREPS(pp2+1:end,pp2+1:end)),linspace(0,1,pp-pp2),level,options);
    CVM(1).cvmQ(idx(j)) = stat0;
    CVM(2).cvmQ(idx(j)) = stat1;
    CVM(3).cvmQ(idx(j)) = stat2;
    CVM(4).cvmQ(idx(j)) = stat3;
    CVM(1).ipvalQ(idx(j)) = pvalue0;
    CVM(2).ipvalQ(idx(j)) = pvalue1;
    CVM(3).ipvalQ(idx(j)) = pvalue2;
    CVM(4).ipvalQ(idx(j)) = pvalue3;


    [pvalue0,~,stat0,~] = CVMtest(RD_c(idx(j),1:end)',firm(5).rdq_c(idx(j),1:end)',1,cov(VARKSI(1:end,1:end)),linspace(0,1,pp),level,options);
    [pvalue1,~,stat1,~] = CVMtest(RD_c(idx(j),1:pp1)',firm(5).rdq_c(idx(j),1:pp1)',1,cov(VARKSI(2:9,2:9)),linspace(0,1,pp1),level,options);
    [pvalue2,~,stat2,~] = CVMtest(RD_c(idx(j),pp1+1:pp2)',firm(5).rdq_c(idx(j),pp1+1:pp2)',1,cov(VARKSI(pp1+1:pp2,pp1+1:pp2)),linspace(0,1,pp2-pp1),level,options);
    [pvalue3,~,stat3,~] = CVMtest(RD_c(idx(j),pp2+1:end)',firm(5).rdq_c(idx(j),pp2+1:end)',1,cov(VARKSI(pp2+1:end,pp2+1:end)),linspace(0,1,pp-pp2),level,options);
    CVM(1).cvmRD(idx(j)) = stat0;
    CVM(2).cvmRD(idx(j)) = stat1;
    CVM(3).cvmRD(idx(j)) = stat2;
    CVM(4).cvmRD(idx(j)) = stat3;
    CVM(1).ipvalRD(idx(j)) = pvalue0;
    CVM(2).ipvalRD(idx(j)) = pvalue1;
    CVM(3).ipvalRD(idx(j)) = pvalue2;
    CVM(4).ipvalRD(idx(j)) = pvalue3;
    [pvalue0,~,stat0,~] = CVMtest(RD_c(idx(j),1:end)',firm(5).rdq(idx(j),1:end)',1,cov(VARKSI(1:end,1:end)),linspace(0,1,pp),level,options);
    CVM(1).ipvalRD2(idx(j)) = pvalue0;

    %Mean Integrated Bias
    CVM(1).mQ(idx(j)) = trapz(linspace(0,1,pp),firm(5).q(idx(j),1:end)'-Qt(idx(j),1:end)')';
    CVM(2).mQ(idx(j)) = trapz(linspace(0,1,pp1),firm(5).q(idx(j),1:pp1)'-Qt(idx(j),1:pp1)')';
    CVM(3).mQ(idx(j)) = trapz(linspace(0,1,pp2-pp1),firm(5).q(idx(j),pp1+1:pp2)'-Qt(idx(j),pp1+1:pp2)')';
    CVM(4).mQ(idx(j)) = trapz(linspace(0,1,pp-pp2),firm(5).q(idx(j),pp2+1:end)'-Qt(idx(j),pp2+1:end)')';

    CVM(1).mRD(idx(j)) = trapz(linspace(0,1,pp),firm(5).rdq_c(idx(j),1:end)'-RD_c(idx(j),1:end)')';
    CVM(2).mRD(idx(j)) = trapz(linspace(0,1,pp1),firm(5).rdq_c(idx(j),1:pp1)'-RD_c(idx(j),1:pp1)')';
    CVM(3).mRD(idx(j)) = trapz(linspace(0,1,pp2-pp1),firm(5).rdq_c(idx(j),pp1+1:pp2)'-RD_c(idx(j),pp1+1:pp2)')';
    CVM(4).mRD(idx(j)) = trapz(linspace(0,1,pp-pp2),firm(5).rdq_c(idx(j),pp2+1:end)'-RD_c(idx(j),pp2+1:end)')';

    %Boostrapped p-values
    for ii=1:4
        stat0 = CVM(ii).statQ(:,idx(j));
        stat0 = stat0(:);
        stat0_ = CVM(ii).statRD(:,idx(j));
        stat0_ = stat0_(:);
        [~,b] = min(abs(stat0-CVM(ii).cvmQ(idx(j))));
        CVM(ii).bpvalQ(idx(j)) = 1-mean(stat0<=CVM(ii).cvmQ(idx(j))); %boostrapped pvalue
        [~,b] = min(abs(stat0_-CVM(ii).cvmRD(idx(j))));
        CVM(ii).bpvalRD(idx(j)) = 1-mean(stat0_<=CVM(ii).cvmRD(idx(j))); %boostrapped pvalue

        CVM(ii).bpvalRD2 = CVM(ii).ipvalRD2; %this stat was not bootstrap
    end


    % For pointwise confidence intervals (plots only)
    DRAWS0(idx(j)).quants_Q = quantile(DRAWS0(idx(j)).Q_dist,[0.01 0.025 0.05 0.1 0.5 0.9 0.95 0.975 0.99]);
    DRAWS0(idx(j)).quants_RD = quantile(DRAWS0(idx(j)).RDQ_dist,[0.01 0.025 0.05 0.1 0.5 0.9 0.95 0.975 0.99]);

    %clear memory from large temp vars
    DRAWS0(idx(j)).Q_dist = [];
    DRAWS0(idx(j)).RDQ_dist = [];
    DRAWS0(idx(j)).PPA1_dist = [];
    DRAWS0(idx(j)).PPA2_dist = [];
    DRAWS0(idx(j)).PPA3_dist = [];
    DRAWS0(idx(j)).PPA4_dist = [];
    DRAWS0(idx(j)).PPA5_dist = [];
    DRAWS0(idx(j)).PPA6_dist = [];
    DRAWS0(idx(j)).PPA7_dist = [];

    fprintf([newline]);

    pause(0.1)

% 
%     DATE(idx(j))
%     1-mean((PRICE_oo(idx(1:j))>quantile(PRICE_draws3(idx(1:j),:)',0.975)')+(PRICE_oo(idx(1:j))<quantile(PRICE_draws3(idx(1:j),:)',0.025)'))
%     1-mean((DISP_oo(idx(1:j))>quantile(DISP_draws3(idx(1:j),:)',0.975)')+(DISP_oo(idx(1:j))<quantile(DISP_draws3(idx(1:j),:)',0.025)'))
%     mean(CVM(1).ipvalQ(intersect(idx(1:j),idx_valid))<0.05)
%     mean(CVM(1).ipvalRD(intersect(idx(1:j),idx_valid))<0.05)
%     mean(CVM(1).bpvalQ(intersect(idx(1:j),idx_valid))<0.05)
%     mean(CVM(1).bpvalRD(intersect(idx(1:j),idx_valid))<0.05)
%     toc

%     if ~isempty(intersect((j-1)/length(idx),(1:1000:length(idx))/length(idx)))
%         save(['temp', num2str(peak_d),'.mat'], '-v7.3')
% 
%     end


end

idx = idx_00;
clear j idx_00;
%save(['temp', num2str(peak_d),'_bs.mat'], '-v7.3')

