function [y x]=FindMinCoor(mat)
%FindMinCoor(mat)
%
% Will return the position of the minimum point. If many exists will take
% the first one. Possible extension would be to take the average of the
% points, once after ensuring that the points are conglomerated.

[y x] = find(mat == min(mat(:)));

if length(y) > 1
    y = y(1);
    x = x(1);
end
   