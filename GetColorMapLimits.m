function [down,up]=GetColorMapLimits(data,n)
%[down,up]=GetColorMapLimits(data,n)
%Given a distribution of points in data, this function detects the
%N*sigma (standard deviation) boundaries. This is usefull in cases where
%outliers prevents the visualization of the interesting structure of the
%images. DATA is a matrix with any dimensions.
%
%Selim, 2006

i         = isfinite(data);
m         = nanmean(data(i));
sigma     = sqrt( nanmean(data(i).^2) - nanmean( data(i)).^2);

up        = m+n*sigma;
down      = m-n*sigma;
