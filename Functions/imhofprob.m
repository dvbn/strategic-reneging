function [pr,ifault]=imhofprob(mu0,A,P,c,eps2,iter,verbose)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function evaluates numerically the probability that
% x'Px < c where x is N(mu,A) using Imhof's (1961) procedure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This version: David Benatia - Economics Department - University of 
% Montreal - June, 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Original method developed by Imhof (1961) programmed in FORTRAN by 
% Koerts and Abrahamse (1969), then translated and adapted by Farebrother
% (1990) in PASCAL. This is a MATLAB version translated by an unknown
% author (par: last revision 5/21/98; edit: I suspect Paul Ruud is the author).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Farebrother's (1990) original header:
% {Algorithm AS 256.1  Appl. Statist. (1990) Vol.39, No.2}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Details:
% - imhofprob evaluates Pr(x'Px < c), where x ~ N(mu,A)
%
% Description (taken from Farebrother (1990):
% - imhof evaluates the probability that a diagonal form in normal
% variables is less than a given value, denoted arg
% - imhofbd calculates a suitable replacement for the infinite upper limit
% of integration of F(x). It is used to trap small values of |\lambda_j|
% - imhofint evaluates the resulting expression by Simpson's rule
% - imhoftep is a variant of imhof for tridiagional form in normal
% variables
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Notes:
% - lambda contains diagonal elements of diagonal matrix in quadratic form
% - mult contains multiplicities of diagonal elements
% - delta contains means of standard normals (for non-central cases)
% - noterms contains dimension of lambda, delta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% David's Comments: we have x'Px where x~N(mu0,A)
RA=chol(A)'; % we use cholesky decomposition to get v~N(mu,In) as in 
% Farebrother (90)
mu=inv(RA)*mu0; %corrected mean vector mu
Q=RA'*P*RA; %Q in v'Qv where v~N(mu,In) equivalent to x'Px
[fil,~]=size(Q); 
[H,D]=eig(Q); %Diagonalization of Q, denoted D  (G in Farebrother (90)), H
% is the orthonormal matrix which converts Q to diagonal form D=H'QH

%Some checks - H must be orthonormal (see Farebrother (90))(david)
check=(H*H')-eye(fil);
check=max(max(check));
if check>1e-4
    Qprev=Q;
    Q=round(1e6*Q)/1e6;
    [H,D]=eig(Q);
    check1=max(max(abs(Q-Qprev)));
    check2=(H*H')-eye(fil);
    check2=max(max(abs(check2)));
    check=max(check1,check2);
    if check>1e-4
    disp('Warning:H may not be orthogonal')
    disp('H')
    disp(H)
    end
end

v=H'*mu; % now we have z'Dz where z~N(H'*mu,In) and D diagonal
lambda=diag(D); % coefs in expression (7) in Farebrother (90)
mult=ones(fil,1); % multiplicities of coefs in (7)
delta=v.^2; % non-centralities v1^2,...,vn^2 in (7) - squared mean of r.v.
noterms=fil; % dimension of T in (2) and number of terms in (7)
arg=c; %x in (7)
eps1=1e-4; % desired max truncation error in (9)
%eps2=1e-3; % if |\lambda_i| <eps2 - omitted from imhofbd (truncation)
eps3=1e-4; % desired approx accuracy of imhofint (integral)
bound=-10; %upper limit of integration used in imhofint (set to 0 or <0 
%for evaluation with imhofbd)
[pr,ifault] = imhof(lambda,mult,delta,noterms,arg,bound,eps1,eps2,eps3,iter);
if verbose==1
    if ifault~=0
        display(['Problem in Imhof procedure - ifault==',num2str(ifault)])
        if ifault == 1
            display('tql3 was not able to converge in maxqlit iterations')
        end
        if ifault== 2
            display('one or more of the constraints noterms> 0, nc > 0, bound > 0, epsO > 0, epsl > 0, eps2 > 0 and eps3 > 0 is not satisfied; the constraint bound > 0 is checked by imhofint and sneekin only.')
        end
        if ifault == 3
            display('one or more of the constraints mult[j] > 1 and delta[j] > 0 is not satisfied; the offending value of j is indicated by the value of imhof; this check should also be inserted in imhofbd and imhofint if they are to be used independently')
        end
        if ifault == 4
            display('all values of Xj satisfy | Xj | < eps2 in imhofbd')
        end
        if ifault == 5
            display('imhofint or sneekint was not able to converge in maxit iterations')
        end
        if ifault == 6
            display('the value of F(x) found by imhofint or sneekint does not satisfy 0.0 < F(x) S 1.0;')
        end
        if ifault == 7
            display('one or more values of Xj satisfy |j | < eps2 in sneekbd')
        end
    end
end