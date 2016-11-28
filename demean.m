function [x]=demean(x)

x = x - repmat(nanmean(x),size(x,1),1);
