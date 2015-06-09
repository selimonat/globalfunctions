function [out] = make_gaussian_fmri_tau(X,amp,tau,offset)
%[out] = make_gaussian_fmri_tau(X,amp,tau,offset);
%
%	Same as make_gaussian_fmri.m however the width parameters is not
%	defined by standard deviation but with precision (TAU). Generates a
%	Gaussian with AMP, FWHM and offset parameters. The center location is   
%	fixed to zero. According to wikipedia this has better convergence
%	properties.
%


out  = amp*(exp ( - (tau*X).^2 / 2)) + offset;

