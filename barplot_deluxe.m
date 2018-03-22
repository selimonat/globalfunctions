function [h p]=barplot_deluxe(D,varargin)
%will plot bars, SEM errorbars, and asterix on the current axis. Use
%VARARGIN to precise xticklabels.

bar(nanmean(D),'k');
hold on;
errorbar(nanmean(D),nanstd(D)./sqrt(size(D,1)),'ro','linewidth',3,'capsize',0,'marker','none');
hold off;
if nargin >1
    set(gca,'xticklabel',varargin{1},'XTickLabelRotation',45,'fontsize',12,'box','off','xgrid','on','ygrid','on')
else
    set(gca,'fontsize',12,'box','off','xgrid','off','ygrid','on')
end
%
[h p ] = ttest(D,0,'alpha',.05);
for n = 1:size(D,2);
    if p(n) <= .05
        text(n,max(ylim),pval2asterix(p(n)),'HorizontalAlignment','center','fontsize',20);
    end
end
grid on;