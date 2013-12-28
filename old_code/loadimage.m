function [ image ] = loadimage()
%LOADIMAGE Summary of this function goes here
%   Detailed explanation goes here
    % load in fits data
    image = fitsread('mosaic.fits');

end

