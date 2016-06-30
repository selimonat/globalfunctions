function [fit,param]=fitcorrmat(cormat)
%[fit,param]=fitcorrmat(cormat)
%
% Will model a covariance matrix's parameters using gradient optimization
% approach. This function works together with getcorrmat,
% it knows their parameters. Initial parameters are randomly set within the
% range of cormat.
%
%
% PARAM(1:4) is [amp_circ amp_gau amp_const amp_diagonal].
%
%
% See also: getcorrmat


viz      = 0;%see the results or not
opt      = optimset('display','none','tolfun',10^-20,'tolx',10^-20,'maxfunevals',10000,'maxiter',10000);
Y        = cormat;

if ~any(isnan(Y(:)));%dont dive into shit
    cost_fun                           = @(param) sum((Y(:) - Vectorize(getcorrmat(param(1),param(2),param(3),param(4)))).^2);
    r                                  = range(Y(:));
    x0                                 = rand(1,4)*2*r-r;%random initialization of parameters;
    [param fval exitflag output]       = fminsearch(cost_fun,x0,opt);
    fit                                = getcorrmat(param(1),param(2),param(3),param(4));
    %
    if exitflag == 0;keyboard;end;%sanity check for convergence;
    if viz
        figure(10);imagesc([cormat fit cormat-fit]);colorbar;drawnow;%pause
    end    
else
    keyboard%sanity check, this should never happen.
end
