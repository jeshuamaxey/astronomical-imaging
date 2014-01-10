function [ coords ] = brightestpoint( image )
%TEST Summary of this function goes here
%   Detailed explanation goes here
    M = max(image);
    MM = max(M);
    [i,j] = ind2sub(size(image), find(image==MM));
    coords = [i,j];
end

