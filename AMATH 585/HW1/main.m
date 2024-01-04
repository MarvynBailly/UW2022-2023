%Homework 1

nvals = [5,10,15,20];
x = linspace(-5,5,1000)';
y = 1./(1 + x.^2);

figure(1)
plot(x,y)
hold on

%Part (a)
for i=1:3
	n= nvals(i);
	xvals = -5 + (10/n)*(0:n);
	yvals = 1./(1 + xvals.^2);
	plot(x, getLagrange(xvals,yvals,x))
end
legend("f(x)","n=5","n=10","n=15","n=20");
hold off

%Part (b)
figure(2)
plot(x,y) 
hold on

for i=1:4
	n= nvals(i);
	xCheb = 5*cos(pi*(2*(0:n) +1)/(2*(n+1)));
	yCheb = 1./(1 + xCheb.^2);
	plot(x, getLagrange(xCheb,yCheb,x))
end
legend("f(x)","n=5","n=10","n=15","n=20");
hold off


%Part (c)
figure(3)
plot(x,y) 
hold on

for i=1:2
	n= nvals(i);
	
	xSpline = -5 + (10/n)*(0:n);
	ySpline = 1./(1 + xSpline.^2);
	
	plot(x,spline(xSpline,[5/338 ySpline -5/338],x));
end
legend("f(x)","n=5","n=10");
hold off



