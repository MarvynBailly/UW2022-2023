clear variables

n = 16; 
h = 10.^(0:-1:-n); 
x0 = 1.2; 
fdExact = cos(x0);

%Part A
error = zeros(1,n+1);

for i=0:n
	fdAprox = (sin(x0 + h(i+1)) - sin(x0))/(h(i+1));
	error(i+1) = abs(fdExact - fdAprox);
end

figure(1)
loglog(h,error);
hold on

%Part B
error2 = zeros(1,n+1);

for i=0:n
	fdAprox = (2*cos(x0+h(i+1)/2)*sin(h(i+1)/2))/(h(i+1));
	error2(i+1) = abs(fdExact - fdAprox);
end

figure(2)
loglog(h,error2);
hold off
