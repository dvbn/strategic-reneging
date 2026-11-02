function [x,ifault] = imhofint(lambda, mult, delta, noterms, arg, bound, eps3,iter)
%
% {Algorithm AS 256.2  Appl. Statist. (1990) Vol.39, No.2}
%
% {Pascal translation of Koerts and Abrahamse's procedure
%  for evaluating Imhof's integral by Simpson's Rule}

maxit=iter; %used to be set at 14 (March 30 2017, David)

if (noterms < 1) | (bound <= 0.0) | (eps3 <= 0.0)
   ifault = 2;
   x = -2.0;
else
   ifault = 5;
   n = 2;
   step = 0.5*bound;
   eps4 = 3.0*pi*eps3;
   sum1 = -arg;
   for i = 1:noterms
      sum1 = sum1+lambda(i)*(mult(i)+delta(i));
   end
   sum1 = 0.5*sum1+imhoffn(bound,lambda,mult,delta,noterms,arg,bound,eps3);
   sum2 = 0.0;
   sum4 = imhoffn(step,lambda,mult,delta,noterms,arg,bound,eps3);
   int2 = (sum1+4.0*sum4)*step;
   i = 0;
	cgd = logical(0);
   while (i~=maxit) & ~cgd
      i = i+1;
      n = n+n;
      step = 0.5*step;
      int1 = int2;
      sum2 = sum2+sum4;
      int2 = sum1+sum2+sum2;
      sum4 = 0.0;
      j = 1;
      while j <= n
         sum4 = sum4+imhoffn(j*step,lambda,mult,delta,noterms,arg,bound,eps3);
         j = j+2;
      end
      int2 = (int2+4.0*sum4)*step;
      if i > 3
         if abs(int1-int2) < eps4
            if abs(int2) > 1.5*pi
               ifault = 6;
            else
               ifault = 0;
            end
            cgd = logical(1);
         end
      end
   end
   x = 0.5-int2/(3.0*pi);
end

return
