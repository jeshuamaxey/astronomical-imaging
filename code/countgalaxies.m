function [ galaxies ] = countgalaxies( img_masked, img_size, threshold, g_bg )
%COUNTGALAXIES Summary of this function goes here
%   Detailed explanation goes here
    done = 0;
    inst_zero_pt = 25.3;                                   %instrumental zero point
    galaxies = zeros(1,4);                                 % stores catalog of galaxies (consider preallocating array improves efficiency)
    i=0;                                                   % keeps track of position galaxies array
    
    while ~done
        coords = brightestpoint(img_masked);               % array of coordinates for the brightest point of the image
        [num_of_coords,w] = size(coords);                  % number of 'brightest points'
        y = coords(1);                                     %changed x and y order (should only go to 4000)
        x = coords(1+num_of_coords);
        brightness = img_masked(y,x);                      % brightness at brightest point
        
        if (brightness <= threshold) | (brightness <= g_bg) % end while loop if all brightest points have been masked
            sprintf('Threshold = %d complete.\nCount = %d', threshold, size(galaxies,1))
            done = 1;                      
        else
            % create variable aperture
            aperture = makeaperture(img_masked, threshold, brightness, x, y, g_bg);

            if(aperture > 1)
                brightness = galaxybrightness(img_masked, img_size, x, y, aperture/2);
                calibrated_magnitude = inst_zero_pt - 2.5*log10(brightness);
                % store data
                galaxies(i+1,1) = brightness;
                galaxies(i+1,2) = y;
                galaxies(i+1,3) = x;
                galaxies(i+1,4) = calibrated_magnitude;

                % mask out galaxy
                mask = createcirclemask(img_size, x, y, aperture/2);
                img_masked = img_masked.*(~mask);
                % set masked out areas to local background
                zero_values = find(img_masked==0);
                img_masked(zero_values) = g_bg;
                
                % every 10 galaxies, output program update
                if (mod(i,10)==0) & i > 0
                    sprintf('Count = %d\nBrightness = %d\nCal. Mag. = %d\nAperture = %d', i, brightness, calibrated_magnitude, aperture)
                end
                % increment i
                i=i+1;
            end
        end
    end
    fitswrite(img_masked, 'img/post_count.fits');
end

