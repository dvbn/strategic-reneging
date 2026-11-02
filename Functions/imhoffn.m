function x = imhoffn(u, lambda, mult, delta, noterms, arg, bound, eps3)
%
%   {imhoffn evaluates Imhof's integrand}
%

rho   = 0.0;
sum   = 0.0;
theta = -u*arg;
for i = 1:noterms
   hold  = u*lambda(i);
   hold2 = hold*hold;
   hold3 = 1.0+hold2;
   theta = theta+mult(i)*atan(hold)+delta(i)*hold/hold3;
   sum   = sum+delta(i)*hold2/hold3;
   rho   = rho+mult(i)*log(hold3);
end
x = sin(0.5*theta)/(u*exp(0.5*sum+0.25*rho));

return
