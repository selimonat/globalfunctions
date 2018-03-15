function Publication_RemoveXaxis(h)
%Publication_RemoveXaxis(h)
%
% Removes the x-axis line, which is useless when it doesn't coincides with
% zero. H is a vector of handles.
%
% SO

for nh = 1:length(h)
    pause(.2);
    h(nh).XRuler;
    h(nh).XRuler.Axle;
    h(nh).XRuler.Axle.LineStyle;
    h(nh).XRuler.Axle.LineStyle = 'none';
    h(nh).XRuler.TickLength     = [0 0];
end