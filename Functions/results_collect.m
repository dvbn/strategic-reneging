%% Collect results

load(['Tempfiles/temp',num2str(prefix),'_',num2str(0),'.mat'])
%% Price Responsive Loads: Table B.3 AYRES Report p.27
S_PRL = zeros(length(P_grid),1);
S_PRL(P_grid>=75 & P_grid<100) = 31;
S_PRL(P_grid>=100 & P_grid<500) = 31+62;
S_PRL(P_grid>=500 & P_grid<800) = 31+62+46;
S_PRL(P_grid>=800 & P_grid<=1000) = 31+62+46+41;

nS_PRL = nan(length(DATE),length(P_grid));
for jj=1:length(DATE)
    nS_PRL(jj,:) = S_PRL - min(S_PRL(PRICE(jj)<=P_grid));
end

%% Net import functions
% We don't have all the data to replicate Ayres assumptions for AB-BC intertie

Imp_BC = min(IMP_obs(:,1),Imp_cap_BC);
Exp_BC = min(EXP_obs(:,1),Exp_cap_BC);

I_BC = zeros(length(P_grid),1);
I_BC(P_grid>=45 & P_grid<46) = 0.25;
I_BC(P_grid>=46 & P_grid<55) = 0.5;
I_BC(P_grid>=55 & P_grid<89) = 0.75;
I_BC(P_grid>=89 & P_grid<=1000) = 1;

E_BC = zeros(length(P_grid),1);
E_BC(P_grid>=0 & P_grid<25) = 1;
E_BC(P_grid>=25 & P_grid<27) = 0.75;
E_BC(P_grid>=27 & P_grid<29) = 0.5;
E_BC(P_grid>=29 & P_grid<=33) = 0.25;

Imp_SK = min(IMP_obs(:,3),Imp_cap_SK);
Exp_SK = min(EXP_obs(:,3),Exp_cap_SK);

% p.26 Ayres
% P > 55, up to available cap
% P < 55, down to zero
% Nothing is assumed for exports, so we use the same as for BC

I_SK = zeros(length(P_grid),1);
I_SK(P_grid>=55 & P_grid<=1000) = 1;

E_SK = zeros(length(P_grid),1);
E_SK(P_grid>=0 & P_grid<25) = 1;
E_SK(P_grid>=25 & P_grid<27) = 0.75;
E_SK(P_grid>=27 & P_grid<29) = 0.5;
E_SK(P_grid>=29 & P_grid<=33) = 0.25;

Imp_cap_BC(PRICE>89) = Imp_BC(PRICE>89);
Exp_cap_BC(PRICE<25) = Exp_BC(PRICE<25);
Imp_cap_SK(PRICE>55) = Imp_SK(PRICE>55);
Exp_cap_SK(PRICE<25) = Exp_SK(PRICE<25);

% Net import functions
Imp_BC_h = repmat(Imp_cap_BC,1,length(P_grid)).*repmat(I_BC',length(DATE),1);
Exp_BC_h = repmat(Exp_cap_BC,1,length(P_grid)).*repmat(E_BC',length(DATE),1);
nI_BC = Imp_BC_h - Exp_BC_h;

Imp_SK_h = repmat(Imp_cap_SK,1,length(P_grid)).*repmat(I_SK',length(DATE),1);
Exp_SK_h = repmat(Exp_cap_SK,1,length(P_grid)).*repmat(E_SK',length(DATE),1);
nI_SK = Imp_SK_h - Exp_SK_h;

% Recentered around observed values
for jj=1:length(DATE)
    nI_SK(jj,:) = nI_SK(jj,:) - min(nI_SK(jj,PRICE(jj)<=P_grid));
    nI_BC(jj,:) = nI_BC(jj,:) - min(nI_BC(jj,PRICE(jj)<=P_grid));
end

% Net supply function from PRL and intercos.
corr_factor =  nS_PRL + nI_BC + nI_SK;



%% Compute quantity, price, profit and welfare using predicted functions by intersecting S and RD
%init
DISP_oo = zeros(n,1);
DISP_hh = zeros(n,1);
DISP_hhc = zeros(n,1);
DISP_hh2 = zeros(n,1);
DISP_ho = zeros(n,1);
DISP_hc = zeros(n,1);
DISP_oh = zeros(n,1);
DISP_oc = zeros(n,1);
DISP_occ = zeros(n,1);

PRICE_oo = zeros(n,1);
PRICE_hh = zeros(n,1);
PRICE_hhc = zeros(n,1);
PRICE_hh2 = zeros(n,1);
PRICE_ho = zeros(n,1);
PRICE_hc = zeros(n,1);
PRICE_oh = zeros(n,1);
PRICE_oc = zeros(n,1);
PRICE_occ = zeros(n,1);

mQ = zeros(4,n);
mRD = zeros(4,n);



for peak_d=0:1

    load(['Tempfiles/temp',num2str(prefix),'_',num2str(peak_d),'.mat'])

    id = 4;
    idx_test = unique([idx_train;idx_valid]);

    for i=idx'
        %Observed strategy w/ observed RD
        [PRICE_temp,QUANTITY_temp] = QPEQ(firm(id+1).rdq(i,:),firm(id+1).q(i,:),P_grid,p_grid);
        DISP_oo(i) = QUANTITY_temp;
        PRICE_oo(i) = PRICE_temp;

        %Estimated counterfactual strategy w/ estimated counterfactual RD
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_c(i,:),Qt(i,:),P_grid,p_grid);
        DISP_hh(i) = QUANTITY_temp;
        PRICE_hh(i) = PRICE_temp;

        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_c(i,:)-corr_factor(i,:),Qt(i,:),P_grid,p_grid);
        DISP_hhc(i) = QUANTITY_temp;
        PRICE_hhc(i) = PRICE_temp;

        %Estimated counterfactual strategy w/ estimated counterfactual RD  net of PPA bids
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD(i,:)-corr_factor(i,:),Qt(i,:),P_grid,p_grid);
        DISP_hh2(i) = QUANTITY_temp;
        PRICE_hh2(i) = PRICE_temp;

        %Estimated counterfactual strategy w/ observed RD
        [PRICE_temp,QUANTITY_temp] = QPEQ(firm(id+1).rdq(i,:),Qt(i,:),P_grid,p_grid);
        DISP_ho(i) = QUANTITY_temp;
        PRICE_ho(i) = PRICE_temp;

        %Estimated counterfactual strategy w/ constructed counterfactual RD
        [PRICE_temp,QUANTITY_temp] = QPEQ(firm(id+1).rdq_c(i,:),Qt(i,:),P_grid,p_grid);
        DISP_hc(i) = QUANTITY_temp;
        PRICE_hc(i) = PRICE_temp;

        %Observed strategy w/ estimated counterfactual RD
        [PRICE_temp,QUANTITY_temp] = QPEQ(RD_c(i,:),firm(id+1).q(i,:),P_grid,p_grid);
        DISP_ho(i) = QUANTITY_temp;
        PRICE_ho(i) = PRICE_temp;

        %Observed strategy w/ constructed counterfactual RD: essentially
        %what the regulator did
        [PRICE_temp,QUANTITY_temp] = QPEQ(firm(id+1).rdq_c(i,:),firm(id+1).q(i,:),P_grid,p_grid);
        DISP_oc(i) = QUANTITY_temp;
        PRICE_oc(i) = PRICE_temp;

        [PRICE_temp,QUANTITY_temp] = QPEQ(firm(id+1).rdq_c(i,:)-corr_factor(i,:),firm(id+1).q(i,:),P_grid,p_grid);
        DISP_occ(i) = QUANTITY_temp;
        PRICE_occ(i) = PRICE_temp;

        pp = length(P_grid);
        pp1 = round(length(P_grid)*9/52);
        pp2 = round(length(P_grid)*26/52);

		
	    % Supply strategy shifts
	    mQ(1,i) = trapz(linspace(0,1,pp),firm(5).q(i,1:end)'-Qt(i,1:end)')';
		mQ(2,i) = trapz(linspace(0,1,pp1),firm(5).q(i,1:pp1)'-Qt(i,1:pp1)')';
	    mQ(3,i) = trapz(linspace(0,1,pp2-pp1),firm(5).q(i,pp1+1:pp2)'-Qt(i,pp1+1:pp2)')';
	    mQ(4,i) = trapz(linspace(0,1,pp-pp2),firm(5).q(i,pp2+1:end)'-Qt(i,pp2+1:end)')';
		% RD strategy shifts
	    mRD(1,i) = trapz(linspace(0,1,pp),firm(5).rdq_c(i,1:end)'-RD_c(i,1:end)')';
	    mRD(2,i) = trapz(linspace(0,1,pp1),firm(5).rdq_c(i,1:pp1)'-RD_c(i,1:pp1)')';
	    mRD(3,i) = trapz(linspace(0,1,pp2-pp1),firm(5).rdq_c(i,pp1+1:pp2)'-RD_c(i,pp1+1:pp2)')';
	    mRD(4,i) = trapz(linspace(0,1,pp-pp2),firm(5).rdq_c(i,pp2+1:end)'-RD_c(i,pp2+1:end)')';

        
    end

    RESULTS(peak_d+1).SUMSTATS = SUMSTATS;

end

%PROFIT
PROFIT_oo = PRICE.*DISP_oo;
PROFIT_hhc = PRICE.*DISP_oo - PRICE_hhc.*DISP_hhc;
PROFIT_hh = PRICE.*DISP_oo - PRICE_hh.*DISP_hh;
PROFIT_occ = PRICE.*DISP_oo - PRICE_occ.*DISP_occ;
PROFIT_hh2 = PRICE.*DISP_oo - PRICE_hh2.*DISP_hh2;

%WELFARE
TCOST_oo = PRICE.*DISP;
TCOST_hhc = PRICE.*DISP - PRICE_hhc.*DISP;
TCOST_hh = PRICE.*DISP - PRICE_hh.*DISP;
TCOST_occ = PRICE.*DISP - PRICE_occ.*DISP;
TCOST_hh2 = PRICE.*DISP - PRICE_hh2.*DISP;

table(DATE(idx_events3),PRICE_oo(idx_events3),PRICE(idx_events3),PRICE_hh(idx_events3),PRICE_hhc(idx_events3),PRICE_oc(idx_events3),PRICE_occ(idx_events3),K_c(idx_events3)-K(idx_events3))
table(DATE(idx_events3),DISP_oo(idx_events3),DISP_oo(idx_events3),DISP_hh(idx_events3),DISP_hhc(idx_events3),DISP_oc(idx_events3),DISP_occ(idx_events3))

save(['Tempfiles/temp',num2str(prefix),'.mat'],'-v7.3')
