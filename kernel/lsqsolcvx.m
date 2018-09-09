function x = lsqsolcvx(A,b)
% LSQSOLCVX compute solution of constrained least squares
% problem based on CVX functions
%
% inputs:
%    A         n x m matrix
%    b         right hand side (vector)

[m,n] = size(A);

% call cvx functionality
cvx_begin
	variable x(n);
	minimize(norm(A*x - b))
cvx_end

end
