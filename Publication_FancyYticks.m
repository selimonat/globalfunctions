function Publication_YtickSize(h,varargin)
%Publication_yticks(h)
%
%

if nargin == 1
    ticksize = .1;
else
    ticksize = varargin{1};
end


for nh = 1:length(h)
    a = h(nh);
    pause(.2);    
    a.YAxis(1).LineWidth  = 1.5;
    a.YAxis(1).TickLength = [ticksize 0];   
end