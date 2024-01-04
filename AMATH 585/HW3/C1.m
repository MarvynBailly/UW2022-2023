format long

%driver code for coding problem one

syms f(x1);
f(x1) = 0.5*x1 - sin(x1);

%Part A
interval = [pi/2, pi];
resultsA = zeros(3,2);

resultsA(1,:) = bisection(f,interval,10e-3,1);
resultsA(2,:) = bisection(f,interval,10e-7,1);
resultsA(3,:) = bisection(f,interval,10e-15,1);

%Part B
x0 = pi; %set inital guess

resultsB = zeros(3,2);

resultsB(1,:) = newton(f,10e-3,x0, false);
resultsB(2,:) = newton(f,10e-7,x0, false);
resultsB(3,:) = newton(f,10e-15,x0, false);


%Part C
x0 = pi/2;
x1 = pi;
resultsC = zeros(3,2);

resultsC(1,:) = secant(f,10e-3,x0,x1);
resultsC(2,:) = secant(f,10e-7,x0,x1);
resultsC(3,:) = secant(f,10e-15,x0,x1);

format short