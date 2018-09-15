%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################
function x = lsqsolcvx(A,b)
% LSQSOLCVX compute solution of constrained least squares
% problem based on CVX functions
%
% inputs:
%    A         n x m matrix
%    b         right hand side (vector)
% outputs:
%    x         solution

n = size(A,2);

% call cvx functionality
cvx_begin
	variable x(n);
	minimize(norm(A*x - b))
cvx_end

end
