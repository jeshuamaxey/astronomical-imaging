disp('************* COMMENCE *************')

%main
disp('Loading data')
% load in masked fits data
img_masked = fitsread('img/img_masked.fits');
img_size = size(img_masked);

disp('Commencing galaxy count')
												% runtime ~45mins
g_bg = 3418;       			% global background
g_bg_sigma = 13;				% half width half maximum of the gaussian fitted to the pixel count distritbution curve
threshold	= g_bg;				% used to stop the program early to produc half processed images
galaxies = countgalaxies(img_masked, img_size, threshold, g_bg, g_bg_sigma);

% output data to file

outputtofile(galaxies);

disp('************ FINISHED ************')