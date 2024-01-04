function [times,values] = runge(f,h,t0,tf,y0)
    
    times = [t0:h:tf];          
    values = zeros(1,length(times));
    
    values(1) = y0;
    
    
    
    for i=2:length(times)
        th = (times(i-1) + times(i))/2;
        Y1 = values(i-1);
        Y2 = values(i-1) + 0.5*h*f(Y1,times(i-1));
        Y3 = values(i-1) + 0.5*h*f(Y2,th);
        Y4 = values(i-1) + h*f(Y3,th);
        values(i) = values(i-1) + 1/6 * h * (f(Y1,times(i-1)) + 2*f(Y2,th) + 2*f(Y3,th) + f(Y4,times(i)));
    end
    
end