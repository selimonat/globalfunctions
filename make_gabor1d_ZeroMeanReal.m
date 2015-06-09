function [out]=make_gabor1d_ZeroMeanReal(X,ampGau,fwhmX,centerX,freq)
%Real Gabor meaning, it is NOT the sum of Gau and Sine but their
%multiplication

sigmaX   = fwhmX ./2.35482;
out      = ampGau.*exp( - (((X - centerX).^2)./(2*sigmaX.^2)) ).*cos((X-centerX).*freq);
out      = out - mean(out);