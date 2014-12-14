function [mat]=CancelDiagonals(mat,filling)
%[mat]=CancelDiagonals(mat,filling)
%
%   Fills with FILLING the diagonals of a matrix, most useful for
%   correlation matrices with 1s along the diagonal.
%

s = size(mat);
ss = s(1)+1;
if s(1) == s(2)
    mat(1:ss:end) = filling;        
else
    display('square matrix needed')
end