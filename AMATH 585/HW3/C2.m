clc
format long

%Driver code for coding problem 2

syms f(x1,x2);
f(x1,x2) = [(x1 + 3)*(x2^3 - 7) + 18 sin(x2*exp(x1)-1)];

%Part A and C
x0 = [-0.5, 1.4]; 
exact = [0,1];

[output,error] = newton(f,10e-15,x0,exact)

convergence = error(2:end) ./ (error(1:end-1))  %goes to zero
convergence = error(2:end) ./ (error(1:end-1)).^2 %seems bounded
convergence = error(2:end) ./ (error(1:end-1)).^2.2 %seems to blow up

figure(1)
semilogy(error)
hold on

%Part B and C
[output,error] = broyden(f,10e-15,x0, exact)

convergence = error(2:end) ./ (error(1:end-1)) %goes to zero
convergence = error(2:end) ./ (error(1:end-1)).^2 %blows up

figure(2)
semilogy(error)
hold off


format short