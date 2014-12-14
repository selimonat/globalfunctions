function PlotTransparentLine(x,y,alpha,color,varargin) 
%PlotTransparentLine(x,y,alpha,color) 


x  = x(:)';
x  = [x fliplr(x)];
for n = 1:size(y,2);        
    yflip = [y(:,n)' fliplr(y(:,n)')];
    patch(x,yflip,'g','EdgeAlpha',alpha,'EdgeColor',color,'FaceColor','none',varargin{:});
end