function x = lsqsolcvx(A,b)
% compute solution of constrained least squares problem
% using CVX function

[m,n] = size(A);

% call cvx functionality
cvx_begin
    variable x(n);
    minimize(norm(A*x - b))
cvx_end

end
