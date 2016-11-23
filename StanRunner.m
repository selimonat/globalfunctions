T       = 50;
t       = [1:T]';
x       = deg2rad([-135:45:180]');
offset  = linspace(10,10,T)';
amp     = linspace(10,10,T)';
kappa   = logspace(-2,1.4,T)';
sigma_y = repmat(0,1,50);
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
t2.SingleSubjectFit(2);
init.amp         = t2.fit_results{2}.params(:,1);
init.std         = t2.fit_results{2}.params(:,2);
init.offset      = t2.fit_results{2}.params(:,3);
init.sigma_y     = t2.fit_results{2}.params(:,4);
%%
fit = FitVonMises_stan(x,y,t,'iter',500,'chains',4);
%%
figure;
subplot(3,4,1);
plot(offset,median(fit.extract.offset),'o');
DrawIdentityLine(gca);
subplot(3,4,2);
plot(amp,median(fit.extract.amp),'o');
DrawIdentityLine(gca);
subplot(3,4,3);
plot(kappa,median(fit.extract.kappa),'o');
DrawIdentityLine(gca);
subplot(3,4,4);
plot(sigma_y,median(fit.extract.sigma_y),'o');
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
D = abs(kappa(:)'-median(fit.extract.kappa));
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