%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################
clear, close all;

% this script illustrates how to access dual variables
c = [49;-34;-50;-5];
A = [ -4, 12, -2,  1;...
     -17, 12,  7, 11;...
       1,  0, -6,  1;...
       3,  3, 22, -1;...
     -11,  2, -1, -8];
b = [8;13;-4;27;-18];

n = size(A,2);
cvx_begin
    variable x(n);
    dual variable v;
    minimize( c' * x );
    subject to
        v : A * x <= b;
cvx_end

fprintf('%s\n',repmat('-' , [1,64]));
fprintf('solution xstar = (%.2e,%.2e,%.2e,%.2e)\n',x);
fprintf('optimal value  = %.2f\n', cvx_optval);
fprintf('%s\n',repmat('-' , [1,64]));
fprintf('complementary slackness condition:\n');
fprintf('v.*(b-A*x)     = (%.2e,%.2e,%.2e,%.2e,%.2e)\n',v.*(b-A*x));
fprintf('%s\n',repmat('-' , [1,64]));
