function [out] = make_gaussian_fmri_zeromean_matrixform(x,amp,sd)
%[out] = make_gaussian_fmri_zeromean_matrixform(X,amp,sd);
%
%	This is equivalent to make_gaussian_fmri_zeromean, but accepts vectors
%	as input variables. X doens't need to be the same size as amp
%



d   = mean(diff(x));
XT  = length(x);
%%
out = zeros( length(x) , length(amp) );
c   = 0;
for nx = x(:)'
    c        = c+1;
    out(c,:) = amp.*exp(-(nx./sd).^2/2) - amp.*sqrt(2.*pi.*sd.^2)./d./XT;    
end