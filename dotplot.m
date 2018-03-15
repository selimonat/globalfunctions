function [h]=dotplot(mat,varargin)
%[h]=dotplot(mat,varargin)
%
%
% DOTPLOT is an honest way of presenting your data. Can be used as an
% alternative to barplot. The benefit being that all data points are shown
% which are typically hidded in a barplot.
%
% MAT contains variables in its columns.
% VARARGIN can be used to fine-tune dots.
% H is axis handle.
%
% SO.

tcol        = size(mat,2);
tpoints     = size(mat,1);
xcenters    = 1:2:tcol*2;

color       = [0.3 .3 .3];
MarkerSize  = 32;
LineWidth   = 2;
transparency= .3;
%% plot dots
for ncol = 1:tcol
    X       = linspace(0.5,1.5,tpoints)'+2*(ncol-1);
    h(ncol) = scatter(X(:),mat(:,ncol),MarkerSize  ,color,'filled','MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerFaceAlpha',transparency , 'MarkerEdgeAlpha',transparency,varargin{:});
    hold on;
    plot([X(1)-.5 X(end)+.5],repmat(nanmean(mat(:,ncol)),1,2),'-','color','k','linewidth',1);
end
plot([-0.5 1.5+2*(tcol-1)+1],[0 0],'color',[0 0 0 0]);%plot an invisible line so that subsequent calls of axis tight doesn't screw up the plot
%%
set(gca,'xtick',xcenters,'color','none','ygrid','on')
hold off;
box off;
Publication_RemoveXaxis(gca);
axis tight

%%
