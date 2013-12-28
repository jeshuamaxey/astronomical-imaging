image = fitsread('mosaic.fits');
img_size = size(image);

border = 200;

y_max = img_size(1);
x_max = img_size(2);

for c=1:border
    for d=1:x_max
        image(c,d) = 0;
    end
end

for c=y_max-border:y_max
    for d=1:x_max
        image(c,d) = 0;
    end
end

for c=1:border
    for d=1:y_max
        image(d,c) = 0;
    end
end

for c=x_max-border:x_max
    for d=1:y_max
        image(d,c) = 0;
    end
end
fitswrite(image,'no-borders.fits');