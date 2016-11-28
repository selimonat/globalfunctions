function [fit,param]=fitcorrmat(cormat,method)
%[fit,param]=fitcorrmat(cormat)
%
% Will model a covariance matrix's parameters using a grid search
% approach (default method). This function works together with getcorrmat,
% it knows their parameters. The alternative method uses gradient descent
% (method = 'gradient').
%
% PARAM is [amp_circ amp_gau amp_const amp_diagonal].
%
% See also: getcorrmat


if nargin == 1
    method == 'grid'
end

if strcmp(method,'grid');
    r = range(cormat(:));
    ts = size(cormat,3);%total subjects
    res        = 50;
    amp_circs  = linspace(0,r*2,res);
    amp_gaus   = linspace(0,r*2,res);
    amp_consts = linspace(0,r*2,res);
    amp_diags  = linspace(0,r*2,res);
    error      = nan(ts,res.^4);
    lut        = nan(4,res.^4);
    c          = 0;
    for amp_circ = amp_circs
        fprintf('%4.4g percent finished.\n',amp_circ./max(amp_circs)*100);
        for amp_gau = amp_gaus
            for amp_const = amp_consts
                for amp_diag  = amp_diags
                    c        = c + 1;
                    for ns = 1:size(cormat,3)
                        lut(:,c)    = [amp_circ amp_gau amp_const amp_diag];%look up table for parameter values
                        error(ns,c) = sum((Vectorize(cormat(:,:,ns)) - Vectorize(getcorrmat(amp_circ,amp_gau,amp_const,amp_diag))).^2);
                    end
                end
            end
        end
    end
    
    %collect the optima per subject
    for ns = 1:ts
        [~,i]       = min(error(ns,:));
        if ~any(isnan(error(ns,:)))
            param(:,ns) = [lut(1,i) lut(2,i) lut(3,i) lut(4,i)];
            fit(:,:,ns) = getcorrmat(param(1,ns),param(2,ns),param(3,ns),param(4,ns));
            %     imagesc([cormat fit cormat-fit]);colorbar;
            %     drawnow;
        else
            param(:,ns) = NaN;
            fit(:,:,ns) = NaN;
        end
    end
    
elseif strcmp(method,'gradient')
    ts       = size(cormat,3);
    param    = nan(4,ts);
    fit      = nan(8,8,ts);
    opt      = optimset('display','none','tolfun',10^-16,'tolx',10^-16,'maxfunevals',10000,'maxiter',10000);    
    for ns = 1:ts%run across subjects
        Y                                      = cormat(:,:,ns);%data for this subject
        if ~any(isnan(Y(:)))%dont dive into shit
            cost_fun                           = @(param) sum((Y(:) - Vectorize(getcorrmat(param(1),param(2),param(3),param(4)))).^2);
            r = range(Y(:));
            x0                                 = [.5 .5 .5 .5];%random initialization of parameters;
            [param(:,ns) fval exitflag output] = fminsearch(cost_fun,x0,opt);
            param(1,ns)  = abs(param(1,ns));
            if exitflag == 0
%                 keyboard
            end
            fit(:,:,ns)                        = getcorrmat(param(1,ns),param(2,ns),param(3,ns),param(4,ns));
            %%
%             figure(10);subplot(1,2,1)
%             imagesc([CancelDiagonals(cormat(:,:,ns),NaN) CancelDiagonals(fit(:,:,ns),NaN) CancelDiagonals(cormat(:,:,ns)-fit(:,:,ns),NaN)]);colorbar;drawnow;
%             subplot(1,2,2)
%             bar(param(1:2,ns));
%             pause            
        end
    end
end