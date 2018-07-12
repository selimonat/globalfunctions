function tiles = RectMatrix(delta,space,col,total)
% Computes a matrix of RECTS for PTB.
%
% Returns TOTAL rects with size DELTA and spacing SPACE, organized in a
% matrix of COL columns
%
% Selim Onat



tiles = [];
for i = 0:total-1        
    tiles = [tiles;[(space+delta)*mod(i,col)  (space+delta)*floor(i/col)  delta+(space+delta)*mod(i,col) delta+(space+delta)*floor(i/col)]];       
end
