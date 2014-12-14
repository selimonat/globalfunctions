function [down,up]=GetColorMapLimits(data,n)
%[down,up]=GetColorMapLimits(data,n)
%Given a distribution of points in data, this function detects the
%N*sigma (standard deviation) boundaries. This is usefull in cases where
%outliers prevents the visualization of the interesting structure of the
%images. DATA is a matrix with any dimensions.
%
%Selim, 2006


m         = nanmean(data(:));
sigma     = sqrt( nanmean(data(:).^2) - nanmean( data(:)).^2);

up        = m+n*sigma;
down      = m-n*sigma;
