function [H]=GetSubplotHandles(fh)
%GetSubplotHandles(fh)
%
%   Will return axis handles present in a figure, possibly created using
%   subplot or not.
%
%   SO


h = get(gcf,'children');
H = [];
for nh = 1:length(h)
    if strcmp(get(h,'type'),'axes');
        H =[H h(nh)];
    end
end