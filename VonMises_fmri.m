function [out] = VonMises_fmri(X,amp,kappa,offset)
%[out] = VonMises_fmri(X,amp,kappa,offset)
%
% Same as VonMises but without the CENTERing parameter.
%


[out] = VonMises(X,amp,kappa,0,offset);


