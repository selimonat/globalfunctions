function [out] = make_gabor(Ysize,Xsize,fwhmX,fwhmY,amp,freq,ori,phase,centerY,centerX);
%function [out] = make_gabor(Ysize,Xsize,fwhmX,fwhmY,amp,freq,ori,phase,centerY,centerX);
%freq  = number of cycles per patch
%ori = 0 & pi are horizontal and pi/2 is vertical 

boy = [Ysize Xsize];

ori = ori - pi/2;

sigmaX = fwhmX ./2.3548;
sigmaY = fwhmY ./2.3548;

[X Y] = meshgrid(1:Ysize,1:Xsize);X = X - centerX;Y = Y - centerY;

Xb   = X;
X    = X*cos(ori) - Y*sin(ori);
Y    = Xb*sin(ori)+ Y*cos(ori);
out  = amp*exp( - (( ( (X.^2)./(2*sigmaX.^2))+((Y.^2) ./(2*sigmaY.^2) ))) ).*cos(2*pi*(freq/boy(1))*X+phase);
out  = out - mean(out(:));


