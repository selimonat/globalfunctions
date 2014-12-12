function [z]=nanzscore(x,flag,dim)
%nanzscore(x,flag,dim)
%
%   Exactly the same as matlab's zscore but with nan operators so that the
%   result is not all nan when the data contains NaN values.
%
%

if isequal(x,[]), z = []; return; end

if nargin < 2
    flag = 0;
end
if nargin < 3
    % Figure out which dimension to work along.
    dim = find(size(x) ~= 1, 1);
    if isempty(dim), dim = 1; end
end

% Compute X's mean and sd, and standardize it
mu = nanmean(x,dim);
sigma = nanstd(x,flag,dim);
sigma0 = sigma;
sigma0(sigma0==0) = 1;
z = bsxfun(@minus,x, mu);
z = bsxfun(@rdivide, z, sigma0);
