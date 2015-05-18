function [BC]=BinEdges2BinCenters(BE)

BC = BE(1:end-1) + diff(BE)/2;%this was wrong!! 
%now it is right and today is 20th of march 2007. probably the ones in the
%paper was wrong. but does not make a huge difference :-(. :-).