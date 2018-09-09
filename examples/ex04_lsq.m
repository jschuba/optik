clear, close all;
clc;

m = 32; n = 32;

% create random matrices and vectors
A = randn(n,m);
b = randn(m,1);

% define function handle for objective
j = @(x) lsqobj(A,x,b,'j');

% define function handle for gradient
g = @(x) lsqobj(A,x,b,'g');

% compute hessian matrix
H = lsqobj(A,[],[],'h');


x = randn(n,1);
fprintf('objective value:        %e\n', j(x));
fprintf('norm of gradient:       %e\n', norm(g(x)));
fprintf('norm of hessian matvec: %e\n', norm(H*x));

