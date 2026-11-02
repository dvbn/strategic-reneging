function [bd,ifault] = imhofbd(lambda,mult,delta,noterms,eps1,eps2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Original method developed by Imhof (1961) programmed in FORTRAN by 
% Koerts and Abrahamse (1969), then translated and adapted by Farebrother
% (1990) in PASCAL. This is a matlab version.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Farebrother's (1990) original header
% {Algorithm AS 256.1  Appl. Statist. (1990) Vol.39, No.2}
% {Pascal translation of Koerts and Abrahamse's procedure
%   for evaluating Imhof's upper bound}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Original matlab translation:  par 5/20/98 (unknown author)
% This version: David Benatia - Economics Department - University of 
% Montreal - June, 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description (taken from Farebrother (1990):
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

ifault=0;
if (noterms<1) | (eps1 <=0) | (eps2<=0)
   ifault  =  2;
   bd = -2;
else
   count = 0;
   sum1  = 0;
   sum2  = 0;
   for i = 1:noterms
      hold = abs(lambda(i));
      if hold > eps2
         count = count+mult(i);
         sum1 = sum1+mult(i)*log(hold);
      end
      sum2 = sum2+delta(i);
   end
   if count < 0.9
      ifault = 4;
      bd = -4.0;
   else
      count = 0.5*count;
      sum1 = 0.5*sum1+log(pi*count);
      range = exp(-(sum1+0.5*sum2+log(eps1))/count);
      if sum2==0.0
         range = range+5.0/count;
      else
         while count~=0.0;
            sum2 = 0.0;
            for i = 1:noterms
               hold = (range*lambda(i))*(range*lambda(i));
               sum2 = sum2+delta(i)*hold/(1.0+hold);
            end
            hold = exp(sum1+count*log(range)+0.5*sum2);
            if hold*eps1 <= 1.0
               range = range+5.0/count;
            else
               count = 0.0;
            end
         end
      end
   end
   bd = range;
end

return
