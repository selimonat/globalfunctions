function [vec]=squareform_force(mat)
%[vec]=squareform_force(mat)
%   inspired from squareform but much more liberal, doesn't require perfect
%   similarity matrix, so small round-off errors do not bug me.
%   assumes mat is correlation similarity, so it fills diagonals with ones
%   when you vec 2 matrix.


if ~isvector(mat)
    
    n       = size(mat,1);
    vec     = mat(tril(true(n),-1));
    vec2ind = vec(:)';                 % force to a row vector, even if empty
    
else
    
    n = length(mat(:));
    m = ceil(sqrt(2*n)); % (1 + sqrt(1+8*n))/2, but works for large n
    Z = zeros(m,class(mat));
    if m>1
        Z(tril(true(m),-1)) = mat;
        Z = Z + Z';
    end
    Z(diag(true(1,m))) = 1;    
    vec = Z;
end