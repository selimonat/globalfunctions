function [o] = FitGauss(X,Y,funtype)
%there should be no NaN values on the X and Y vectors.


%%
%addpath('/Users/onat/Documents/LabComputer/onat/Documents/Code/Matlab/DERIVESTsuite/');
visualization = 1;
%% make sure we have columns
X        = X(:);
Y        = Y(:);
CONSTANT = 0;%will be add to all the data points 

%% x-axis, original and upscaled
xs      = sort(unique(X));
o.xsup  = linspace(xs(1),xs(end),100);
o.xsori = linspace(xs(1),xs(end),8);
%%

%% set the function to be fitted
if funtype == 1
    o.fitfun = @(X,p) repmat(p(1),length(X),1);
    o.L      = [ min(Y)  0];%mean sigma
    o.U      = [ max(Y)  2*std(Y)];
    o.dof    = 1;  
    o.funname= 'null';
elseif funtype == 2
    
    o.fitfun = @(X,p) make_gaussian_fmri(X,p(1),p(2),p(3));%2 amp, std, offset
    o.L      = [-range(Y)*2    0       mean(Y)-range(Y)*2          .01    ];
    o.U      = [range(Y)*2     20      mean(Y)+range(Y)*2    std(Y(:)+rand(length(Y),1).*eps)*2 ];%
    o.dof    = 3;
    o.funname= 'gaussian';       
 
elseif funtype == 3
    
    o.fitfun = @(X,p) make_gaussian_fmri_zeromean(X,p(1),p(2));%2 amp fwhm
    o.L      = [ -range(Y)*2  0     .01    ];
    o.U      = [  range(Y)*2  20       std(Y(:)+rand(length(Y),1).*eps)*2 ];  
    o.dof    = 3;
    o.funname = 'gaussian_ZeroMean';    
    %detect the mean, store it and subtract it
    CONSTANT = mean(Y);
    Y        = Y-CONSTANT;%we are not interested in the baseline, just remove it so we don't need to estimated it.    

elseif funtype == 4
    
    o.fitfun = @(X,p) make_gaussian_fmri_tau(X,p(1),p(2),p(3));%amp, tau, offset
    o.L      = [-range(Y)*2    0    mean(Y)-range(Y)*2          .01    ];
    o.U      = [range(Y)*2     20  mean(Y)+range(Y)*2    std(Y(:)+rand(length(Y),1).*eps)*2 ];
    o.dof    = 3;
    o.funname= 'gaussian_tau';       
       
elseif funtype == 5
    o.fitfun = @(X,p) VonMises_fmri(X, p(1), p(2), p(3));
    o.L      = [ -range(Y)*2  10.^-16  mean(Y)-range(Y)*2   0];%amp kappa offset
    o.U      = [  range(Y)*2  20       mean(Y)+range(Y)*2   std(Y)];
    o.dof    = 3;
    o.funname= 'vonmises';

elseif funtype == 6
    o.fitfun = @(X,p) make_gabor1d_ZeroMean(X,p(1),p(2),p(3),p(4));%amp std freq baseline
    o.L      = [ -range(Y)*2  0    1  -range(Y)*2    .01    ];
    o.U      = [  range(Y)*2  20   4   range(Y)*2  std(Y(:)+rand(length(Y),1).*eps)*2 ];  
    o.dof    = 6;
    o.funname= 'gabor';
elseif funtype == 7
    o.fitfun = @(X,p) p(1)*cos(X*p(2)) + p(3);%amp std freq baseline
    o.L      = [ -range(Y)*2  1  -range(Y)*2    .01    ];
    o.U      = [  range(Y)*2  4   range(Y)*2 std(Y(:)+rand(length(Y),1).*eps)*2 ];  
    o.dof    = 3;
    o.funname= 'cosine';    
    
end
%% set the objective function

o.funny  = @(params) sum(-log( normpdf( Y - o.fitfun( X, params(1:end-1)) , 0,params(end)) ));

%% Initial estimattion of the parameters

%if gabor or gaussian, make a grid-estimatation
if funtype > 1
           o.Init = RoughEstimator(X,Y,o.funname,o.L,o.U)';
%     o.Init = GaussianEstimate(X,Y);
else %null model
    o.Init = mean(Y);
end
%
%% once we have the rough parameter values, create a sigma grid, and
% estimate the sigma as well.
tsample = 10000;
sigmas  = linspace(0.001,std(Y)*3,tsample);
% % c       = nan(1,tsample);
% % for i = 1:tsample;
% %     c(i) =  o.funny([o.Init sigmas(i)]);
% % end
% % [m i]  = min(c);

%% alternative method: based on the likelihood of sigma given the data points assuming a Gaussian normal distribution.
PsigmaGiveny = sigmas.^-length(Y) .* exp( - (1./(2.*sigmas.^2) ) .* sum((Y - o.fitfun(X,o.Init)).^2) );
[m i]        = max(PsigmaGiveny);
%%
o.Init   = [o.Init sigmas(i)];
o.U(end) = o.Init(end)*10;
%
%% Optimize!
%fmincon is preferable as it minimizes the function and not its square
%as lsqnonln etc...

%set optim options
options         = optimset('Display','none','maxfunevals',10000,'tolX',10^-12,'tolfun',10^-12,'MaxIter',10000,'Algorithm','interior-point');
[o.Est, o.Likelihood, o.ExitFlag]  = fmincon(o.funny, o.Init, [],[],[],[],o.L,o.U,[],options);

null.fitfun     = @(X,p) repmat(p(1),length(X),1);
null.L          = [ min(Y)  0];%mean sigma
null.U          = [ max(Y)  2*std(Y)];
null.Init       = o.Init;
null.funny      = @(params) sum(-log( normpdf( Y - null.fitfun( X, params(1:end-1)) , 0,params(end)) ));
Y               = Y + rand(size(Y))*eps;
null.Likelihood = [];
try
    [null.Est, null.Likelihood, null.ExitFlag]  = fmincon(null.funny, [mean(Y) std(Y)], [],[],[],[], null.L , null.U , [], options);
end

% % 
% % 
% % 
% % [o2{1}.Est, o2{1}.Likelihood, o2{1}.ExitFlag]   = fminsearch(o.funny, o.Init, options);
% % o2{1}.fit                                       = o.fitfun( o.xsori  , o2{1}.Est)+CONSTANT;%add the mean we subtracted
% % o2{1}.fitup                                       = o.fitfun( o.xsup  , o2{1}.Est)+CONSTANT;%add the mean we subtracted
% % 
% options       = optimset('Display','none','maxfunevals',10000,'tolX',10^-12,'tolfun',10^-12,'MaxIter',10000);
% o.fitfun2                           = @(p,X) o.fitfun(X,p);
% [o.Est, o.Likelihood, o.ExitFlag]   = lsqcurvefit(o.fitfun2, o.Init(1:end-1), X(:)', Y(:)',[],[],options);
% [o.Est, o.Likelihood, o.ExitFlag]   = lsqcurvefit(o.fitfun2, o.Est , X(:)', Y(:)',[],[],options);
% % 
% % o2{2}.fit               = o.fitfun( o.xsori  , o2{2}.Est)+CONSTANT;%add the mean we subtracted
% % o2{2}.fitup                                       = o.fitfun( o.xsup  , o2{2}.Est)+CONSTANT;%add the mean we subtracted

%% Compute a residual
%This is the RMS differences between the model and data points...
o.residuals     = Y-o.fitfun(X,o.Est);
o.ss_Residual   = sqrt(mean((Y-o.fitfun(X,o.Est)).^2));
%Compute the Hessian and SEM, SEMs computed from the Hessian are mainly
%useless, especially in the case of FWHM parameters...
%o.Hess       = hessian(o.funny,o.Est);
%o.sem_Hess   = sqrt(diag(inv(o.Hess)));
%Compute the univarite marjinal likelihood profile base Confidence Intervals
%
%% produce the fit with the estimated parameters
o.fit               = o.fitfun( o.xsori  , o.Est) + CONSTANT;%add the mean we subtracted
o.fit_init          = o.fitfun( o.xsup   , o.Init)+ CONSTANT;
% I am not sure adding the low-res MEAN to high-res fit is a 100% correct
% thing
o.fitup             = o.fitfun( o.xsup   , o.Est)+CONSTANT;

%% Get the likelihood
o.pval = NaN;
if ~isempty(null.Likelihood)
    dof     = o.dof - 1;%the DOF of the null hypothesis is 0.
    o.pval  = -log10(1-chi2cdf(-2*(o.Likelihood - null.Likelihood),dof) + eps);    
end

%% Visualization
if visualization
    c       = 0;
    tsub    = length(X)./8;%to compute SEM we need the number of subjects.
    for nx = xs(:)'%for each unique X variable compute a the average/std/sem values.
        c               = c+1;
        Y_ave(c)        = mean(Y(X==nx));
        Y_ave_trim(c)   = trimmean(Y(X==nx),5);
        Y_std(c,1)      = std(Y(X==nx));%will be used to plot errorbars
        Y_sem(c,1)      = Y_std(c,1)./sqrt(tsub);
    end
    figure(100);clf
    plot(o.xsup,o.fitup,'ro','linewidth',3);
    hold on
    plot(o.xsup,o.fit_init,'color',[.3 .3 .3],'linewidth',3);    
    errorbar(xs, Y_ave+CONSTANT, Y_sem, 'b'  ,'linewidth',3);
    hold off
    if funtype > 1
        title(sprintf('Likelihood: %03g',o.Likelihood));
    end
    drawnow;
    grid on;   
end
