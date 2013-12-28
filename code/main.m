disp('************* COMMENCE *************')

%main
disp('Loading data')
% load in masked fits data
img_masked = fitsread('img/img_masked.fits');
img_size = size(img_masked);

disp('Commencing galaxy count')

threshold = 25000; 			% count galaxies above this brightness
g_bg = 3480;       			% global background
galaxies = countgalaxies(img_masked, img_size, threshold, g_bg);

% output data to file

outputtofile(galaxies);

disp('************ FINISHED ************')