function [t]=pval2asterix(pval)
%
%   Generates asteriks strings based on the p-value
%
% 
% P value       Wording	Summary
%
% < 0.001       Very significant	***
% 0.001 to 0.01	Very significant	**
% 0.01 to 0.05	Significant         *
% ≥ 0.05        Not significant     ns

t =[];
if pval < 0.05 & pval >= 0.01
    repfac = 1;
elseif pval < 0.01 & pval >= 0.001
    repfac = 2;
elseif pval < 0.001
    repfac = 3;
else
    repfac = 0;
    t = sprintf('ns\n(%0.1g)',pval);
    return
end
t = repmat('*',1,repfac);