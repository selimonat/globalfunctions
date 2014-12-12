function [f]=ListFiles(path);
%[f]=ListFiles(path);
%General File Finder, excludes directories/
%Returns in a vertical cell array all the detected directories within
%path.
%
%
%Selim, 09-May-2012 16:24:17

f = dir([path '*'] );
f = {f(~[f.isdir]).name};
f = regexp(f,'[^^.].*','match');
f = [f{:}]';


