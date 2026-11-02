function [Qtemp] = mon_smooth_f2(Qtemp)

Qtemp = -Qtemp;
minQ = -min(min(Qtemp));
Qtemp = Qtemp +minQ;

for j = 1:52
Qtemp(Qtemp(:,j)<0,j) = zeros(sum(Qtemp(:,j)<0),1);
end
for j = 1:51
    Qtemp(Qtemp(:,52-j)>Qtemp(:,52-j+1),52-j) = Qtemp(Qtemp(:,52-j)>Qtemp(:,52-j+1),52-j+1);
end

Qtemp = -Qtemp+minQ;