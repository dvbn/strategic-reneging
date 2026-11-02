function [bd,ifault] = imhofbd0(lambda,eps1,eps2)
% lambda contains diagonal elements of diagonal matrix in quadratic form

% this is a streamlined version of imhofbd.m for cases where 
%     all the multiplicities of the diagonal elements equal one
%     the means of normals are all zero

ifault=0;
noterms=size(lambda,1);
if (eps1 <=0) | (eps2<=0)
   ifault  =  2;
   bd = -2;
else
   count = 0;
   sum1  = 0;
   sum2  = 0;
   for i = 1:noterms
      hold = abs(lambda(i));
      if hold > eps2
         count = count+1;
         sum1 = sum1+log(hold);
      end
   end
   if count < 0.9
      ifault = 4;
      bd = -4.0;
   else
      count = 0.5*count;
      sum1 = 0.5*sum1+log(pi*count);
      range = exp(-(sum1+log(eps1))/count);
      range = range+5.0/count;
   end
   bd = range;
end

return
