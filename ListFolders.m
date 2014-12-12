function [f]=ListFolders(path);
%[f]=GetFolders(path);
%General Directory Finder, excludes '.' and '..'.
%Returns in a vertical cell array all the detected directories within
%path.
%
%
%Selim, 15-Jan-2007 18:18:51

f = dir([path '*'] );
f = {f([f.isdir]).name};
f = regexp(f,'[^^.].*','match');
f = [f{:}]';


