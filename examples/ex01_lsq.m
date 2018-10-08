%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################
clear, close all;
clc;

% in this script we solve an unconstrained least squares problem
% using CVX

% set up problem sizes
m = 32; n = 32;

% create a random matrix of size m x n
A = randn(m,n);

% create random vector in R^m
b = randn(m,1);

cvx_begin
    variable x(n)
    minimize( norm(A*x - b, 2) )
cvx_end
