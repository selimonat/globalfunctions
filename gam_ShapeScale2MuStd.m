function [mu,sd]=gam_ShapeScale2MuStd(shape,scale)
%[shape,scale]=gam_ShapeScale2MuStd(shape,scale)
%
% Will return required shape and scale parameters for a desired MU and STD
% variables for Gamma distribution. dgamma in BUGS however prefers the
% 1/scale (i.e. rate) parameter.
%
% See alsp: MuStd2ShapeScale


mu = shape.*scale;
sd = sqrt(shape.*scale.^2);
