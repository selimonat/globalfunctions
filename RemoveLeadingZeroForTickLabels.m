function [Y]=RemoveLeadingZeroForTickLabels(yticks)
% [Y]=RemoveLeadingZeroForTickLabels(TickLabels)
%
%
% Removoes the leading zero from labels such that 0.91 -> .91. YTICKS is a
% cell array of tick labels.
%
%


Y = [];
for i = 1:length(yticks);
    Y{i} = round(yticks(i)*100)/100;
    if yticks(i) > 0
        Y{i} = regexprep(mat2str(Y{i}),'^0.','.');  
    else
        Y{i} = regexprep(mat2str(Y{i}),'^-0.','-.');   
    end
end