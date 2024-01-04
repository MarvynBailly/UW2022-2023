function hw6q6c
A = 2*eye(10) - diag(ones(9,1),1) - diag(ones(9,1),-1);

%set v to be some vector with norm 1
v = eye(10,1);

% Initialize lambda variables
lambdaOld = Inf;
lambdaNew = 0;

%set v
vOld = v;

%counter
counter = 0;

while lambdaOld~=lambdaNew
    w = (A - eye(10))\vOld;
    v = w/norm(w);
    lambdaOld = lambdaNew;
    lambdaNew = transpose(v)*A*v;
    vOld = v;
    counter = counter + 1;
end

disp(lambdaOld)
disp(v)
disp(counter)