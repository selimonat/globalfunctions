function [h]=hvfigure
%ffigure
% will create a new figure that is vertically half-screen 

ss = get(0,'ScreenSize');
h = figure('position',[ss(1:2) ss(3)/2 ss(4)])