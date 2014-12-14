function DrawIdentityLine(h,varargin)
%DrawIdentityLine(gca)
%Draws an identity line to the figure GCA. VARARGIN is passed to the plot
%function so that if necessary the colour or other properties of the line
%can be set.
%
%
%Selim, 2005
subplot(h);%make the current plot current
[a] = [get(h,'xlim') get(h,'ylim')];
bla = linspace(min(a),max(a),100);
hold on
plot(bla,bla,varargin{:});
hold off