function [fwhm, sigma] = vM2FWHM(kappa)
%fwhm = vM2FWHM(kappa)
%transforms a given vonMises function's kappa parameter to FWHM. Kappa
%parameter has no intuition, however FWHM is easily understandable.
amp     = 1;
centerX = 0;
offset  = 0;
%
s       = size(kappa);
kappa   = kappa(:);

for nka = 1:length(kappa)
    X           = linspace(-180,180,100000);%degrees
    Y           = Tuning.VonMises(X,amp,kappa(nka),centerX,offset);%requires degrees, converts to rads inside.
    
    half_height = [max(Y)-min(Y)]./2+min(Y);%
    d           = abs(Y - half_height);
    
    [~,i]       =  min(d(X > centerX));
    i = i+sum(X < centerX);
    [~,i2]      =  min(d(X < centerX));
    
    % plot(abs(Y-half_height));
    
    fwhm(nka)        =  abs(diff(X([i i2])));
    sigma(nka)       =  fwhm(nka)./2.35482;
end

fwhm  = reshape(fwhm,[s]);
sigma = reshape(sigma,[s]);