img_masked = fitsread('img/img_masked.fits');

dist = zeros(5000);
dist_file = fopen('data/dist.txt','w');

disp('Commencing Counting')

for c=1:5000
	dist(c) = size(find(img_masked==c),1);
	fprintf( dist_file, '%d, %d\n', c, dist(c));
	if mod(c,20) == 0
		sprintf('c = %2.1f percent done\n',100*c/5000)
	end
end

disp('DONE!')

plot(dist);