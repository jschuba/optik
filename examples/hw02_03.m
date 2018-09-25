clear, close all;
clc;

% in this script we solve an unconstrained least squares problem
% using CVX

% set up problem sizes
m = 32; n = 32;
A = randn(m,n);
b = randn(m,1);

cvx_begin
    variable x1(n)
    minimize( norm(A*x1 - b, 2) )
cvx_end

cvx_begin
    variable x2(n)
    x2 >= 0
    minimize( norm(A*x2 - b, 2) )
cvx_end

figure();
plot(x1); hold on; plot(x2,'x'); hold off;
xlim([1,n]);
legend('Unconstrained', 'Constrained');
title('solution of least-squares');

