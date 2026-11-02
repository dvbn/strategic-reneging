function x = imhoffn0(u, lambda, arg)
%
%   {imhoffn0 evaluates Imhof's integrand}
%

noterms=size(lambda,1);

rho   = 0.0;
theta = -u*arg;
for i = 1:noterms
   hold  = u*lambda(i);
   hold2 = hold*hold;
   hold3 = 1.0+hold2;
   theta = theta+atan(hold);
   rho   = rho+log(hold3);
end
x = sin(0.5*theta)/(u*exp(0.25*rho));

return
