function Publication_Asteriks(mat,varargin);

if nargin > 1
    xcenters = varargin{1};
else
    xcenters = 1:size(mat,2);    
end

[~, P] = ttest(mat,0,'alpha',.05);
for n = 1:size(P,2)
    if P(n) <= .05;
        text(xcenters(n),max(ylim)+range(ylim)*.1,pval2asterix(P(n)),'HorizontalAlignment','center','fontsize',12);
    end
end