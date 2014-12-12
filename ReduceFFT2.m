function [vec,freq]=ReduceFFT2(mat)
%[vec,freq]=ReduceFFT2(mat)
%
%It averages a two dimensional amplitude matrix (result of fft2) over
%different frequencies. The resulting vector VEC is amplitude (or power) as a
%function of frequency. The increment of frequency is the same as the
%original two dimensional matrix. The corresponding frequencies for each
%entry are given in FREQ in units of cycle per pixel.
%
%IMPORTANT: 1/ you must FFTSHIFT the mat before using this function
%           2/ if MAT is not square then the results are wrong!! simply use
%           the zero padding option of FFT.
%
%
%
%Selim, 12-Feb-2007 21:54:13

s     = size(mat);
if s(1) == s(2)
    c     = GetCenter(s);
    [X Y] = meshgrid((1:s(2))-c(2),(1:s(1))-c(1));
    C     = round(sqrt(X.^2 + Y.^2))+1;
    %mask
    %we discard all the points which are outside of the circle with
    %diameter the size of the patch.
    mask     =  C > round(c(1));
    C(mask)  = [];
    X(mask)  = [];
    Y(mask)  = []; 
    mat(mask)= [];
    %
    vec   = zeros( 1, max(C(:)) );
    %after adding plus one the first entry in VEC will correspond to 0th
    %frequency now.
    count = vec;
    for n = 1:length(X(:));
        vec( C(n) ) = vec( C(n) ) + mat(n);
    end
    vec  = vec(:);
    freq = linspace(0,0.5,c(1));
    freq = freq(:);
else
    display('INPUT must be a square matrix!');
end
    function [c] = GetCenter(s)

        for i = 1:2

            if mod(s(i),2) == 0
                c(i) = s(i)/2+1;
            else
                c(i) = ceil(s(i)./2);
            end
        end
    end


end