function output = secant(f, tol, x0, x1)
    %Input: function, tolerance, and initial guesses
    %Ouput: approximation using Secant method and the number of iterations 
    
    y0 = x0;
    y1 = x1; 
    y2 = y1 - double((y1 - y0)/(f(y1) - f(y0))*f(y1)); %do one iteration
    
    iter = 1;
    
    while norm(y2 - y1) > tol
        y0 = y1; %update terms
        y1 = y2;
        y2 = y1 - double((y1 - y0)/(f(y1) - f(y0))*f(y1));
        iter = iter + 1;
    end
    output = [y2, iter];
end