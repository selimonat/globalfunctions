function [params]=RoughEstimator(x,y,funname,L,U)
%%[params]=RoughEstimator(x,y,funtype,L,U)
%
%   Will roughly estimate the parameters of a Gaussian or Gabor function
%   using a grid approach. Generally these initial estimates are a bit
%   slower compared to more heuristic approaches however they are nearly as
%   good as the result of the gradient descent which makes the optimization
%   use less iteration. X and Y are the data points and FUNTYPE follows the
%   convention in FitGauss.m and it works for either Gabor or Gaussian
%   functions. The estimation uses all the data points, not average at
%   given angles. L and U are the lower/upper bounds of the grid. Pay
%   attention that the argument orders corresponds to the function selected
%   by the funtype.
%
%   Selim Onat

grid = 35;
%%


%create a reportoire of Gaussians or Gabors.
if strcmp(funname,'gaussian_ZeroMean')
    %%
    g    = single(zeros(length(x),50*25));
    lut  = single(zeros(length(L)-1,size(g,2)));
    %
    amps      = linspace(L(1),U(1),grid*2);
    widths     = linspace(L(2),U(2),grid);
    %
    c       = 0;
    for amp = amps
        for width = widths
                c        = c+1;
                lut(:,c) = [amp;width];
                dummy    = make_gaussian_fmri_zeromean(x,amp,width);
                g(:,c)   = dummy;
        end
    end
    
elseif strcmp(funname,'gaussian')
    %%
    g    = single(zeros(length(x),50*25));
    lut  = single(zeros(length(L)-1,size(g,2)));
    %
    amps      = linspace(L(1),U(1),grid*2);
    widths     = linspace(L(2),U(2),grid);    
    baselines = linspace(L(3),U(3),grid);
    %
    c       = 0;
    for amp = amps
        for width = widths            
            for baseline = baselines
                c        = c+1;
                lut(:,c) = [amp;width;baseline];
                dummy    = make_gaussian_fmri(x,amp,width,baseline);
                g(:,c)   = dummy;
            end
        end
    end

elseif strcmp(funname,'gaussian_tau')
    %%
    g    = single(zeros(length(x),50*25));
    lut  = single(zeros(length(L)-1,size(g,2)));
    %
    amps       = linspace(L(1),U(1),grid*2);
    widths     = linspace(L(2),U(2),grid);        
    baselines  = linspace(L(3),U(3),grid);
    %
    c       = 0;
    for amp = amps
        for width = widths            
            for baseline = baselines
                c        = c+1;
                lut(:,c) = [amp;width;baseline];
                dummy    = make_gaussian_fmri_tau(x,amp,width,baseline);
                g(:,c)   = dummy;
            end
        end
    end    
    
    
elseif strcmp(funname,'vonmises')
    %%
    g    = single(zeros(length(x),50*25));
    lut  = single(zeros(length(L)-1,size(g,2)));
    %
    amps      = linspace(L(1),U(1),grid*2);
    widths     = logspace(L(2),U(2),grid);    
    baselines = linspace(L(3),U(3),grid);
    %
    c       = 0;
    for amp = amps
        for width = widths            
            for baseline = baselines
                c        = c+1;
                lut(:,c) = [amp;width;baseline];
                dummy    = make_gaussian_fmri_tau(x,amp,width,baseline);
                g(:,c)   = dummy;
            end
        end
    end    
    
        
    
    
elseif strcmp(funname,'gabor')
    %%
    grid = 15;
    g    = single(zeros(length(x),grid*grid*10*1*grid));
    lut  = single(zeros(length(L)-1,size(g,2)));
    %    
    amps      = linspace(L(1),U(1),grid);
    widths    = linspace(L(2),U(2),grid);
    freqs     = linspace(L(3),U(3),grid);
    baselines = linspace(L(4),U(4),grid);
    %
    c       = 0;
    for amp = amps
        for width = widths
            for freq = freqs;  
                for baseline = baselines;
                    c        = c+1;
                    lut(:,c) = [amp;width;freq;baseline];
                    dummy    = make_gabor1d_ZeroMean(x,amp,width,freq,baseline);
                    g(:,c)   = dummy;
                end
            end
        end
    end    

elseif strcmp(funname,'cosine')
    %%
    grid = 15;
    g    = single(zeros(length(x),grid*grid*10*1*grid));
    lut  = single(zeros(length(L)-1,size(g,2)));
    %
    amps       = linspace(L(1),U(1),grid);
    freqs      = linspace(L(2),U(2),grid);
    baselines  = linspace(L(3),U(3),grid);
    %
    c       = 0;
    for amp = amps
        for freq = freqs
            for baseline = baselines
                c        = c+1;
                lut(:,c) = [amp;freq;baseline];
                dummy    = amp*cos(x*freq)+baseline;
                g(:,c)   = dummy;       
            end
        end
    end
    
    
end


%%
res   = (sum( (g - repmat((y(:)),1,size(g,2))).^2 ));
[m i] = min(res);

params = double(lut(:,i));