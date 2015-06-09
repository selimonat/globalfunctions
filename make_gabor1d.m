function [out] = make_gabor1d(X,fwhmX,amp,freq,phase,centerX,offset)
%produces one dimensional gaussian. 
%[out] = make_gabor1d(Xsize,fwhmX,amp,freq,phase,centerX);
% freq  = number of cycles per patch


%X       = 1:Xsize;
Xsize    = X(end)-X(1);%length(X);
sigmaX   = fwhmX ./2.3548;
X        = X - centerX;

out  = amp*exp( - ((X.^2)./(2*sigmaX.^2)) ).*cos(2*pi*(freq/Xsize)*X+phase);
%out  = out - mean(out(:));
out  = out + offset;
