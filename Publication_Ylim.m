function [ylim]=Publication_Ylim(h,varargin)
%[ylim]=Publication_Ylim(h,D,M)
%
%
% Will nicely move y-axis limits to nicely rounded numbers. It will round
% the Dth digit relative to the decimal comma to a multiple of M.
%
% D is an integer. 2 would round ylim to second decimal, such as 2.34 would
% become 2.35 (if M = 5). For 123.1212, D=0 would result in 125, D = -1
% in 150, and D = -2 in 500 when M is 5.
%
%
% Default values of D = 0 and M = 10.
%
% Publication_Ylim(h,0,5) round to 5.
%
% See also:
% Publication_NiceTicks
%
% SO

if nargin >= 2
    D = varargin{1};
else
    D = 0;
end

if nargin == 3
    M = varargin{2};
else
    M = 1;
end


D = 10^D;
%get ylim across all panels
for nh = 1:length(h)
    axis tight;
    x(nh,:) = get(h(nh),'ylim');%ylim 
end
%merge ylims
x = [min(x(:,1)) max(x(:,2))];
%find the required value
x = x*D;
x = [floor(x(1)/M)*M ceil(x(2)/M)*M ];%therefore the ylim will be a multiple of M
x = x/D;
%set the limit
for nh = 1:length(h)
    set(h(nh),'YLim',x);    
    get(h(nh),'ylim')
end


