function [shape,scale,rate]=gam_ModeStd2ShapeScale(mode,sd)
%[shape,scale,rate]=ModeStd2ShapeScale(mu,std)
%
% Will return required shape and scale parameters for a desired MODE and STD
% variables for Gamma distribution. dgamma in BUGS however prefers the
% 1/scale (i.e. rate) parameter.
%
% see also ShapeScale2MuStd


rate  = ( mode + sqrt( mode.^2 + 4*sd.^2 ) ) ./ ( 2 * sd.^2 );
shape = 1 + mode .* rate;
scale = 1./rate;