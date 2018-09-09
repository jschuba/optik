function x = lsqsolbndcvx(A,b,l,u)
% LSQSOLBNDCVX function to solve the convex optimization problem
% (least squares problem) with box constraints/bounds on x, i.e.,
%    min_x ||Ax - b||_2 subject to l <= x <= u
%
% inputs:
%    A         n x m matrix
%    b         right hand side (vector)
%    l         component wise lower bound
%    u         component wise upper bound
% outputs:
%    x         solution

% get number of columns
n = size(A,2);

cvx_begin
	variable x(n);
	minimize( norm(A*x - b, 2) )
	subject to
		l <= x <= u  % inequality constraints
cvx_end

end
