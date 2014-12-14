function [BE]=GetHistEqBinEdges(data,nBins)
%[BinEdges]=GetHistEqBinEdges(data,nBins)
%
%This function computes the bin edges that can be used for histogram
%equalization. It divides the scale of the FeatureMap into NBINS . For
%example, if we are dealing with mean luminance 
%maps, our dynamic range of values is most probably (depending on the
%images) between 0 and 255. The binedges computed in this algorithm divide
%this range into NBINS. The special property of these binedges is that the
%total number of fixations within each bin is equal.
%
%DATA can anything, it will be vectorized before BE detection.
%

%vectorize
data = data(:);
%sort the Feature map
[data i] = sort(data);
%distance between bins
Increment = length(data)./nBins;
%index of each bin, rounded
BE_i      = round((1:nBins-1)*Increment);
BE        = [data(1) ; data(BE_i) ; data(end)];