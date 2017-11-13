function [h]=dotplot(mat)
%this function is an alternative to the barplot the benefit being the fact
%that all data points are shown.

tcol    = size(mat,2);
tpoints = size(mat,1);

figure(1000);
for ncol = 1:tcol
    X       = linspace(0,1,tpoints)'+2*(ncol-1);
    color   = rand(1,3);
    h(ncol) = plot(X(:),mat(:,ncol),'o','color',color);
    hold on;
    plot([X(1)-.25 X(end)+.25],repmat(nanmean(mat(:,ncol)),1,2),'-','color',color','linewidth',4);
    plot([X(1)-.25 X(end)+.25],repmat(nanmedian(mat(:,ncol)),1,2),'-.','color',color','linewidth',2);
end
set(gca,'xtick',(0:2:2*(tcol-1))+.5,'xticklabel',1:tcol)
hold off;