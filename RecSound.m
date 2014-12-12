function [s]=RecSound(l);
%[s]=RecSound(l);
%Records a stereo sound of length L with sampling rate of 44100 and 16 bit.


display('creating audio object');
recorder = audiorecorder(44100,16,2);

display('recording the sound. SPEAK!!')
record(recorder,l);

pause(l+l/2);

display('saving to the work space');
s = getaudiodata(recorder);
plot(s);