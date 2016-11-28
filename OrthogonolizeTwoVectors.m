function [e,bestfit]=OrthogonolizeTwoVectors(e)

%[e]=OrthogonolizeTwoVectors(e);
%
%
%   Will orthogonalize two vectors A and B, where e = [A(:) B(:)], so that their correlation is
%   equal to zero. Will subtract from B, the best fitting part of A to B.



% fprintf('Correlations before orthonormalizing:\n');
% corrcoef(e)
%find the best fitting e1 to e2. 
beta    = [e(:,1) ones(size(e,1),1)]\e(:,2);
bestfit = e(:,1)*beta(1);
%
e(:,2)  = [e(:,2)-bestfit];
% fprintf('New correlations after orthonormalizing:\n');
% corrcoef(e)
