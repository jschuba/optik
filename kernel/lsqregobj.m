
function [result] = lsqregobj(A,x,b,beta,flag)
% LSQOBJ implementation of objective function for
% regularized least squares problem
%
% inputs:
%    A         n x m matrix
%    b         right hand side (vector)
%    x         current iterate
%    beta      regularizer parameter
%    flag      flag to identify what's going to be computed
%              options are:
%              'j'    objective value
%              'g'    gradient
%              'h'    hessian
% outputs:
%    result    value of objective functional or gradient

switch flag
	case 'j'
		% evaluate objective functional j(x) = ||Ax-b||^2_2
		dr = A*x - b;
		result = 0.5*dr(:)'*dr(:) + 0.5.*beta.*x'*x;
	case 'g'
		% evaluate gradient g(x) = A^\T(Ax-b)
		dr = A*x - b;
		result = A'*dr + beta.*x;
	case 'h'
		% compute hessian A^\T A
		result = A'*A + beta.*eye(size(A,2));
	otherwise
		error('flag not defined');
end
end
