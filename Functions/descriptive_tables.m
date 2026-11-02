%% Descriptives table 1

load('Tempfiles/temp0_0.mat')

clear BHAT2 SHAT2;

Demand = DISP+wind+nansum(IMP_obs,2)-nansum(EXP_obs,2);

%Market demand (GWh)
BHAT2{1,1} =  ['$',num2str(mean(Demand(idx_train)/1000),'%0.2f'),'$'];
BHAT2{1,2} =  ['$',num2str(mean(Demand(idx_valid)/1000),'%0.2f'),'$'];
BHAT2{1,3} =  ['$',num2str(mean(Demand(idx_events)/1000),'%0.2f'),'$'];
BHAT2{1,4} =  ['$',num2str(mean(Demand(idx_events2)/1000),'%0.2f'),'$'];
SHAT2{1,1} =  ['$',num2str(std(Demand(idx_train)/1000),'%0.2f'),'$'];
SHAT2{1,2} =  ['$',num2str(std(Demand(idx_valid)/1000),'%0.2f'),'$'];
SHAT2{1,3} =  ['$',num2str(std(Demand(idx_events)/1000),'%0.2f'),'$'];
SHAT2{1,4} =  ['$',num2str(std(Demand(idx_events2)/1000),'%0.2f'),'$'];

%Price (CAD)
BHAT2{2,1} =  ['$',num2str(mean(PRICE(idx_train)),'%0.1f'),'$'];
BHAT2{2,2} =  ['$',num2str(mean(PRICE(idx_valid)),'%0.1f'),'$'];
BHAT2{2,3} =  ['$',num2str(mean(PRICE(idx_events)),'%0.1f'),'$'];
BHAT2{2,4} =  ['$',num2str(mean(PRICE(idx_events2)),'%0.1f'),'$'];
SHAT2{2,1} =  ['$',num2str(std(PRICE(idx_train)),'%0.1f'),'$'];
SHAT2{2,2} =  ['$',num2str(std(PRICE(idx_valid)),'%0.1f'),'$'];
SHAT2{2,3} =  ['$',num2str(std(PRICE(idx_events)),'%0.1f'),'$'];
SHAT2{2,4} =  ['$',num2str(std(PRICE(idx_events2)),'%0.1f'),'$'];

%Capacity (GW)
BHAT2{3,1} =  ['$',num2str(mean(K(idx_train)/1000),'%0.2f'),'$'];
BHAT2{3,2} =  ['$',num2str(mean(K(idx_valid)/1000),'%0.2f'),'$'];
BHAT2{3,3} =  ['$',num2str(mean(K(idx_events)/1000),'%0.2f'),'$'];
BHAT2{3,4} =  ['$',num2str(mean(K(idx_events2)/1000),'%0.2f'),'$'];
SHAT2{3,1} =  ['$',num2str(std(K(idx_train)/1000),'%0.2f'),'$'];
SHAT2{3,2} =  ['$',num2str(std(K(idx_valid)/1000),'%0.2f'),'$'];
SHAT2{3,3} =  ['$',num2str(std(K(idx_events)/1000),'%0.2f'),'$'];
SHAT2{3,4} =  ['$',num2str(std(K(idx_events2)/1000),'%0.2f'),'$'];

%Mean BID TA (MW)
BHAT2{4,1} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_train,:))) ,'%0.0f'),'$'];
BHAT2{4,2} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_valid,:))) ,'%0.0f'),'$'];
BHAT2{4,3} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_events,:))) ,'%0.0f'),'$'];
BHAT2{4,4} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_events2,:))) ,'%0.0f'),'$'];
SHAT2{4,1} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_train,:),2)) ,'%0.0f'),'$'];
SHAT2{4,2} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_valid,:),2)),'%0.0f'),'$'];
SHAT2{4,3} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_events,:),2)) ,'%0.0f'),'$'];
SHAT2{4,4} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_events2,:),2)) ,'%0.0f'),'$'];

%Mean BID RS (MW)
BHAT2{5,1} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_train,:))) ,'%0.0f'),'$'];
BHAT2{5,2} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_valid,:))) ,'%0.0f'),'$'];
BHAT2{5,3} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_events,:))) ,'%0.0f'),'$'];
BHAT2{5,4} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_events2,:))) ,'%0.0f'),'$'];
SHAT2{5,1} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_train,:),2)) ,'%0.0f'),'$'];
SHAT2{5,2} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_valid,:),2)) ,'%0.0f'),'$'];
SHAT2{5,3} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_events,:),2)) ,'%0.0f'),'$'];
SHAT2{5,4} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_events2,:),2)) ,'%0.0f'),'$'];

%Output TA (MWh)
BHAT2{6,1} =  ['$',num2str(mean(firm(5).DISP(idx_train)'),'%0.0f'),'$'];
BHAT2{6,2} =  ['$',num2str(mean(firm(5).DISP(idx_valid)'),'%0.0f'),'$'];
BHAT2{6,3} =  ['$',num2str(mean(firm(5).DISP(idx_events)'),'%0.0f'),'$'];
BHAT2{6,4} =  ['$',num2str(mean(firm(5).DISP(idx_events2)'),'%0.0f'),'$'];
SHAT2{6,1} =  ['$',num2str(std(firm(5).DISP(idx_train)'),'%0.0f'),'$'];
SHAT2{6,2} =  ['$',num2str(std(firm(5).DISP(idx_valid)'),'%0.0f'),'$'];
SHAT2{6,3} =  ['$',num2str(std(firm(5).DISP(idx_events)'),'%0.0f'),'$'];
SHAT2{6,4} =  ['$',num2str(std(firm(5).DISP(idx_events2)'),'%0.0f'),'$'];

%Wind TA (MWh)
BHAT2{7,1} =  ['$',num2str(mean(wind_TA(idx_train)),'%0.0f'),'$'];
BHAT2{7,2} =  ['$',num2str(mean(wind_TA(idx_valid)),'%0.0f'),'$'];
BHAT2{7,3} =  ['$',num2str(mean(wind_TA(idx_events)),'%0.0f'),'$'];
BHAT2{7,4} =  ['$',num2str(mean(wind_TA(idx_events2)),'%0.0f'),'$'];
SHAT2{7,1} =  ['$',num2str(std(wind_TA(idx_train)),'%0.0f'),'$'];
SHAT2{7,2} =  ['$',num2str(std(wind_TA(idx_valid)),'%0.0f'),'$'];
SHAT2{7,3} =  ['$',num2str(std(wind_TA(idx_events)),'%0.0f'),'$'];
SHAT2{7,4} =  ['$',num2str(std(wind_TA(idx_events2)),'%0.0f'),'$'];

%Wind Total (MWh)
BHAT2{8,1} =  ['$',num2str(mean(wind(idx_train)),'%0.0f'),'$'];
BHAT2{8,2} =  ['$',num2str(mean(wind(idx_valid)),'%0.0f'),'$'];
BHAT2{8,3} =  ['$',num2str(mean(wind(idx_events)),'%0.0f'),'$'];
BHAT2{8,4} =  ['$',num2str(mean(wind(idx_events2)),'%0.0f'),'$'];
SHAT2{8,1} =  ['$',num2str(std(wind(idx_train)),'%0.0f'),'$'];
SHAT2{8,2} =  ['$',num2str(std(wind(idx_valid)),'%0.0f'),'$'];
SHAT2{8,3} =  ['$',num2str(std(wind(idx_events)),'%0.0f'),'$'];
SHAT2{8,4} =  ['$',num2str(std(wind(idx_events2)),'%0.0f'),'$'];

%NG Price
BHAT2{9,1} =  ['$',num2str(mean(NGPRICE(idx_train)),'%0.1f'),'$'];
BHAT2{9,2} =  ['$',num2str(mean(NGPRICE(idx_valid)),'%0.1f'),'$'];
BHAT2{9,3} =  ['$',num2str(mean(NGPRICE(idx_events)),'%0.1f'),'$'];
BHAT2{9,4} =  ['$',num2str(mean(NGPRICE(idx_events2)),'%0.1f'),'$'];
SHAT2{9,1} =  ['$',num2str(std(NGPRICE(idx_train)),'%0.1f'),'$'];
SHAT2{9,2} =  ['$',num2str(std(NGPRICE(idx_valid)),'%0.1f'),'$'];
SHAT2{9,3} =  ['$',num2str(std(NGPRICE(idx_events)),'%0.1f'),'$'];
SHAT2{9,4} =  ['$',num2str(std(NGPRICE(idx_events2)),'%0.1f'),'$'];

%Temperature Calgary
BHAT2{10,1} =  ['$',num2str(mean(WEATHER.tempcal(idx_train)),'%0.1f'),'$'];
BHAT2{10,2} =  ['$',num2str(mean(WEATHER.tempcal(idx_valid)),'%0.1f'),'$'];
BHAT2{10,3} =  ['$',num2str(mean(WEATHER.tempcal(idx_events)),'%0.1f'),'$'];
BHAT2{10,4} =  ['$',num2str(mean(WEATHER.tempcal(idx_events2)),'%0.1f'),'$'];
SHAT2{10,1} =  ['$',num2str(std(WEATHER.tempcal(idx_train)),'%0.1f'),'$'];
SHAT2{10,2} =  ['$',num2str(std(WEATHER.tempcal(idx_valid)),'%0.1f'),'$'];
SHAT2{10,3} =  ['$',num2str(std(WEATHER.tempcal(idx_events)),'%0.1f'),'$'];
SHAT2{10,4} =  ['$',num2str(std(WEATHER.tempcal(idx_events2)),'%0.1f'),'$'];

%Observations
BHAT2{11,1} =  ['$',num2str(length(wind(idx_train)),'%0.0f'),'$'];
BHAT2{11,2} =  ['$',num2str(length(wind(idx_valid)),'%0.0f'),'$'];
BHAT2{11,3} =  ['$',num2str(length(wind(idx_events)),'%0.0f'),'$'];
BHAT2{11,4} =  ['$',num2str(length(wind(idx_events2)),'%0.0f'),'$'];
SHAT2{11,1} =  [' '];
SHAT2{11,2} =  [' '];
SHAT2{11,3} =  [' '];
SHAT2{11,4} =  [' '];

BHAT2
SHAT2

Labelx = {'Output (GWh)', 'Price (CAD)', 'Av. Capacity (GW)', 'Mean Bid TA (MW)', ...
    'Mean Bid RS (MW)','Output TA (MWh)','Wind TA (MWh)', 'Wind (MWh)','NG Price (CAD)','Temp Calgary (C)', 'Observations'};

TABLE2 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}l*{8}{c}}',...
    ' \toprule & \multicolumn{2}{c}{Training set} & \multicolumn{2}{c}{Testing set} & \multicolumn{2}{c}{Events} & \multicolumn{2}{c}{Add. Events}   \\',...
    ' & Mean & Std & Mean & Std & Mean & Std & Mean & Std      \\',...            
    '\hline ',...
    ];

TABLE2 = [TABLE2, ' \emph{Off-Peak} & & & & & & & & \\ '];
    
    for ii=[1 2 3 4 5 7 8 9 10 11]
        TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        BHAT2{ii,1},' & ',...
        SHAT2{ii,1},' & ',...
        BHAT2{ii,2},' & ',...
        SHAT2{ii,2},' & ',...
        BHAT2{ii,3},' & ',...
        SHAT2{ii,3},' & ',...
        BHAT2{ii,4},' & ',...
        SHAT2{ii,4},'  \\ '];
    end

    TABLE2 = [TABLE2,...
        ' \hline '];


load('Tempfiles/temp0_1.mat')

Demand = DISP+wind+nansum(IMP_obs,2)-nansum(EXP_obs,2);

clear BHAT2 SHAT2;

%Market demand (GWh)
BHAT2{1,1} =  ['$',num2str(mean(Demand(idx_train)/1000),'%0.2f'),'$'];
BHAT2{1,2} =  ['$',num2str(mean(Demand(idx_valid)/1000),'%0.2f'),'$'];
BHAT2{1,3} =  ['$',num2str(mean(Demand(idx_events)/1000),'%0.2f'),'$'];
BHAT2{1,4} =  ['$',num2str(mean(Demand(idx_events2)/1000),'%0.2f'),'$'];
SHAT2{1,1} =  ['$',num2str(std(Demand(idx_train)/1000),'%0.2f'),'$'];
SHAT2{1,2} =  ['$',num2str(std(Demand(idx_valid)/1000),'%0.2f'),'$'];
SHAT2{1,3} =  ['$',num2str(std(Demand(idx_events)/1000),'%0.2f'),'$'];
SHAT2{1,4} =  ['$',num2str(std(Demand(idx_events2)/1000),'%0.2f'),'$'];

%Price (CAD)
BHAT2{2,1} =  ['$',num2str(mean(PRICE(idx_train)),'%0.1f'),'$'];
BHAT2{2,2} =  ['$',num2str(mean(PRICE(idx_valid)),'%0.1f'),'$'];
BHAT2{2,3} =  ['$',num2str(mean(PRICE(idx_events)),'%0.1f'),'$'];
BHAT2{2,4} =  ['$',num2str(mean(PRICE(idx_events2)),'%0.1f'),'$'];
SHAT2{2,1} =  ['$',num2str(std(PRICE(idx_train)),'%0.1f'),'$'];
SHAT2{2,2} =  ['$',num2str(std(PRICE(idx_valid)),'%0.1f'),'$'];
SHAT2{2,3} =  ['$',num2str(std(PRICE(idx_events)),'%0.1f'),'$'];
SHAT2{2,4} =  ['$',num2str(std(PRICE(idx_events2)),'%0.1f'),'$'];

%Capacity (GW)
BHAT2{3,1} =  ['$',num2str(mean(K(idx_train)/1000),'%0.2f'),'$'];
BHAT2{3,2} =  ['$',num2str(mean(K(idx_valid)/1000),'%0.2f'),'$'];
BHAT2{3,3} =  ['$',num2str(mean(K(idx_events)/1000),'%0.2f'),'$'];
BHAT2{3,4} =  ['$',num2str(mean(K(idx_events2)/1000),'%0.2f'),'$'];
SHAT2{3,1} =  ['$',num2str(std(K(idx_train)/1000),'%0.2f'),'$'];
SHAT2{3,2} =  ['$',num2str(std(K(idx_valid)/1000),'%0.2f'),'$'];
SHAT2{3,3} =  ['$',num2str(std(K(idx_events)/1000),'%0.2f'),'$'];
SHAT2{3,4} =  ['$',num2str(std(K(idx_events2)/1000),'%0.2f'),'$'];

%Mean BID TA (MW)
BHAT2{4,1} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_train,:))) ,'%0.0f'),'$'];
BHAT2{4,2} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_valid,:))) ,'%0.0f'),'$'];
BHAT2{4,3} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_events,:))) ,'%0.0f'),'$'];
BHAT2{4,4} =  ['$',num2str( mean(mean(SUMSTATS(9).Yg(idx_events2,:))) ,'%0.0f'),'$'];
SHAT2{4,1} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_train,:),2)) ,'%0.0f'),'$'];
SHAT2{4,2} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_valid,:),2)),'%0.0f'),'$'];
SHAT2{4,3} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_events,:),2)) ,'%0.0f'),'$'];
SHAT2{4,4} =  ['$',num2str( std(mean(SUMSTATS(9).Yg(idx_events2,:),2)) ,'%0.0f'),'$'];

%Mean BID RS (MW)
BHAT2{5,1} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_train,:))) ,'%0.0f'),'$'];
BHAT2{5,2} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_valid,:))) ,'%0.0f'),'$'];
BHAT2{5,3} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_events,:))) ,'%0.0f'),'$'];
BHAT2{5,4} =  ['$',num2str( mean(mean(SUMSTATS(1).Yg(idx_events2,:))) ,'%0.0f'),'$'];
SHAT2{5,1} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_train,:),2)) ,'%0.0f'),'$'];
SHAT2{5,2} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_valid,:),2)) ,'%0.0f'),'$'];
SHAT2{5,3} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_events,:),2)) ,'%0.0f'),'$'];
SHAT2{5,4} =  ['$',num2str( std(mean(SUMSTATS(1).Yg(idx_events2,:),2)) ,'%0.0f'),'$'];

%Output TA (MWh)
BHAT2{6,1} =  ['$',num2str(mean(firm(5).DISP(idx_train)'),'%0.0f'),'$'];
BHAT2{6,2} =  ['$',num2str(mean(firm(5).DISP(idx_valid)'),'%0.0f'),'$'];
BHAT2{6,3} =  ['$',num2str(mean(firm(5).DISP(idx_events)'),'%0.0f'),'$'];
BHAT2{6,4} =  ['$',num2str(mean(firm(5).DISP(idx_events2)'),'%0.0f'),'$'];
SHAT2{6,1} =  ['$',num2str(std(firm(5).DISP(idx_train)'),'%0.0f'),'$'];
SHAT2{6,2} =  ['$',num2str(std(firm(5).DISP(idx_valid)'),'%0.0f'),'$'];
SHAT2{6,3} =  ['$',num2str(std(firm(5).DISP(idx_events)'),'%0.0f'),'$'];
SHAT2{6,4} =  ['$',num2str(std(firm(5).DISP(idx_events2)'),'%0.0f'),'$'];

%Wind TA (MWh)
BHAT2{7,1} =  ['$',num2str(mean(wind_TA(idx_train)),'%0.0f'),'$'];
BHAT2{7,2} =  ['$',num2str(mean(wind_TA(idx_valid)),'%0.0f'),'$'];
BHAT2{7,3} =  ['$',num2str(mean(wind_TA(idx_events)),'%0.0f'),'$'];
BHAT2{7,4} =  ['$',num2str(mean(wind_TA(idx_events2)),'%0.0f'),'$'];
SHAT2{7,1} =  ['$',num2str(std(wind_TA(idx_train)),'%0.0f'),'$'];
SHAT2{7,2} =  ['$',num2str(std(wind_TA(idx_valid)),'%0.0f'),'$'];
SHAT2{7,3} =  ['$',num2str(std(wind_TA(idx_events)),'%0.0f'),'$'];
SHAT2{7,4} =  ['$',num2str(std(wind_TA(idx_events2)),'%0.0f'),'$'];

%Wind Total (MWh)
BHAT2{8,1} =  ['$',num2str(mean(wind(idx_train)),'%0.0f'),'$'];
BHAT2{8,2} =  ['$',num2str(mean(wind(idx_valid)),'%0.0f'),'$'];
BHAT2{8,3} =  ['$',num2str(mean(wind(idx_events)),'%0.0f'),'$'];
BHAT2{8,4} =  ['$',num2str(mean(wind(idx_events2)),'%0.0f'),'$'];
SHAT2{8,1} =  ['$',num2str(std(wind(idx_train)),'%0.0f'),'$'];
SHAT2{8,2} =  ['$',num2str(std(wind(idx_valid)),'%0.0f'),'$'];
SHAT2{8,3} =  ['$',num2str(std(wind(idx_events)),'%0.0f'),'$'];
SHAT2{8,4} =  ['$',num2str(std(wind(idx_events2)),'%0.0f'),'$'];

%NG Price
BHAT2{9,1} =  ['$',num2str(mean(NGPRICE(idx_train)),'%0.1f'),'$'];
BHAT2{9,2} =  ['$',num2str(mean(NGPRICE(idx_valid)),'%0.1f'),'$'];
BHAT2{9,3} =  ['$',num2str(mean(NGPRICE(idx_events)),'%0.1f'),'$'];
BHAT2{9,4} =  ['$',num2str(mean(NGPRICE(idx_events2)),'%0.1f'),'$'];
SHAT2{9,1} =  ['$',num2str(std(NGPRICE(idx_train)),'%0.1f'),'$'];
SHAT2{9,2} =  ['$',num2str(std(NGPRICE(idx_valid)),'%0.1f'),'$'];
SHAT2{9,3} =  ['$',num2str(std(NGPRICE(idx_events)),'%0.1f'),'$'];
SHAT2{9,4} =  ['$',num2str(std(NGPRICE(idx_events2)),'%0.1f'),'$'];

%Temperature Calgary
BHAT2{10,1} =  ['$',num2str(mean(WEATHER.tempcal(idx_train)),'%0.1f'),'$'];
BHAT2{10,2} =  ['$',num2str(mean(WEATHER.tempcal(idx_valid)),'%0.1f'),'$'];
BHAT2{10,3} =  ['$',num2str(mean(WEATHER.tempcal(idx_events)),'%0.1f'),'$'];
BHAT2{10,4} =  ['$',num2str(mean(WEATHER.tempcal(idx_events2)),'%0.1f'),'$'];
SHAT2{10,1} =  ['$',num2str(std(WEATHER.tempcal(idx_train)),'%0.1f'),'$'];
SHAT2{10,2} =  ['$',num2str(std(WEATHER.tempcal(idx_valid)),'%0.1f'),'$'];
SHAT2{10,3} =  ['$',num2str(std(WEATHER.tempcal(idx_events)),'%0.1f'),'$'];
SHAT2{10,4} =  ['$',num2str(std(WEATHER.tempcal(idx_events2)),'%0.1f'),'$'];

%Observations
BHAT2{11,1} =  ['$',num2str(length(wind(idx_train)),'%0.0f'),'$'];
BHAT2{11,2} =  ['$',num2str(length(wind(idx_valid)),'%0.0f'),'$'];
BHAT2{11,3} =  ['$',num2str(length(wind(idx_events)),'%0.0f'),'$'];
BHAT2{11,4} =  ['$',num2str(length(wind(idx_events2)),'%0.0f'),'$'];
SHAT2{11,1} =  [' '];
SHAT2{11,2} =  [' '];
SHAT2{11,3} =  [' '];
SHAT2{11,4} =  [' '];
    
TABLE2 = [TABLE2, ' \emph{Peak} & & & & & & & & \\ '];
for ii=[1 2 3 4 5 7 8 9 10 11]
        TABLE2 = [TABLE2,...
        Labelx{ii},' & ',...
        BHAT2{ii,1},' & ',...
        SHAT2{ii,1},' & ',...
        BHAT2{ii,2},' & ',...
        SHAT2{ii,2},' & ',...
        BHAT2{ii,3},' & ',...
        SHAT2{ii,3},' & ',...
        BHAT2{ii,4},' & ',...
        SHAT2{ii,4},'  \\ '];
    end

    
TABLE2 = [TABLE2,' \bottomrule ' ...
    '\end{tabular*}'];

fileID = fopen([tablepath,'/table_3.tex'],'w'); %DESCR1
fprintf(fileID,'%s',TABLE2);
fclose(fileID);

BHAT2
SHAT2
%% Description of Weather variables
clear TABLE0

 Xw_varnames' %194 weather vars from Weather stations

idxtemp = find(contains( Xw_varnames,'Temp')) %52 temp
idxhum = find(contains( Xw_varnames,'Hum')) %46
idxws = find(contains( Xw_varnames,'Windspeed')) %33
idxwa = find(contains( Xw_varnames,'Windangle')) %17
idxdew = find(contains( Xw_varnames,'DewPoint')) %46

clear list
for ii=1:length(Xw_varnames)
list{ii} = Xw_varnames{ii}(end-6:end);
end
unique(list) %53 weather stations.

[a,b] = intersect(INFOS_WEATHER.IDclim,unique(list));

listname = sort(INFOS_WEATHER.Station(b));

TABLE0 = ' ';
for ii=1:length(b)
[a,~] = find(contains( INFOS_WEATHER.Station(b),listname(ii)));


id = intersect(find(contains( Xw_varnames,'Temp')),find(contains( Xw_varnames,INFOS_WEATHER.IDclim(b(a)))));
id2 = intersect(find(contains( Xw_varnames,'Dew')),find(contains( Xw_varnames,INFOS_WEATHER.IDclim(b(a)))));
id3 = intersect(find(contains( Xw_varnames,'Hum')),find(contains( Xw_varnames,INFOS_WEATHER.IDclim(b(a)))));
id4 = intersect(find(contains( Xw_varnames,'Windangle')),find(contains( Xw_varnames,INFOS_WEATHER.IDclim(b(a)))));
id5 = intersect(find(contains( Xw_varnames,'Winds')),find(contains( Xw_varnames,INFOS_WEATHER.IDclim(b(a)))));

if ii==9
id = id(1);
id2 = id2(1);
id3 = id3(1);
id4 = id4(1);
id5 = id5(1);
end

TABLE0 = [TABLE0,listname{ii}(1:min(length(listname{ii}),19)),' & ',num2str(INFOS_WEATHER.Lon(b(a(1)))),' & ',num2str(INFOS_WEATHER.Lat(b(a(1)))),...
    ' & ',num2str(mean(Xw(:,id)),'%0.1f'),' & ',num2str(mean(Xw(:,id2)),'%0.1f'),' & ',num2str(mean(Xw(:,id3)),'%0.1f'),...
    ' & ',num2str(mean(Xw(:,id4)),'%0.1f'),' & ',num2str(mean(Xw(:,id5)),'%0.1f'), ' \\ '];
end

TABLE0

fileID = fopen([tablepath,'/table_B1.tex'],'w'); %DESCR2
fprintf(fileID,'%s',TABLE0);
fclose(fileID);