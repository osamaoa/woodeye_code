function [im rawFileHeader] = IvRawRead_AO(fname,do_show)
%IvRawRead Opens raw images
%   [im rawFileHeader] = IvRawRead(FILENAME) Usage example with argument description
%
%   [IM RAWFILEHEADER] = IVRAWREAD(FILENAME) Opens image FILENAME and returns the image
%   IM and the picbuf header RAWFILEHEADER

%==========================================================================
%   File: IvRawRead.m
%   Copyright (C) Innovativ Vision AB, 2007
%
%   $Log: /Tools/IvMatlabLib/IvRawRead.m $ /Tools/IvMatlabLib/IvRawRead.m $
%   
%   2     08-01-04 14:12 Ae
%   Function now returns picbuf header
%   
%   1     07-11-15 8:12 Ae
%   Opens RAW files
%==========================================================================

rawFileHandle = fopen(fname, 'r');
if (rawFileHandle == -1)
   error('File not found.')
end;

[rawFile, rawFileSize] = fread(rawFileHandle, inf, 'uchar');
fclose(rawFileHandle);

% The header is the first 24 bytes of the raw file.
rawFileHeader = rawFile(1 : 24);
rawFileImageData = uint8(rawFile(25 : rawFileSize));

% Byte 21 and 22 in the header give the image width.
%imageLength = rawFileHeader(2) * 256 + rawFileHeader(1)
imageWidth = rawFileHeader(6) * 256 + rawFileHeader(5);
imageLength = (rawFileSize - 24) / (imageWidth + 40); %sizeof(PicLine) = 40 it seems
% Reshape the image vector to form the image.
im = reshape(rawFileImageData, imageWidth + 40, imageLength);
if do_show==1
    imshow(im);
end

