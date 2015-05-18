function ColorWheel
%ColorWheel
%
%Creates a circular color wheel.

[y x] = meshgrid(linspace(-10,10,10000));
map = pi/2+(atan(x./y)) + repmat([ones(1,size(x,2)/2) zeros(1,size(x,2)/2)]*pi,size(x,1),1);
imagesc(map);
colormap(hsv(8));
axis image;
axis off;
SaveFigure('/Users/onat/Desktop/CW.png');