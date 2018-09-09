clear, close all;
clc;

% in this script we solve a constrained least squares problem
% with bounds (inequality constraints) on x; we use a Matlab
% implementation and compare it to the CVX implementation

% set up problem sizes
m = 32; n = 32;

% create a random matrix in R^{m,n}
A = randn([m,n]);

% create random vector in R^m
b = randn([m,1]);

% generate the bounds for the inequality constraint
% $l \succeq x \succeq u$
bnds = randn(n,2);
l = min( bnds, [], 2 );
u = max( bnds, [], 2 );

% solve least squares problem ||Ax - b||
x1 = lsqsolbnd(A,b,l,u);
x2 = lsqsolbndcvx(A,b,l,u);

% display the results
figure();
plot(x1); hold on; plot(x2,'x'); hold off;
xlim([1,n]);
legend('ML-QP', 'CVX');
title('solution of least-squares (box constraints)');

% show the relative error
fprintf('error norm (QR)  %e\n', norm(A*x1 - b)/norm(x1));
fprintf('error norm (CVX) %e\n', norm(A*x2 - b)/norm(x2));
