function [PRICE,QUANTITY] = QPEQ(RD,S,P_grid,p_grid)

interprd = interp1(P_grid,RD,p_grid,'linear');

interpq = interp1(P_grid,S,p_grid,'linear');

[~,b] = min(abs(interpq-interprd));
QUANTITY = interpq(b);
PRICE = p_grid(max(find(interprd(b)==interprd)));


