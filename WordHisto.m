function [occ,el]=WordHisto(txt)
%txt is a string which contains the path to the .TXT file.

fid = fopen(txt)
ali = textscan(fid,'%s');

%clean
list = {';' '.' ',' '"' '?'};
tl   = max(size(list));
tw   = max(size(ali{1}));
ali2 = ali;

for nw = 1:tw;    
    for nl = 1:tl;        
        ii = ali2{1}{nw} == list{nl};
        if sum(ii) ~= 0
            ali2{1}{nw}(ii) = [];
        end        
    end    
end

%Count
el = unique( ali2{1});


for nel = 1:max(size(el));
    nel
count = 0;        
    for nw = 1:tw
        if strcmp(ali2{1}{nw},el{nel});            
           count = count +1;            
        end
        %
    end
occ(nel) = count;    
end

%sort
[occ i ] = sort(occ,'descend');
el = {el{i}};

plot(occ(1:75),1:75,'o')
set(gca,'ytick',1:75,'yticklabel',{el{1:75}});