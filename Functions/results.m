%% Profit and Welfare: Figures & Tables
% Profit and Welfare (Table 8 & Table 9)

for prefix_i = 0
    
load(['Tempfiles/temp',num2str(0),'_1_bs.mat'])  
prefix = prefix_i;
load(['Tempfiles/temp',num2str(prefix),'.mat'])

events_d1 = events_d*0;
events_d1(find(DATE>=datetime(2010,11,19,17,0,0) & DATE<=datetime(2010,11,19,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2010,11,23,10,0,0) & DATE<=datetime(2010,11,23,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2010,12,13,17,0,0) & DATE<=datetime(2010,12,13,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2011,2,16,17,0,0) & DATE<=datetime(2011,2,16,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2010,11,24,14,0,0) & DATE<=datetime(2010,11,24,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2010,11,26,16,0,0) & DATE<=datetime(2010,11,26,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2010,11,30,15,0,0) & DATE<=datetime(2010,11,30,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2011,1,15,10,0,0) & DATE<=datetime(2011,1,15,21,0,0))) = 1; 
events_d1(find(DATE>=datetime(2011,1,21,14,0,0) & DATE<=datetime(2011,1,21,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2011,4,12,14,0,0) & DATE<=datetime(2011,4,12,21,0,0))) = 1;
events_d1(find(DATE>=datetime(2011,8,12,17,0,0) & DATE<=datetime(2011,8,12,21,0,0))) = 1;

run('results_tables.m')
%produce figures_pricesimpacts, quantityimpacts, SRDimpacts
%tables /table_PROFIT, WELFARE 
end

% %% One way to look at results across data splits (if several prefix)
% WW = zeros(6,9);
% for p=1:13
% WW = WW + results_struct(p).WELFARE/13;
% end
% 
% PP = zeros(6,9);
% for p=1:13
% PP = PP + results_struct(p).PROFIT/13;
% end
% 
% PP
% WW
% 
% %%
% WW = [0;0];
% for p=1:13
% WW = [max(WW(1),results_struct(p).WELFARE(1,9));max(WW(2),results_struct(p).WELFARE(4,9))];
% end
% WW
% WW = [1e99;1e99];
% for p=1:13
% WW = [min(WW(1),results_struct(p).WELFARE(1,9));min(WW(2),results_struct(p).WELFARE(4,9))];
% end
% WW
% 
% WW = [0;0];
% for p=1:13
% WW = [max(WW(1),results_struct(p).PROFIT(1,9));max(WW(2),results_struct(p).PROFIT(4,9))];
% end
% WW
% WW = [1e99;1e99];
% for p=1:13
% WW = [min(WW(1),results_struct(p).PROFIT(1,9));min(WW(2),results_struct(p).PROFIT(4,9))];
% end
% WW
% 
% WW =
% 
%   117.0800
%   599.0183
% 
% 
% WW =
% 
%   115.4852
%   595.6419
% 
% 
% WW =
% 
%    13.5267
%    67.0587
% 
% 
% WW =
% 
%    13.3523
%    66.7093


%% Table 6 & Table B2: Inference stats & tables 
clear -except tablepath figurepath
clc
prefix = 0;
run('inferencestats_tables.m')

%% Table 7 : RD  elasticity, price impacts and strategy shifts
run('results_POSTREG.m') 

%% Figures 1 & 2
run('generate_EPSfigures.m') 

%% Table B3: Prediction PPA table
run('predPPA_table.m')

%Check
%1/6.07 * 20.87 + 1/1.79 * 21.71 + 1/1.94 * 89.18 + 1/1.37 * 180.26 + 1/7.12*35.94 + 1/0.39 * 38.52 + 1/0.33 * 17.12 + 1/3.58 * 91.59 + 1/0.75 * 131.35
%idx = find(DATE>=datetime(2010,11,1) & DATE<=datetime(2011,9,1));
%sum(PRICE(idx).*DISP(idx))
%630/(3.8849e+03 - 630) = 19.4% nearly 20%

%% Tables 3 & B1
run('descriptive_tables.m')