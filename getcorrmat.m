function [cmat] = getcorrmat(amp_circ,amp_gau,amp_const,amp_diag)
%[cmat] = getcorrmat(amp_circ,amp_gau,amp_const);
%
% computes a covariance matrix based on circular, gaussian, constant and
% diagonal contributions.




x    = pi/4:pi/4:2*pi;

w    = [amp_circ*cos(x);...
    amp_circ*sin(x);...%circular components
    make_gaussian1d(x-pi,amp_gau*2,4,0);...%gaussian component
    -ones(1,8)*amp_const; ...%constant component.
    diag(ones(1,8))*amp_diag];%diagonal component

cmat = (w'*w);