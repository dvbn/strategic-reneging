function [x,ifault] = imhofint0(arg, lambda, bound, eps3)
%
% {Algorithm AS 256.2  Appl. Statist. (1990) Vol.39, No.2}
%
% {Pascal translation of Koerts and Abrahamse's procedure
%  for evaluating Imhof's integral by Simpson's Rule}

noterms=size(lambda,1);
maxit=14;

if (bound <= 0.0) | (eps3 <= 0.0)
   ifault = 2;
   x = -2.0;
else
   ifault = 5;
   n = 2;
   step = 0.5*bound;
   eps4 = 3.0*pi*eps3;
   sum1 = -arg;
   for i = 1:noterms
      sum1 = sum1+lambda(i);
   end
   sum1 = 0.5*sum1+imhoffn0(bound,lambda,arg);
   sum2 = 0.0;
   sum4 = imhoffn0(step,lambda,arg);
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
         sum4 = sum4+imhoffn0(j*step,lambda,arg);
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
