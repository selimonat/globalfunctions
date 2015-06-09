function [OUT] = make_gaussian1d_ZeroMean(X,amp,fwhmX,centerX)
%[out] = make_gaussian1d_ZeroMean(X,amp,fwhmX,centerX);
%
%	Same as make_gaussian
%   

OUT      = zeros(length(X),length(amp));
sigmaX   = fwhmX ./2.35482;
for n = 1:length(amp)
    out      = exp( - (((X - centerX(n)).^2)./(2*sigmaX(n).^2)) );
    out      = amp(n).*out;
    OUT(:,n) = out - mean(out);
end
