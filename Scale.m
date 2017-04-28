function [y]=Scale(x)
%[y]=Scale(x)
%
%   Scales X to have all values between one and zero. X can be of any
%   dimension.
%
%Selim 2006 November 15

y = x;
if ~isempty(x(:)) && sum(abs(diff(x(:)))) ~= 0;
    x = x - min(x(:));
    y = x./max(x(:));
end