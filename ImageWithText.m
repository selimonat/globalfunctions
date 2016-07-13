function h=ImageWithText(mat1,mat2,varargin);
%ImageWithText(mat1,mat2,varargin);
%
%
%VARARGIN is used for colorbar, MAT1 is the imaged matrix, MAT2 is the
%textual matrix. Use MAT1 = MAT2 if you want to print the value of the same
%matrix
%

if nargin == 3
    cb = varargin{1};
else
    cb = [min(mat1(~isinf(mat1))) max(mat1(~isinf(mat1)))];
end


h=imagesc(mat1,cb);            %# Create a colored plot of the matrix values
colorbar


textStrings = num2str(mat2(:),'%4.2f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x,y] = meshgrid(1:size(mat1,2),1:size(mat1,1));   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range

