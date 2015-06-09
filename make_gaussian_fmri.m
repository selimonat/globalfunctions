function [out] = make_gaussian_fmri(X,amp,sd,offset)
%[out] = make_gaussian_fmri(X,amp,sd,offset);
%
%	Generates a Gaussian with AMP, SD and offset parameters. The center location is 
%	fixed to zero.
%


% sigmaX   = fwhm;% ./2.35482;
out      = amp.*exp( - (0.5*(X./sd).^2 )) + offset;



