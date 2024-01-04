clear variables, clear figures

n = 8;
h = 10.^(-1:-1:-n);

fiExact = pi;

%midpoint rule
errorsM = zeros(1,n);

for i=1:n
	points = (0:h(i):1-h(i))+h(i)/2; %make a list of points minus the last one and shift it to middle
	fVals = 4./(1+points.^2); %plug them into the function
	
	fiApprox = h(i)*sum(fVals); %apply mid point rule
	errorsM(i) = abs(fiExact - fiApprox);
end


%trapezoidal rule
errorsT = zeros(1,n);

for i=1:n
	points = (0:h(i):1); %make a list of points
	fVals = 4./(1+points.^2); %plug them into the function
	
	fiApprox = 1/2*h(i)*fVals(1) + sum(h(i)*fVals(2:end-1)) + 1/2*h(i)*fVals(end);
	errorsT(i) = abs(fiExact - fiApprox);
end


%Simpons rule
errorsS = zeros(1,n);

for i=1:n
	points = [0,1];
	points1 = (h(i):2*h(i):1-h(i)); %make a list of points to mult by 2
	points2 = (2*h(i):2*h(i):1-2*h(i)); %make a list of points to mult by 4
	fVals = 4./(1+points.^2); %plug them into the function
	fVals1 = 4./(1+points1.^2); %plug them into the function
	fVals2 = 4./(1+points2.^2); %plug them into the function
	
	fiApprox = (h(i)/3)*(sum(fVals) + 4*sum(fVals1) + 2*sum(fVals2));
	errorsS(i) = abs(fiExact - fiApprox);
end


figure(10);
loglog(h,errorsT);
hold on
loglog(h,errorsM);
hold on
loglog(h,errorsS);
legend("Midpoint","Trapezoidal","Simpons");
hold on
