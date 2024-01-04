clear All
format long

%setting up things
syms f(y,t);
f(y,t) = - 1/t^2 - y/t - y^2;
t0 = 1;
tf = 2;
y0 = -1;
h = 0.01;

%find exact solution
opts = odeset('RelTol',1e-12,'AbsTol',1e-12);
exact = ode45(@(t,y)- 1/t^2 - y/t - y^2,[t0,tf],y0,opts);

%% part A 
[fet,fey] = forwardEuler(f,h,t0,tf,y0);
%plot approx with exact
figure(1)
plot(fet,deval(exact,fet));
hold on
plot(fet,fey);
legend("ODE45","Forward Euler");
hold off

%part B
[iet,iey] = improvedEuler(f,h,t0,tf,y0);
%plot approx with exact
figure(2)
plot(iet,deval(exact,fet));
hold on
plot(iet,iey);
legend("ODE45","Improved Euler");
hold off

%part C
[ret,rey] = runge(f,h,t0,tf,y0);
%plot approx with exact
figure(3)
plot(ret,deval(exact,fet));
hold on
plot(ret,rey);
legend("ODE45","Fourth Order Runge-Kutta");
hold off

%%
%compute convergence

%Forward Euler
n = 10;
fError = zeros(1,n);
hvals = 2.^-[1:n];
for i = 1:n
    h = hvals(i);
    [fet,fey] = forwardEuler(f,h,t0,tf,y0);
    fError(i) = norm(fey - deval(exact,fet),Inf);
end
%get slope
figure(4)
loglog(hvals,fError);
p = polyfit(log(hvals),log(fError),1);
p(1)

%%
%Improved Euler
n = 10;
iError = zeros(1,n);
hvals = 2.^-[1:n];
for i = 1:n
    h = hvals(i);
    [iet,iey] = improvedEuler(f,h,t0,tf,y0);
    iError(i) = norm(iey - deval(exact,iet),Inf);
end
%get slope
figure(5)
loglog(hvals,iError);
p = polyfit(log(hvals),log(iError),1);
p(1) %outputs 


%%
%Runge
n = 7;
rError = zeros(1,n);
hvals = 2.^-[1:n];
for i = 1:n
    h = hvals(i);
    [ret,rey] = runge(f,h,t0,tf,y0);
    rError(i) = norm(rey - deval(exact,ret),Inf);
end

%get slope
figure(6)
loglog(hvals,rError);
p = polyfit(log(hvals),log(rError),1);
p(1) %outputs 

format short