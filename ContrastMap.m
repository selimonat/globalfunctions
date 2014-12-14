function [cim]=ContrastMap(im,ws,Normalize,Pad,p);
%[cim]=ContrastMap(im,ws,Normalize,Pad);
%computes the contrast map of a given image IM by using a window size of
%WS. IM can contain many different images in its 3rd dimension then CIM
%contains the contrast maps of the corresponding images in its third dimension.
%It uses convolution routines of matlab. WS is preferentially an odd number
%this makes it straigthforward to select the number of zeros used to zeros
%pad. NORMALIZE has to be 1 if you want to normalize the standard
%deviation map by the mean luminance of the image. if PAD is 1 it zero pads
%the image so that the contrast map and the image have the same size.
%
%Last Revision by Selim 2005.
if rem(ws,2)~=0

    imsize = [size(im,1) size(im,2)];
    %total images
    ti = size(im,3);
    %initialize the CIM    
    
    if Pad == 1
    cim = zeros(imsize(1),imsize(2),ti);
    else
    cim = zeros(imsize(1)-ws+1,imsize(2)-ws+1,ti);    
    end
    %convolution matrix
    %p = ones(ws)*1./ws.^2;
    %compute the contrast map

    for n = 1:ti
        n
        if Normalize == 1
            dummy = (sqrt(conv2(im(:,:,n).^2,p,'valid') - conv2(im(:,:,n),p,'valid').^2))./mean2(im(:,:,n));
            if Pad == 1
                cim(:,:,n) = padarray(dummy,[(ws-1)/2  (ws-1)/2 ]);
            else
                cim(:,:,n) = dummy;
            end
        elseif Normalize == 0
            dummy = (sqrt(conv2(im(:,:,n).^2,p,'valid') - conv2(im(:,:,n),p,'valid').^2));
            if Pad == 1
                cim(:,:,n) = padarray(dummy,[(ws-1)/2  (ws-1)/2 ]);
            else
                cim(:,:,n) = dummy;
            end
        else
            display('[cim]=ContrastMap(im,ws,Normalize); Normalize has be equal to 1 or 0.');
        end
    end

else
    display(['choose a odd numbered window size']);
end
