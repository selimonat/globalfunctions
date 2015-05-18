function [row,col]=GetSubplotNumber(troi)
%[row,col]=GetSubplotNumber(troi)
%
%   This function will return the optimal subplot col and row numbers for a
%   given number of subplots that is desired.


if troi ~= 1
    row = floor(sqrt(troi));
    col = ceil(sqrt(troi));
    while troi > (row*col)
        row = row + 1;
    end
else%if we have only one ROI no subplots
    row = 1;
    col = 1;
end