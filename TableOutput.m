function TableOutput(col_names,row_names,numbers)
%TableOutput(col_names,numbers)
%
%Print the matrix in NUMBERS as a table using the column titles in col_names.
%col_names is a cell array of string characters, can be left empty. NUMBERS is
%a matrix.

if isempty(col_names)
    col_names = cell(1,size(numbers,2));
end
%
tab           = 4;
tcolumn       = length(col_names);
trow          = size(row_names,1);
column_size   = max(cellfun(@(x) length(x),col_names)) + tab;%max column size with the tab
table_size    = column_size*(tcolumn+1);%with the row name column
%%
s_col_names   = [repmat(' ',1,column_size) repmat(['%-' num2str(column_size-tab) 's\t'],1,length(col_names)) '\n'];
s_col_names   = [s_col_names repmat('=',1,table_size) '\n'];
s_numbers     = [ '%-' num2str(column_size-1) 's: '  repmat(['%-' num2str(column_size) '.5f' ],1,tcolumn) '\n'];
s_numbers     = repmat(s_numbers,1,size(numbers,1));

fmt   = [s_col_names(:);s_numbers(:)]';
%append the row_names to left of the values.
values = reshape([row_names; num2cell(numbers(:))],trow,tcolumn+1)'
sprintf(fmt,col_names{:},values{:})