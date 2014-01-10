function [ bright_star_mask ] = maskbrightstars( img_size )
%MASKBRIGHTSTARS Summary of this function goes here
%   Detailed explanation goes here
    disp('Masking bright stars')
    bright_star_mask = ones(img_size);
    %           col, row
    coords =  [ 1443,3205;
                 779,3318;
                 975,2774;
                 907,2286;
                2092,1426;
                2134,2308;
                2135,3759;
                 561,4096;
                1458,4033;
                2261,3297;
                1643, 344;
                1036, 438;
                ];
    radius =   [244;
                53;
                39;
                36;
                27;
                29;
                31;
                28;
                23;
                37;
                14;
                15;
                ];
    l = size(coords);
    l = l(1);
    for c=1:l
        y = coords(c);
        x = coords(c+l);
        % [xx,yy] = ndgrid((1:15)-rx,(1:15)-ry);
        [xx,yy] = ndgrid((1:img_size(1))-x,(1:img_size(2))-y);
        temp_mask = (xx.^2 + yy.^2) < radius(c)^2;
        temp_mask = ~temp_mask;
        bright_star_mask = bright_star_mask & temp_mask;
    end
end

