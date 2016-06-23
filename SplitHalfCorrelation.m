function [r]=SplitHalfCorrelation(X,classes)
%X is [dimensions,repetitions];
%Splits X into two halves and computes the correlation between halves.


tt = 1000;
P  = cvpartition(classes,'Holdout',0.50);
tclass = length(unique(classes));
r  = nan(tclass,tclass,tt);
t  = 0;
while t < tt
    t        = t + 1;
    P  = P.repartition;
    %%
    for c = unique(classes);
        i       = (classes == c)&P.test';
        Y1(:,c) = mean(X(:,i),2);
        i       = (classes == c)&P.training';
        Y2(:,c) = mean(X(:,i),2);
    end
    %%
    r(:,:,t) = Y1'*Y2;    
end
r = mean(r,3);