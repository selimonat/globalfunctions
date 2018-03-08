function Publication_CreateColorMap(type,range)
%Publication_CreateColorMap(type,range)
%
%Creates an image to be used as a colormap

%%
range = sort(range);
imagesc((repmat(linspace(range(1),range(2),100)',1,20))');
a =  gca;
box off;
axis image;
axis xy
a.XRuler.Axle.LineStyle = 'none';
a.YRuler.Axle.LineStyle = 'none';
a.YRuler.TickLength = [0 0];                
a.YTick = [];
set(gca,'xtick',[5 95],'fontsize',64,'xticklabel',range,'XAxisLocation','top');
