addpath('/home/onat/Documents/Code/C++/cmdstan-2.12.0/');
addpath('/home/onat/Documents/Code/Matlab/MatlabProcessManager/');
addpath('/home/onat/Documents/Code/Matlab/MatlabStan/')
%%
T       = 50;
t       = [1:T]';
x       = deg2rad([-135:45:180]');
offset  = linspace(10,10,T)';
amp     = linspace(10,10,T)';
kappa   = logspace(-2,1.4,T)';
sigma_y = repmat(.01,1,50);
y       = [];
for ti = 1:T
    %y(ti,:) = [offset(ti) + amp(ti)*exp(-(x/sd(ti)).^2) + randn(8,1)*sigma_y(ti)]';
    y(ti,:) = VonMises(x,amp(ti),kappa(ti),0,offset(ti)) + randn(8,1)*sigma_y(ti);    
end
imagesc(y)
%% ok estimate initial values with MLE
data.y           = y;
data.x           = repmat(x(:)',size(data.y,1),1);
data.ids         = t
t2               = Tuning(data);
t2.visualization = 0;
t2.gridsize      = 10;
nfun             = 5;
t2.SingleSubjectFit(nfun);
init.amp         = t2.fit_results{nfun}.params(:,1);
init.kappa       = t2.fit_results{nfun}.params(:,2);
init.offset      = min(15,t2.fit_results{nfun}.params(:,3));
init.sigma_y     = mean(t2.fit_results{nfun}.params(:,4));
%%
cd ~/Documents/Code/StanModelsMatlab/FitVonMises/
fit = FitVonMises_stan(x,y,t,'iter',50000,'chains',4,'init',init);
%%
figure;
subplot(3,4,1);
plot(offset,median(fit.extract.offset),'o');xlabel('true');ylabel('fitted')
DrawIdentityLine(gca);title('offset')
subplot(3,4,2);
plot(amp,median(fit.extract.amp),'o');
DrawIdentityLine(gca);;xlabel('true');ylabel('fitted');;title('amp')
subplot(3,4,3);
plot(log(kappa),log(median(fit.extract.kappa)),'o');
DrawIdentityLine(gca);;xlabel('true');ylabel('fitted');;title('kappa')
subplot(3,4,4);
plot(sigma_y,median(fit.extract.sigma_y),'o');
;xlabel('true');ylabel('fitted');;title('sigma noise')
%
subplot(3,4,5);
D = abs(offset(:)'-median(fit.extract.offset))
plot(D,'o');
title(sprintf('%3.5g',mean(D)))
subplot(3,4,6);
D = abs(amp(:)'-median(fit.extract.amp));
plot(D,'o');
title(sprintf('%3.5g',mean(D)))
subplot(3,4,7);
D = abs(log(kappa(:))'-log(median(fit.extract.kappa)));
plot(D,'o');
title(sprintf('%3.5g',mean(D)))
subplot(3,4,8);
D = abs(sigma_y(:)'-median(fit.extract.sigma_y));
plot(D,'o');
title(sprintf('%3.5g',mean(D)))
%
subplot(3,4,9)
imagesc(squeeze(median(fit.extract.y_new)),[10 20]);colorbar
title('median')
subplot(3,4,10)
imagesc(squeeze(mean(fit.extract.y_new)),[10 20]);colorbar
title('mean')
subplot(3,4,11)
imagesc(squeeze(mode(fit.extract.y_new)),[10 20]);colorbar
title('mode')
subplot(3,4,12)
imagesc(y,[10 20]);colorbar
title('data');

%% play around with Gaussian process

y      = (z);%z is coming GaussianProcessTutorial.m, but generally I was pretty unsuccesul on fitting this.
x      = linspace(0,1,50); 
data.x = x;
data.N = length(x);
data.y = y;
clear fit;
fit    = stan('file','gp-fit.stan','data',data,'verbose',true,'iter',500);
%% let's fit a random walk model.

T       = 50;
t       = [1:T]';
x       = deg2rad([-135:45:180]');

sigma_y  = repmat(.01,1,50);
clear amp offset kappa;
offset(1)  = 10;
amp(1)     = 10;
kappa(1)   = 1;

doffset  = [0 randn(1,T-1)]';
damp     = [0 randn(1,T-1)]';
dkappa   = [0 randn(1,T-1)]';

y       = [];
for ti = 1:T
    %y(ti,:) = [offset(ti) + amp(ti)*exp(-(x/sd(ti)).^2) + randn(8,1)*sigma_y(ti)]';
    amp(end+1)    = amp(end)    + damp(ti);
    kappa(end+1)  = kappa(end)  + dkappa(ti);
    offset(end+1) = offset(end) + doffset(ti);
    y(ti,:) = VonMises(x,amp(end),kappa(end),0,offset(end)) + randn(8,1)*sigma_y(ti);    
end
imagesc(y);colorbar;



