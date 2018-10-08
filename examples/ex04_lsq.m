%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################
clear, close all;
clc;

m = 32; n = 32;

% create random matrices and vectors
A = randn(n,m);
b = randn(m,1);

% define function handle for objective
j = @(x,flag) lsqobj(A,x,b,flag);

x = randn(n,1);
fprintf('objective value:        %e\n', j(x,'j'));
fprintf('norm of gradient:       %e\n', norm(j(x,'g')));

