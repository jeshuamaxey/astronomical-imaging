%MAIN SCRIPT
GalaxyCount=0; %Setting the initial values
mj = 0;
mi = 0;
NewGlobalBackground = 3440 ; % After looking at the noise levels in the picture
[X, Y] = meshgrid(1:2570, 1:4611); %for the circular apertures – sets the coordinate system for x and y
A=fitsread('EdittedCompleteMask.fits');
A(A == 0) = NewGlobalBackground; %Assigning the zeros and ones to the NGB to help with the Local Background
A(A == 1) = NewGlobalBackground; %the ones have appear from the edges of the bleeding areas when combined while (max(max(A)) > NewGlobalBackground) %assigning detection limit
[i,j] = find(A == max(A(:))); %maximum of the whole matrix is max(A(:)) i = i(1,1);
%these two lines make sure that if there are two or more pixels of the same intensity then they are dealt with separately and not as an array
j = j(1,1);
while median(median(A(i+mi,j-1:j+1))) > NewGlobalBackground
%NewGlobalBackground is used to prevent a galaxy and its surroundings being counted multiple times
mi = mi+1;
end
while median(median(A(i-1:i+1,j+mj))) > NewGlobalBackground %do the same in the j direction
mj = mj+1;
end
%these two while loops increase the size of the aperture based on the intensity of the edge pixels - will continue until the median of the 3 edge pixels are less than the NewGlobalBackground
if (mi + mj == 0)
%nothing, just used to separate this condition from the two below because you can’t make a circular of 0 radius
elseif (mj>mi)
Aperture0 = sqrt((X-j).^2+(Y-i).^2)> mj+3; %small circle of zeros of radius mj+3 Aperture1 = sqrt((X-j).^2+(Y-i).^2)<= mj+3; %small circle of 1s for aperture sum mi = 0; %done this to help with localcircle
%+3 is used to cover outer lying pixels which may be slightly higher than the background else %(mi>=mj) not 0
Aperture0 = sqrt((X-j).^2+(Y-i).^2)> mi+3; Aperture1 = sqrt((X-j).^2+(Y-i).^2)<= mi+3; mj = 0;
end
P = [i,j];          %this was used for testing
%small circle of 0s
 %small circle of 1s for aperture sum
if (mi + mj > 1)
Aperture = A.*Aperture1;
n = sum(sum(Aperture1));
ApertureSum = sum(sum(Aperture));
ApertureSurround = sqrt((X-j).^2+(Y-i).^2)<= (2*(mj+mi));
LocalCircle = ApertureSurround.*Aperture0.*A;
N = sum(sum(ApertureSurround.*Aperture0)); LocalBackground = sum(sum(LocalCircle))/N; IntensityCount = ApertureSum - n*LocalBackground; IZP = 25.3; %instrumental zero point
%creating an annulus around the aperture
%gives the number of pixels in the annulus
%gives the annulus mean (local background)
%finds the count contribution of the galaxy in the aperture
%ignoring small singular pixels
      %creating the aperture around the galaxy
% number of pixels in the
      %total count inside
aperture
the aperture
%large circle of 1s for the annulus
CalMag = IZP - 2.5*log10(IntensityCount); %Calibrated Magnitudes using the equation in the lab script GalaxyCount = GalaxyCount + 1; %increment the galaxy count by 1
A = A.*Aperture0 + NewGlobalBackground*Aperture1; %reassign the aperture to new global background
M = [GalaxyCount,i,j,IntensityCount,LocalBackground,CalMag]; %Create an array for saving
save('FullLengthTest3-3440NGB.txt','M','-append', '-ASCII','-double'); %save and append array else
A(i-1:i+1,j-1:j+1) = NewGlobalBackground; %masking a small (less than 3 diameter circle) with a 3x3 square disp(P);
%display the position, this allowed to see if, when the counts were not increasing, the program was considering different pixels – we had problems where this was not the case
end
disp(GalaxyCount); %this is to let us see if the program is working mj = 0; %resets the values
mi = 0;
end
fitswrite(A,'FullLengthTest3-3440NGB.fits'); %saves the resulting image after everything has been masked %final Test took 3 hours 55 minutes and there were 7315 galaxies counted
