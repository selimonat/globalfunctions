function [cmat,mask] = CorrelationMatrix( mat, ts,alpha,method)
%[cmat,mask] = CorrelationMatrix( mat, ts,alpha,method)
%
% MAT is data with different columns.
%
% METHOD == bootci
%
% will compute bootstrap confidence intervals using TS samples at ALPHA
% level. 
%
% METHOD == bootstrp, will compute bootstrap samples and will return the
% results as a 3D matrix, where 3rd dimension is samples.


mask    = [];
cmat = [];
if strcmp(method,'bootci')
    corrfun = @(X) 1-pdist(X', 'correlation' );
    data    = mat;
    dummy   = bootci(ts,{corrfun ,  data},'alpha',alpha,'type','bca');
    cmat    = squareform(corrfun(data));
    %detect entries where zero is not within the confidence interval
    mask    = squareform( (sum(dummy < 0) == 2)+(sum(dummy > 0) == 2) == 1);    
elseif strcmp(method,'bootstrp')
    if size(mat,2) == 2;
        corrfun = @(X) 1-pdist(X', 'correlation' );
        data    = mat;
        cmat    = bootstrp(ts,corrfun ,  data);        
    else
        fprintf('Using this option with more than 2 variables doesn''t make sense, divide into pairwise comparisons prior\n');
    end
end
%%
figure(100);clf
h = imagesc(cmat,[-1 1]);
hold on;
mask = double(mask);
mask(mask == 0) = .25;
colorbar
set(h,'AlphaData',mask);
hh=ImageWithText(cmat,cmat);
set(hh,'AlphaData',0);
hold on;
