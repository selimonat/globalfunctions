function PlotCorrMat(c,v)
%%
R = c;
G = 1-c;
B = zeros(size(c));

CM = cat(3,R,G,B);
CM = rgb2hsv(CM);
%
CM(:,:,3) =  v;
CM        = hsv2rgb(CM);
%
imagesc(CM)
