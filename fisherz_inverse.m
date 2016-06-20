function [r]=fisherz_inverse(z)
%[r]=fisherz_inverse(z)
%
%   Inverse transfroms fisher-z transformed correlation values.
%
%   See also fisherz


r=(exp(2*z)-1)./(exp(2*z)+1);
r(isinf(z)) = 1;
