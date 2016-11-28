function [cmat] = getcorrmat(amp_circ,amp_gau,amp_const,amp_diag)
%[cmat] = getcorrmat(amp_circ,amp_gau,amp_const);
%
% computes a covariance matrix based on circular, gaussian, constant and
% diagonal contributions.



% 
x    = [pi/4:pi/4:2*pi];
% 
w    = [amp_circ*cos(x);...
        amp_circ*sin(x);...%circular components
        make_gaussian1d(x-pi-deg2rad(22.5),amp_gau,2,0);...%gaussian component
        -ones(1,8)*amp_const; ...%constant component.
        diag(ones(1,8))*amp_diag];%diagonal component
cmat = w'*w;
% cmat = corrcov(cmat);
    
% x       = [pi/4:pi/4:2*pi]';
% basis   = [cos(x)   sin(x)   make_gaussian1d(x-pi,2,4,0) -ones(8,1) diag(ones(1,8))*amp_diag];
% weights = [amp_circ amp_circ amp_gau                      amp_const repmat(amp_const,1,8)];
% cmat    = (basis*diag(weights)*basis');  
% cmat    = corrcov(cmat);
% cmat    = cmat.^2;


% basis   = basis*diag(weights);
% basis2  = basis./repmat(sqrt(sum(basis.^2,2)),1,size(basis,2));
% cmat    = basis2*basis2';

% cmat    = (basis*diag(weights)*basis');

%%
% weights = [ 40 40 51 ];
% weights = [amp_circ amp_circ amp_gau ];
% basis   = [cos(x) sin(x) make_gaussian1d(x-pi,amp_gau*2,2,0) ];
% basis   = basis*diag(weights);
% basis2  = basis./repmat(sqrt(sum(basis.^2,2)),1,3);
% cmat    = basis2*basis2';
% subplot(1,3,1);imagesc(basis2*basis2');colorbar
% subplot(1,3,2);plot(basis2);hold on;
% subplot(1,3,3);imagesc(CancelDiagonals( corrcoef(basis2(:,1:3)),NaN),[-1 1]);colorbar;