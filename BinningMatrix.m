function [BM,centers]=BinningMatrix(ttrial,tbin,binsize)
%[BM]=BinningMatrix(ttrial,tbin,binsize)
%
%   Will generate Toeplitz-like matrix with can be used for temporal
%   binning into TBINS, a time series with a total of TTRIALS. The sum
%   along columns and rows is exactly constant.
%
%   This is useful in cases where, say a total of 34 trials are recorded.
%   Binning this data into equal number of bins trials within each bin is
%   not possible. This BM will make it for you ;).
%
%   If there are 3 input arguments, the BM is a sliding averager matrix.

if nargin == 2
    edges    = linspace(0,ttrial,tbin+1);
    M        = [0:tbin;edges;round(edges) ; edges - floor(edges)];
    %
    last_bin = 1;
    BM       = zeros(ttrial,tbin);
    for ntrial = 1:ttrial
        current_bin                           = max(find(M(2,:) < ntrial));
        BM(ntrial,current_bin)                = 1;
        if current_bin ~= last_bin
            BM(ntrial,[last_bin current_bin]) = [ M(4,current_bin) 1-M(4,current_bin)];
        end
        last_bin                              = current_bin;
    end
    BM      = BM./repmat(sum(BM),size(BM,1),1);
    centers = ([1:size(BM,1)]-.5)*BM;
    
elseif nargin == 3
    %%    
    centers  = linspace(binsize/2,ttrial-binsize/2,tbin);
    BM       = zeros(ttrial,tbin);    
    %%
    for nc = 1:length(centers)        
        BM( (ceil(centers(nc)-binsize/2):floor(centers(nc)+binsize/2-1))+1 , nc) = 1;        
        if ~mod(centers(nc),.5) == 0
            BM( floor(centers(nc)-binsize/2)+1,nc)  = ceil(centers(nc)-binsize/2) - (centers(nc)-binsize/2);
            BM( ceil(centers(nc)+binsize/2),nc)     = (centers(nc)+binsize/2)     - floor(centers(nc)+binsize/2);
        end
    end  
end
