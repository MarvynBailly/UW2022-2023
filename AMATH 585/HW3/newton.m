function [output,error] = newton(f, tol, x0, exact)
    %Input: function, tolerance, initial guess, and exact solution
    %Ouput: approximation using Newton method, the number of iterations, and errors 
    
    n = length(x0);         %get dim of system
    syms x [1, n];          %create a list of symbols x0,x1,...,xn
    
    J = jacobian(f, x);      %create a jacobian function
    
    y1 = x0;
    y2 = y1 + (double(subs(J,x,y1)) \ double(-subs(f,x,y1))')';
    
    iter = 1;               %set counter for iterations
    
    %compute the error
    error = false;
    if(~(isa(exact,'boolean')))
        error = [norm(y2 - exact)];
    end
    
    
    
    while norm(y2 - y1) > tol
        y1 = y2;            %update guess
        y2 = y1 + (double(subs(J,x,y1)) \ double(-subs(f,x,y1))')'; %compute next term
        
        
        %compute the error
        if(~(isa(exact,'boolean')))
            error = [error, norm(y2 - exact)];
        end
        
        iter = iter + 1;
    end
   
    output = [y2, iter];
end