function [out] = make_gaussian1d(X,amp,fwhm,offset)
%[out] = make_gaussian_fmri(X,amp,fwhm,offset);
%
%	Generates a Gaussian with AMP, FWHM and offset parameters. The center location is 
%	fixed to zero.
%


sigmaX   = fwhm ./2.35482;
out      = amp.*exp( - ((X.^2)./(2*sigmaX.^2)) ) + offset;



