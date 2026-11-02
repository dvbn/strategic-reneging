% Application - reneging contracts
% First regression tables are here:
%
close all
clear
clc
tablepath = 'Tables';
figurepath = 'Figures';

%% Load data
load('data.mat')

%% Identify manipulation events
% Two types of manupulation events.
% Some events have been investigated by the regulator (idx_events), others
% have been pointed out by rivals but not investigated (idx_events2). We
% study both types separately and jointly (idx_events3).

%Sample to be used
n = length(DATE);
idx = find(DATE>=datetime(2008,1,1) & DATE<datetime(2011,9,1));

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
% idx_event6_3 = intersect(idx,find(YEAR==2010 & MONTH==11 & DAY==26));
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
% %Jan 15 Saturday to Jan 17 16:00 Monday KH1 followed by KH2 from 16:00 to Jan 18
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
% %August 12 to 19: SD4 SD5 SD6  - new event: we neglect this event since it
% %also involves several to planned outages and we lack info about which
% %outages are forced.
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

%% OUTAGES INDICATORS
% Generate dummies for different types of outages

load('OUTAGES_PPA.mat')

TABLE_OUTAGES_PPA.start_date = datetime(TABLE_OUTAGES_PPA.start_date,'InputFormat','yyyy-MM-dd HH:mm:ss eee'); %format for datestr and datetime use different rules
TABLE_OUTAGES_PPA.end_date = datetime(TABLE_OUTAGES_PPA.end_date,'InputFormat','yyyy-MM-dd HH:mm:ss eee');

%Outages between 1-2008 to 1-2009
idx = find(TABLE_OUTAGES_PPA.start_date>=datetime(2008,1,1) & TABLE_OUTAGES_PPA.start_date<datetime(2009,1,1) ...
    & TABLE_OUTAGES_PPA.end_date-TABLE_OUTAGES_PPA.start_date >hours(3) &  TABLE_OUTAGES_PPA.end_date-TABLE_OUTAGES_PPA.start_date <=days(7));

outage_2008_d = zeros(size(DATE));
outage_2008_d1 = zeros(size(DATE));
outage_2008_k = zeros(size(DATE));
for ii=1:length(idx)
    idx0 = find(DATE>=TABLE_OUTAGES_PPA.start_date(idx(ii)) & DATE<TABLE_OUTAGES_PPA.end_date(idx(ii)));
    outage_2008_d(idx0) = 1;
    outage_2008_k(idx0) = sum(TABLE_OUTAGES_PPA{idx(ii),5:end},2);

    idx0 = find(DATE>=TABLE_OUTAGES_PPA.start_date(idx(ii)) & DATE<=TABLE_OUTAGES_PPA.start_date(idx(ii))+hours(2) & DATE<TABLE_OUTAGES_PPA.end_date(idx(ii)));
    outage_2008_d1(idx0) = 1;
end

%Outages between 1-2009 to 1-2010
idx = find(TABLE_OUTAGES_PPA.start_date>=datetime(2009,1,1) & TABLE_OUTAGES_PPA.start_date<datetime(2010,1,1) ...
    & TABLE_OUTAGES_PPA.end_date-TABLE_OUTAGES_PPA.start_date >hours(3) &  TABLE_OUTAGES_PPA.end_date-TABLE_OUTAGES_PPA.start_date <=days(7));
outage_2009_d = zeros(size(DATE));
outage_2009_d1 = zeros(size(DATE));
outage_2009_k = zeros(size(DATE));
for ii=1:length(idx)
    idx0 = find(DATE>=TABLE_OUTAGES_PPA.start_date(idx(ii)) & DATE<TABLE_OUTAGES_PPA.end_date(idx(ii)));
    outage_2009_d(idx0) = 1;
    outage_2009_k(idx0) = sum(TABLE_OUTAGES_PPA{idx(ii),5:end},2);

    idx0 = find(DATE>=TABLE_OUTAGES_PPA.start_date(idx(ii)) & DATE<=TABLE_OUTAGES_PPA.start_date(idx(ii))+hours(2) & DATE<TABLE_OUTAGES_PPA.end_date(idx(ii)));
    outage_2009_d1(idx0) = 1;
end

%Outages between 1-2010 to 1-2012
idx = find(TABLE_OUTAGES_PPA.start_date>=datetime(2010,1,1) & TABLE_OUTAGES_PPA.start_date<datetime(2012,1,1) ...
    & TABLE_OUTAGES_PPA.end_date-TABLE_OUTAGES_PPA.start_date >hours(3) &  TABLE_OUTAGES_PPA.end_date-TABLE_OUTAGES_PPA.start_date <=days(7));
outage_2010_d = zeros(size(DATE));
outage_2010_d1 = zeros(size(DATE));
outage_2010_k = zeros(size(DATE));
for ii=1:length(idx)
    idx0 = find(DATE>=TABLE_OUTAGES_PPA.start_date(idx(ii)) & DATE<TABLE_OUTAGES_PPA.end_date(idx(ii)));
    outage_2010_d(idx0) = 1;
    outage_2010_k(idx0) = sum(TABLE_OUTAGES_PPA{idx(ii),5:end},2);

    idx0 = find(DATE>=TABLE_OUTAGES_PPA.start_date(idx(ii)) & DATE<=TABLE_OUTAGES_PPA.start_date(idx(ii))+hours(2) & DATE<TABLE_OUTAGES_PPA.end_date(idx(ii)));
    outage_2010_d1(idx0) = 1;
end

outages_all = zeros(length(DATE),height(TABLE_OUTAGES_PPA));
for ii=1:length(TABLE_OUTAGES_PPA.start_date)
    outageevent{ii,1} = [];
    if  (TABLE_OUTAGES_PPA.end_date(ii)-TABLE_OUTAGES_PPA.start_date(ii) >hours(3) &&  TABLE_OUTAGES_PPA.end_date(ii)-TABLE_OUTAGES_PPA.start_date(ii) <days(7))

        outageevent{ii,1} = append(string(TABLE_OUTAGES_PPA.Properties.VariableNames(4+find(TABLE_OUTAGES_PPA{ii,{'SD1' 'SD2' 'SD3' 'SD4' 'SD5' 'SD6' 'KH1' 'KH2'}}~=0))),': ', datestr(TABLE_OUTAGES_PPA.start_date(ii),'yyyy-mm-dd'),' to ',datestr(TABLE_OUTAGES_PPA.end_date(ii),'yyyy-mm-dd'));

        outages_all(find(DATE>=TABLE_OUTAGES_PPA.start_date(ii) & DATE<=TABLE_OUTAGES_PPA.end_date(ii)),ii) = 1;


    end

end

%Keeping track of outage events
outageevent(sum(outages_all)==0) = [];
outages_all(:,sum(outages_all)==0) = [];
%table(outageevent,sum(outages_all)')

% Indicators for outages
d_e = zeros(size(DATE,1),14);

for ii=4:14 % "suspicious outage events" (idx_events,idx_events2)
    d_e(event(ii-3).index(K_c(event(ii-3).index)>K(event(ii-3).index)),ii) = 1;
end

% "supposedly normal outage events"
d_e( (outage_2008_d) == 1,1) = 1;
d_e( (outage_2009_d) == 1,2) = 1;
d_e( (outage_2010_d - sum(d_e,2)) == 1,3) = 1;

%% Manipulation events
% First 3 hours of outage
ho = 3;
events_d1 = events_d*0;
events_d1(find(DATE>=datetime(2010,11,19,18,0,0) & DATE<=datetime(2010,11,19,18+ho-1,0,0))) = 1;
events_d1(find(DATE>=datetime(2010,11,23,10,0,0) & DATE<=datetime(2010,11,23,10+ho-1,0,0))) = 1;
events_d1(find(DATE>=datetime(2010,12,13,17,0,0) & DATE<=datetime(2010,12,13,17+ho-1,0,0))) = 1;
events_d1(find(DATE>=datetime(2011,2,16,18,0,0) & DATE<=datetime(2011,2,16,18+ho-1,0,0))) = 1;
% events_d1(find(DATE>=datetime(2010,11,24,14,0,0) & DATE<=datetime(2010,11,24,14+ho-1,0,0))) = 1;
% events_d1(find(DATE>=datetime(2010,11,26,16,0,0) & DATE<=datetime(2010,11,26,16+ho-1,0,0))) = 1;
% events_d1(find(DATE>=datetime(2010,11,30,15,0,0) & DATE<=datetime(2010,11,30,15+ho-1,0,0))) = 1;
% %events_d1(find(DATE>=datetime(2011,1,15,18,0,0) & DATE<=datetime(2011,1,15,18+ho-1,0,0))) = 1; 
% events_d1(find(DATE>=datetime(2011,1,21,19,0,0) & DATE<=datetime(2011,1,21,19+ho-1,0,0))) = 1;
% events_d1(find(DATE>=datetime(2011,4,12,14,0,0) & DATE<=datetime(2011,4,12,14+ho-1,0,0))) = 1;
% events_d1(find(DATE>=datetime(2011,8,12,17,0,0) & DATE<=datetime(2011,8,12,17+ho-1,0,0))) = 1;

% All hours of outage
events_d2 = events_d*0;
events_d2(find(DATE>=datetime(2010,11,19,18,0,0) & DATE<=datetime(2010,11,21,23,0,0))) = 1;
events_d2(find(DATE>=datetime(2010,11,23,10,0,0) & DATE<=datetime(2010,11,23,21,0,0))) = 1;
events_d2(find(DATE>=datetime(2010,12,13,17,0,0) & DATE<=datetime(2010,12,16,22,0,0))) = 1;
events_d2(find(DATE>=datetime(2011,2,16,18,0,0) & DATE<=datetime(2011,2,18,21,0,0))) = 1;
% events_d2(find(DATE>=datetime(2010,11,24,14,0,0) & DATE<=datetime(2010,11,25,16,0,0))) = 1;
% events_d2(find(DATE>=datetime(2010,11,26,16,0,0) & DATE<=datetime(2010,11,29,14,0,0))) = 1;
% events_d2(find(DATE>=datetime(2010,11,30,15,0,0) & DATE<=datetime(2010,12,3,7,0,0))) = 1;
% %events_d2(find(DATE>=datetime(2011,1,15,18,0,0) & DATE<=datetime(2011,1,18,11,0,0))) = 1;
% events_d2(find(DATE>=datetime(2011,1,21,19,0,0) & DATE<=datetime(2011,1,27,17,0,0))) = 1;
% events_d2(find(DATE>=datetime(2011,4,12,14,0,0) & DATE<=datetime(2011,4,17,22,0,0))) = 1;
% events_d2(find(DATE>=datetime(2011,8,12,17,0,0) & DATE<=datetime(2011,8,19,23,0,0))) = 1;

id = 4; %focus on TransAlta

table((DATE(idx_events3)),weekday(DATE(idx_events3)),events_d1(idx_events3),events_d2(idx_events3),K_c(idx_events3)-K(idx_events3)) 

%% At times too verbose due to dummies
warning('off','MATLAB:nearlySingularMatrix');
warning('off','MATLAB:rankDeficientMatrix');

%% Table Reg 1 (Table 4): Strategic timing of forced outages
% Should we consider the outage timing as strategic?
% We regress outage indicators onto explanatory variables

for jj=1:2

    if jj==1

        %Column 1 %events identified by the regulator
        idx_clean = setdiff(find(DATE>=datetime(2010,11,1) & DATE<datetime(2011,9,1)),[]);
        events_d = events_d1;
        mean(events_d) % 0.5/% of hours
    else

        %Column 2 %extra events reported by witnesses
        idx_clean = setdiff(find(DATE>=datetime(2010,11,1) & DATE<datetime(2011,9,1)),[]);
        events_d = events_d2;
        mean(events_d)% 0.8/% of hours
    end


    % Main variables
    X1 = [(Demand(idx_clean))/1000,wind(idx_clean)/1000,... %/max(wind(idx_clean))<0.05,... %wind(idx_clean)/max(wind(idx_clean))<0.05,...
        ];

    HOUR_d = dummyvar(HOUR+1);
    WDAY_d = dummyvar(WDAY);
    WEEK_d = dummyvar(WEEK);
    YEAR_d = dummyvar(YEAR-2007);
    MONTH_d = dummyvar(MONTH);

    % All features
    X = [X1,ones(length((idx_clean)),1),HOUR_d((idx_clean),1:23),WDAY_d((idx_clean),2:end),...
        MONTH_d((idx_clean),1:end-1),YEAR_d(idx_clean,1:end-1)];
    [B,BINT,R,RINT,STATS] = regress(events_d(idx_clean),X,0.05);
    X(:,find(B==0)) = [];

    BHAT = nan(size(X1,2)+6,size(X1,2));
    SHAT = nan(size(X1,2)+6,size(X1,2));
    R2 = nan(size(X1,2),1);
    N = nan(size(X1,2),1);
    BHAT_min = nan(3,size(X1,2));
    BHAT_max = nan(3,size(X1,2));
    SHAT_min = nan(3,size(X1,2));
    SHAT_max = nan(3,size(X1,2));

    maxLag = floor(4*(length(idx_clean)/100)^(2/9));

    for ii=1:size(X1,2)
        [B,BINT,R,RINT,STATS] = regress(events_d(idx_clean),X(:,[1:ii,(size(X1,2)+1):size(X,2)]),0.05);

        [~,se,B] = hac(X(:,[1:ii,(size(X1,2)+1):size(X,2)]),events_d(idx_clean),Bandwidth=maxLag + 1,Intercept=false);
        BINT = [B-1.96*se,B+1.96*se];

        B_std = (B - BINT(:,1))/1.96;
        BHAT(1:ii,ii) = B(1:ii);
        SHAT(1:ii,ii) = se(1:ii); 
        R2(ii) = STATS(1);
        N(ii) = length(R);

        X_ = X(:,[1:ii,(size(X1,2)+1):size(X,2)]);

        B_COV = (events_d(idx_clean)-X_*B)'*(events_d(idx_clean)-X_*B)/(length(idx_clean)-size(X_,2)+1)*inv(X_'*X_);
        PAR(1).INX = length([(1:ii)';1])+(1:8);
        PAR(2).INX = length([(1:ii)';1])+(9:16);
        PAR(3).INX = length([(1:ii)';1])+(17:23);
        PAR(4).INX = length([(1:ii)';1;(1:23)'])+(1:6);


        for i=1:3
            BHAT_min(i,ii) = min(B(PAR(i).INX));
            BHAT_max(i,ii) = max(B(PAR(i).INX));
            SHAT_min(i,ii) = min(se(PAR(i).INX));
            SHAT_max(i,ii) = max(se(PAR(i).INX));

        end
        i = 4;
        BHAT(size(X1,2)+1:end,ii) = B(PAR(i).INX);
        SHAT(size(X1,2)+1:end,ii) = se(PAR(i).INX); %(1-normcdf(abs((B(PAR(i).INX)./((B(PAR(i).INX)-BINT(PAR(i).INX,2))/1.96)))))*2;

    end

    clear BHAT2 SHAT2

    for i=1:size(BHAT,2)
        for ii=1:size(BHAT,1)
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) >0.1
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.3f'),'$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.1
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.3f'),'^{\star}$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.05
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.3f'),'^{\star\star}$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.01
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star\star}$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if isnan(2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) )
                BHAT2{ii,i} =  ' ';
                SHAT2{ii,i} =  ' ';
            end
        end
    end

    for i=1:size(BHAT_min,2)
        for ii=1:size(BHAT_min,1)
            BHAT2{8+ii,i} =  ['$',num2str(BHAT_min(ii,i),'%0.2f'),',',num2str(BHAT_max(ii,i),'%0.2f'),'$'];
            SHAT2{8+ii,i} =  ['$(',num2str(SHAT_min(ii,i),'%0.2f'),',',num2str(SHAT_max(ii,i),'%0.2f'),')$'];
        end
    end

    reg(jj).BHAT2 = BHAT2;
    reg(jj).SHAT2 = SHAT2;
    reg(jj).N = N;
    reg(jj).R2 = R2;

end

for jj=3:4

    if jj==3
        %Column 1% 2008, 2009, 2010 outage before portfolio bidding strategy
        idx_clean = find(DATE>=datetime(2008,1,1) & DATE<datetime(2010,11,1)) ;
        Y = outage_2008_d1(idx_clean)+outage_2009_d1(idx_clean)+outage_2010_d1(idx_clean);
        mean(Y) % 2.6\% of hours
    elseif jj==4
        %Column 2% 2010, 2011 outage after strategy
        %idx_clean = find(DATE>=datetime(2010,11,1) & DATE<datetime(2011,9,1)) ;
        %Y = max(outage_2010_d1(idx_clean),events_d1(idx_clean)); %min(outage_2010_d(idx_clean)+events_d(idx_clean),1);
        idx_clean = find(DATE>=datetime(2008,1,1) & DATE<datetime(2010,11,1)) ;
        Y = outage_2008_d(idx_clean)+outage_2009_d(idx_clean)+outage_2010_d(idx_clean);
        mean(Y) % 35\% of hours
    end

    X1 = [(Demand(idx_clean))/1000,wind(idx_clean)/1000,...
        ]; %


    HOUR_d = dummyvar(HOUR+1);
    WDAY_d = dummyvar(WDAY);
    WEEK_d = dummyvar(WEEK);
    YEAR_d = dummyvar(YEAR-2007);
    MONTH_d = dummyvar(MONTH);

    X = [X1,ones(length((idx_clean)),1),HOUR_d((idx_clean),1:23),WDAY_d((idx_clean),2:end),...
        MONTH_d((idx_clean),1:end-1),YEAR_d(idx_clean,1:end-1)];
    [B,BINT,R,RINT,STATS] = regress(Y,X,0.05);
    X(:,find(B==0)) = [];


    BHAT = nan(size(X1,2)+6,size(X1,2));
    SHAT = nan(size(X1,2)+6,size(X1,2));
    R2 = nan(size(X1,2),1);
    N = nan(size(X1,2),1);
    BHAT_min = nan(3,size(X1,2));
    BHAT_max = nan(3,size(X1,2));
    SHAT_min = nan(3,size(X1,2));
    SHAT_max = nan(3,size(X1,2));


    for ii=1:size(X1,2)

        [B,BINT,R,RINT,STATS] = regress(Y,X(:,[1:ii,(size(X1,2)+1):size(X,2)]),0.05);
        %table([(1:ii)';1;(1:23)';(2:7)';(1:size(WEEK_d(:,[1:14,45:52]),2))'],BINT(:,1),BINT(:,2),B)

        [~,se,B] = hac(X(:,[1:ii,(size(X1,2)+1):size(X,2)]),Y,Bandwidth=maxLag + 1,Intercept=false);
        BINT = [B-1.96*se,B+1.96*se];

        B_std = (B - BINT(:,1))/1.96;
        BHAT(1:ii,ii) = B(1:ii);
        SHAT(1:ii,ii) = se(1:ii); %(1-normcdf(abs((B(1:ii)./((B(1:ii)-BINT(1:ii,2))/1.96)))))*2; %B_std(1:ii);
        R2(ii) = STATS(1);
        N(ii) = length(R);

        X_ = X(:,[1:ii,(size(X1,2)+1):size(X,2)]);
        %table(B_std,sqrt(diag((events_d(idx_clean)-X_*B)'*(events_d(idx_clean)-X_*B)/(length(idx_clean)-size(X_,2)+1)*inv(X_'*X_))))
        B_COV = (events_d(idx_clean)-X_*B)'*(events_d(idx_clean)-X_*B)/(length(idx_clean)-size(X_,2)+1)*inv(X_'*X_);
        PAR(1).INX = length([(1:ii)';1])+(1:8);
        PAR(2).INX = length([(1:ii)';1])+(9:16);
        PAR(3).INX = length([(1:ii)';1])+(17:23);
        PAR(4).INX = length([(1:ii)';1;(1:23)'])+(1:6);

        for i=1:3
            BHAT_min(i,ii) = min(B(PAR(i).INX));
            BHAT_max(i,ii) = max(B(PAR(i).INX));
            SHAT_min(i,ii) = min(se(PAR(i).INX));
            SHAT_max(i,ii) = max(se(PAR(i).INX));

        end
        i = 4;
        BHAT(size(X1,2)+1:end,ii) = B(PAR(i).INX);
        SHAT(size(X1,2)+1:end,ii) = se(PAR(i).INX);

    end

    clear BHAT2 SHAT2

    for i=1:size(BHAT,2)
        for ii=1:size(BHAT,1)
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) >0.1
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.1
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star}$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.05
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star}$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.01
                BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star\star}$'];
                SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.3f'),')$'];
            end
            if isnan(2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) )
                BHAT2{ii,i} =  ' ';
                SHAT2{ii,i} =  ' ';
            end
        end
    end


    % for i=1:size(BHAT_min,2)
    % for ii=1:size(BHAT_min,1)
    %    BHAT2{10+ii,i} =  ['$[',num2str(BHAT_min(ii,i),'%0.2f'),',',num2str(BHAT_max(ii,i),'%0.2f'),']$'];
    %    SHAT2{10+ii,i} =  ['$([',num2str(SHAT_min(ii,i),'%0.2f'),',',num2str(SHAT_max(ii,i),'%0.2f'),'])$'];
    % end
    % end

    for i=1:size(BHAT_min,2)
        for ii=1:size(BHAT_min,1)
            BHAT2{8+ii,i} =  ['$',num2str(BHAT_min(ii,i),'%0.2f'),',',num2str(BHAT_max(ii,i),'%0.2f'),'$'];
            SHAT2{8+ii,i} =  ['$(',num2str(SHAT_min(ii,i),'%0.2f'),',',num2str(SHAT_max(ii,i),'%0.2f'),')$'];
        end
    end

    reg(jj).BHAT2 = BHAT2;
    reg(jj).SHAT2 = SHAT2;
    reg(jj).N = N;
    reg(jj).R2 = R2;

end



BHAT2 = [reg(1).BHAT2(:,2),reg(2).BHAT2(:,2),reg(3).BHAT2(:,2),reg(4).BHAT2(:,2)];
SHAT2 = [reg(1).SHAT2(:,2),reg(2).SHAT2(:,2),reg(3).SHAT2(:,2),reg(4).SHAT2(:,2)];
N = [reg(1).N(2)',reg(2).N(2)',reg(3).N(2)',reg(4).N(2)'];
R2 = [reg(1).R2(2)',reg(2).R2(2)',reg(3).R2(2)',reg(4).R2(2)'];

BHAT2
SHAT2

%% Latex table

Labexx = {' Demand (GWh) ', ' Wind (GWh) ',...
    ' Monday ',' Tuesday ', ' Wednesday ', ' Thursday ', ' Friday ', ' Saturday ', ' 12am-8am dummies ', ' 9am to 4pm dummies ', ' 5pm to 11pm dummies '};

TABLE1 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{5}{c}}',...
    ' \toprule & $(1)$ & $(2)$ & $(3)$ & $(4)$   \\',...
    ' \hline ',...
    ];

for ii=1:11 %setdiff(1:12,[5,6,8,9]) %
    TABLE1 = [TABLE1,...
        Labexx{ii},' & ',...
        BHAT2{ii,1},' & ',...
        BHAT2{ii,2},' & ',...
        BHAT2{ii,3},' & ',...
        BHAT2{ii,4},'  \\ ', ...
        '  & ',...
        SHAT2{ii,1},' & ',...
        SHAT2{ii,2},' & ',...
        SHAT2{ii,3},' & ',...
        SHAT2{ii,4},'  \\ '];
end

TABLE1 = [TABLE1,...
    ' \hline ',...
    ' Observations & ',num2str(N(1)),' & ',num2str(N(2)),' & ',num2str(N(3)),' & ',num2str(N(4)),' \\ ',...;
    ' $R^2$ & ',num2str(R2(1),'%0.2f'),' & ',num2str(R2(2),'%0.2f'),' & ',num2str(R2(3),'%0.2f'),' & ',num2str(R2(4),'%0.2f'),' \\ \bottomrule '];

TABLE1 = [TABLE1,...
    '\end{tabular*}'];
BHAT2
% %if savetable==1
fileID = fopen([tablepath,'/table_4.tex'],'w');
fprintf(fileID,'%s',TABLE1);
fclose(fileID);
% %end

sum(events_d2==1)
sum(events_d1==1)




%% Events onto P, Q, B, RD, K
% Impacts of outages onto price, TransAlta production, TransAtla bid
% function, its residual demand function, and available capacity
% Not reported in final paper

idx_clean = find(DATE>=datetime(2008,1,1) & DATE<datetime(2011,9,1)) ;
maxLag = floor(4*(length(idx_clean)/100)^(2/9));

clc
HOUR_d = dummyvar(HOUR+1);
WDAY_d = dummyvar(WDAY);
WEEK_d = dummyvar(WEEK);
YEAR_d = dummyvar(YEAR-2007);
MONTH_d = dummyvar(MONTH);

%PRICE
X1 = [d_e(idx_clean,:),wind(idx_clean)/std(wind(idx_clean)),Demand(idx_clean)/std(Demand(idx_clean)),NGPRICE(idx_clean)/std(NGPRICE(idx_clean)),WEATHER.tempcal(idx_clean).*(WEATHER.tempcal(idx_clean)>10),WEATHER.tempcal(idx_clean).*(WEATHER.tempcal(idx_clean)<=10)]; %using K_c is a problem because it is very correlated with DISP and dRD
X = [X1,ones(length((idx_clean)),1),HOUR_d((idx_clean),1:23),WDAY_d((idx_clean),2:end),MONTH_d((idx_clean),1:11),YEAR_d(idx_clean,1:3)];

BHAT = nan(size(X,2),5);
SHAT = nan(size(X,2),5);
R2 = nan(1,5);
N = nan(1,5);

mean(X1(:,1))
Y = PRICE(idx_clean);

[B,BINT,R,RINT,STATS] = regress(Y,X,0.05);

[~,se,B] = hac(X,Y,Bandwidth=maxLag + 1,Intercept=false);
BINT = [B-1.96*se,B+1.96*se];
table((1:14)',BINT(1:14,:),B(1:14))

BHAT(:,1) = B;
SHAT(:,1) = se;
R2(1) = STATS(1);
N(1) = length(idx_clean);

%Q
X1 = [d_e(idx_clean,:),wind(idx_clean)/std(wind(idx_clean)),Demand(idx_clean)/std(Demand(idx_clean)),NGPRICE(idx_clean)/std(NGPRICE(idx_clean)),WEATHER.tempcal(idx_clean).*(WEATHER.tempcal(idx_clean)>10),WEATHER.tempcal(idx_clean).*(WEATHER.tempcal(idx_clean)<=10)]; %using K_c is a problem because it is very correlated with DISP and dRD
X = [X1,ones(length((idx_clean)),1),HOUR_d((idx_clean),1:23),WDAY_d((idx_clean),2:end),MONTH_d((idx_clean),1:11),YEAR_d(idx_clean,1:3)];

mean(X1(:,1))
Y = firm(5).DISP(idx_clean)'; %

[B,BINT,R,RINT,STATS] = regress(Y,X,0.05);
[~,se,B] = hac(X,Y,Bandwidth=maxLag + 1,Intercept=false);
BINT = [B-1.96*se,B+1.96*se];
table((1:14)',BINT(1:14,:),B(1:14))

BHAT(:,2) = B;
SHAT(:,2) = se;
R2(2) = STATS(1);
N(2) = length(idx_clean);

%BIDS
X1 = [d_e(idx_clean,:),wind(idx_clean)/std(wind(idx_clean)),Demand(idx_clean)/std(Demand(idx_clean)),NGPRICE(idx_clean)/std(NGPRICE(idx_clean)),WEATHER.tempcal(idx_clean).*(WEATHER.tempcal(idx_clean)>10),WEATHER.tempcal(idx_clean).*(WEATHER.tempcal(idx_clean)<=10)]; %using K_c is a problem because it is very correlated with DISP and dRD
X = [X1,ones(length((idx_clean)),1),HOUR_d((idx_clean),1:23),WDAY_d((idx_clean),2:end),MONTH_d((idx_clean),1:11),YEAR_d(idx_clean,1:3)];

mean(X1(:,1))
%Y = firm(5).DISP(idx_clean)'./firm(5).k(idx_clean); %
Y = mean(firm(5).q(idx_clean,:),2);

[B,BINT,R,RINT,STATS] = regress(Y,X,0.05);
[~,se,B] = hac(X,Y,Bandwidth=maxLag + 1,Intercept=false);
BINT = [B-1.96*se,B+1.96*se];
table((1:14)',BINT(1:14,:),B(1:14))
BHAT(:,3) = B;
SHAT(:,3) = se;
R2(3) = STATS(1);
N(3) = length(idx_clean);

% RD
Y = mean(firm(5).rdq(idx_clean,:),2);

[B,BINT,R,RINT,STATS] = regress(Y,X,0.05);
[~,se,B] = hac(X,Y,Bandwidth=maxLag + 1,Intercept=false);
BINT = [B-1.96*se,B+1.96*se];
table((1:14)',BINT(1:14,:),B(1:14))
BHAT(:,4) = B;
SHAT(:,4) = se;
R2(4) = STATS(1);
N(4) = length(idx_clean);

% TOTAL CAPACITY REMOVED
Y = outage_2008_k(idx_clean) + outage_2009_k(idx_clean) + outage_2010_k(idx_clean) ; %
Y(idx_events3) = mean(firm(5).rdq(idx_events3,:),2)-mean(firm(5).rdq_c(idx_events3,:),2);

[B,BINT,R,RINT,STATS] = regress(Y,X,0.05);
[~,se,B] = hac(X,Y,Bandwidth=maxLag + 1,Intercept=false);
BINT = [B-1.96*se,B+1.96*se];
table((1:14)',BINT(1:14,:),B(1:14))
BHAT(:,5) = B;
SHAT(:,5) = se;
R2(5) = STATS(1);
N(5) = length(idx_clean);

BHAT
SHAT

clear BHAT2 SHAT2

for i=1:size(BHAT,2)
    for ii=1:size(BHAT,1)
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) >0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.1f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.1f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.05
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.1f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.01
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.1f'),'^{\star\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.1f'),')$'];
        end
        if isnan(2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) )
            BHAT2{ii,i} =  ' ';
            SHAT2{ii,i} =  ' ';
        end
    end
end

BHAT2
SHAT2

R2
N


%% Collect results into a latex table
% Not reported in final paper

%table
Labexx = {' 2008 outages ', ' 2009 outages ', ' 2010-11 outages ',...
    ' Nov19-Nov21 ',' Nov23 ',' Dec13-Dec16 ',' Feb16-Feb18 ',...
    ' Nov24-Nov25 ',' Nov26-Nov29 ',' Nov30-Dec03 ',' Jan15-Jan18 ',' Jan21-Jan27 ',' Apr12-Apr18 ',' Aug12-Aug19 '};

TABLE1 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{5}{c}}',...
    ' \toprule & $P$ & $Q$ & $S$ & $RD$ & $Outage$   \\',...
    ' \hline ',...
    ];

for ii=1:14 %setdiff(1:12,[5,6,8,9]) %
    TABLE1 = [TABLE1,...
        Labexx{ii},' & ',...
        BHAT2{ii,1},' & ',...
        BHAT2{ii,2},' & ',...
        BHAT2{ii,3},' & ',...
        BHAT2{ii,4},' & ',...
        BHAT2{ii,5},'  \\ ', ...
        '  & ',...
        SHAT2{ii,1},' & ',...
        SHAT2{ii,2},' & ',...
        SHAT2{ii,3},' & ',...
        SHAT2{ii,4},' & ',...
        SHAT2{ii,5},'  \\ '];
end

TABLE1 = [TABLE1,...
    ' \hline ',...
    ' Observations & ',num2str(N(1)),' & ',num2str(N(2)),' & ',num2str(N(3)),' & ',num2str(N(4)),' & ',num2str(N(5)),' \\ ',...;
    ' $R^2$ & ',num2str(R2(1),'%0.2f'),' & ',num2str(R2(2),'%0.2f'),' & ',num2str(R2(3),'%0.2f'),' & ',num2str(R2(4),'%0.2f'),' & ',num2str(R2(5),'%0.2f'),' \\ \bottomrule '];

TABLE1 = [TABLE1,...
    '\end{tabular*}'];
BHAT2
fileID = fopen([tablepath,'/table_appendix_REG_PRELIM.tex'],'w');
fprintf(fileID,'%s',TABLE1);
fclose(fileID);


%% Demand and seasonality
% Not reported in final paper
% Pick weather station as close to calgary as possible

idx_TEMP = find(contains(WEATHER.Properties.VariableNames,'Temp'));
idx_HUM = find(contains(WEATHER.Properties.VariableNames,'Hum'));
idx_DEW = find(contains(WEATHER.Properties.VariableNames,'DewP'));
idx_WS = find(contains(WEATHER.Properties.VariableNames,'Windsp'));

idx_TEMP(mean(isnan(WEATHER{:,idx_TEMP}))>0.01) = [];
idx_HUM(mean(isnan(WEATHER{:,idx_HUM}))>0.01) = [];
idx_DEW(mean(isnan(WEATHER{:,idx_DEW}))>0.01) = [];
idx_WS(mean(isnan(WEATHER{:,idx_WS}))>0.01) = [];

DIST = nan(size(idx_TEMP));
for ii=1:length(idx_TEMP)
    temp = (WEATHER.Properties.VariableNames{idx_TEMP(ii)});
    find(contains(INFOS_WEATHER.IDclim,temp(end-7:end)));
    GPS = INFOS_WEATHER{find(contains(INFOS_WEATHER.IDclim,temp(end-6:end))),[3 2]};
    [d1km d2km]=lldistkm(GPS,[51.0447034,-114.074094]);
    DIST(ii) = d1km;
end
[~,b0] = sort(DIST);
idx_TEMP = idx_TEMP(b0(1));

DIST = nan(size(idx_HUM));
for ii=1:length(idx_HUM)
    temp = (WEATHER.Properties.VariableNames{idx_HUM(ii)});
    find(contains(INFOS_WEATHER.IDclim,temp(end-7:end)));
    GPS = INFOS_WEATHER{find(contains(INFOS_WEATHER.IDclim,temp(end-6:end))),[3 2]};
    [d1km d2km]=lldistkm(GPS,[51.0447034,-114.074094]);
    DIST(ii) = d1km;
end
[~,b0] = sort(DIST);
idx_HUM = idx_HUM(b0(1));

DIST = nan(size(idx_DEW));
for ii=1:length(idx_DEW)
    temp = (WEATHER.Properties.VariableNames{idx_DEW(ii)});
    find(contains(INFOS_WEATHER.IDclim,temp(end-7:end)));
    GPS = INFOS_WEATHER{find(contains(INFOS_WEATHER.IDclim,temp(end-6:end))),[3 2]};
    [d1km d2km]=lldistkm(GPS,[51.0447034,-114.074094]);
    DIST(ii) = d1km;
end
[~,b0] = sort(DIST);
idx_DEW = idx_DEW(b0(1));

DIST = nan(size(idx_WS));
for ii=1:length(idx_WS)
    temp = (WEATHER.Properties.VariableNames{idx_WS(ii)});
    find(contains(INFOS_WEATHER.IDclim,temp(end-7:end)));
    GPS = INFOS_WEATHER{find(contains(INFOS_WEATHER.IDclim,temp(end-6:end))),[3 2]};
    [d1km d2km]=lldistkm(GPS,[51.0447034,-114.074094]);
    DIST(ii) = d1km;
end
[~,b0] = sort(DIST);
idx_WS = idx_WS(b0(1));

BHAT = nan(12+23,4);
SHAT = nan(12+23,4);
R2 = nan(1,4);
N = nan(1,4);

for jj=1:4

    if jj==1
        idx_clean = find(DATE>=datetime(2008,1,1) & DATE<datetime(2009,1,1)) ;
    elseif jj==2
        idx_clean = find(DATE>=datetime(2009,1,1) & DATE<datetime(2010,1,1)) ;
    elseif jj==3
        idx_clean = find(DATE>=datetime(2010,1,1) & DATE<datetime(2011,1,1)) ;
    elseif jj==4
        idx_clean = find(DATE>=datetime(2011,1,1) & DATE<datetime(2012,1,1)) ;
    end

    X = [ones(length(idx_clean),1),...
        ((WEATHER{idx_clean,{'tempcal'}}>10)).*(WEATHER{idx_clean,{'tempcal'}}-10),...
        (-(WEATHER{idx_clean,{'tempcal'}}<=10)).*(WEATHER{idx_clean,{'tempcal'}}-10),...
        WEATHER{idx_clean,[idx_HUM idx_DEW idx_WS]},...
        WDAY_d(idx_clean,2:end),HOUR_d(idx_clean,1:23),MONTH_d(idx_clean,1:end-1)];

    Y = (Demand(idx_clean))/1000;

    if jj==4
        X(:,end-3:end) = [];
    end
    [B,BINT,R,RINT,STATS] = regress(Y,X);
    X(:,find(B==0)) = [];

    maxLag = floor(4*(length(idx_clean)/100)^(2/9));
    [~,se,B] = hac(X,Y,Bandwidth=maxLag + 1,Intercept=false);

    BINT = [B-1.96*se,B+1.96*se];

    BHAT(:,jj) = B(1:12+23);
    SHAT(:,jj) = se(1:12+23);
    R2(jj) = STATS(1);
    N(jj) = length(idx_clean);
end

clear BHAT2 SHAT2

for i=1:4
    for ii=1:12
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) >0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.05
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.01
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if isnan(2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) )
            BHAT2{ii,i} =  ' ';
            SHAT2{ii,i} =  ' ';
        end
    end
end

BHAT2
SHAT2
R2
N


%% Collect results into a latex table
% Not reported in final paper

Labexx = {' Constant ', ' Cooling Degrees ', ' Heating Degrees ',...
    ' Humidity ',' DewPoint ',' WindSpeed ',' Monday ',...
    ' Tuesday ',' Wednesday ',' Thursday ',' Friday ',' Saturday '};

TABLE1 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{4}{c}}',...
    ' \toprule & $2008$ & $2009$ & $2010$ & $2011$    \\',...
    ' \hline ',...
    ];

for ii=1:12 
    TABLE1 = [TABLE1,...
        Labexx{ii},' & ',...
        BHAT2{ii,1},' & ',...
        BHAT2{ii,2},' & ',...
        BHAT2{ii,3},' & ',...
        BHAT2{ii,4},'  \\ ', ...
        '  & ',...
        SHAT2{ii,1},' & ',...
        SHAT2{ii,2},' & ',...
        SHAT2{ii,3},' & ',...
        SHAT2{ii,4},'  \\ '];
end

TABLE1 = [TABLE1,...
    ' \hline ',...
    ' Observations & ',num2str(N(1)),' & ',num2str(N(2)),' & ',num2str(N(3)),' & ',num2str(N(4)),' \\ ',...;
    ' $R^2$ & ',num2str(R2(1),'%0.2f'),' & ',num2str(R2(2),'%0.2f'),' & ',num2str(R2(3),'%0.2f'),' & ',num2str(R2(4),'%0.2f'),' \\ \bottomrule '];

TABLE1 = [TABLE1,...
    '\end{tabular*}'];
BHAT2
fileID = fopen([tablepath,'/table_appendix_REG_DEMAND.tex'],'w');
fprintf(fileID,'%s',TABLE1);
fclose(fileID);


%% Table Reg 2 (Table 5): Strategic wind curtailment?
clearvars -except d_e events_d1 events_d2 tablepath
load('WINDTABLE.mat')

%% MODEL 1
% BEFORE/AFTER
clear reg

%TransAlta wind farm output
Y = sum(WINDTABLE{:,idx_WINDTA([1 3 4 6])},2); 

%Period
idx2 = find(WINDTABLE.Time>=datetime(2008,1,1) & WINDTABLE.Time<datetime(2011,9,1));

%Treatment before/after
TREAT = zeros(size(Y));
TREAT(find(WINDTABLE.Time>=datetime(2010,11,1) & WINDTABLE.Time<datetime(2011,12,31))) = 1;

X = [TREAT,... %WINDTABLE.NG_PRICE,... %(WINDTABLE.CAPACITY-WINDTABLE.PRODUCTION)/1000,
    WINDTABLE{:,idx_WINDO}./repmat(std(WINDTABLE{:,idx_WINDO}),length(Y),1),...
    WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}}./repmat(std(WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}},'omitnan'),length(Y),1),...
    DUMS(:,1:end),ones(length(DUMS),1)];

%OLS
[B,BINT,R,RINT,STATS] = regress(Y(idx2),[X(idx2,:)]);
STATS(1)
BINT(1:10,:)

%OLS with Newey-West covariance
maxLag = floor(4*(length(idx2)/100)^(2/9));
[EstCoeffCov,se,coeff] = hac(...
    X(idx2,:),Y(idx2),Bandwidth=maxLag + 1,Intercept=false);

table(B(1:end),se(1:end),B(1:end)./se(1:end))
reg(1).BHAT = coeff;
reg(1).SHAT = se;
reg(1).R2 = STATS(1);
reg(1).N = length(idx2);

%% MODEL 2
% EVENTS 1 / EVENTS 2

%Treatment investigated events/suspected events/no events
TREAT1 = zeros(size(Y));
TREAT1(intersect(idx_events,find(events_d==1))) = 1;
TREAT2 = zeros(size(Y));
TREAT2(intersect(idx_events2,find(events_d==1))) = 1;

X = [TREAT1,TREAT2,WINDTABLE{:,idx_WINDO}./repmat(std(WINDTABLE{:,idx_WINDO}),length(Y),1),...
    WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}}./repmat(std(WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}},'omitnan'),length(Y),1),...
    ones(length(DUMS),1),DUMS(:,1:end)]; %,WINDTABLE{:,idx_TEMP} ,WINDTABLE{:,idx_WA},W

[B,BINT,R,RINT,STATS] = regress(Y(idx2),[X(idx2,:)]);
STATS(1)

table(BINT(1:14,1),BINT(1:14,2))

[EstCoeffCov,se,coeff] = hac(...
    X(idx2,:),Y(idx2),Bandwidth=maxLag + 1,Intercept=false);

reg(2).BHAT = coeff;
reg(2).SHAT = se;
reg(2).R2 = STATS(1);
reg(2).N = length(idx2);

% reg(2).BHAT(1)/mean(Y(find(X(:,1)==1)))
% decrease wind power output by 16% on average

%% MODEL 3
% SEPARATE EVENTS (not reported in table because takes too much space)
% A wind farm owned by TA was shut down during event 5, hence removing 70MW
% from the market.

X = [d_e(:,1:end),WINDTABLE{:,idx_WINDO}./repmat(std(WINDTABLE{:,idx_WINDO}),length(Y),1),...
    WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}}./repmat(std(WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}},'omitnan'),length(Y),1),...
    ones(length(DUMS),1),DUMS(:,1:end)]; %,WINDTABLE{:,idx_TEMP} ,WINDTABLE{:,idx_WA},W

[B,BINT,R,RINT,STATS] = regress(Y(idx2),[X(idx2,:)]);
STATS(1)

table(BINT(1:14,1),BINT(1:14,2))


[EstCoeffCov,se,coeff] = hac(...
    X(idx2,:),Y(idx2),Bandwidth=maxLag + 1,Intercept=false);

reg(3).BHAT = coeff;
reg(3).SHAT = se;
reg(3).R2 = STATS(1);
reg(3).N = length(idx2);

%% MODEL 4 
%ALL EVENTS ENMAX
Y = sum(WINDTABLE{:,idx_WINDEN},2);

X = [sum(d_e(:,4:7),2)>0,sum(d_e(:,8:end),2)>0,WINDTABLE{:,{'WIND_TA1' 'WIND_TA3' 'WIND_TA4' 'WIND_TA6' 'WIND_O3' 'WIND_O4'}}./repmat(std(WINDTABLE{:,{'WIND_TA1' 'WIND_TA3' 'WIND_TA4' 'WIND_TA6'  'WIND_O3' 'WIND_O4'}}),length(Y),1),...
    WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}}./repmat(std(WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}},'omitnan'),length(Y),1),...
    ones(length(DUMS),1),DUMS(:,1:end)]; %,WINDTABLE{:,idx_TEMP} ,WINDTABLE{:,idx_WA},W


[B,BINT,R,RINT,STATS] = regress(Y(idx2),[X(idx2,:)]);

STATS(1)
table(BINT(1:end,1),BINT(1:end,2))

[EstCoeffCov,se,coeff] = hac(...
    X(idx2,:),Y(idx2),Bandwidth=maxLag + 1,Intercept=false);

reg(4).BHAT = coeff;
reg(4).SHAT = se;
reg(4).R2 = STATS(1);
reg(4).N = length(idx2);

%% MODEL 5
%ALL EVENTS SUNCOR
Y = sum(WINDTABLE{:,idx_WINDSU},2);

X = [sum(d_e(:,4:7),2)>0,sum(d_e(:,8:end),2)>0,WINDTABLE{:,{'WIND_TA1' 'WIND_TA3' 'WIND_TA4' 'WIND_TA6' 'WIND_O1' 'WIND_O2'}}./repmat(std(WINDTABLE{:,{'WIND_TA1' 'WIND_TA3' 'WIND_TA4' 'WIND_TA6' 'WIND_O1' 'WIND_O2'}}),length(Y),1),...
    WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}}./repmat(std(WINDTABLE{:,{'Windspeed_3030830' 'Windspeed_3030720' 'Windspeed_3031640' 'Windspeed_3051R4R'}},'omitnan'),length(Y),1),...
    ones(length(DUMS),1),DUMS(:,1:end)]; %,WINDTABLE{:,idx_TEMP} ,WINDTABLE{:,idx_WA},W


[B,BINT,R,RINT,STATS] = regress(Y(idx2),[X(idx2,:)]);
STATS(1)
B(1)


[EstCoeffCov,se,coeff] = hac(...
    X(idx2,:),Y(idx2),Bandwidth=maxLag + 1,Intercept=false);

reg(5).BHAT = coeff;
reg(5).SHAT = se;
reg(5).R2 = STATS(1);
reg(5).N = length(idx2);

%% ORGANIZE RESULTS
BHAT = nan(14,4);

BHAT(:,1) = reg(1).BHAT([ 1 1 (2:5) (6:9) 1 1 1 1]); %TREAT O1 O2 O3 O4 WS1 WS2 WS3 WS4
BHAT(:,2) = reg(2).BHAT([ 1 2 (3:6) (7:10) 1 1 1 1]); %TREAT O1 O2 O3 O4 WS1 WS2 WS3 WS4
BHAT(:,3) = reg(4).BHAT([ 1 2 1 1 (7:8) (9:12) (3:6) ]); %TREAT TA1 TA2 TA3 TA4 O3 O4 WS1 WS2 WS3 WS4
BHAT(:,4) = reg(5).BHAT([ 1 2 (7:8) 1 1 (9:12) (3:6)]); %TREAT TA1 TA2 TA3 TA4 O1 O2 WS1 WS2 WS3 WS4

BHAT([2 (11:14)],1) = nan;
BHAT([(11:14)],2) = nan;
BHAT([3 4],3) = nan;
BHAT([5 6],4) = nan;
table((1:14)',BHAT(:,1),BHAT(:,2),BHAT(:,3),BHAT(:,4))

SHAT = nan(14,5);

SHAT(:,1) = reg(1).SHAT([ 1 1 (2:5) (6:9) 1 1 1 1]); %TREAT O1 O2 O3 O4 WS1 WS2 WS3 WS4
SHAT(:,2) = reg(2).SHAT([ 1 2 (3:6) (7:10) 1 1 1 1]); %TREAT O1 O2 O3 O4 WS1 WS2 WS3 WS4
SHAT(:,3) = reg(4).SHAT([ 1 2 1 1 (7:8) (9:12) (3:6) ]); %TREAT TA1 TA2 TA3 TA4 O3 O4 WS1 WS2 WS3 WS4
SHAT(:,4) = reg(5).SHAT([ 1 2 (7:8) 1 1 (9:12) (3:6)]); %TREAT TA1 TA2 TA3 TA4 O1 O2 WS1 WS2 WS3 WS4

SHAT([2 (11:14)],1) = nan;
SHAT([(11:14)],2) = nan;
SHAT([3 4],3) = nan;
SHAT([5 6],4) = nan;
table((1:14)',SHAT(:,1),SHAT(:,2),SHAT(:,3),SHAT(:,4))

%% Generate latex table
clear BHAT2 SHAT2

for i=1:4
    for ii=1:14
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) >0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.05
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if 2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) <=0.01
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if isnan(2*(1-normcdf(abs(BHAT(ii,i))/SHAT(ii,i) )) )
            BHAT2{ii,i} =  ' ';
            SHAT2{ii,i} =  ' ';
        end
    end
end

BHAT2
SHAT2
reg.R2
reg.N


Labexx = {' Treat 1 ', ' Treat 2 ', ' WF ENMAX 1 ',...
    ' WF ENMAX 2 ',' WF SUNCOR 1 ',' WF SUNCOR 2 ',' WindSpeed 1 ',...
    ' WindSpeed 2 ',' WindSpeed 3 ',' WindSpeed 4 ',' WF TA 1 ',' WF TA 2 ',' WF TA 3 ',' WF TA 4 '};

TABLE1 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{4}{c}}',...
    ' \toprule & $Wind TA$ & $Wind TA$ & $Wind ENMAX$ & $Wind SUNCOR$    \\',...
    ' \hline ',...
    ];

for ii=1:14
    TABLE1 = [TABLE1,...
        Labexx{ii},' & ',...
        BHAT2{ii,1},' & ',...
        BHAT2{ii,2},' & ',...
        BHAT2{ii,3},' & ',...
        BHAT2{ii,4},'  \\ ', ...
        '  & ',...
        SHAT2{ii,1},' & ',...
        SHAT2{ii,2},' & ',...
        SHAT2{ii,3},' & ',...
        SHAT2{ii,4},'  \\ '];
end

TABLE1 = [TABLE1,...
    ' \hline ',...
    ' Observations & ',num2str(reg(1).N),' & ',num2str(reg(2).N),' & ',num2str(reg(4).N),' & ',num2str(reg(5).N),' \\ ',...;
    ' $R^2$ & ',num2str(reg(1).R2,'%0.2f'),' & ',num2str(reg(2).R2,'%0.2f'),' & ',num2str(reg(4).R2,'%0.2f'),' & ',num2str(reg(5).R2,'%0.2f'),' \\ \bottomrule '];

TABLE1 = [TABLE1,...
    '\end{tabular*}'];
BHAT2
fileID = fopen([tablepath,'/table_5.tex'],'w');
fprintf(fileID,'%s',TABLE1);
fclose(fileID);

