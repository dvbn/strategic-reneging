function [p,ifault] = imhof0(x,A)
% function p = imhof0(x,A) computes the cdf for a 
% quadratic form in a vector of independent and identically 
% distributed standard normal random variables and a matrix  A,
% z'Az  where  z~N(0,I)

% this is a specialization of the imhof.m, which is a translation
% of pascal code in 
%
% {Algorithm AS 256.3  Appl. Statist. (1990) Vol.39, No.2}

% par: last revision 5/21/98

eps1 = 1e-4;
eps2 = 1e-4;
eps3 = 1e-4;

B = 0.5*(A+A');                   % "symmetrize" A (necessary?)
S = eig(B);                       % eigenvalues of B

[bound,ifault] = imhofbd0(S,eps1,eps2);
if ifault==0
   [p,ifault] = imhofint0(x,S,bound,eps3);
else
   p = -ifault;
end

return