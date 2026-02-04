function [im, rawFileHeader] = IvRawRead_AO(fname, do_show)
%IvRawRead_AO Opens raw images
%   [im rawFileHeader] = IvRawRead(FILENAME) Usage example with argument description
%
%   [IM RAWFILEHEADER] = IVRAWREAD(FILENAME) Opens image FILENAME and returns the image
%   IM and the picbuf header RAWFILEHEADER

%==========================================================================
%   File: IvRawRead.m
%   Copyright (C) Innovativ Vision AB, 2007
%   (Restored from archive)
%==========================================================================

if nargin < 2
    do_show = 0;
end

rawFileHandle = fopen(fname, 'r');
if (rawFileHandle == -1)
   error('File not found: %s', fname);
end

[rawFile, rawFileSize] = fread(rawFileHandle, inf, 'uchar');
fclose(rawFileHandle);

% The header is the first 24 bytes of the raw file.
rawFileHeader = rawFile(1 : 24);
rawFileImageData = uint8(rawFile(25 : rawFileSize));

% Byte 21 and 22 in the header give the image width.
%imageLength = rawFileHeader(2) * 256 + rawFileHeader(1)
imageWidth = rawFileHeader(6) * 256 + rawFileHeader(5);
% Avoid division by zero if width is bad
if imageWidth == 0
    error('Invalid image width in raw header');
end

imageLength = (rawFileSize - 24) / (imageWidth + 40); %sizeof(PicLine) = 40 it seems

% Reshape the image vector to form the image.
% dimensions usually (height, width) or (width, height)? 
% Original code: reshape(rawFileImageData, imageWidth + 40, imageLength);
% It seems the 'width' here includes padding (40 bytes).
im = reshape(rawFileImageData, imageWidth + 40, imageLength);

if do_show==1
    imshow(im);
end
end
