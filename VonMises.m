function [out] = VonMises(X,amp,kappa,centerX,offset)
%[out] = VonMises(X,amp,centerX,kappa,offset)
%
%This is a variation of the von Mises distribution explained here:
%http://en.wikipedia.org/wiki/Von_Mises_distribution. This is the base
%function used by VonMises_fmri_*.m functions.
%



out    =  (exp(kappa*cos(X-centerX))-exp(-kappa))./(exp(kappa)-exp(-kappa));%put it btw [0 and 1]
out    =  amp*out + offset;%and now scale it

