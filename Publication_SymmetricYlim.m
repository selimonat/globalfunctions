function Publication_SymmetricYlim(h);
%Publication_SymmetricYlim(h);
%
% Will change ylim property so that it is symmetrical around 0. H is a
% vector of axes handles.
%
% SO


for nh = 1:length(h)
    Y = get(h(nh),'ylim');
    if 0 > min(Y) & 0 < max(Y)
        set(h,'ylim',[-max(abs(Y)) max(abs(Y))]);
    end
end