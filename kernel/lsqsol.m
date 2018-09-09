function x = lsqsol(A,b)
% LSQSOL compute solution of unconstrained least squares problem,
% i.e., min_x ||A*x - b||,
% based on the default matlab implementation (QR factorization)
%
% inputs:
%    A         n x m matrix
%    b         right hand side (vector)

% we use backslash, which will default to a QR fractorization
x = A\b;

end
