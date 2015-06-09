function out = make_gaussian1d(Xsize,peak,center,fwhmX,baseline)
%out = make_gaussian1d(Xsize,peak,center,fwhmX,baseline)
%
%
%   PEAK is the peak position of the Gaussian. BASELINE is the zero level.
%   This function is slightly different than make_gaussian1d_fmri, where
%   peak argument is replaced by amplitude, where amplitude = peak-offset.

sigmaX = fwhmX ./2.35482;

[X] = 1:Xsize;
X = X - center;

out  = exp( - (( ( (X.^2)./(2*sigmaX.^2)) )));

out  = (peak-baseline)*out+baseline;
