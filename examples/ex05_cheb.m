%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################

% this script is based on an example found in CVX

% the goal is to find the Chebyshev center of a polyhedron, i.e.,
% the largest euclidean ball that lies in a polyhedron
%
%         P = {x \in R^2 : a_i'*x <= b_i, i=1,...,m}
%
% described by linear inequalites, where x is in R^2

clear, close all;
clc;

% generate the input data
a1 = [ 3;  1];
a2 = [ 2; -2];
a3 = [-1;  2];
a4 = [-2; -2];

b = ones(4,1);

% create and solve the problem
cvx_begin
	variable r(1)
	variable xc(2)
	maximize ( r )
	subject to
		a1'*xc + r*sqrt(a1'*a1) <= b(1);
		a2'*xc + r*sqrt(a2'*a2) <= b(2);
		a3'*xc + r*sqrt(a3'*a3) <= b(3);
		a4'*xc + r*sqrt(a4'*a4) <= b(4);
cvx_end


% display the results
x     = linspace(-2,2);
theta = 0:pi/100:2*pi;

figure()
plot( x, -x*a1(1)./a1(2) + b(1)./a1(2),'k-'); % plot hyperplane
hold on;
plot( x, -x*a2(1)./a2(2) + b(2)./a2(2),'k-'); % plot hyperplane
plot( x, -x*a3(1)./a3(2) + b(3)./a3(2),'k-'); % plot hyperplane
plot( x, -x*a4(1)./a4(2) + b(4)./a4(2),'k-'); % plot hyperplane
plot( xc(1) + r*cos(theta), xc(2) + r*sin(theta), 'r'); % plot circle
plot(xc(1),xc(2),'k+'); % plot center point
h = xlabel('$x_1$'); set(h,'Interpreter','latex','FontSize',25);
h = ylabel('$x_2$'); set(h,'Interpreter','latex','FontSize',25);
h = title('chebyshev center of a polyhedron');
set(h,'FontSize',12);
xlim([-1 1]); ylim([-1 1]);
axis equal;
hold off;
