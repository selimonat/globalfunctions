function subplotChangeSize(h,W,H)
%subplotChangeSize(h,W,H)
%
%Increases/Decreases the size of the subplot handled by H by an amount
%determined by W and H. It keeps the center position the same.
%
%Selim, 06-Mar-2009 18:13:33


pos = get(h,'position');
set(h,'position',[pos(1)-W/2 pos(2)-H/2 pos(3)+W pos(4)+H]);