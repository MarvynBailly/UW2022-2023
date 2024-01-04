function q11()
format long;
m = 50; n = 12;
t = linspace(0,1,m);

A = fliplr(vander(t));
A = A(:,1:12);
b = cos(4*t)';

%Method A - Normal Equation%
R = chol(A'*A);
xa = R\(R'\(A'*b));

%Method D - QR factorization%
[Q, R] = qr(A);
xd = R\(Q'*b);

%Method E - A\b%
xe = A\b;

%Method F - SVD factorization%
[U, S, V] = svd(A,0);
xf = V*(S\(U'*b));

x = [xa, xd, xe, xf]
end