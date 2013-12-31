function [ aperture ] = makeaperture( img_masked, threshold, brightness, x, y, g_bg )
%MAKEAPERTURE
%   Produces a variable aperture
    [h,w] = size(img_masked);
    % account for perimeter
    h = h - 400;
    w = w - 400;
    ratio = 0;
    % remember what the original coords of the star are
    original_x = x;
    original_y = y;
    %THIS IS IMPORTANT!!!!!
    %thing = ((brightness - g_bg)*0.05)+g_bg);
    % added to each variable aperture
    lip = 2;
%   Extend in x-direction to find the radius of star in this direction
    edge_brightness = g_bg+1; %ensures while loops begin
    while (edge_brightness > g_bg) & (x < w)
        x=x+1;
        edge_brightness = median([img_masked(y-1,x),img_masked(y,x),img_masked(y+1,x)]);
    end

%   Extend in y-direction to find the radius of star in this direction
    while (edge_brightness > g_bg) & (y < h)
        edge_brightness = g_bg+1; %ensures while loops begin
        y=y+1;
        edge_brightness = median([img_masked(y,x-1),img_masked(y,x),img_masked(y,x+1)]);
    end

%   Return largest of the two apertures
    x_aperture = x - original_x;
    y_aperture = y - original_y;

    if x_aperture < y_aperture
        aperture = (2*y_aperture)+lip;
    else
        aperture = (2*x_aperture)+lip;
    end
end

