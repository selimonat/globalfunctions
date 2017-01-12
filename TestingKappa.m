%%
X = deg2rad(linspace(-135,180,8));
y = [];
kappas=logspace(-4,2.5,100);
for n = kappas    
    y = [y;VonMises(X,2,n,0,0)];
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
X = deg2rad(linspace(-135,180,8));
y = [];
kappas=linspace(10^-4,10^2.5,100);
for n = kappas
    y = [y;VonMises(X,2,n,0,0)];
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
kappas=linspace(20,120,100)
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