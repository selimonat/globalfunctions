function [mini]=EqualizeSubPlotYlim( FigInd, varargin)
%[mini]=EqualizeSubPlotYlim( FigInd, varargin)
%
%
%
%For a given figure, it equalizes the y-axis boundaries of all the subplots
%that are drawn. VARARGIN might be used to select a subset of subplots to
%apply the function. VARARGIN has to be axe handle, you can get them via
%all = findall(FigInd,'type','axes').
%
%Selim, 13-May-2012 17:37:14
%Selim, 24-Jul-2013 17:20:04 possibility to equalize only a subset of
%subplots


%detect which ones we would like to normalize
if nargin > 1    
    all = varargin{1};
else 
    all = findall(FigInd,'type','axes');
end
all = all(:)';
%
%
y   = [];
for i = all
    y = [y ; get(i,'ylim')];
end
%
mini = [min(y(:,1)) max(y(:,2))];
for i = all;
    set(i,'ylim',mini);    
end

