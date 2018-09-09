function x = lsqsolbnd(A,b,l,u)
% LSQSOLBND function to solve the convex optimization problem
% (least squares problem) with box constraints / bounds
% on x, i.e.,
%    min_x ||Ax - b||_2 subject to l <= x <= u
% inputs:
%    A         n x m matrix
%    b         right hand side (vector)
%    l         component wise lower bound
%    u         component wise upper bound

% call the Matlab solver (quadratic programming)
x = quadprog(2*A'*A, -2*A'*b, [], [], [], [], l, u);

end
