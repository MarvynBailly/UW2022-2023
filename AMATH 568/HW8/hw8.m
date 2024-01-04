%Switch these to match which situation you are tring to simulate
%d = 1;
%e = .1;
d = .1;
e = .2;
w = 10e2;


wVals = 10.^linspace(-0.5,3,1000);
GVals = zeros(1,length(wVals));


for i = 1:length(wVals)
    w = wVals(i);
    T = 2*pi/w;
    tSpan = [0,T];

    y01 = [1,0];
    %--switch these to match which sitaution you are trying to simulate
    [t1,y1] = ode45(@(t,y) upNonLinear(t,y,d,e,w), tSpan, y01);
    %[t1,y1] = ode45(@(t,y) downNonLinear(t,y,d,e,w), tSpan, y01);
    %[t1,y1] = ode45(@(t,y) up(t,y,d,e,w), tSpan, y01);
    %[t1,y1] = ode45(@(t,y) down(t,y,d,e,w), tSpan, y01);
    

    %--switch these to match which sitaution you are trying to simulate
    y02 = [0,1];
    [t2,y2] = ode45(@(t,y) upNonLinear(t,y,d,e,w), tSpan, y02);
    %[t1,y1] = ode45(@(t,y) downNonLinear(t,y,d,e,w), tSpan, y01);
    %[t1,y1] = ode45(@(t,y) up(t,y,d,e,w), tSpan, y01);
    %[t1,y1] = ode45(@(t,y) down(t,y,d,e,w), tSpan, y01);


    GVals(i) = y1(end,1) + y2(end,2);
end

figure(1)
semilogx(wVals,GVals);
hold on
semilogx([10^(-1),10e3],[2,2],"--r")
semilogx([10^(-1),10e3],[-2,-2],"--r")
axis([10^(-1),10e3,-5,5])
xlabel('\omega')
ylabel('\Gamma')
hold off

function dydt = down(t,y,d,e,w)
    dydt = [y(2); -(d + e*cos(w*t))*y(1)];
end
function dydt = up(t,y,d,e,w)
    dydt = [y(2); (d+e*cos(w*t))*y(1)];
end
function dydt = downNonLinear(t,y,d,e,w)
    dydt = [y(2); -(d+e*cos(w*t))*sin(y(1))];
end
function dydt = upNonLinear(t,y,d,e,w)
    dydt = [y(2); (d+e*cos(w*t))*sin(y(1))];
end



