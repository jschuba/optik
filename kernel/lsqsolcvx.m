function x = lsqsolcvx(A,b)
% compute solution of constrained least squares problem
% using CVX function

[m,n] = size(A);

cvx_begin
    variable y(n);
    minimize(norm(A*y - b))
cvx_end
x = y;

end
