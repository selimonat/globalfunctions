function plot_basis(M,varargin)
%plot_basis(M,varargin)
%plots columns of M as vectors originating from (0,0).
%shows the transformation of M as a quiver plot.
%VARARGIN = color of the vectors



%%
c= [0 0 0];
if ~isempty(varargin)
    c = varargin{1};
end
for i = 1:size(M,2)   
    x = M(:,i)';
    arrow([0,0],x,'color',c,'linewidth',3)
    hold on;
end
R = 2;
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2],'xgrid','on','ygrid','on','fontsize',25);
axis equal;
box off
%%
delta = .5;
[x,y] = meshgrid(-R:delta:R,-R:delta:R);
x     = x(:);
y     = y(:);
Y     = M*[x y]';
Y2    = inv(M)*[x y]';
for i = 1:length(x)
    plot(x(i),y(i),'k+','markersize',3)
    arrow([x(i),y(i)],Y(:,i),'length',2,'color','r')
    arrow([x(i),y(i)],Y2(:,i),'length',2,'color','k')
end
hold off
xlim([-R,R]);
ylim([-R,R]);

