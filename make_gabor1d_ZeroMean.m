function [out]=make_gabor1d_ZeroMean(x,amp,sd,freq,c)


out      = amp.*exp(-((x)./sd).^2/2).*cos((x).*freq) + c;
% out      = out - mean(out);