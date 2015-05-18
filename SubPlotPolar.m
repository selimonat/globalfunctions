function [x y w]=SubPlotPolar(n)
%[x y w]=SubPlotPolar(n)
%
%
%Returns the subplot position coordinates for a polar organization of the
%subplots.
%
%Selim Onat, 15-May-2012 10:26:48



w = 1/n*1.2;
angles = deg2rad(linspace(0,360-360/n,n));
x      = 0.3*cos(angles)+0.5-w/2;
y      = 0.3*sin(angles)+0.5-w/2;
% % % figure;
% % % for i = 1:8    
% % %     subplot('position',[x(i) y(i) w w])    
% % % end