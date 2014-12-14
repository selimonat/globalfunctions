function PolarBarPlot(theta,rho,cdata,diameter,labels)
%PolarBarPlot(theta,rho,cdata,diameter,labels)
%
% Generates a polar bar plot by drawings bars with height THETA (in radians) at angles
% RHO. CDATA is a column vector of RGB values. CDATA can be either one
% single column or a matrix [3xN] where N is the size of theta. Flat lines
% are drawn at DIAMETER. LABELS is a cell
% array of size N, representing a label for each bar. DIAMETER and LABEL
% might be left, [] or '', respectively if not wanted.
%
% sonat, 2014

outer  = 0;%turn it to 1 to make have a outer circle.
spikes = 0;
% spikes that are emanating from the center
spike_lw   = 1;%linewidth
spike_ls   = '--';%linestyle
%% get the negative values shifted so that min is 0
mini = -5;
% mini       = min(rho);
rho        = rho - mini;
%%
% transform angle and height to patch friendly coordinates, each value pair
% will now define a triangle. First transform centers (theta) to edges.
bin_size   = deg2rad(MinimumAngle(rad2deg(theta),rad2deg(circshift(theta,[0 1]))))/2;%distance between
bin_edge   = theta + bin_size;
bin_edge   = [bin_edge;circshift(bin_edge,[0 1])];
%% now go to the cartesian coordinates,
%  each column represents the coordinates of a triangle with peak directed
%  to the center
yy = repmat(rho,size(bin_edge,1),1).*sin(bin_edge);
xx = repmat(rho,size(bin_edge,1),1).*cos(bin_edge);
yy = [zeros(1,size(yy,2)) ; yy ; zeros(1,size(yy,2))];
xx = [zeros(1,size(yy,2)) ; xx ; zeros(1,size(yy,2))];

L  = max(sqrt(xx(2,:).^2 + yy(2,:).^2))*1.25;
%% use same colour if only one is provided
if size(cdata,2) == 1
    cdata = repmat(cdata,1,size(yy,2));
end
%% plot the triangles and get a handle
for nbin = 1:size(xx,2)
    patch(xx(:,nbin),yy(:,nbin),cdata(:,nbin)','linestyle','none','edgecolor','none');
    %     elseif strcmp(method,'line')
    %         plot(xx([2 3],nbin),yy([2 3],nbin),varargin{:})
    %         PlotTransparentLine(xx([2 3],nbin),yy([2 3],nbin),.9,'k',varargin{:});
    %         line(xx(:,nbin),yy(:,nbin),'color','k',varargin{:});
    %     elseif strcmp(method,'axes')
    %         PlotTransparentLine( [0 L*cos(bin_edge(1,nbin))]' , [0 L*sin(bin_edge(1,nbin))]',1,'k','linestyle','-.')
    %     elseif strcmp(method,'circle')
    hold on
end
%% draw the spikes
if spikes
    for nbin = 1:size(xx,2)
        line( [0 L*cos(bin_edge(1,nbin))]' , [0 L*sin(bin_edge(1,nbin))]','linestyle',spike_ls,'color','k','linewidth',spike_lw )
    end
end
%% draw the circles
for d= diameter-mini
    dummy = linspace(0,2*pi,1000);
    x     = d*cos(dummy);
    y     = d*sin(dummy);
    line(x,y,'color',[.2 .2 .2],'linewidth',spike_lw )
end
%% draw finally the outer circle
if outer
    dummy = linspace(0,2*pi,1000);
    x = L*cos(dummy);
    y = L*sin(dummy);
    line(x,y,'color','k','linewidth',spike_lw,'linestyle',spike_ls)
end
%% draw the arbitrary curve if it is given

%% drawn the labels
for nlabel = 1:length(labels)
    x = L*1.05*cos(theta(nlabel));
    y = L*1.05*sin(theta(nlabel));
    text(x,y,labels{nlabel},'fontsize',30,'horizontalalignment','center')
end
%%
axis square
axis equal
axis off
hold off;
