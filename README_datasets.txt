%% Description of the three datasets (mat-files)
% Aggregation of several public datasets from AESO and Environment Canada
% See Benatia & de Villemeur (2023)

%%%%% DATASET 1: data.mat %%%%%
% Main dataset

%Time variables
DATE %timestamp (datetime)
DAY %day of the month
MONTH %month of the year
WDAY %day of the week
WEEK %week of the year

% Bids
firm (structure)
p_grid % fine price grid 
P_grid % coarse price grid
q_grid % quantity grid

% firm(id) contains data for the fringe (1), ATCO (2), CP (3), ENMAX(4), TransAlta (5), TransCanada (6)
firm(id).asset %(actual) asset-level offers, 
.asset_cap % asset available capacities, 
.asset_id % asset identification code
.DISP %firm-level production
.DISP_asset %asset-level production
.DISP_PPA %firm-level PPA production
.k %firm-level available capacity
.k_asset %asset-level available capacity
.k_asset_c %asset-level counterfactual available capacity
.k_PPA %PPA capacity
.list_asset %list of asset id controlled by the firm
.id %id of the firm
.obs %firm-level actual bids (price-quantity pairs)
.p %bid as a function of q_grid (not used)
.p_c %counterfactual bid as a function of q_grid (not used)
.rd %residual demand function defined over q_grid (not used)
.rd_c %counterfactual residual demand function defined over q_grid (not used)
.q %quantity bid as a function of price grid (P_grid), for example: run plot(firm(1).q(1,:),P_grid) to display bid function at date firm(1).date(1), this applies to the following objects
.q_c %counterfactual quantity bid function defined over P_grid
.rdq %residual demand function defined over P_grid
.rdq_c %counterfactual residual demand function defined over P_grid
.drdq %derivative of the RD defined over P_grid (not used)
.drdq_c %counterfactual (not used)

% Production & capacity variables
DISP %domestic production determined by the market 
Demand %measured load of the system 
K %available capacity (total)
K_c %counterfactual available capacity (total)

% Firm-level production (disp) & generator-level production (gen) 
% In practice one should instead use the measures from the structure "firm" which includes bids.
ATCO_disp, ATCO_gen, CP_disp, CP_gen, ENMAX_disp, ENMAX_gen, FRINGE_disp, FRINGE_gen, TA_disp, TA_gen, TC_disp, TC_gen

% Import & Export: capacity by interco, observed exports and imports.
Exp_cap, Exp_cap_BC, Exp_cap_SK, EXP_obs
Imp_cap, Imp_cap_BC, Imp_cap_SK, IMP_obs

% Price variables
PRICE %actual price (hourly smp)
PRICE_DA %day-ahead price
NGPRICE %natural gas price

% Available capacity of PPA plants
 SD1_cap, SD2_cap, SD3_cap, SD4_cap, SD5_cap, SD6_cap, KH1_cap, KH2_cap, BR5_cap
 
% Derated capacity of PPA plants, and counterfactual derates
DERATE_BRKH, DERATE_BRKH_c, DERATE_BRKH_rel, DERATE_SD, DERATE_SD_c, DERATE_SD_rel, 

% Outage measures of PPA plants and others
OUTAGE_BRKH, OUTAGE_SD, OUTAGES,   

% Wind variables
wind %windE+WIND_F+wind_S+wind_TA
wind_d %((max(wind)-wind)./max(wind)>=0.95);
wind_ENMAX, wind_F, wind_SUNCOR, wind_TA, %firm-level wind output
wind_TA2 %asset-level wind output for TransAlta

% Variables used to keep track of reneging events
event, events_d, idx_event1, idx_event10, idx_event10_1, idx_event10_2, idx_event10_3, idx_event10_4, idx_event10_5, idx_event10_6, idx_event10_7, idx_event11, idx_event11_1, idx_event11_2, idx_event11_3, idx_event11_4, idx_event11_5, idx_event11_6, idx_event11_7, idx_event11_8, idx_event1_1, idx_event1_2, idx_event1_3, idx_event2, idx_event2_1, idx_event3, idx_event3_1, idx_event3_2, idx_event3_3, idx_event3_4, idx_event4, idx_event4_1, idx_event4_2, idx_event4_3, idx_event5, idx_event5_1, idx_event5_2, idx_event6, idx_event6_1, idx_event6_2, idx_event6_3, idx_event6_4, idx_event7, idx_event7_1, idx_event7_2, idx_event7_3, idx_event7_4, idx_event8, idx_event8_1, idx_event8_2, idx_event8_3, idx_event8_4, idx_event9, idx_event9_1, idx_event9_2, idx_event9_3, idx_event9_4, idx_event9_5, idx_events, idx_events2, idx_events3

% Weather variables
WEATHER (Table with many variables)
INFOS_WEATHER (infos about these variables)


%%%%% DATASET 2: OUTAGES_PPA.mat %%%%%
% Dataset with additional information about outages at PPA plants
% The table includes start/end dates, max and mean prices, and the derated capacity by plant

%%%%% DATASET 3: WINDTABLE.mat %%%%%
DUMS % time dummies
events_d, idx_events, idx_events2 %keep track of reneging events 
idx_WINDEN, idx_WINDO, idx_WINDSU, idx_WINDTA %column id of wind gen of each firm 
WINDTABLE %table with wind gen-level output and weather vars