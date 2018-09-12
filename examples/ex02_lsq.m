clear, close all;
clc;

% in this script we solve an unconstrained least squares problem
% using CVX and the default Matlab approach and compare the results

% set up problem sizes
m = 32; n = 32;

% create a random matrix of size m x n
A = randn(m,n);

% create random vector in R^m
b = randn(m,1);

% solve least squares problem ||Ax - b||
x1 = lsqsol(A,b);
x2 = lsqsolcvx(A,b);

% display the results
figure();
plot(x1); hold on; plot(x2,'x'); hold off;
xlim([1,n]);
legend('ML-QR', 'CVX');
title('solution of least-squares');

% show the relative error
fprintf('error norm (ML-QR) %e\n', norm(A*x1 - b)/norm(x1));
fprintf('error norm (CVX)   %e\n', norm(A*x2 - b)/norm(x2));
