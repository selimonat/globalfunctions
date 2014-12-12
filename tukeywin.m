function w = tukeywin(n,r)

%TUKEYWIN Tukey window.
%   TUKEYWIN(N) returns an N-point Tukey window in a column vector.
%
%   W = TUKEYWIN(N,R) returns an N-point Tukey window in a column vector.
%   A Tukey window is also known as the cosine-tapered window.  The R
%   parameter specifies the ratio of taper to constant sections. This ratio
%   is normalized to 1 (i.e., 0 < R < 1). If ommited, R is set to 0.500.
%
%   NOTE: At extreme values of R, the Tukey window degenerates into other
%   common windows. Thus when R = 1, it is equivalent to a Hanning window.
%   Conversely, for R = 0 the Tukey window is equivalent to a boxcar window.
%
%   EXAMPLE:
%      N = 64;
%      w = tukeywin(N,0.5);
%      plot(w); title('64-point Tukey window, Ratio = 0.5');
%
%   See also CHEBWIN, GAUSSWIN, KAISER, WINDOW.
 
%   Reference:
%     [1] fredric j. harris [sic], On the Use of Windows for Harmonic Analysis
%         with the Discrete Fourier Transform, Proceedings of the IEEE,
%         Vol. 66, No. 1, January 1978, Page 67, Equation 38.
 
%   Author(s): A. Dowd
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.11 $  $Date: 2002/08/30 18:50:36 $
 
error(nargchk(1,2,nargin));
 % Default valuefor R parameter.
if nargin < 2 | isempty(r),
    r = 0.500;
end
 
[n,w,trivialwin] = check_order(n);
if trivialwin, return, end;
 
if r <= 0,
    w = ones(n,1);
elseif r >= 1,
    w = hann(n);
else
    t = linspace(0,1,n)';
    % Defines period of the taper as 1/2 period of a sine wave.
    per = r/2;
    tl = floor(per*(n-1))+1;
    th = n-tl+1;
    % Window is defined in three sections: taper, constant, taper
    w = [ ((1+cos(pi/per*(t(1:tl) - per)))/2);  ones(th-tl-1,1); ((1+cos(pi/per*(t(th:end) - 1 + per)))/2)];
end


function [n_out, w, trivalwin] = check_order(n_in)
%CHECK_ORDER Checks the order passed to the window functions.
% [N,W,TRIVALWIN] = CHECK_ORDER(N_ESTIMATE) will round N_ESTIMATE to the
% nearest integer if it is not alreay an integer. In special cases (N is [],
% 0, or 1), TRIVALWIN will be set to flag that W has been modified.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.6 $  $Date: 2002/03/28 17:29:27 $

w = [];
trivalwin = 0;

% Special case of negative orders:
if n_in < 0,
   error('Order cannot be less than zero.');
end

% Check if order is already an integer or empty
% If not, round to nearest integer.
if isempty(n_in) | n_in == floor(n_in),
   n_out = n_in;
else
   n_out = round(n_in);
   warning('Rounding order to nearest integer.');
end

% Special cases:
if isempty(n_out) | n_out == 0,
   w = zeros(0,1);               % Empty matrix: 0-by-1
   trivalwin = 1; 
elseif n_out == 1,
   w = 1;
   trivalwin = 1;   
end
