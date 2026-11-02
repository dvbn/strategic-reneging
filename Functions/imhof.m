function [x,ifault] = imhof(lambda,mult,delta,noterms,arg,bound,eps1,eps2,eps3,iter)
%
% {Algorithm AS 256.3  Appl. Statist. (1990) Vol.39, No.2}
%
% {Pascal translation of Koerts and Abrahamse's implementation of
%  Imhof's procedure for evaluating the probability that a diagonal
%  quadratic form in normal variables is less than a given value, arg}

% lambda contains diagonal elements of diagonal matrix in quadratic form
% mult contains multiplicities of diagonal elements
% delta contains means of standard normals (for non-central cases)
% noterms contains dimension of lambda, delta


%{check parameters}
if (noterms < 1) | (eps1 <= 0.0) | (eps2 <= 0.0) | (eps3 <= 0.0)
   ifault = 2;
   x = -2.0;
else
   ifault = 1;
   i = 0;  % correction? (in Farebrother it is initialized at i=1)
   while ifault==1
      i = i+1;
      if i==noterms
         ifault = 0;
      end
      if (mult(i) < 1) | (delta(i) < 0.0)
         ifault = 3;
         x = -i;
      end
   end

%  {main body}
   if ifault==0
      if bound <= 0.0  % one may choose the bound rather than use:
         [bound,ifault] = imhofbd(lambda,mult,delta,noterms,eps1,eps2);
      end
      if ifault==0
         [x,ifault] = imhofint(lambda,mult,delta,noterms,arg,bound,eps3,iter);
      else
         x = -ifault;
      end
   end
end

return
