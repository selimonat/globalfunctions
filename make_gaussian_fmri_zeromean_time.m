function [out] = make_gaussian_fmri_zeromean_time(x,amp,sd)
%[out] = make_gaussian_fmri_zeromean(X,amp,sd);
%
% This is the extended version of make_gaussian_fmri_zeromean to time
% domain. AMP and SD are not scalar but vectors representing the temporal
% evolution of the AMP and SD parameters. AMP and SD have to be the same
% size.



d = mean(diff(x));

%out      = amp.*exp(-tau*(x.^2)/2) - amp*sqrt(2*pi/tau)./d./(length(X));

%for speed length(X) can be precomputed
XT = length(x);
%as well as d
% d  = 0.02;
%out      = amp.*exp(-tau*(x.^2)/2) - amp*sqrt(2*pi/tau)./d./XT;

for nt = 1:length(amp)
    out(nt,:)      = amp(nt).*exp(-(x./sd(nt)).^2/2) - amp(nt)*sqrt(2*pi*sd(nt)^2)./d./XT;
end