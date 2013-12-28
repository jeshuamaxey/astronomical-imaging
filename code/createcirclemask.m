function [ circle_mask ] = createcirclemask( img_size, x, y, r )
%CREATECIRCLEMASK Summary of this function goes here
%   Creates a circle of 1s of radius r centred at x,y
%		within a mesh of size img_size
    [xx,yy] = ndgrid((1:img_size(1))-y,(1:img_size(2))-x);
    % [xx,yy] = ndgrid((1:img_size(1))-x,(1:img_size(2))-y);
    circle_mask = (xx.^2 + yy.^2) < (r)^2;
end

