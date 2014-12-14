function [s]=FastStd(d)
%[s]=FastStd(vector)

s = sqrt( mean(d.^2) - mean(d).^2 );
