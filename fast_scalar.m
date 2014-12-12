% FAST_SCALAR   Fast scalarproduct of arrays with arbitrary (but equal) dimensions
%
%   This function performs an elementwise multiplication of two arrays of arbitrary 
%   (but equal) sizes and adds the products, i.e.
%
%   sum(a(:).*b(:))
%
%   In order to gain speed, it is not checked, whether the input arguments 
%   are of same size.
%
%   Example: a = rand(10);
%            b = rand(10);
%            sp = fast_scalar(a,b);
%
% MK 2003

function  scalar_product =  fast_scalar(a,b)
scalar_product = sum(a(:).*b(:));