function [ brightness_galaxy ] = galaxybrightness( image, img_size, x, y, r )
%   GALAXYBRIGHTNESS
%   Finds total (cumulative) brightness of a galaxy, returns brightness as value

    % create mask to count galaxy brightness
    galaxy_mask = createcirclemask(img_size,x,y,r);

    % create mask to count local background
    lbg_mask = createcirclemask(img_size,x,y,2*r);
    annulus_mask = xor(lbg_mask, galaxy_mask);

    % create images from masks 
    galaxy_image = image.*galaxy_mask;
    annulus_image = image.*annulus_mask;

    % count number of pixels in both galaxy and annulus
    N_galaxy = sum(sum(galaxy_mask));
    N_annulus = sum(sum(annulus_mask));

    % Find the cumulative brightness of both galaxy and annulus
    total_brightness_galaxy = sum(sum(galaxy_image));
    total_brightness_annulus = sum(sum(annulus_image));
    
    % find the brightness of galaxy 
    % (Initial galaxy count - local background)
    % local_background = N_galaxy * (total_brightness_annulus/N_annulus)
    l_bg_per_pixel = total_brightness_annulus/N_annulus;
    brightness_galaxy = total_brightness_galaxy - (N_galaxy * l_bg_per_pixel );
    
end

