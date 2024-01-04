function [times,values] = improvedEuler(f,h,t0,tf,y0)
    
    times = [t0:h:tf];          
    values = zeros(1,length(times));
    
    values(1) = y0;
    
    
    
    for i=2:length(times)
        Y = values(i-1) + h*f(values(i-1),times(i-1));
        values(i) = values(i-1) + 0.5*h*(f(values(i-1),times(i-1)) + f(Y,times(i)));
    end
    
end