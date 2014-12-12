function [Cleaned]=RemoveLinear(toClean)

%[Cleaned]=RemoveLinear(toClean)
%Removes the linear component from a time-series, so that the best fitting
%line's slope to the CLEANED signal is 0. Modified: Now remove the second
%order content as well
%
%
%This script is not fully ready yet.

tS       = size(toClean,1);
tPix     = size(toClean,2);
%
A        = [ ones(tS,1)  (1:tS)' (1:tS)'.^2 (1:tS)'.^3 (1:tS)'.^4];    
Cleaned  = zeros(tS,tPix);
for n = 1:tPix;
    X            = lscov( A , toClean(:,n));
    Cleaned(:,n) = toClean(:,n)-A*X;    
end
