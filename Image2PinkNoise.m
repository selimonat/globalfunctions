function [Pink]=Image2PinkNoise(im)
%[Pink]=Image2PinkNoise(im)
%IM is the image from which the power spectra is taken and used to create
%the pink noise. IT HAS TO BE A DOUBLE PRECISION VARIABLE otherwise you will
%get warning messages. Power spectra is then combined with random phase
%information and transformed back to the pixel space. The resulting matrix
%PINK has the same power spectra as IM which also means that mean and
%standard deviations of IM and PINK are exactly the same.
%
%Selim 2006




%fourier transform the image.
imf   = fft2(im);
%Store the amplitudes, we will use those with the random angles;
Amp = abs(imf);

%now we need random phases. We will obtain this by ffting a random matrix
%with the same size as im.
RandAngles = angle( fft2( rand(size(im)) ) );

%Use the Random Angles and the Amplitudes and convert back to the pixel
%space.
Pink = real(ifftn(Amp.*exp(i.*RandAngles)));


