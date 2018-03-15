function Publication_RemoveYaxis(h)
%Publication_RemoveYaxis(h)
%
% Removes the y-axis line.
%
% SO

for nh = 1:length(h)
    pause(.2);
    h(nh).YTickLabel = [];
    h(nh).YRuler;
    h(nh).YRuler.Axle;
    h(nh).YRuler.Axle.LineStyle;
    h(nh).YRuler.Axle.LineStyle = 'none';
    h(nh).YRuler.TickLength     = [0 0];    
end