function [out] = make_gaussian_fmri_zeromean_time(x,amp,sd)
%[out] = make_gaussian_fmri_zeromean(X,amp,sd);
%
% This is the extended version of make_gaussian_fmri_zeromean to time
% domain. AMP and SD are not scalar but vectors representing the temporal
% evolution of the AMP and SD parameters. AMP and SD have to be the same
% size.
%
% This function might behave strangely if X doesn't span the -135 to 180
% range, expected in typical feargen situation.


amp = amp(:);
sd  = sd(:);
viz = 1;

if length(amp) == length(sd)
    
    d  = mean(diff(x));
    XT = length(x);
    
    for nt = 1:length(amp)
        out(nt,:) = amp(nt).*exp(-(x./sd(nt)).^2/2) - amp(nt)*sqrt(2*pi*sd(nt)^2)./d./XT;
    end
   
    if viz%enter visalization loop here.        
        ncurves = repmat([1:length(amp)],length(x),1);
        x       = repmat(x(:),1,length(amp));
        h = plot3(ncurves,x,out','k','linewidth',2);;        
        xlabel('time');
        ylabel('condition');
        zlabel('amplitude');
        zp = [0 0];
        xp = get(gca,'Xlim');
        yp = get(gca,'Ylim');
        % Use the axes x and Y limits to find the co-ordinates for the patch
        x1 = [ xp(1) xp(2) xp(2) xp(1)];
        z1 = ones(1,numel(x1))* 0;
        y1 = [ yp(1) yp(1) yp(2) yp(2)];
        v = patch(x1,y1,z1, 'g');
        set(v,'facealpha',.8,'edgealpha',.8);
        grid on
    end
    
else
    fprintf('Please enter the same number of parameters for AMP and SD...\n')
end