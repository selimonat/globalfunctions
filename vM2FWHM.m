function fwhm = vM2FWHM(amp,centerX,kappa,offset)
%fwhm = vM2FWHM(amp,centerX,kappa,offset)
%transforms a given vonMises function's kappa parameter to FWHM. Kappa
%parameter has no intuition, however FWHM is easily understandable.


X           = linspace(-180,180,100000);%degrees
Y           = Tuning.VonMises(X,amp,kappa,centerX,offset);%requires degrees, converts to rads inside.

half_height = [max(Y)-min(Y)]./2+min(Y);%
d           = abs(Y - half_height);

[~,i]       =  min(d(X > centerX));
i = i+sum(X < centerX);
[~,i2]      =  min(d(X < centerX));

% plot(abs(Y-half_height));

fwhm        =  abs(diff(X([i i2])));

