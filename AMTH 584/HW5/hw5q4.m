function hw5q4(size)
%define condnos
condnos = [1,10^4,10^8,10^12,10^16];

%define xtrue
xtrue = randn(size,1);

%one big loop for each condnos case
for i=1:length(condnos)
    A = matgen(size,condnos(i));
    b = A*xtrue;
    
    %Method 1 - Guassian Elimation with Partial Pivoting
    x1 = A\b;
    error1 = norm(x1 - xtrue)/norm(xtrue);
    residual1 = norm(b-A*x1)/(norm(A)*norm(x1));
    
    %Method 2 - Inverting A
    x2 = inv(A)*b;
    error2 = norm(x2 - xtrue)/norm(xtrue);
    residual2 = norm(b-A*x2)/(norm(A)*norm(x2));
    
    %Method 3 - Cramer's Rule
    dA = det(A);
    x3 = zeros(size,1);
    for j=1:size
        Aj = A;
        Aj(:,j) = b;
        dj = det(Aj);
        x3(j) = dj/dA;
    end
    error3 = norm(x3 - xtrue)/norm(xtrue);
    residual3 = norm(b-A*x3)/(norm(A)*norm(x3));
    
    fprintf("For Condition number: %e \n",condnos(i))
    x = [x1,x2,x3];
    error = [error1,error2,error3];
    residual = [residual1,residual2,residual3];
    %disp("x: " + x)
    fprintf("Relative error and res for GE: %e and %e \n",error1,residual1)
    fprintf("Relative error and res for inv(A): %e and %e \n",error2,residual2)
    fprintf("Relative error and res for Cramer: %e and %e \n",error3,residual3)
    fprintf("\n")
end
