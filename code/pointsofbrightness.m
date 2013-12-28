function [ s ] = pointsofbrightness( image, brightness )
%POINTSOFBRIGHTNESS Summary of this function goes here
%   Detailed explanation goes here
    [i,j] = ind2sub(size(image), find(image==brightness));
     coords = [i,j];
    t = size(coords);
    s = t(1);
end

