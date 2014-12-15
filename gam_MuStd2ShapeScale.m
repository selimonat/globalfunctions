function [shape,scale,rate]=gam_MuStd2ShapeScale(mu,sd)
%[shape,scale]=gam_MuStd2ShapeScale(mu,std)
%
% Will return required shape and scale parameters for a desired MU and STD
% variables for Gamma distribution. dgamma in BUGS however prefers the
% 1/scale (i.e. rate) parameter.
%
% see also ShapeScale2MuStd




shape = mu.^2./sd.^2;

scale = sd.^2./mu;

rate = 1./scale;