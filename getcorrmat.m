function [cmat] = getcorrmat(amp_circ,amp_gau,amp_const,amp_diag)
%[cmat] = getcorrmat(amp_circ,amp_gau,amp_const);
%
% computes a covariance matrix based on circular, gaussian, constant and
% diagonal contributions.

%%
global mu
global sigma

%%
x      = pi/4:pi/4:2*pi;
x      = x(:);      
%
G      = make_gaussian1d(x-mu,2,sigma,0);
B      = -ones(1,8);
D      = diag(ones(1,8));
%
M      = [cos(x) sin(x) G(:) B(:) D];
% MM     = M*inv(diag(sqrt(diag(M'*M))));%unitize all basis functions.
%%
cmat   = M*diag([amp_circ amp_circ amp_gau amp_const repmat(amp_diag,1,8)])*M';