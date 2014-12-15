function [r]=RandomSkewers(B,T,tbs)
%[r]=RandomSkewers(B,T,tvs)
%
%   Computers the distribution of correlation coefficients following random
%   skewer analysis for testing the similarity of covariance matrices B and T.
%
%   
%   1. Cheverud, J. M., J. J. Rutledge, and W. R. Atchley. 1983. Quantitative
%   genetics of development: Genetic correlations among age-specific trait
%   values and the evolution of ontogeny. Evolution 37:895-905.

%   2. Cheverud, J. M. 1996. Quantitative genetic analysis of cranial
%   morphology in the cotton-top (Saguinus oedipus) and saddle-back S.
%   fuscicollis) tamarins. J. Evol. Biol. 9:5-42.
%
%
%   See also, RandomSkewersAnalysis, RandomSkewersAnalysisPlot

r = NaN(1,tbs);
t = size(B,1);

for bs = 1:tbs
    %
    rs        = rand(t,1);
    i         = randsample(t,4);
    rs(i)     = -rs(i);
    rs        = rs./norm(rs);
    r(bs)     = corr2(B*rs,T*rs);
    r(bs)     = sqrt(sum((B*rs - T*rs).^2));
    %
%     r(bs)
%     plot(B*rs);hold on;plot(T*rs,'r');plot(rs,'g');hold off
%     pause;
end