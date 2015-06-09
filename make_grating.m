function out = make_grating(dims,F,orient,offset,varargin)
%out = make_grating(dims,F,orient,offset,varargin)  
% from Christoph % THIS SCRIPT IS GREAT BECAUSE IT MAKES THE GRATING BEGINNING FROM THE CENTER AND NOT CORNER
% function out = makeGrating(dims,F,orient,offset,varargin) 
% creates a grating of size dims (scalar or vector).
% F is either taken relative to dims or if varargin is given, then this is the size of the displayed
% image and F is in cpd.
% offset: pi = opposite contrast;
% it has the opposite orientaion response compared to the make_gabor.
% thats why I put a 90 degree 
%orient = pi/2 - deg2rad(orient); % so it accepts degrees
%F = F*dims(2); %so it accepts Freq per patch if activated takes cycle per pixel.

orient = orient - pi/2;

if sum(size(dims))>1
    S(1) = dims(1);
    S(2) = dims(2);
else 
    S(1) = dims;
    S(2) = dims;
end

[X,Y] =meshgrid([-S(1)/2+1:S(1)/2],[-S(2)/2+1:S(2)/2]);
%[X,Y] =meshgrid([1:S(1)],[1:S(2)]);

if length(varargin) ==1
    PixPerDeg = S(1) / varargin{1};
	F = F/PixPerDeg;
else
    F = F/S(1);
end

 Xb = X;
 X = X*cos(orient)-Y*sin(orient);
 Y = Xb*sin(orient)+Y*cos(orient);

%w =  cos(orient-atan(X./Y)) .* sqrt(X.^2 + Y.^2);

out = exp(i*(2*pi*F*X+(offset)));

%out = exp(i*(2*pi*F*w+offset));