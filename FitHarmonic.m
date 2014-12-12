function [s2,sf,freqx]=FitHarmonic(s,Fs,pad,freq_down,freq_up);
% Fs   = 100;
% Nfft = length(s);
% freq_up = 6.5;
% freq_down = 5.5;

N=size(s,1);
Nfft=max(2^(nextpow2(N)+pad),N);% number of points in fft


sf = fft(s,Nfft);
[freqx,findx]=getfgrid(Fs,Nfft,[0 Fs/2]);
% % %
% % figure(100);
% % plot(f,abs(sf(findx)))


ind = (freqx <= freq_up) & (freqx >= freq_down);
ind = [ind fliplr(ind(2:end-1))];
sf(~ind,:) = 0;
s2 = ifft(sf);
s2(length(s)+1:end,:) = [];


