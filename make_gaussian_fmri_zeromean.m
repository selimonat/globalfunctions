function [out] = make_gaussian_fmri_zeromean(x,amp,sd)
%[out] = make_gaussian_fmri_zeromean(X,amp,sd);
%
%	Generates a Gaussian with AMP, FWHM and offset parameters. The center location is 
%	fixed to zero. The creation relies on the make_gaussian_fmri, and
%	consequently the mean is substracted.
%


% 0 th version: Shifts the Gaussian based on the mean value of the computed
% curve NOT based on the full Gaussian.

%first the desired gaussian
% % % [out]  = make_gaussian_fmri(X,amp,sd,0);

% % % %then the mean value of the gaussian to be subracted from OUT. This is
% % % %necessary to do this in two goes, because if X is only a partial point on
% % % %the feargen profile we might end up in a situation where we dont subtract
% % % %the mean of the feargen profile. For example if is X is not a vector but a
% % % %single point, then the mean will always be equal to zero. So in order to
% % % %get the offset correction we have to call the make_gaussian routing with
% % % %the full x values.
% % % X      = deg2rad(linspace(-135,180,8));
% % % offset = mean(make_gaussian_fmri(X,amp,sd,0));
% % % out    = out - offset;



%1st VERSION...
% % % d = mean(diff(x));
% % % 
% % % out      = amp.*exp(-tau*(x(1:end).^2)/2) - amp*sqrt(2*pi/tau)./d./(length(x));
% % % mean(out)


%2nd Version with SD and more dense sampling of the area under curve

% X = linspace(-10,10,1000);%having a larger X axis will allow us to compute the mean
%of a gaussian that is much wider than the x-axis window we are interest if
%FG profiles
if length(x) ~= 1
    d = mean(diff(x));
else
    d = 0.7854;
end

%out      = amp.*exp(-tau*(x.^2)/2) - amp*sqrt(2*pi/tau)./d./(length(X));

%for speed length(X) can be precomputed
XT = length(x);
%as well as d
% d  = 0.02;
%out      = amp.*exp(-tau*(x.^2)/2) - amp*sqrt(2*pi/tau)./d./XT;


out      = amp.*exp(-(x./sd).^2/2) - amp*sqrt(2*pi*sd.^2)./d./XT;