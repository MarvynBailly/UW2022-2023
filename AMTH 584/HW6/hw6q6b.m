function hw6q6b
%form A
A = 2*eye(10) - diag(ones(9,1),1) - diag(ones(9,1),-1);

%Get exact eigenvalues
E = eig(A);
counter = 0;
lambdaExact = E(10); 

%set v to be some vector with norm 1
v = eye(10,1);

%define lambdas
lambdaOld = -Inf;
lambdaNew = Inf;

%define v
vOld = v;

%collect the error
oldError = -1;

while lambdaOld~=lambdaNew
    w = A*vOld;
    v = w/norm(w);
    lambdaOld = lambdaNew;
    lambdaNew = transpose(v)*A*vOld;
    vOld = v;
    
    if mod(counter,10) == 0
        if oldError == -1
            newError = abs(lambdaExact - lambdaNew);
            disp([newError,newError/oldError])
            oldError = newError;
        else
            oldError = abs(lambdaExact - lambdaNew);
            disp(abs(lambdaExact - lambdaNew))
        end
    end
    counter = counter + 1;
end

disp(lambdaOld)
disp(v)