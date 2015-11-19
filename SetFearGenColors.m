function [colors] = SetFearGenColors
%[color] = SetFearGenColors
%
%   Changes default axes color order to a circular HSV. COLOR is the
%   used colormap.
%
%   See also: SetFearGenBarColors, GetFearGenColors

colors = GetFearGenColors;
set(0,'DefaultAxesColorOrder',colors);