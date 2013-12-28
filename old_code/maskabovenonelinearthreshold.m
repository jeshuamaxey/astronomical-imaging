function [ img_masked ] = maskabovenonelinearthreshold()
%MASKABOVENONELINEARTHRESHOLD Summary of this function goes here
%   Detailed explanation goes here
    % mask all pixels above the non linear threshold
    mask = ones(size(image));
    mask = mask*non_linear_threshold;
    mask = gt(mask, image);
    img_masked = mask.*image;

end

