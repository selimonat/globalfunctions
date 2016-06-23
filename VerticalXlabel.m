function VerticalXlabel(labels,varargin);
%VerticalXlabel(label);
%
%Plots vertically oriented x tick labels.
%LABELS is a cell array containing the labels. VARARGIN fed to text
%function. Make sure that the number of labels in LABELS and the number of
%ticks in the figure are same.
%
%TODO : the position is always above the plot, this could be optionalized
%in later version
%
%
%Selim 2006,Nov 16


tlabels  = length(labels);
set(gca,'xtick',1:tlabels);
tickpos = get(gca,'xtick');
for c = 1:length(labels);
    text(tickpos(c),0.05,labels{c},'rotation',90,varargin{:});
end
%remove the xlabel so there is no embombrement
set(gca,'xticklabel',[]);