function out = make_gabor_fromchris(dims,F,orient,band,offset,varargin)  
% FROM CHRISTOPHE
% function out = make_gabor_fromchris(dims,F,orient,band,offset,varargin) 
% creates a gaborwavelet of size dims (scalar or vector).
% band is the bandwidth and F is either taken relative to dims
% or if varargin is given, then this is the size of the displayed
% image and F is in cpd.
% offset: pi = opposite contrast;

orient = deg2rad(orient);


if sum(size(dims))>1
    S(1) = dims(1);
    S(2) = dims(2);
else 
    S(1) = dims;
    S(2) = dims;
end
F = F*S(1);
[X,Y] =meshgrid([-S(1)/2+1:S(1)/2],[-S(2)/2+1:S(2)/2]);

if length(varargin) ==1
    PixPerDeg = S(1) / varargin{1};
	F = F/PixPerDeg;
else
    F = F/S(1);
end

sig = band/F; % why ?

Xb = X;
X = X*sin(orient)-Y*cos(orient);
Y = Xb*cos(orient)+Y*sin(orient);
 out = exp( -(X.^2 + Y.^2) / (2*sig^2)).*exp(i*(2*pi*F*X+offset));	

