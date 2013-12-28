unmasked_file_name = 'img/mosaic.fits';
masked_file_name = 'img/img_masked.fits';

disp('Loading data')
% load in fits data
image = fitsread(unmasked_file_name);
img_size = size(image);

% create component masks
perimeter_mask = maskperimeter(img_size);
nonlinear_mask = masknonlinear(image, img_size);
bright_star_mask = maskbrightstars(img_size);
bleed_mask = maskbleed(image, img_size);

% apply component masks
img_masked = image;
img_masked = img_masked.*perimeter_mask;
img_masked = img_masked.*nonlinear_mask;
img_masked = img_masked.*bright_star_mask;
img_masked = img_masked.*bleed_mask;

% set masked out areas to local background
global_background = 3480;
zero_values = find(img_masked==0);
img_masked(zero_values) = global_background;

% write masked image to file
fitswrite(img_masked, masked_file_name);

sprintf('Masks applied and saved to %s', masked_file_name)
disp('************ MASK DONE *************')