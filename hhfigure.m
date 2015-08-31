function [h]=hhfigure(fnum)
%hhfigure
% will create a new figure that is horizontally half-screen. FNUM is the
% figure window number and optional.


if nargin > 0
    h=figure(fnum);
else
    h=figure;
end
ss = get(0,'ScreenSize');
set(h,'position',[ss(1:2) ss(3) ss(4)/2]);