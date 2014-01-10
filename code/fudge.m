shit_img = fitsread('img/pc_wrong.fits');

wrong_values = find(shit_img==3457);
shit_img(wrong_values) = 3418;

fitswrite(shit_img, 'img/pc_right.fits');

disp('FINISH!')