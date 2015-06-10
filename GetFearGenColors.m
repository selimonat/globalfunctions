function [color]=GetFearGenColors(varargin)
%[color]=GetFearGenColors
%
%   Returns the circular HSV color space in COLOR.

color = circshift( hsv(8), [3 0] );
color = [color ; [0 0 0] ; [0.5 0.5 0.5]];

if nargin > 0   
    color = color(varargin{1},:);    
end