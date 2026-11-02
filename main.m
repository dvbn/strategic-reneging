% Application - Strategic reneging
% July 2023
% David Benatia

% README_datasets.txt for a description of datafiles.

close all
clear
clc

cd(fileparts(mfilename('fullpath')))
addpath("Functions/")
addpath("Data/")
mkdir("Figures/")
mkdir("Tables/")
mkdir("Tempfiles/")
tablepath = 'Tables';
figurepath = 'Figures';

%% Preliminary analysis
%Produce long versions of Table 4 & Table 5, and additional regression results not reported
%in the paper
run('part1.m')

%% Estimation
% Estimate prediction models for RS, S and S_PPA.
% Produce temporary results files.
% Remark: glmnet is sometimes difficult to install for some users. A known issue
%appears to be with the fortran library. Here's a way to solve it for mac
%users.
%https://stackoverflow.com/questions/57207357/dyld-library-not-loaded-usr-local-gfortran-lib-libgfortran-3-dylib-reason-im
%dvbn$ sudo ln /Applications/MATLAB_R2022b.app/sys/os/maci64/libgfortran.3.dylib /usr/local/lib/libgfortran.3.dylib

for prefix = 0 %use several (e.g. 0:10) to train the models on multiple data splits, reported results use only a single split to reduce cpu time
run('estimation.m')
end

%% Collect main results
% Calculate counterfactual prices, quantities, profits, welfare, strategies
% Produce temporary results files.

for prefix = 0
run('results_collect.m')
end
    
%% Bootstrap inference
% Draw S, RD and PPA plant bids from joint distribution to evaluate
% uncertainty of predicted counterfactual outcomes (parametric bootstrap)
% Note: this part of the program takes a while to run.
clear
clc
constrained_d = 1; % ex-post constraints for predictions (monotonicity)
prefix = 0;

load(['Tempfiles/temp',num2str(prefix),'.mat'])
n = length(DATE);
ndraws = 5000;

%init
DISP_draws = zeros(n,ndraws);
PRICE_draws = zeros(n,ndraws);
DISP_draws2 = zeros(n,ndraws);
PRICE_draws2 = zeros(n,ndraws);
DISP_draws3 = zeros(n,ndraws);
PRICE_draws3 = zeros(n,ndraws);
DISP_draws4 = zeros(n,ndraws);
PRICE_draws4 = zeros(n,ndraws);
DISP_draws5 = zeros(n,ndraws);
PRICE_draws5 = zeros(n,ndraws);
DISP_draws6 = zeros(n,ndraws);
PRICE_draws6 = zeros(n,ndraws);
PROFIT_hhc_draws = zeros(n,ndraws);
PROFIT_hh_draws = zeros(n,ndraws);
PROFIT_hh2_draws = zeros(n,ndraws);
TCOST_hhc_draws = zeros(n,ndraws);
TCOST_hh_draws = zeros(n,ndraws);
TCOST_hh2_draws = zeros(n,ndraws);
mQ_draws = zeros(n,ndraws);
mRD_draws = zeros(n,ndraws);

for peak_d = 0:1
    load(['Tempfiles/temp',num2str(prefix),'_',num2str(peak_d),'.mat'])
    rng(100) %reproducibility
    run('application_bs.m') %re-do the core analysis (S and RS) on bootstrap samples

    save(['Tempfiles/temp',num2str(prefix),'_CASE_',num2str(peak_d),'.mat'], 'CASE', '-v7.3')
    save(['Tempfiles/temp',num2str(prefix),'_CVM_',num2str(peak_d),'.mat'], 'CVM', '-v7.3')

    table(CVM(1).mQ(idx_valid)',CVM(1).bpvalQ(idx_valid)',CVM(1).ipvalQ(idx_valid)')
    table(DATE(idx_events),CVM(1).mQ(idx_events)',CVM(1).bpvalQ(idx_events)',CVM(1).ipvalQ(idx_events)')

    table(CVM(1).mRD(idx_valid)',CVM(1).bpvalRD(idx_valid)',CVM(1).ipvalRD(idx_valid)')
    table(DATE(idx_events),CVM(1).mRD(idx_events)',CVM(1).bpvalRD(idx_events)',CVM(1).ipvalRD(idx_events)')
    table(DATE(idx_events2),CVM(1).mRD(idx_events2)',CVM(1).bpvalRD(idx_events2)',CVM(1).ipvalRD(idx_events2)')

    clear CVM CASE
    save(['Tempfiles/temp',num2str(prefix),'_',num2str(peak_d),'_bs.mat'], '-v7.3')

    clear stat0 stat0_ stat_grid
end

%% Figure & Tables
% Produce long versions of remaining tables & figures
tablepath = 'Tables';
figurepath = 'Figures';
run('results.m')

%% Delete temp files
%rmdir("Tempfiles/")
