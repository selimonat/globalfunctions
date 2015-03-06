function out = make_gaussian2D(Ysize,Xsize,fwhmY,fwhmX,centerY,centerX)
%out = make_gaussian2D(Ysize,Xsize,fwhmY,fwhmX,centerY,centerX);
%   produces a 2D gaussian with amplitude = 1. YSIZE and XSIZE are the size
%   in pixels, FWHMX and FWHMY specifies the width at half width in pixels,
%   CENTERX and CENTERY specifies the location of the center point.
%   
%   Selim 2003

sigmaX = fwhmX ./2.3548;
sigmaY = fwhmY ./2.3548;


[X Y] = meshgrid(1:Xsize,1:Ysize);
X = X - centerX;Y = Y - centerY;


out  = exp( - (( ( (X.^2)./(2*sigmaX.^2))+((Y.^2) ./(2*sigmaY.^2) ))) );