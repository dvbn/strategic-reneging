function [J] = CVMtest2(bhat,b0,n,SIGMA,T,level,options)
% Test H0: Y = X, where X and Y are functional objects using the
% Cramer-Von Mises statistic J = || n^(-1/2) \sum_i (Yi-Xi) ||^2
% Last update: March 31 2017
% Author: David Benatia
% Affiliation: Université de Montréal

% Estimation of eigenvalues (and eigenfunctions?)
%[V,D] = eig((n*(T(2)-T(1)))*SIGMA);
%[V,D] = eig(SIGMA);
%rescale = 1.0; %1.1
%L = ((n-2)/(length(T)-15))*diag(D);
%L = ((n)/(length(T)))*diag(D); %

% Cramer Von-Mises statistic
%J = trapz(T,(n^(1/2)*(bhat-b0)).^2); %n^(1/2)*

J = trapz(T,n^(1/2)*(bhat-b0).^2); %
%J = trapz2(T,n^(1/2)*(bhat-b0).^2); %faster but less precise in some instances


% 
% % Imhof p-value
% eps = options.eps;
% iter = options.iter;
% k = sum(L>eps); %truncate eigenvalues smaller than some given threshold
% weightvec = sort(L,'descend'); %sort eigenvalues
% weight = diag(weightvec(1:k)); % truncated diagonalized
% [temp,ifault] = imhofprob(zeros(k,1),eye(k),weight,J,eps,iter,0);
% pvalue=1-temp; %calculated p-value: >0.05 => no evidence against the null
% reject = pvalue<=level;