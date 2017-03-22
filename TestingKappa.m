%%
X = (linspace(-135,180,8));
y = [];
kappas = linspace(0,20,100)
% kappas = logspace(-4,1.5,100);
[fwhms ] = vM2FWHM(kappas);
for n = kappas    
    y = [y;Tuning.VonMises(X,2,n,0,0)];
end;
clf;
figure(1);clf;
contourf(X,kappas,[NaN(1,size(y,2));diff(y)],10);
axis xy
% set(gca,'yscale','log')
figure(2);clf;
contourf(X,kappas,(y),10);axis xy
%  set(gca,'yscale','log')
figure(3);clf;%this figure shows that a kappa of 10 or 15 consists of nearly identical curves, whereas a change of +5 has a much higher impact when on 1 to 6.
plot((kappas(2:end)),mean(abs(diff(y)),2),'o-');
xlabel('kappa');
ylabel('average absolute change');

figure(4);clf;%this figure shows that a kappa of 10 or 15 consists of nearly identical curves, whereas a change of +5 has a much higher impact when on 1 to 6.
plot((fwhms(2:end)),mean(abs(diff(y)),2),'o-');
xlabel('fwhms');
ylabel('average absolute change')

%%
X = (linspace(-135,180,8));
y = [];
kappas=linspace(0,100,100);
for n = kappas
    y = [y;Tuning.VonMises(X,2,n,0,0)];
end;
clf;
figure(1);clf;
contourf(X,kappas,[NaN(1,size(y,2));diff(y)],10);
axis xy
% set(gca,'yscale','log')
figure(2);clf;
contourf(X,kappas,(y),10);axis xy
% set(gca,'yscale','log')
%%
X = (linspace(-135,180,8));
y = [];
kappas=linspace(20,180,100)
for n = kappas
    y = [y;exp(-((X/n).^2))];    
end;
clf;
figure(1);clf;
contourf(X,kappas,[NaN(1,size(y,2));diff(y)],10);
axis xy
set(gca,'yscale','log')
figure(2);clf;
contourf(X,kappas,(y),10);axis xy
set(gca,'yscale','log')
%%
%%
X = (linspace(-135,180,8));
y = [];
kappas=logspace(-4,1.5,100);
kappas=linspace(0,20,100);
for n = kappas    
    y = [y;Tuning.VonMises(X,2,n,0,0)];
end;
clf;
figure(1);clf;
plot((kappas(2:end)),mean(abs(diff(y)),2),'o-')