function SetFearGenBarColors(h,varargin)
%SetFearGenBarColors(h,vargargin)
%
%   Changes color of the bars to circular HSV colorset. VARARGIN can be
%   used to set the colors to a specific value. These should RGB values for
%   each bar, that is nBar x 3 matrix.
%
%   See also: SetFearGenColors.



h     = get(h,'children');
tbar  = length(get(h,'YData'));
set(h,'CData', repmat(1:tbar,1,tbar/tbar),'edgecolor','none');
%
if nargin == 1
    color    = GetFearGenColors;    
    colormap(color(1:tbar,:));
else
    color    = varargin{1}';
    colormap(color);
end
