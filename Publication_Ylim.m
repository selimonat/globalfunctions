function [ylim]=Publication_Ylim(h,varargin)
% [ylim]=Publication_Ylim(h,D,M)
%
%
% Will nicely move y-axis limits to nicely rounded numbers. It will round
% the Dth digit relative to the decimal comma to a multiple of M.
%
% D is an integer. 2 would round ylim to second decimal, such as 2.34 would
% become 2.35 (if M = 5). For 123.1212, D=0 would result in 125, D = -1
% in 150, and D = -2 in 500 when M is 5.
%
% Will also nicen y-ticks using Publication_NiceTicks.
%
% Default values of D = 0 and M = 10.
%
% Publication_Ylim(h,0,5) round to 5.
%
% See also:
% Publication_NiceTicks
%
% Selim

if nargin >= 2
    D = varargin{1};
else
    D = 0;
end

if nargin == 3
    M = varargin{2};
else
    M = 5;
end

axis tight;
D = 10^D;

x = get(h,'ylim');%ylim 
x = x*D;
x = [floor(x(1)/M)*M ceil(x(2)/M)*M ];%therefore the ylim will be a multiple of M
x = x/D;
%
set(h,'YLim',x);
ylim = x;


Publication_NiceTicks(h,M);
