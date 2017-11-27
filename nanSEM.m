function [data_sem]=nanSEM(data)
%[data_sem]=nanSEM(data)
%
% Computes the SEM of matrix along the first dimension. Takes care of NaNs

data_sem = squeeze(nanstd(data,1,1)./sqrt(sum(isnan(data))));


