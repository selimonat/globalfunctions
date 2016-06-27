function [cmap] =colormapper(colorcode,varargin)
% defines a colormap CMAP to be fed into colormap(CMAP) for a given image.
% takes a colorcode as input, referring to RGB channels, for which 1 means
% positive and -1 means negative direction, while 0 leaves this channel
% out.
% So activate channels by 1 and give +/- to indicate for which numbers
% these channels contribute (neg/pos).
% 
% Example: the colorcode [1 0 -1] gives a colormap with a gradient from
% red (pos values) via black (0) to blue (neg values), while colorcode [1 1
% 0] gives red-black-green, [1 1 -1] would give yellow-black-blue and so
% on.
% Additionally, you can force an illustratino to test your colormap by
% giving an additional (arbitrary) input argument.
cmap = zeros(256,3);
ind = find(colorcode == 1);
cmap(:,ind) = repmat([zeros(1, 132), linspace(0, 1, 124)]',[1 length(ind)]);
ind = find(colorcode == -1);
cmap(:,ind) = repmat([linspace(1, 0, 124), zeros(1, 132)]',[1 length(ind)]);

if nargin ==2
    figure;
    data = peaks(300);
    minValue = min(data(:));
    maxValue = max(data(:));
    % Scale the data to between -1 and +1. (not super necessary, but then
    % it simulates correlation data
    data = (data-minValue) * 2 / (maxValue - minValue) - 1;
    imagesc(data)
    colorbar
    colormap(cmap)
end