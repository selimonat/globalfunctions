function [t]=pval2asterix(p)
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

t = repmat('*',1,ceil(-log10([0.05 0.01 0.001])./-log10(.05)));