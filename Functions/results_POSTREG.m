% For an increase in dRD, the slope of the inverse RD increases.

% Slope of RD
dRD1 = zeros(n,1);
for i=1:n
    [B,BINT,R,RINT,STATS] = regress(firm(5).rdq(i,:)',[ones(length(P_grid),1),P_grid],0.1);
    %plot(P_grid,firm(id+1).rdq(i,:),'x')
    %hold on
    %plot(P_grid,[ones(length(P_grid),1),P_grid]*B)
    %hold off
    dRD1(i,1) = B(2);
    %pause
end


BB = [];
SS = [];

R2_ = nan(4,4);
N_ = nan(4,4);

for ij=1:3
    prefix = 0;

load(['Tempfiles/temp',num2str(prefix),'_0.mat'])

idx_opeak = find(HOUR<8 | HOUR>21);


if ij==1
    idx_target = intersect(idx_opeak,intersect([event(1).index;event(2).index;event(3).index;event(4).index],find(events_d==1))); %setdiff(idx_events2,idx_event5);
elseif ij==2
    idx_target = intersect(idx_opeak,intersect([event(1).index;event(2).index;event(3).index;event(4).index;event(7).index;event(8).index;event(10).index;event(11).index],find(events_d==1))); %setdiff(idx_events2,idx_event5);
elseif ij==3
    idx_target = intersect(idx_opeak,[idx_valid]);
end


idx_targ = [idx_target];
HOUR_d = dummyvar(HOUR+1);
WDAY_d = dummyvar(WDAY);
MONTH_d = dummyvar(MONTH);

dRD2 = dRD1(idx_target,:);
X1 = [HOUR_d(idx_target,1:end-1),WDAY_d(idx_target,1:end-1)];
X12 = K_c(idx_target)-K(idx_target);
dQ = DISP_oo(idx_target)-DISP_hhc(idx_target);
dP = PRICE(idx_target)-PRICE_hhc(idx_target);
dD = trapz(linspace(0,1,length(P_grid)),firm(5).q(idx_target,:)'-Qt(idx_target,1:length(P_grid))')';

load(['Tempfiles/temp',num2str(prefix),'_1.mat'])

idx_peak = find(HOUR>=8 & HOUR<=21);

if ij==1
    idx_target = intersect(idx_peak,intersect([event(1).index;event(2).index;event(3).index;event(4).index],find(events_d==1))); %setdiff(idx_events2,idx_event5);
elseif ij==2
    idx_target = intersect(idx_peak,intersect([event(1).index;event(2).index;event(3).index;event(4).index;event(7).index;event(8).index;event(10).index;event(11).index],find(events_d==1))); %setdiff(idx_events2,idx_event5);
elseif ij==3
    idx_target = intersect(idx_peak,[idx_valid]);
end


idx_targ = [idx_targ;idx_target];

dRD2 = [dRD2;dRD1(idx_target,:)];
X1 = [X1;[HOUR_d(idx_target,1:end-1),WDAY_d(idx_target,1:end-1)]];
X12 = [X12;(K_c(idx_target)-K(idx_target))/1000];

if ij==3
X12=[];
end

dQ = [dQ;DISP_oo(idx_target)-DISP_hhc(idx_target)];
dP = [dP;PRICE_oo(idx_target)-PRICE_hhc(idx_target)];
dD = [dD;trapz(linspace(0,1,length(P_grid)),firm(5).q(idx_target,:)'-Qt(idx_target,1:length(P_grid))')']; %same thing

dD_d = 0*dD;
dD_d(dD<0) = 1;

idx_targ2 = (1:length(dD)); %all obs (peak+offpeak)

BHAT = nan(2,4);
SHAT = nan(2,4);

[B_0,BINT,~,~,STATS] = regress(dD(idx_targ2),[ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1]);
maxLag = floor(4*(length(idx_targ2)/100)^(2/9));
se = (BINT(:,2) - B_0)/1.96;
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dD(idx_targ2),Type="HC",Weights="HC4",Intercept=false);
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dD(idx_targ2),Intercept=false);
BHAT(1,1) = B_0(2);
BHAT(2,1) = B_0(3);
SHAT(1,1) = se(2);
SHAT(2,1) = se(3);
R2_(ij,1) = STATS(1);
N_(ij,1) = length(dD);

[B_0,BINT,~,~,STATS] = regress(dQ(idx_targ2),[ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1]);
se = (BINT(:,2) - B_0)/1.96;
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dQ(idx_targ2),Type="HC",Weights="HC4",Intercept=false);
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dQ(idx_targ2),'Bandwidth',maxLag+1,Intercept=false);

BHAT(1,2) = B_0(2);
BHAT(2,2) = B_0(3);
SHAT(1,2) = se(2);
SHAT(2,2) = se(3);
R2_(ij,2) = STATS(1);
N_(ij,2) = length(dD);

[B_0,BINT,~,~,STATS] = regress(dP(idx_targ2),[ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1]);
se = (BINT(:,2) - B_0)/1.96;
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dP(idx_targ2),Type="HC",Weights="HC4",Intercept=false);
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dP(idx_targ2),'Bandwidth',maxLag+1,Intercept=false);
BHAT(1,3) = B_0(2);
BHAT(2,3) = B_0(3);
SHAT(1,3) = se(2);
SHAT(2,3) = se(3);
R2_(ij,3) = STATS(1);
N_(ij,3) = length(dD);

[B_0,BINT,~,~,STATS] = regress(dD_d(idx_targ2),[ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1]);
se = (BINT(:,2) - B_0)/1.96;
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dD_d(idx_targ2),Type="HC",Weights="HC4",Intercept=false);
[~,se,B] = hac([ones(size(dD(idx_targ2))),dRD2(idx_targ2),X12,X1],dD_d(idx_targ2),'Bandwidth',maxLag+1,Intercept=false);
BHAT(1,4) = B_0(2);
BHAT(2,4) = B_0(3);
SHAT(1,4) = se(2);
SHAT(2,4) = se(3);
R2_(ij,4) = STATS(1);
N_(ij,4) = length(dD);

BB = [BB;BHAT];
SS = [SS;SHAT];

BB
SS

R2_
N_

end

BB(end,:) = nan;
SS(end,:) = nan;

BB
SS

R2_
N_

%%

BHAT = BB;
SHAT = SS;

clear BHAT2 SHAT2
for i=1:size(BHAT,2)
    for ii=1:size(BHAT,1)
        if (1-normcdf(abs( BHAT(ii,i)./SHAT(ii,i) ) ))*2>0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if (1-normcdf(abs( BHAT(ii,i)./SHAT(ii,i) ) ))*2<=0.1
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if (1-normcdf(abs( BHAT(ii,i)./SHAT(ii,i) ) ))*2<=0.05
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if (1-normcdf(abs( BHAT(ii,i)./SHAT(ii,i) ) ))*2<=0.01
            BHAT2{ii,i} =  ['$',num2str(BHAT(ii,i),'%0.2f'),'^{\star\star\star}$'];
            SHAT2{ii,i} =  ['$(',num2str(SHAT(ii,i),'%0.2f'),')$'];
        end
        if isnan(SHAT(ii,i))
            BHAT2{ii,i} =  ' ';
            SHAT2{ii,i} =  ' ';
        end
    end
end

BHAT2
SHAT2
%%

%table
TABLE1 = ['\begin{tabular*}{1\hsize}{@{\hskip\tabcolsep\extracolsep\fill}ll*{4}{c}}',...
    ' \toprule & & $\widehat{\Delta S}$ & $\widehat{\Delta Q}$ & $\widehat{\Delta P}$ & $\mathds{1}_{\widehat{\Delta S}<0}$   \\',...
    ' ',...
    ];

TABLE1 = [TABLE1,...
    ' \hline ',...
    ' Main events & RD slope ',' & ',...
    BHAT2{1,1},' & ',...
    BHAT2{1,2},' & ',...
    BHAT2{1,3},' & ',...
    BHAT2{1,4},'  \\ ', ...
    ' & & ',SHAT2{1,1},' & ',...
    SHAT2{1,2},' & ',...
    SHAT2{1,3},' & ',...
    SHAT2{1,4},'  \\ ', ...
    ' & Outage capacity',' & ',...
     BHAT2{2,1},' & ',...
    BHAT2{2,2},' & ',...
    BHAT2{2,3},' & ',...
    BHAT2{2,4},'  \\ ', ...
    ' &  & ',SHAT2{2,1},' & ',...
    SHAT2{2,2},' & ',...
    SHAT2{2,3},' & ',...
    SHAT2{2,4},'  \\ ',...
    ' & Observations  & ',num2str(N_(1,1)),' & ',num2str(N_(1,2)),' & ',num2str(N_(1,3)),' & ',num2str(N_(1,4)),' \\ ',...;
    ' & $R^2$  & ',num2str(R2_(1,1),'%0.2f'),' & ',num2str(R2_(1,2),'%0.2f'),' & ',num2str(R2_(1,3),'%0.2f'),' & ',num2str(R2_(1,4),'%0.2f'),' \\ '];

i = 2;
TABLE1 = [TABLE1,...
    ' \hline ',...
    ' All events & RD slope ',' & ',...
    BHAT2{3,1},' & ',...
    BHAT2{3,2},' & ',...
    BHAT2{3,3},' & ',...
    BHAT2{3,4},'  \\ ', ...
    ' & & ',SHAT2{3,1},' & ',...
    SHAT2{3,2},' & ',...
    SHAT2{3,3},' & ',...
    SHAT2{3,4},'  \\ ', ...
    ' & Outage capacity',' & ',...
     BHAT2{4,1},' & ',...
    BHAT2{4,2},' & ',...
    BHAT2{4,3},' & ',...
    BHAT2{4,4},'  \\ ', ...
    ' &  & ',SHAT2{4,1},' & ',...
    SHAT2{4,2},' & ',...
    SHAT2{4,3},' & ',...
    SHAT2{4,4},'  \\ ',...
    ' & Observations &  ',num2str(N_(i,1)),' & ',num2str(N_(i,2)),' & ',num2str(N_(i,3)),' & ',num2str(N_(i,4)),' \\ ',...;
    ' & $R^2$ &  ',num2str(R2_(i,1),'%0.2f'),' & ',num2str(R2_(i,2),'%0.2f'),' & ',num2str(R2_(i,3),'%0.2f'),' & ',num2str(R2_(i,4),'%0.2f'),' \\ '];

i = 3;
TABLE1 = [TABLE1,...
    ' \hline ',...
    ' Testing & RD slope ',' & ',...
    BHAT2{5,1},' & ',...
    BHAT2{5,2},' & ',...
    BHAT2{5,3},' & ',...
    BHAT2{5,4},'  \\ ', ...
    ' & & ',SHAT2{5,1},' & ',...
    SHAT2{5,2},' & ',...
    SHAT2{5,3},' & ',...
    SHAT2{5,4},'  \\ ', ...
    ' & Outage capacity',' & ',...
     BHAT2{6,1},' & ',...
    BHAT2{6,2},' & ',...
    BHAT2{6,3},' & ',...
    BHAT2{6,4},'  \\ ', ...
    ' &  & ',SHAT2{6,1},' & ',...
    SHAT2{6,2},' & ',...
    SHAT2{6,3},' & ',...
    SHAT2{6,4},'  \\ ',...
    ' & Observations &  ',num2str(N_(i,1)),' & ',num2str(N_(i,2)),' & ',num2str(N_(i,3)),' & ',num2str(N_(i,4)),' \\ ',...;
    ' & $R^2$ &  ',num2str(R2_(i,1),'%0.2f'),' & ',num2str(R2_(i,2),'%0.2f'),' & ',num2str(R2_(i,3),'%0.2f'),' & ',num2str(R2_(i,4),'%0.2f'),' \\ '];


% i = 4;
% TABLE1 = [TABLE1,...
%     ' \hline ',...
%     ' Testing & RD slope ',' & ',...
%     BHAT2{7,1},' & ',...
%     BHAT2{7,2},' & ',...
%     BHAT2{7,3},' & ',...
%     BHAT2{7,4},'  \\ ', ...
%     ' & & ',SHAT2{7,1},' & ',...
%     SHAT2{7,2},' & ',...
%     SHAT2{7,3},' & ',...
%     SHAT2{7,4},'  \\ ', ...
%     ' & Outage capacity',' & ',...
%      BHAT2{8,1},' & ',...
%     BHAT2{8,2},' & ',...
%     BHAT2{8,3},' & ',...
%     BHAT2{8,4},'  \\ ', ...
%     ' &  & ',SHAT2{8,1},' & ',...
%     SHAT2{8,2},' & ',...
%     SHAT2{8,3},' & ',...
%     SHAT2{8,4},'  \\ ',...
%     ' & Observations &  ',num2str(N_(i,1)),' & ',num2str(N_(i,2)),' & ',num2str(N_(i,3)),' & ',num2str(N_(i,4)),' \\ ',...;
%     ' & $R^2$ &  ',num2str(R2_(i,1),'%0.2f'),' & ',num2str(R2_(i,2),'%0.2f'),' & ',num2str(R2_(i,3),'%0.2f'),' & ',num2str(R2_(i,4),'%0.2f'),' \\ '];


TABLE1 = [TABLE1,...
    ' \bottomrule ','\end{tabular*}'];

%if savetable==1
fileID = fopen([tablepath,'/table_7.tex'],'w');
fprintf(fileID,'%s',TABLE1);
fclose(fileID);
%end
