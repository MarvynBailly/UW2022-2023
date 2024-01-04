function output = bisection(f, interval, tol, iter)
    %Input: function, interval, tolerance, and number of iterations
    %Ouput: approximation using Bisection method and the number of iterations
    
    mid = (interval(1) + interval(2))/2; %get mid point
    
    if(f(mid) == 0 || interval(2)-interval(1) < tol) %we found the root
        output = [mid,iter];
    elseif(f(interval(1))*f(mid) < 0) %if signs are different on left
        output = bisection(f, [interval(1), mid], tol, iter+1);
    elseif(f(interval(2))*f(mid) < 0) %if signs are different on right
        output = bisection(f, [mid, interval(2)], tol, iter+1);
    else
        output = "Can not find root";
    end
end