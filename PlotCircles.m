function p = PlotCircles(x, y, Diameter, col, alpha)
%p = PlotCircles(x, y, Diameter, col, alpha)
%
% PlotCircles: Plot circular circles of relative size circle
% Returns handles to all patches plotted. If Diameter has two entries than
% the first one is the width and the second the height. COL is color.

    % aspect is width / height
% % %     fPos = get(gcf, 'Position');
% % %     % need width, height in data values
% % %     xl = xlim();
% % %     yl = ylim();
% % %     %
% % %     w = circle*(xl(2)-xl(1))/fPos(3);
% % %     h = circle*(yl(2)-yl(1))/fPos(4);
    
    if length(Diameter) == 1
        Diameter(2) = Diameter(1);
    end

    %
    w = Diameter(1);
    h = Diameter(2);
    
    
    theta = 0:pi/15:2*pi;
    mx    = w*sin(theta);
    my    = h*cos(theta);
    num   = 0;
    %
    %
    for k = 1:length(x)
        for f = 1:length(y)
            num = num+1;
            p(num) = patch(x(k)+mx, y(k)+my, col, 'FaceColor', col, 'FaceAlpha', alpha, 'EdgeColor', 'none');
        end
    end
end