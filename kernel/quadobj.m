%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################
function [result] = quadobj(Q,x,b,c,flag)
% QUADOBJ implementation of objective function for
% quadratic function
%
% inputs:
%    Q         n x n matrix
%    b         vector (linear part)
%    x         current iterate
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
		result = 0.5*x'*Q*x + b'*x + c;
	case 'g'
		% evaluate gradient g(x) = A^\T(Ax-b)
		result = Q*x + b;
	case 'h'
		% compute hessian A^\T A
		result = Q;
	otherwise
		error('flag not defined');
end


end
