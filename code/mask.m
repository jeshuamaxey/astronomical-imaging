unmasked_file_name = 'img/mosaic.fits';
masked_file_name = 'img/img_masked.fits';
% global background 
g_bg = 3422;

disp('Loading data')
% load in fits data
image = fitsread(unmasked_file_name);
img_masked = image;
img_size = size(image);

% create component masks
perimeter_mask = maskperimeter(img_size);
nonlinear_mask = masknonlinear(image, img_size);
bright_star_mask = maskbrightstars(img_size);
bleed_mask = maskbleed(image, img_size);

% create array of coords where the mask is zero
perimeter_coords = find(perimeter_mask==0);
n = size(perimeter_coords,1);
% for each coordinate, set corresponding coordinate of image to g_bg
for c=1:n
	img_masked(perimeter_coords(c)) = g_bg;
end

% create array of coords where the mask is zero
nonlinear_coords = find(nonlinear_mask==0);
n = size(nonlinear_coords,1);
% for each coordinate, set corresponding coordinate of image to g_bg
for c=1:n
	img_masked(nonlinear_coords(c)) = g_bg;
end

% create array of coords where the mask is zero
bright_star_coords = find(bright_star_mask==0);
n = size(bright_star_coords,1);
% for each coordinate, set corresponding coordinate of image to g_bg
for c=1:n
	img_masked(bright_star_coords(c)) = g_bg;
end

% create array of coords where the mask is zero
bleed_coords = find(bleed_mask==0);
n = size(bleed_coords,1);
% for each coordinate, set corresponding coordinate of image to g_bg
for c=1:n
	img_masked(bleed_coords(c)) = g_bg;
end

%%%%%%%%% START OLD MASKING CODE

% apply component masks
% img_masked = image;
% img_masked = img_masked.*perimeter_mask;
% img_masked = img_masked.*nonlinear_mask;
% img_masked = img_masked.*bright_star_mask;
% img_masked = img_masked.*bleed_mask;

% set masked out areas to local background

% zero_values = find(img_masked==0);
% img_masked(zero_values) = g_bg;

%%%%%%%%% END OLD MASKING CODE

% write masked image to file
fitswrite(img_masked, masked_file_name);

sprintf('Masks applied and saved to %s', masked_file_name)
disp('************ MASK DONE *************')