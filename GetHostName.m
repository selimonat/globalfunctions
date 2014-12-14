function [hn]=GetHostName
%[hn]=GetHostName;
%
%   Returns the hostname of the cumputer matlab is running.
%
%   Selim Onat, 26-Apr-2013 12:55:26


[a hn] = system('hostname');
hn     = deblank(hn);

