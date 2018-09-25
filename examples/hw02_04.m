% HW02_Question 4 and 5 main

m = 32; n = 32;
beta = 0.1;

% create random matrices and vectors
A = randn(n,m);
b = randn(m,1);

% define function handle for objective
f = @(x,flag) lsqobj(A,x,b,flag);
j = @(x,flag) lsqregobj(A,x,b,beta,flag);

x = randn(n,1);

checkDerivative(f, x);
checkDerivative(j, x);