clear, close all;
clc;

m = 32; n = 16;

% create a random matrix of size m x n
A = rand([m,n]);

% create random vector in R^m
b = rand([m,1]);

% solve least squares problem ||Ax - b||
x1 = lsqsolqr(A,b);
x2 = lsqsolcvx(A,b);

% display the results
figure();
title('solution of least-squares');
plot(x1); hold on; plot(x2); hold off;
xlim([1,n]);
legend('QR', 'CVX');

% show the relative error
fprintf('error norm (QR)  %e\n', norm(A*x1 - b)/norm(x1));
fprintf('error norm (CVX) %e\n', norm(A*x2 - b)/norm(x2));