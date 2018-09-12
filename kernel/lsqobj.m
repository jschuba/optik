function [result] = lsqobj(A,x,b,flag)
% LSQOBJ implementation of objective function for
% least squares problem
%
% inputs:
%    A         n x m matrix
%    b         right hand side (vector)
%    x         current iterate
%    flag      flag to identify what's going to be computed
%              options are:
%              'j'    objective value
%              'g'    gradient
%              'h'    hessian
% outputs:
%    result    value of objective functional, gradient or
%              hessian matvec



switch flag
	case 'j'
		% evaluate objective functional j(x) = ||Ax-b||^2_2
		dr = A*x - b;
		result = 0.5*dr(:)'*dr(:);
	case 'g'
		% evaluate gradient g(x) = A^\T(Ax-b)
		dr = A*x - b;
		result = A'*dr;
	case 'h'
		% compute hessian
		result = A'*A;
	otherwise
		error('flag not defined');
end


end
