function [output,error] = broyden(f, tol, x0, exact)
    %Input: function, tolerance, and initial guess
    %Ouput: approximation using Newton method and the number of iterations 
    
    
    n = length(x0);         %get dim of system
    syms x [1, n];          %create a list of symbols x0,x1,...,xn
    
    J = jacobian(f, x);      %create a jacobian function
    y1 = x0;
    Ai = inv(double(subs(J,x,y1))); %compute
    y2 = y1 - (Ai*double(subs(f,x,y1)'))'; 
    g = (double(subs(f,x,y2) - subs(f,x,y1)))'; %define
    p = (y2 - y1)';
    
    %compute the error
    error = [norm(y2 - exact)];
    
    iter = 1;               %set counter for iterations
    
    while norm(y2 - y1) > tol
        Ai = Ai - ((Ai*g-p)*p'*Ai)/(p'*Ai*g); %compute
        y1 = y2;    %update
        y2 = y1 - (Ai*double(subs(f,x,y1)'))';
        g = (double(subs(f,x,y2) - subs(f,x,y1)))';
        p = (y2 - y1)';
        
        error = [error, norm(y2 - exact)];
        
        iter = iter + 1;
    end
    
    output = [y2 iter];
end