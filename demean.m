function [x]=demean(x)

x = x - repmat(mean(x),size(x,1),1);