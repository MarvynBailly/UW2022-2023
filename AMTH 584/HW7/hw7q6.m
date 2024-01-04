function hw7q6
A = delsq(numgrid('L',500));
[m,m] = size(A);
b = rand(m,1);
tol = 1.0 * 10^(-8);
tic, 
[x,flag,relres,iter,resvec] = pcg(A,b,tol,m); 
toc

semilogy(0:iter,resvec)
hold on

L = ichol(A);
tic,
[x,flag,relres,iter,resvecic] = pcg(A,b,tol,m,L,L');
toc

semilogy(0:iter,resvecic)
hold off

legend("unpreconditioned","preconditioned");