function f = supertitle(s,pos,varargin)
% SUPERTITLE 	makes a big title over all subplots
%
%	supertitle(S) writes the string S as a title
%	It returns the handle if you want it.
%
%	supertitle(S,pos) lets you specify a position be 0 and 1. Default is .95
%
% 1995,1996 Matteo Carandini
% part of the Matteobox toolbox

if nargin < 2, pos = 0.95; end

currax = gca;
axes('position',[.5 pos 0.1 0.1 ],'xcolor',[0 0 0],'visible','off');

if ~isempty(s)
	%f = text(0 , 0, s, 'units', 'normalized',...
	%	'verticalalignment','top','horizontalalignment','center' );
    f = text(0 , 0, s, 'units', 'normalized',...
		'verticalalignment','top','horizontalalignment','center',varargin{:} );
    
end
axes(currax);
