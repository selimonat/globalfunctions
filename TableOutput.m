function TableOutput(names,numbers)
%TableOutput(names,numbers)
%
%Print the matrix in NUMBERS as a table using the column titles in NAMES.
%NAMES is a cell array of string characters, can be left empty. NUMBERS is
%a matrix.

if isempty(names)
    names = cell(1,size(numbers,2));
end

s_names   = [repmat('%s\t',1,length(names)) '\n\n'];
s_numbers = [repmat('%3.2g\t',1,size(numbers,2)) '\n'];
s_numbers = repmat(s_numbers,1,size(numbers,1));

fmt   = [s_names(:);s_numbers(:)]';
values = num2cell(numbers);
sprintf(fmt,names{:},values{:})