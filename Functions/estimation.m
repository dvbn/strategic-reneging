
for peak_d = 0:1 %0:1  %the program is run separately for (peak_d=1) superpeak hours (5pm to 10pm) and other hours (peak_d=0).

    %% Load data
    % Lots of stuff here, get rid of useless vars.
    load('data.mat')

%     %% Table 1: Market shares (update numbers)
%     % Table 1 uses these numbers for market shares
%     clc
%     idx = find(DATE>=datetime(2010,11,1) & DATE<=datetime(2011,3,31));
%     
%     %TransCanada
%     mean(firm(6).k(idx)./K(idx))
%     mean((sum(firm(6).k_asset(idx,:),2)-sum(firm(6).k_asset(idx,7:12),2))./K(idx))
%     %firm(6).asset(7:12).id
%     
%     %ATCO
%     mean(firm(2).k(idx)./K(idx))
%     mean((sum(firm(2).k_asset(idx,:),2)+sum(firm(4).k_asset(idx,3),2)+sum(firm(6).k_asset(idx,11:12),2)/2)./K(idx))
%     %firm(4).asset_id(3)
%     %firm(6).asset(11:12).id
%     
%     %ENMAX
%     mean(firm(4).k(idx)./K(idx))
%     mean((firm(4).k(idx)+wind_ENMAX(idx))./(K(idx)+wind(idx)))
%     mean((sum(firm(4).k_asset(idx,:),2)-sum(firm(4).k_asset(idx,[3,10,11]),2))./K(idx))
%     firm(4).asset_id([3,10,11])
%     
%     %CP
%     mean(firm(3).k(idx)./K(idx))
%     mean((sum(firm(3).k_asset(idx,:),2)-sum(firm(3).k_asset(idx,10:11),2)+sum(firm(1).k_asset(idx,19:20),2))./K(idx))
%     firm(3).asset(10:11).id
%     firm(1).asset(19:20).id
%     
%     %TA
%     mean(firm(5).k(idx)./K(idx))
%     mean((firm(5).k(idx)+wind_TA(idx))./(K(idx)+wind(idx)))
%     mean((sum(firm(5).k_asset(idx,:),2) + sum(firm(4).k_asset(idx,[10,11]),2) +...
%         sum(firm(3).k_asset(idx,10:11),2)  + sum(firm(6).k_asset(idx,7:10),2) + sum(firm(6).k_asset(idx,11:12),2)/2)./K(idx))
%     firm(4).asset_id(10:11)
%     firm(3).asset(10:11).id
%     firm(6).asset_id(7:10)
%     firm(6).asset_id(11:12)
%     
%     
%     %% Average bid price per MW for PPA plants during period
%     % Stats about bid functions for PPA plants discussed in the paper
%     
%     idx = find(DATE>=datetime(2010,1,1) & DATE<=datetime(2011,9,1));
% 
%     temp0 = mean(firm(3).k_asset(idx,10)).*mean(sum(firm(3).asset(10).offer_q(idx,:).*firm(3).asset(10).offer_p(idx,:),2)./firm(3).k_asset(idx,10),'omitnan')
%     temp1 = mean(firm(3).k_asset(idx,10));
%     temp0 = temp0 + mean(firm(3).k_asset(idx,11)).*mean(sum(firm(3).asset(11).offer_q(idx,:).*firm(3).asset(11).offer_p(idx,:),2)./firm(3).k_asset(idx,11),'omitnan')
%     temp1 = temp1 + mean(firm(3).k_asset(idx,11));
%     temp0 = temp0 + mean(firm(4).k_asset(idx,3)).*mean(sum(firm(4).asset(3).offer_q(idx,:).*firm(4).asset(10).offer_p(idx,:),2)./firm(4).k_asset(idx,3),'omitnan')
%     temp1 = temp1 + mean(firm(4).k_asset(idx,3));
%     temp0 = temp0 + mean(firm(4).k_asset(idx,10)).*mean(sum(firm(4).asset(10).offer_q(idx,:).*firm(4).asset(10).offer_p(idx,:),2)./firm(4).k_asset(idx,10),'omitnan')
%     temp1 = temp1 + mean(firm(4).k_asset(idx,10));
%     temp0 = temp0 + mean(firm(3).k_asset(idx,11)).*mean(sum(firm(4).asset(11).offer_q(idx,:).*firm(4).asset(11).offer_p(idx,:),2)./firm(4).k_asset(idx,11),'omitnan')
%     temp1 = temp1 + mean(firm(4).k_asset(idx,11));
% 
%     for ii=7:12
%     temp0 = temp0 + mean(firm(6).k_asset(idx,ii)).*mean(sum(firm(6).asset(ii).offer_q(idx,:).*firm(6).asset(ii).offer_p(idx,:),2)./firm(6).k_asset(idx,ii),'omitnan')
%     temp1 = temp1 + mean(firm(6).k_asset(idx,ii));
%     end
% 
%     temp0/temp1 %14.8807$/MWh on average for PPA plants
% 
%     temp0 = mean(firm(3).k_asset(idx,10)).*mean(max(firm(3).asset(10).offer_q(idx,:).*(firm(3).asset(10).offer_p(idx,:)<=0),[],2)./firm(3).k_asset(idx,10),'omitnan')
%     temp0 = temp0 + mean(firm(3).k_asset(idx,11)).*mean(max(firm(3).asset(11).offer_q(idx,:).*(firm(3).asset(11).offer_p(idx,:)<=0),[],2)./firm(3).k_asset(idx,11),'omitnan')
% 
%     temp0 = temp0 + mean(firm(4).k_asset(idx,3)).*mean(max(firm(4).asset(3).offer_q(idx,:).*(firm(4).asset(3).offer_p(idx,:)<=0),[],2)./firm(4).k_asset(idx,3),'omitnan')
%     temp0 = temp0 + mean(firm(4).k_asset(idx,10)).*mean(max(firm(4).asset(10).offer_q(idx,:).*(firm(4).asset(10).offer_p(idx,:)<=0),[],2)./firm(4).k_asset(idx,10),'omitnan')
%     temp0 = temp0 + mean(firm(4).k_asset(idx,11)).*mean(max(firm(4).asset(11).offer_q(idx,:).*(firm(4).asset(11).offer_p(idx,:)<=0),[],2)./firm(4).k_asset(idx,11),'omitnan')
% 
%     for ii=7:12
%     temp0 = temp0 + mean(firm(6).k_asset(idx,ii)).*mean(max(firm(6).asset(ii).offer_q(idx,:).*(firm(6).asset(ii).offer_p(idx,:)<=0),[],2)./firm(6).k_asset(idx,ii),'omitnan')
%     end
% 
%     temp0 %0.7394 of capacity is offered at zero prices



%% Manipulation events

n = length(DATE);
idx = (1:n)';

% %Event sets: allegations against TransAlta
% %Event 1: Sundance 5
% idx_event1_1 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==19));
% idx_event1_2 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==20));
% idx_event1_3 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==21));
% 
% %Event 2: Sundance 2
% idx_event2_1 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==23));
% 
% %Event 3: Sun 2 Sun 6 + Keephills 1
% idx_event3_1 = intersect(idx,find(YEAR==2010 & MONTH==12 & DAY==13));
% idx_event3_2 = intersect(idx,find(YEAR==2010 & MONTH==12 & DAY==14));
% idx_event3_3 = intersect(idx,find(YEAR==2010 & MONTH==12 & DAY==15));
% idx_event3_4 = intersect(idx,find(YEAR==2010 & MONTH==12 & DAY==16));
% 
% %Event 4: Keephills 2
% idx_event4_1 = intersect(idx,find(YEAR==2011 & MONTH==2 & DAY==16));
% idx_event4_2 = intersect(idx,find(YEAR==2011 & MONTH==2 & DAY==17));
% idx_event4_3 = intersect(idx,find(YEAR==2011 & MONTH==2 & DAY==18));
% 
% %All days with strategic forced outages (as investigated by the MSA)
% idx_events = [idx_event1_1;idx_event1_2;idx_event1_3;idx_event2_1;...
%     idx_event3_1;idx_event3_2;idx_event3_3;idx_event3_4;...
%     idx_event4_1;idx_event4_2;idx_event4_3]; %
% 
% 
% % Witness reports indicate additional events:
% %CP: 12 to 14 April and 12 to 19 August 2011
% %ENMAX: 24 Nov, 26 Nov, 30 Nov, Jan 15, Jan 17, Jan 21
% 
% % Outages at PPA plants are informative:
% % load('OUTAGES_PPA.mat')
% % TABLE_OUTAGES_PPA.start_date = datetime(TABLE_OUTAGES_PPA.start_date,'InputFormat','yyyy-MM-dd HH:mm:ss eee'); %format for datestr and datetime use different rules
% % TABLE_OUTAGES_PPA.end_date = datetime(TABLE_OUTAGES_PPA.end_date,'InputFormat','yyyy-MM-dd HH:mm:ss eee');
% % TABLE_OUTAGES_PPA.duration = TABLE_OUTAGES_PPA.end_date - TABLE_OUTAGES_PPA.start_date;
% % TABLE_OUTAGES_PPA = movevars(TABLE_OUTAGES_PPA, 'duration', 'Before', 'maxprice');
% 
% %Event sets: allegations against TransAlta in the witness reports
% %Event 5: Sundance 5
% idx_event5_1 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==24));
% idx_event5_2 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==25));
% %Longer event than initially defined for SD5, but Nov 24 is hard to associate to a new forced
% %outage event. No visible price impact in the data. Only 180MW down
% 
% %Event 6: Sundance 3
% %Friday Nov 26 to Monday Nov 29: SD3 - new event
% idx_event6_1 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==26));
% idx_event6_2 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==27));
% idx_event6_3 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==28));
% idx_event6_4 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==29));
% 
% %Event 7: Keephills 2
% %Tuesday Nov 30 to Friday Dec 3: KH2 - new event
% idx_event7_1 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==30));
% idx_event7_2 = intersect(idx,find(YEAR==2010 & MONTH==12 & DAY==1));
% idx_event7_3 = intersect(idx,find(YEAR==2010 & MONTH==12 & DAY==2));
% idx_event7_4 = intersect(idx,find(YEAR==2010 & MONTH==12 & DAY==3));
% 
% %Event 8: KH1 + KH2
% %Jan 15 to Jan 17 KH1 followed by KH2 from 16:00 to Jan 18
% %Tuesday. Probably something there, followed by KH1 again until Jan 18
% %9:00. - new event
% idx_event8_1 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==15));
% idx_event8_2 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==16));
% idx_event8_3 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==17));
% idx_event8_4 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==18));
% 
% %Event 9: SD4 SD5 KH2 (+SD3 offline for a month starting Jan 21)
% %Jan 21: SD3 and SD4 offline, followed with overlap by SD5 and KH2 - new event
% idx_event9_1 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==21));
% idx_event9_2 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==22));
% idx_event9_3 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==23));
% idx_event9_4 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==24));
% idx_event9_5 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==25));
% idx_event9_6 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==26));
% idx_event9_7 = intersect(idx,find(YEAR==2011 & MONTH==1 & DAY==27));
% 
% %Event 10: SD4 + SD5
% %Apr 12 to 17: SD4 and SD5  - new event
% idx_event10_1 = intersect(idx,find(YEAR==2011 & MONTH==4 & DAY==12));
% idx_event10_2 = intersect(idx,find(YEAR==2011 & MONTH==4 & DAY==13));
% idx_event10_3 = intersect(idx,find(YEAR==2011 & MONTH==4 & DAY==14));
% idx_event10_4 = intersect(idx,find(YEAR==2011 & MONTH==4 & DAY==15));
% idx_event10_5 = intersect(idx,find(YEAR==2011 & MONTH==4 & DAY==16));
% idx_event10_6 = intersect(idx,find(YEAR==2011 & MONTH==4 & DAY==17));
% idx_event10_7 = intersect(idx,find(YEAR==2011 & MONTH==4 & DAY==18));
% 
% %Event 11: SD4 + SD5 (+ SD6 for 2 months)
% %August 12 to 19: SD4 SD5 SD6 
% idx_event11_1 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==12));
% idx_event11_2 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==13));
% idx_event11_3 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==14));
% idx_event11_4 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==15));
% idx_event11_5 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==16));
% idx_event11_6 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==17));
% idx_event11_7 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==18));
% idx_event11_8 = intersect(idx,find(YEAR==2011 & MONTH==8 & DAY==19));
% 
% %Extra events
% idx_events2 = [idx_event5_1, idx_event5_2, idx_event6_1, idx_event6_2, idx_event6_3, idx_event6_4, idx_event7_1, idx_event7_2, idx_event7_3, idx_event7_4, idx_event8_1, idx_event8_2, idx_event8_3, idx_event8_4, idx_event9_1, idx_event9_2, idx_event9_3, idx_event9_4, idx_event9_5, idx_event9_6, idx_event9_7, idx_event10_1, idx_event10_2, idx_event10_3, idx_event10_4, idx_event10_5, idx_event10_6, idx_event10_7, idx_event11_1, idx_event11_2, idx_event11_3, idx_event11_4, idx_event11_5, idx_event11_6, idx_event11_7, idx_event11_8];
% idx_events2 = sort(idx_events2(:));
% 
% %All events
% idx_events3 = sort([idx_events;idx_events2]);
% 
% %Main event indices
% idx_events = intersect(idx_events,idx);
% idx_events2 = intersect(idx_events2,idx);
% idx_events3 = intersect(idx_events3,idx);

%% Training, validation/testing, reneging sets

    if peak_d==1
        idx = intersect(idx,find(HOUR>=8 & HOUR<=21)); %focus on daytime (07:00 to 21:00)
    else
        idx = setdiff(idx,find(HOUR>=8 & HOUR<=21)); %focus on nightime (21:00 to 07:00)
    end

    idx_events = intersect(idx_events,idx); %events investigated by the regulator
    idx_events2 = intersect(idx_events2,idx); %events signaled but not investigated
    idx_events3 = intersect(idx_events3,idx); %all events

    %Train/valid sets
    idx2 = setdiff(setdiff(idx,idx_events),idx_events2);
    idx_train = idx2; %init training set


    rng(1+prefix*1e6) %ensure reproducibility since sample is split at random


    for hh=0:23 %evenly split the sample by hours
        bb = find(HOUR(idx2)==hh);
        if ~isempty(bb)
            n_valid = round(length(idx2(bb))/3);
            idx_valid = idx2(bb(randi(length(idx2(bb)),n_valid,1)));
            idx_train = setdiff(idx_train,idx_valid);
        end
    end

    idx_valid = setdiff(idx2,idx_train); %valid/test set

%     %% Counterfactual capacity by asset during the events
%     % We recover how much capacity has been removed by firm-plant during each
%     % event. This step allows verifying what was done in the data prepation step.
% 
%     for ff = 1:6
%         firm(ff).k_c = (max(firm(ff).q_c'))';
%         firm(ff).k_asset_c = firm(ff).k_asset;
%     end
% 
%     
%     id=2; %SD5 & %CP: Event 1, 5, 9 10 and 11
%     firm(id+1).k_asset_c(idx_event1,10) = firm(id+1).k_asset(idx_event1,10) +  ...
%         firm(id+1).k_c(idx_event1)-firm(id+1).k(idx_event1);
%     firm(id+1).k_asset_c(idx_event5,10) = firm(id+1).k_asset(idx_event5,10) +  ...
%         firm(id+1).k_c(idx_event5)-firm(id+1).k(idx_event5);
%     firm(id+1).k_asset_c(idx_event9,10) = firm(id+1).k_asset(idx_event9,10) +  ...
%         firm(id+1).k_c(idx_event9)-firm(id+1).k(idx_event9);
%     firm(id+1).k_asset_c(idx_event10,10) = firm(id+1).k_asset(idx_event10,10) +  ...
%         firm(id+1).k_c(idx_event10)-firm(id+1).k(idx_event10);
%     firm(id+1).k_asset_c(idx_event11,10) = firm(id+1).k_asset(idx_event11,10) +  ...
%         firm(id+1).k_c(idx_event11)-firm(id+1).k(idx_event11);
% 
%     %SD6 & %CP: Event 3
%     firm(id+1).k_asset_c(idx_event3,11) = firm(id+1).k_asset(idx_event3,11) +  ...
%         firm(id+1).k_c(idx_event3)-firm(id+1).k(idx_event3);
% 
%     id=3; %KH1 & %ENMAX: Event 3 , 8
%     firm(id+1).k_asset_c(idx_event3,10) = firm(id+1).k_asset(idx_event3,10) +  ...
%         firm(id+1).k_c(idx_event3)-firm(id+1).k(idx_event3);
%     firm(id+1).k_asset_c(idx_event8,10) = firm(id+1).k_asset(idx_event8,10) +  ...
%         firm(id+1).k_c(idx_event3)-firm(id+1).k(idx_event3);
% 
%     %KH2 & %ENMAX: Event 4, 7,9
%     firm(id+1).k_asset_c(idx_event4,11) = firm(id+1).k_asset(idx_event4,11) +  ...
%         firm(id+1).k_c(idx_event4)-firm(id+1).k(idx_event4);
%     firm(id+1).k_asset_c(idx_event7,11) = firm(id+1).k_asset(idx_event7,11) +  ...
%         firm(id+1).k_c(idx_event7)-firm(id+1).k(idx_event7);
%     firm(id+1).k_asset_c(idx_event9,11) = firm(id+1).k_asset(idx_event9,11) +  ...
%         firm(id+1).k_c(idx_event9)-firm(id+1).k(idx_event9);
% 
%     id=5; %SD2 %TC: Event 2 and 3,
%     firm(id+1).k_asset_c(idx_event2,8) = firm(id+1).k_asset(idx_event2,8) +  ...
%         firm(id+1).k_c(idx_event2)-firm(id+1).k(idx_event2);
%     firm(id+1).k_asset_c(idx_event3,8) = firm(id+1).k_asset(idx_event3,8) +  ...
%         firm(id+1).k_c(idx_event3)-firm(id+1).k(idx_event3);
% 
%     %SD3 %TC: Event 6
%     firm(id+1).k_asset_c(idx_event6,9) = firm(id+1).k_asset(idx_event6,9) +  ...
%         firm(id+1).k_c(idx_event6)-firm(id+1).k(idx_event6);
% 
%     %SD4 %TC: Event 9, 10, 11
%     firm(id+1).k_asset_c(idx_event9,10) = firm(id+1).k_asset(idx_event9,10) +  ...
%         firm(id+1).k_c(idx_event9)-firm(id+1).k(idx_event9);
%     firm(id+1).k_asset_c(idx_event10,10) = firm(id+1).k_asset(idx_event10,10) +  ...
%         firm(id+1).k_c(idx_event10)-firm(id+1).k(idx_event10);
%     firm(id+1).k_asset_c(idx_event11,10) = firm(id+1).k_asset(idx_event11,10) +  ...
%         firm(id+1).k_c(idx_event11)-firm(id+1).k(idx_event11);


    %% Bids of PPA plants (zero-price offers)
    % Used to construct counterfactual bids for PPA plants
    % The baseline model assumes they would be offered at zero prices, which is
    % plausible given the data, but we also consider a ML prediction for
    % robustness.

    for ff = 1:6 %replace nan offers by zeros.
        for a = 1:length(firm(ff).list_asset)
            firm(ff).asset(a).offer(isnan(firm(ff).asset(a).offer)) = 0;
        end
    end

    INDX = [3,3,4,4,6,6,6;... %firm index
        10,11,10,11,8,9,10]; %firm-level PPA asset index subject to reneging (see above)

    %Pick an asset and reconstruct its counterfactual bid function
    for jj=1:length(INDX)
        ff = INDX(1,jj);
        a = INDX(2,jj);
        bb = max(find(sum(firm(ff).asset(a).offer_p~=0)==0));
        Q_PPA = zeros(n,length(P_grid));
        offer_q = firm(ff).asset(a).offer_q(:,bb:end);
        offer_p = firm(ff).asset(a).offer_p(:,bb:end);
        for i=1:n
            for j=1:length(P_grid)
                Q_PPA(i,j) = sum(offer_q(i,offer_p(i,:)<=P_grid(j)),2);
            end
        end

        firm(ff).asset(a).Q = Q_PPA; %individual asset bid function defined over P_grid
    end
    clear ff jj a bb i j Q_PPA;

    %% Define features/covariates for ML models

    % 500+ weather variables measured hourly across Alberta
    Xw = WEATHER{:,15:end};
    idx_temp = 14+find(sum(isnan(Xw(idx,:)))==0); %drop all vars with at least one nan
    Xw_varnames = WEATHER.Properties.VariableNames(idx_temp);
    Xw = Xw(:,idx_temp-14);

    % Capacity by assets and counterfactuals (during events)
    Xa= [firm(1).k_asset,firm(2).k_asset,firm(3).k_asset,firm(4).k_asset,firm(5).k_asset,firm(6).k_asset];
    Xa_c= [firm(1).k_asset,firm(2).k_asset,firm(3).k_asset_c,firm(4).k_asset_c,firm(5).k_asset,firm(6).k_asset_c];
    Xa_varnames = cellstr([repmat('asset_',size(Xa,2),1),num2str((1:size(Xa,2))')])';

    % Other covariates
    Xo = [NGPRICE,...
        (WEATHER.tempedm-10).*(WEATHER.tempedm>10),-(WEATHER.tempedm-10).*(WEATHER.tempedm<10),...
        (WEATHER.tempcal-10).*(WEATHER.tempcal>10),-(WEATHER.tempcal-10).*(WEATHER.tempcal<10),...
        (WEATHER.tempvan-10).*(WEATHER.tempvan>10),-(WEATHER.tempvan-10).*(WEATHER.tempvan<10),...
        (WEATHER.tempsktoon-10).*(WEATHER.tempsktoon>10),-(WEATHER.tempsktoon-10).*(WEATHER.tempsktoon<10),...
        DISP,Imp_cap,Exp_cap,...
        wind_ENMAX,wind_F,wind_SUNCOR,wind_TA];
    Xo_varnames = {'NGP','TempEdmHD','TempEdmCD','TempCalHD','TempCalCD','TempVanHD','TempVanCD','TempSasHD','TempSasCD',...
        'Demand','ImpCap','ExpCap','WindE','WindF','WindS','WindTA'};

    % Time dummies
    HOUR_d = dummyvar(HOUR+1);
    WDAY_d = dummyvar(WDAY);
    MONTH_d = dummyvar(MONTH);
    dumm = [HOUR_d,WDAY_d,MONTH_d];
    dumm_varnames = [cellstr([repmat('HOUR_',24,1),num2str((1:24)')])',...
        cellstr([repmat('WDAY_',7,1),num2str((1:7)')])',...
        cellstr([repmat('MONTH_',12,1),num2str((1:12)')])'];

    %continuous covariates
    Xg = [Xa,Xo,Xw];
    Xg_c = [Xa_c,Xo,Xw];

    %standardize continuous covariates
    standardizeX = std(Xg([idx_train;idx_valid],:),'omitnan');
        Xg_varnames = [Xa_varnames,Xo_varnames,Xw_varnames,dumm_varnames(sum(dumm(idx_train,:))~=0)];

    Xg = [Xg./standardizeX,dumm(:,sum(dumm(idx_train,:))~=0)]; %drop dummies with no variations

    Xg_varnames';

    idx_drop = find(sum(isnan(Xg(idx,:)) + isinf(Xg(idx,:)),1)>0); %drop covariates with no variations or nans;
    Xg(:,idx_drop) = []; %some asset capacites are dropped because they have zero variation in the sample.
    Xg_varnames(:,idx_drop) = [];

    %counterfactual covariates (PPA capacities differ in counterfactual
    %scenarios)
    Xg_c = [Xg_c./standardizeX,dumm(:,sum(dumm(idx_train,:))~=0)];
    Xg_c(:,idx_drop) = [];

    %GLMNET Parameters
    ALPHA = 1; %elasticnet mixing parameter, 1 = LASSO
    opts = struct('alpha',ALPHA);
    opts.standardize_resp = 1; %standardize response
    ops.penalty_factor = ones(1,size(Xg,2)); %penalize all variables
    
    %%  Model 1: Predict aggregate supply of rival firms RS model estimation / prediction
    % GLMNET is at times too verbose. Obviously, there are values of the regularization
    % parameter for which the feature matrix is rank deficient or near
    % singular.
    warning('off','MATLAB:nearlySingularMatrix');
    warning('off','MATLAB:rankDeficientMatrix');


    %dependent var: aggregate (inverse) residual supply
    Yg = firm(1).q+firm(2).q+firm(3).q+firm(4).q+firm(6).q;
    %Estimation
    fitg_RD = glmnet(Xg(idx_train,:),Yg(idx_train,:),'mgaussian',opts);
    %Choose lambda -- cross-validation 20-fold
    CVg_RD = cvglmnet(Xg(idx_train,:),Yg(idx_train,:), 'mgaussian',opts, 'mse', 20, [], 'false');
    
    SUMSTATS(1).fitg_RD = fitg_RD;
    SUMSTATS(1).CVg_RD = CVg_RD;
    SUMSTATS(1).Yg = Yg;
    
    clear fitg_RD CVg_RD Yg

    disp('Training RD model ok')
    

    %% Model 2 to 8: Predict supply of PPA plants separately
    
    for jj=1:length(INDX)
        ff = INDX(1,jj);
        a = INDX(2,jj);
        firm(ff).asset(a).id
        
        Yg = firm(ff).asset(a).Q;
        fitg=glmnet(Xg(idx_train,:),Yg(idx_train,:),'mgaussian',opts);
        CVg = cvglmnet(Xg(idx_train,:),Yg(idx_train,:), 'mgaussian',opts, 'mse', 20, [], 'false'); %type='mse' or type='mae'
        
        SUMSTATS(1+jj).fitg = fitg;
        SUMSTATS(1+jj).CVg = CVg;
        SUMSTATS(1+jj).Yg = Yg;
        
        disp(['Training PPA',num2str(jj),' model ok'])
    end

    clear jj ff a fitg CVg Yg
    
    
    
    %% Model 9: Predict supply function of TA
     
    Yg = firm(5).q_c; %observed bid function
    fitg_Q=glmnet(Xg(idx_train,:),Yg(idx_train,:),'mgaussian',opts); %glmnet estimation
    CVg_Q = cvglmnet(Xg(idx_train,:),Yg(idx_train,:), 'mgaussian',opts, 'mse', 20, [], 'false'); %CV choice of lambda
    
    SUMSTATS(9).fitg_Q = fitg_Q;
    SUMSTATS(9).CVg_Q = CVg_Q;
    SUMSTATS(9).Yg = Yg;

    clear fitg_Q CVg_Q Yg
    
    disp('Training S model ok')
    

    %%  Predictions aggregate supply of rival firms RS model estimation / prediction
   
    lambda_1se = 1; %mitigates risks of overfitting
    
    %% Model 1 Prediction
    if lambda_1se==1
        LAMBDA_RD_min = SUMSTATS(1).CVg_RD.lambda_1se;
    else
        LAMBDA_RD_min = SUMSTATS(1).CVg_RD.lambda_min;
    end
    Qhat = glmnetPredict(SUMSTATS(1).fitg_RD,Xg_c,[LAMBDA_RD_min]);

    %Smooth the predicted residual supply functions
    Qs = Qhat;

    %Ex-post monotonicity constraints:
    Qs(:,end)=(K_c-firm(5).k);
    for j = 1:length(P_grid)
        Qs(Qs(:,j)<0,j) = zeros(sum(Qs(:,j)<0),1);
    end
    for j = 1:length(P_grid)-1
        Qs(Qs(:,length(P_grid)-j)>Qs(:,length(P_grid)-j+1),length(P_grid)-j) = Qs(Qs(:,length(P_grid)-j)>Qs(:,length(P_grid)-j+1),length(P_grid)-j+1);
    end

    RDQhat = Qhat; %store unconstrained predictions
    Yghat = Qs; %store constrained predictions

    %Observed RS assuming PPA plants were offered at zero prices during events
    Yg = -firm(5).rdq_c+DISP;

    % Store some statistics to report how well the model fits
    SUMSTATS(1).BIAS(1) = mean(nanmean((Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(1).BIAS(2) = mean(nanmean((Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(1).BIAS(3) = mean(nanmean((Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(1).BIAS(4) = mean(nanmean((Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(1).BIAS(5) = mean(nanmean((Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(1).ABIAS(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(1).ABIAS(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(1).ABIAS(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(1).ABIAS(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(1).ABIAS(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(1).ARBIAS(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))./Yg(idx_train,:)));
    SUMSTATS(1).ARBIAS(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))./Yg(idx_valid,:)));
    SUMSTATS(1).ARBIAS(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))./Yg(idx_events,:)));
    SUMSTATS(1).ARBIAS(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))./Yg(idx_events2,:)));
    SUMSTATS(1).ARBIAS(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))./Yg(idx_events3,:)));

    SUMSTATS(1).STD(1) = mean(std(Yg(idx_train,:)-Yghat(idx_train,:)));
    SUMSTATS(1).STD(2) = mean(std(Yg(idx_valid,:)-Yghat(idx_valid,:)));
    SUMSTATS(1).STD(3) = mean(std(Yg(idx_events,:)-Yghat(idx_events,:)));
    SUMSTATS(1).STD(4) = mean(std(Yg(idx_events2,:)-Yghat(idx_events2,:)));
    SUMSTATS(1).STD(5) = mean(std(Yg(idx_events3,:)-Yghat(idx_events3,:)));

    SUMSTATS(1).RMSE(1) = sqrt(mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:)).^2)));
    SUMSTATS(1).RMSE(2) = sqrt(mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:)).^2)));
    SUMSTATS(1).RMSE(3) = sqrt(mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:)).^2)));
    SUMSTATS(1).RMSE(4) = sqrt(mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:)).^2)));
    SUMSTATS(1).RMSE(5) = sqrt(mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:)).^2)));

    %observed RS
    Yg = -firm(5).rdq+DISP;

    % Store some statistics to report how well the model fits
    SUMSTATS(1).BIAS2(1) = mean(nanmean((Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(1).BIAS2(2) = mean(nanmean((Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(1).BIAS2(3) = mean(nanmean((Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(1).BIAS2(4) = mean(nanmean((Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(1).BIAS2(5) = mean(nanmean((Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(1).ABIAS2(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(1).ABIAS2(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(1).ABIAS2(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(1).ABIAS2(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(1).ABIAS2(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(1).ARBIAS2(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))./Yg(idx_train,:)));
    SUMSTATS(1).ARBIAS2(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))./Yg(idx_valid,:)));
    SUMSTATS(1).ARBIAS2(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))./Yg(idx_events,:)));
    SUMSTATS(1).ARBIAS2(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))./Yg(idx_events2,:)));
    SUMSTATS(1).ARBIAS2(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))./Yg(idx_events3,:)));

    SUMSTATS(1).STD2(1) = mean(std(Yg(idx_train,:)-Yghat(idx_train,:)));
    SUMSTATS(1).STD2(2) = mean(std(Yg(idx_valid,:)-Yghat(idx_valid,:)));
    SUMSTATS(1).STD2(3) = mean(std(Yg(idx_events,:)-Yghat(idx_events,:)));
    SUMSTATS(1).STD2(4) = mean(std(Yg(idx_events2,:)-Yghat(idx_events2,:)));
    SUMSTATS(1).STD2(5) = mean(std(Yg(idx_events3,:)-Yghat(idx_events3,:)));

    SUMSTATS(1).RMSE2(1) = sqrt(mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:)).^2)));
    SUMSTATS(1).RMSE2(2) = sqrt(mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:)).^2)));
    SUMSTATS(1).RMSE2(3) = sqrt(mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:)).^2)));
    SUMSTATS(1).RMSE2(4) = sqrt(mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:)).^2)));
    SUMSTATS(1).RMSE2(5) = sqrt(mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:)).^2)));

    % Store coefficients and model estimates
    betaRD = zeros(length(P_grid),1);
    BETAHAT_RD = zeros(length(P_grid),size(SUMSTATS(1).fitg_RD.beta{1}(:,1),1));

    for j=1:length(P_grid)
        betaRD(j) = sum(SUMSTATS(1).fitg_RD.beta{j}(:,find(LAMBDA_RD_min==SUMSTATS(1).fitg_RD.lambda))~=0);
        BETAHAT_RD(j,:) = SUMSTATS(1).fitg_RD.beta{j}(:,find(LAMBDA_RD_min==SUMSTATS(1).fitg_RD.lambda));
    end
    SUMSTATS(1).PARAMS = mean(betaRD);
    SUMSTATS(1).BETAHAT_RD = BETAHAT_RD;
    SUMSTATS(1).LAMBDA_RD_min= LAMBDA_RD_min;

    SUMSTATS(1)

    %clear j betaRD BETAHAT_RD


    %% Model 2 to 8: Predict supply of PPA plants separately
    close all

    for jj=1:length(INDX)
        ff = INDX(1,jj);
        a = INDX(2,jj);
        firm(ff).asset(a).id
        
        Yg = SUMSTATS(1+jj).Yg;
        
        if lambda_1se==1
            LAMBDA_g_min = SUMSTATS(1+jj).CVg.lambda_1se;
        else
            LAMBDA_g_min = SUMSTATS(1+jj).CVg.lambda_min;
        end
        
        Qhat = glmnetPredict(SUMSTATS(1+jj).fitg,Xg_c,[LAMBDA_g_min]);

        %Ex-post monotonicity constraint
        Qs_temp = Qhat;

        Qs_temp(:,length(P_grid))=firm(ff).k_asset_c(:,a);
        for j = 1:length(P_grid)
            Qs_temp(Qs_temp(:,j)<0,j) = zeros(sum(Qs_temp(:,j)<0),1);
        end
        for j = 1:length(P_grid)-1
            Qs_temp(Qs_temp(:,length(P_grid)-j)>Qs_temp(:,length(P_grid)-j+1),length(P_grid)-j) = Qs_temp(Qs_temp(:,length(P_grid)-j)>Qs_temp(:,length(P_grid)-j+1),length(P_grid)-j+1);
        end

        firm(ff).asset(a).Qhat = Qhat;
        firm(ff).asset(a).Qs = Qs_temp;

        ['Supply of PPA ',num2str(jj),' ok']

        Yghat = Qs_temp;

        % Store some statistics to report how well we fit.
        SUMSTATS(1+jj).BIAS(1) = mean(nanmean((Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(1+jj).BIAS(2) = mean(nanmean((Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(1+jj).BIAS(3) = mean(nanmean((Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(1+jj).BIAS(4) = mean(nanmean((Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(1+jj).BIAS(5) = mean(nanmean((Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(1+jj).ABIAS(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(1+jj).ABIAS(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(1+jj).ABIAS(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(1+jj).ABIAS(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(1+jj).ABIAS(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(1+jj).ARBIAS(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))./Yg(idx_train,:)));
    SUMSTATS(1+jj).ARBIAS(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))./Yg(idx_valid,:)));
    SUMSTATS(1+jj).ARBIAS(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))./Yg(idx_events,:)));
    SUMSTATS(1+jj).ARBIAS(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))./Yg(idx_events2,:)));
    SUMSTATS(1+jj).ARBIAS(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))./Yg(idx_events3,:)));

    SUMSTATS(1+jj).STD(1) = mean(std(Yg(idx_train,:)-Yghat(idx_train,:)));
    SUMSTATS(1+jj).STD(2) = mean(std(Yg(idx_valid,:)-Yghat(idx_valid,:)));
    SUMSTATS(1+jj).STD(3) = mean(std(Yg(idx_events,:)-Yghat(idx_events,:)));
    SUMSTATS(1+jj).STD(4) = mean(std(Yg(idx_events2,:)-Yghat(idx_events2,:)));
    SUMSTATS(1+jj).STD(5) = mean(std(Yg(idx_events3,:)-Yghat(idx_events3,:)));

    SUMSTATS(1+jj).RMSE(1) = sqrt(mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:)).^2)));
    SUMSTATS(1+jj).RMSE(2) = sqrt(mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:)).^2)));
    SUMSTATS(1+jj).RMSE(3) = sqrt(mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:)).^2)));
    SUMSTATS(1+jj).RMSE(4) = sqrt(mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:)).^2)));
    SUMSTATS(1+jj).RMSE(5) = sqrt(mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:)).^2)));

        %Store coeffs and models
        betaPPA = zeros(length(P_grid),1);
        BETAHAT_PPA = zeros(length(P_grid),size(SUMSTATS(1).fitg_RD.beta{1}(:,1),1));

        for j=1:length(P_grid)
            betaPPA(j) = sum(SUMSTATS(1+jj).fitg.beta{j}(:,find(LAMBDA_g_min==SUMSTATS(1+jj).fitg.lambda))~=0);
            BETAHAT_PPA(j,:) = SUMSTATS(1+jj).fitg.beta{j}(:,find(LAMBDA_g_min==SUMSTATS(1+jj).fitg.lambda));
        end
        SUMSTATS(1+jj).PARAMS = mean(betaPPA);
        SUMSTATS(1+jj).BETAHAT_PPA = BETAHAT_PPA;
        SUMSTATS(1+jj).LAMBDA_PPA_min= LAMBDA_g_min;
    end


    %% Counterfactual RD

    % Observed RD:
    %firm(5).rdq
    Yhat = firm(1).q+firm(2).q+firm(3).q+firm(4).q+firm(6).q; %actual RS
    RD_hat = DISP - Yhat; %actual RD

    %Counterfactual RD: observed+zero prices PPA
    Yhat_c = firm(1).q_c+firm(2).q_c+firm(3).q_c+firm(4).q_c+firm(6).q_c; %counterfactual RS
    RD_hat_c = DISP - Yhat_c; %adding withheld capacity at zero prices

    % Predicted RD -- assuming all plants available
    RD_c = DISP - Qs; %counterfactual RD (constrained and predicted)
    RD_c2 = DISP - RDQhat;%counterfactual RD (unconstrained and predicted)

    % Predicted RD -- assuming PPA plants not available
    % Counterfactual RD removing counterfactual bids of PPA plants
    % Remark: we predict RD from the ML model assuming PPA plants are available, then predict what PPA plants
    % would have bid and substract them from the predicted RD.
    Y = Qs;
    for jj=1:length(INDX)
        ff = INDX(1,jj);
        a = INDX(2,jj);
        proportion = (firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a))./firm(ff).k_asset_c(:,a);
        Y((firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a)>0),:) = Y((firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a)>0),:) - proportion((firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a)>0)).*(firm(ff).asset(a).Qs((firm(ff).k_asset_c(:,a)-firm(ff).k_asset(:,a)>0),:));
        RD = DISP - Y;
    end

    %% Model 9: Predict supply function of TA
    close all

    Yg = SUMSTATS(9).Yg;

    if lambda_1se==1
        LAMBDA_Q_min = SUMSTATS(9).CVg_Q.lambda_1se;
    else
        LAMBDA_Q_min = SUMSTATS(9).CVg_Q.lambda_min;
    end
    
    Qhat = glmnetPredict(SUMSTATS(9).fitg_Q,Xg_c,[LAMBDA_Q_min]); %predict

    Qt = Qhat;
    %[~, ~, Qs_fdt, ~, ~, ~, ~] = smooth_monotone(P_grid,Qhat(idx,:)',XfdPar,[],[],0.01,100,[],0);
    %Qt(idx,:) = eval_fd(P_grid,Qs_fdt)';

    Qt(:,length(P_grid))=firm(5).k;
    for j = 1:length(P_grid)
        Qt(Qt(:,j)<0,j) = zeros(sum(Qt(:,j)<0),1);
    end
    for j = 1:length(P_grid)-1
        Qt(Qt(:,length(P_grid)-j)>Qt(:,length(P_grid)-j+1),length(P_grid)-j) = Qt(Qt(:,length(P_grid)-j)>Qt(:,length(P_grid)-j+1),length(P_grid)-j+1);
    end

    'TA Supply ok'

    Yghat = Qt; %Counterfactual Supply -- smoothed and constrained.

    % Construct some statistics to report how well we fit.
    SUMSTATS(9).BIAS(1) = mean(nanmean((Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(9).BIAS(2) = mean(nanmean((Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(9).BIAS(3) = mean(nanmean((Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(9).BIAS(4) = mean(nanmean((Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(9).BIAS(5) = mean(nanmean((Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(9).ABIAS(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))));
    SUMSTATS(9).ABIAS(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))));
    SUMSTATS(9).ABIAS(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))));
    SUMSTATS(9).ABIAS(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))));
    SUMSTATS(9).ABIAS(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))));

    SUMSTATS(9).ARBIAS(1) = mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:))./Yg(idx_train,:)));
    SUMSTATS(9).ARBIAS(2) = mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:))./Yg(idx_valid,:)));
    SUMSTATS(9).ARBIAS(3) = mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:))./Yg(idx_events,:)));
    SUMSTATS(9).ARBIAS(4) = mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:))./Yg(idx_events2,:)));
    SUMSTATS(9).ARBIAS(5) = mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:))./Yg(idx_events3,:)));

    SUMSTATS(9).STD(1) = mean(std(Yg(idx_train,:)-Yghat(idx_train,:)));
    SUMSTATS(9).STD(2) = mean(std(Yg(idx_valid,:)-Yghat(idx_valid,:)));
    SUMSTATS(9).STD(3) = mean(std(Yg(idx_events,:)-Yghat(idx_events,:)));
    SUMSTATS(9).STD(4) = mean(std(Yg(idx_events2,:)-Yghat(idx_events2,:)));
    SUMSTATS(9).STD(5) = mean(std(Yg(idx_events3,:)-Yghat(idx_events3,:)));

    SUMSTATS(9).RMSE(1) = sqrt(mean(nanmean(abs(Yg(idx_train,:)-Yghat(idx_train,:)).^2)));
    SUMSTATS(9).RMSE(2) = sqrt(mean(nanmean(abs(Yg(idx_valid,:)-Yghat(idx_valid,:)).^2)));
    SUMSTATS(9).RMSE(3) = sqrt(mean(nanmean(abs(Yg(idx_events,:)-Yghat(idx_events,:)).^2)));
    SUMSTATS(9).RMSE(4) = sqrt(mean(nanmean(abs(Yg(idx_events2,:)-Yghat(idx_events2,:)).^2)));
    SUMSTATS(9).RMSE(5) = sqrt(mean(nanmean(abs(Yg(idx_events3,:)-Yghat(idx_events3,:)).^2)));
    


    % Store coeffs and models
    betaQ = zeros(length(P_grid),1);
    BETAHAT_Q = zeros(length(P_grid),size(SUMSTATS(9).fitg_Q.beta{1}(:,1),1));

    for j=1:length(P_grid)
        betaQ(j) = sum(SUMSTATS(9).fitg_Q.beta{j}(:,find(LAMBDA_Q_min==SUMSTATS(9).fitg_Q.lambda))~=0);
        BETAHAT_Q(j,:) = SUMSTATS(9).fitg_Q.beta{j}(:,find(LAMBDA_Q_min==SUMSTATS(9).fitg_Q.lambda));
    end
    SUMSTATS(9).PARAMS = mean(betaQ);
    SUMSTATS(9).BETAHAT_Q = BETAHAT_Q;
    SUMSTATS(9).LAMBDA_Q_min= LAMBDA_Q_min;

    SUMSTATS(9)

        save(['Tempfiles/temp',num2str(prefix),'_',num2str(peak_d),'.mat'],'-v7.3')

end
