function x = lsqsolqr(A,b)
% compute solution of unconstrained least squares problem:
% minimize ||A*x - b|| via QR factorization

% backslash will use QR fractorization
x = A\b;

end
