function [ nonlinear_mask ] = maskabovenonelinearthreshold( image, img_size )
%MASKABOVENONELINEARTHRESHOLD Summary of this function goes here
    sprintf('Masking above non-linear threshold')
%   Detailed explanation goes here
    non_linear_threshold = 40000;
    % mask all pixels above the non linear threshold
    nonlinear_mask = ones(img_size);
    nonlinear_mask = nonlinear_mask*non_linear_threshold;
    nonlinear_mask = gt(nonlinear_mask, image);
end

