function [p]=DetectPeaks(d)
%[p]=DetectPeaks(d)
%
%   Finds peaks in a periodic or quasi-periodic signal D. P contains the
%   sample indices of the peak positions.
%
%   It implements a multiscale peak detection algorithm proposed in
%   Scholkmann et al..  D MUST be a signal that is periodic or
%   quasi-periodic such as pulsemeter readouts, respiration belt output or
%   solar spot intensity changes. The periodicity of peaks are detected
%   automatically, no parameter is needed to be given. The periodicity that
%   is detected consists of the periodicity where the highest amount of
%   local maximas are found.
%
%
%   Reference:
%   An Efficient Algorithm for Automatic Peak Detection in Noisy
%   Periodic and Quasi-Periodic Signals
%
%   Felix Scholkmann *, Jens Boss and Martin Wolf
%   Algorithms 2012, 5, 588-603; doi:10.3390/a5040588
%
%
%   Selim Onat, 07-Apr-2013 15:48:52

N = length(d);
L = N/2-1;
%limit scale to 1000
if L > 1000
    L = 1000;
end
%compute the multiscale scalograme
m = 1+rand(L,length(d)-1);
for k = 1:L    
   for i = k+2:N-k+1

       if (d(i-1) > d(i-k-1)) & (d(i-1) > d(i+k-1))
           m(k,i) = 0;
       end       
   end    
end
%
[mini global_mini] = min(sum(m,2));
p  = find(std(double(m(1:global_mini,:))) == 0)-1;%peak indices

%visualization
% % figure(1)
% % subplot(3,1,1)
% % plot(sum(m,2))
% % subplot(3,1,2)
% % plot(std(m(1:global_mini,:)));
% % subplot(3,1,3)
% % imagesc(m);
% % %
% % figure(2);
% % plot(d);
% % hold on
% % plot(p,d(p),'rs');
% % hold off