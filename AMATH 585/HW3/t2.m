x0 = .1;
e0 = 0.3 - .25;


x = x0

iter = 0;

while abs(x - .25) > e0*0.1
    x = x^2 + 3/16;
    
    iter = iter + 1;
    
end
iter