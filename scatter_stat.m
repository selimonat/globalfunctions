function [m]=scatter_stat(t,fields)


X = t.(fields{2});
Y = t.(fields{3});
Z = t.(fields{1});
transparency = .8;
Zsize = Scale(Z);

Cx     = linspace(-2,2,100);
Cy     = linspace(-2,2,100);
[x y]  = meshgrid(Cx,Cy);
%%

m1      = fitlm(t,[fields{1} '~ 1 + ' fields{2} '*' fields{3} ])   
m2      = fitlm(t,[fields{1} '~ 1 + ' fields{2} '+' fields{3} ])    

if m1.ModelCriterion.BIC < m1.ModelCriterion.BIC %better m1
    C      = m1.Coefficients.Estimate;
    Yhat   = [ones(length(x(:)),1) x(:) y(:) x(:).*y(:)]*[C(:)];
    m = m1;
else
    C      = m2.Coefficients.Estimate;
    Yhat   = [ones(length(x(:)),1) x(:) y(:)]*[C(:)];
    m =m2;
end
imagesc(Cx,Cy,reshape(Yhat,100,100));
hold on;
contour(Cx,Cy,reshape(Yhat,100,100),8,'color',[.4 .4 .4]);
%%
for np = 1:length(X)
    h                   = scatter(X(np),(Y(np)),1000,'filled','markerfacealpha',transparency);
    hold on;
    h.SizeData          = 50+(1+Zsize(np)*6).^4;
    h.MarkerFaceColor   = [Zsize(np) 1-Zsize(np) 0];
    h.MarkerEdgeColor   = 'k';
end
hold off;
xlabel(fields{2},'interpreter','none');
ylabel(fields{3},'interpreter','none');
axis xy;