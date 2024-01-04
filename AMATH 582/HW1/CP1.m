% Clean workspace
 clear variables; close all; clc

 % Preamble from CP1_sample.m.  The autograder will take care of any files
 % needed for this step.  Please only submit solution file.

 load('Kraken.mat') %load data matrix
 L = 10; % spatial domain
 n = 64; % Fourier modes
 x2 = linspace(-L,L,n+1); x = x2(1:n); y = x; z = x; %create 3D axis arrays with 64 points
 k = (2*pi/(2*L))*[0:(n/2 - 1), -n/2:-1]; %create frequency array and rescale them to be 2pi periodic 
 ks = fftshift(k); %shift values to order them correctly
 
 %Create 3D grids for both spatial domain and frequency domain 
 [X,Y,Z] = meshgrid(x,y,z);
 [Kx,Ky,Kz] = meshgrid(ks,ks,ks);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

 % sum all realizations in frequency space
 % after your for loop ends, save the sum as variable A1

 realizations = zeros(n,n,n);   %
 totalRealizations = 49;
 for i=1:totalRealizations
	 Un(:, :, :) = reshape(Kraken(:, i), n, n, n);
	 realizations = realizations + fftn(Un);
 end
 A1 = realizations;

 % Average the sum over the 49 realizations (i.e., A1/49) and save as A2
 A2 = A1./totalRealizations;

 
 % find the peak frequencies in x, y, and z directions; i.e., find the
 % max in each direction of the normalized sum A2.
 % save these variables as A3, A4, and A5
 
 [M,I] = max(A2,[],'all','linear'); %find the max value of each column
 for l=1:n
	[i,j] = find(A2(:,:,l)==M);
	if isempty(i) ~= 1 && isempty(j) ~= 1
		peak = [i,j,l];
	end
 end
 A3 = k(peak(1));
 A4 = k(peak(2));
 A5 = k(peak(3));

 
 
%create an appropriate Gaussian filter and save it as A6
tau = 0.1;
k0 = Kx(I);
k1 = Ky(I);
k2 = Kz(I);

filter = exp(-tau*(Kx - k0).^2).*exp(-tau*(Ky - k1).^2).*exp(-tau*(Kz - k2).^2);

A6 = filter;

 

% Using the peak frequencies for the filtered signal, 
% estimate the x, y, and z coordinates of the Kraken over time and save as A7, A8, A9
posX = zeros(1,totalRealizations);
posY = zeros(1,totalRealizations);
posZ = zeros(1,totalRealizations);

for i=1:totalRealizations
	Un(:, :, :) = reshape(Kraken(:, i), n, n, n);
	filteredFreq = fftn(Un) .* A6;
	positions = ifftn(filteredFreq);
	[M,I] = max(positions,[],'all','linear');
	for j=1:n
		[a,b] = find(positions(:,:,j)==M);
		if isempty(a) ~= 1 && isempty(b) ~= 1
			peak = [a,b,j];
			break;
		end
	end
	posX(i) = x(peak(1));
	posY(i) = y(peak(2));
	posZ(i) = z(peak(3));
end

A7 = posX;
A8 = posY;
A9 = posZ;

% Plot the location in x-y-z space over time for your report (not for the autograder)
figure(1)
plot3(posX,posY,posZ)
hold on;
plot3(posX,posY,posZ,'ro');
hold on

% Plot the projection onto the x-y plane for your reprot (not for the autograder)
figure(2)
plot(posX,posY)
hold on
plot(posX,posY,'ro');
hold off

% Save a table of the x-y-z coordinates for your report (not for the autograder)
time = 1:49;
t = table(time',posX',posY',posZ');
t.Properties.VariableNames =["Time Instance","Position X","Position Y","Position Z"];
table2latex(t,'./positionTable')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Include all helper functions below since the autograder can only accept
% one file.
