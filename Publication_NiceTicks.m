function Publication_YTicks(h,varargin)
%Publication_NiceTicks(h,varargin)
%Publication_NiceTicks(h,t_div)
%
%T_DIV is the number of divisions across the ylim OR between 0 zero
%max(ylim). T_DIV of 3 will divide the ylim into 3 segments. If ylim is 0
%to 15, the ticks will be drawn at 0, 5, 10 and 15. If not provided, an
%attempt to use the minimal number of ticks is made.
%
%The recommended way for running is this is following Publication_Ylim.
%
%See also Publication_Ylim

mini = min(ylim);
maxi = max(ylim);

if nargin == 2
    t_div = varargin{1};
end

if mini < 0 & maxi > 0 %if the range includes zero, we would like our y-ticks to include it too.
    %either use T_DIV to divide ylim or find the biggest divisor.
    if nargin == 2
        jump   = maxi/t_div;
    else       
        jump    = GetBiggestDivisor(maxi);
    end    
    yticks = 0:jump:maxi;    
    yticks = [fliplr(0:-jump:mini) yticks(2:end)];
else
    %either use T_DIV to divide ylim or find the biggest divisor.
    if nargin == 2
        jump   = range(ylim)/t_div;
    else       
        jump    = GetBiggestDivisor(range(ylim));
    end    
    yticks = mini:jump:maxi;
end
%
Y     = RemoveLeadingZeroForTickLabels(yticks);

set(h,'ytick',yticks,'YTickLabel',Y);