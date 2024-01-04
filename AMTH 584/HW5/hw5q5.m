function hw5q5
record = 0;
%Construct A
A = eye(60);
A(:,60) = ones(60,1);
B = -1*tril(ones(60),-1);
A = A + B;
%Compute condition number of A
cA = cond(A);
%fprintf("The condition nubmer of A is %e \n",cA)

%generate x
x = randn(60,1);

%compute b
b = A*x;

%Method a - Gaussian Elimination with Pivoting
x_ge = A\b;
error_ge = norm(x_ge - x);
rel_ge = norm(x_ge - x)/norm(x);

%Method b - QR Factorization
[Q,R] = qr(A);
x_qr = R\(Q'*b);
error_qr = norm(x_qr - x);
rel_qr = norm(x_qr - x)/norm(x);

fprintf("Gaussian Elimination Error: %e\n",error_ge)
fprintf("Gaussian Elimination Relative Error: %e\n",rel_ge)
fprintf("QR Facotrization Error: %e\n",error_qr)
fprintf("QR Facotrization Relative Error: %e\n",rel_qr)

