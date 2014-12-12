function [a]=MinimumAngle(y,x);
%[a]=MinimumAngle(x,y);
%
%finds the minimum angle between two angles given in degrees, the answer is
%also in degrees. The clockwise distances from Y to X are considered as
%positive. Opposite angles are considered as positive 180.

x  = deg2rad(x);
y  = deg2rad(y);

a  = atan2(sin(x-y), cos(x-y));

a  = -round(rad2deg(a));

if any(abs(a) == 180);
   a(abs(a) == 180) = 180;
end