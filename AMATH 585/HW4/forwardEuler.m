function [times,values] = forwardEuler(f,h,t0,tf,y0)
    
    times = [t0:h:tf];          
    values = zeros(1,length(times));
    
    values(1) = y0;
    
    
    
    for i=2:length(times)
        values(i) = values(i-1) + h*f(values(i-1),times(i-1));
    end
    
end