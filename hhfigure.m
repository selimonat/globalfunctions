function [h]=hhfigure
%ffigure
% will create a new figure that is horizontally half-screen 

ss = get(0,'ScreenSize');
h = figure('position',[ss(1:2) ss(3) ss(4)/2])