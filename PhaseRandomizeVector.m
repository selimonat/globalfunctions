function [Traj]=PhaseRandomizeVector(vec,varargin)
%[Traj]=PhaseRandomizeVector(vec,varargin)
%
%
%   Randomizes the phases of a vector VEC in the fourier space. The resulting
%   vector has the same power spectra but different phase. VARARGIN, if
%   used is the number of generated vectors stored in the columns of TRAJ.
%   Default is 1.
%
%
%Selim, 24-Feb-2009 18:30:56


if isempty(varargin)
    n = 1;
else
    n=varargin{1} ;
end

vec       = vec(:);
vec_abs = abs(fft(vec));
vec_abs = repmat(vec_abs,1,n);
% get random, symmetric phase information
RanPhase = angle(fft( rand( length(vec),  n  )));

% RanPhase2=RanPhase+pi/2;

% apply random phase to Gauss
newR= (vec_abs).*cos(RanPhase);
newI = (vec_abs).*sin(RanPhase);

% new real and new imaginary parts are combined and inverted from Fourier
% to Time Space
Traj =real(ifft(complex(newR,newI),'symmetric'));