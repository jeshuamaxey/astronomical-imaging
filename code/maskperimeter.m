function [perimeter_mask] = maskperimeter( img_size )
%MASKPERIMETER Summary of this function goes here
%   Detailed explanation goes here
    perimeter_mask = ones(img_size);
    border = 200;

    y_max = img_size(1);
    x_max = img_size(2);

    for c=1:border
        for d=1:x_max
            perimeter_mask(c,d) = 0;
        end
    end

    for c=y_max-border:y_max
        for d=1:x_max
            perimeter_mask(c,d) = 0;
        end
    end

    for c=1:border
        for d=1:y_max
            perimeter_mask(d,c) = 0;
        end
    end

    for c=x_max-border:x_max
        for d=1:y_max
            perimeter_mask(d,c) = 0;
        end
    end
end

