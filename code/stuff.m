while ~done
    coords = brightestpoint(img_masked);    % array of coordinates for the brightest point of the image
    [num_of_coords,w] = size(coords);                     % number of 'brightest points'
    brightness = img_masked(coords(1));        % brightness at brightest point
    if brightness < threshold               % end while loop if all brightest points have been masked
        brightness
        done = 1;                      
    else
        for c=1:num_of_coords                           % for each brightest point, mask
            r=0;                            % reset r to zero for this point
            max_adj=0;
            % first we find half the aperture size (r)
            while max_adj > lbg_threshold           %WTF IS THIS VALUE?
                r=r+1;
                top    = [coords(c),   coords(c+num_of_coords)+r];                              % find coordinates of adjacent coordinates 
                right  = [coords(c)+r, coords(c+num_of_coords)];
                bottom = [coords(c),   coords(c+num_of_coords)-r];
                left   = [coords(c)-r, coords(c+num_of_coords)];
                adjacent = [img_masked(top), img_masked(right), img_masked(bottom), img_masked(left)];   % array of brightnesses of adjacents coordinates
                max_adj = max(adj);
            end
            
            % now we mask with a square aperture with length 2r
            for i=-r:r
                x=coords(c)+i;             % choose column
                for j=-r:r 
                    %num_of_coords
                    %c+num_of_coords+j
                    y=coords(c+num_of_coords)+j;       % choose row
                    %img_masked(x,y)
                    img_masked(x,y)=0;     % mask pixel
                end
            end
        end
    end
end