function [ bleed_mask ] = maskbleed( image, img_size )
%MASKBLEED Summary of this function goes here
%   Detailed explanation goes here
    sprintf('Masking bleeding stars')
    bleed_mask = ones(img_size);
    bg = 3480;
    
    x_min = [1425, 1100, 1330, 1015, 1315, 225, 1390, 901,  969, 771,   2131];
    x_max = [1450, 1652, 1510, 1701, 1540, 235, 1477, 910,  978, 780,   2138];
    y_min = [192,  425,  435,  310,  321,  217, 218,  2223, 2703, 3202, 3708];
    y_max = [4415, 435,  480,  321,  380,  270, 261,  2357, 2836, 3419, 3804];
    
    l = size(x_min);
    l = l(2);
    
    for c=1:l
        for i=x_min(c):x_max(c)
            for j=y_min(c):y_max(c)
                % if too bright then mask
                if image(j,i) > bg
                    bleed_mask(j,i) = 0;
                end
            end
        end
    end
end