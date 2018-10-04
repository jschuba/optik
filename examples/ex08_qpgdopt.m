%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################
clear, close all;
clc;
% this script implements gradient descent for a simple
% test problem with analytical line search

itermax = 100;				% max number of iterations
opttol  = 1e-12;			% tolerance for optimization
xtrue   = [0.0;0.0];		% true solution

% c = [1; 1]; % well conditioned
c = [1,10]; % badly conditioned

% prevent user from attempting to solve problems that will not work
if (c(1) <= 0 || c(2) <= 0)
	warning('does not work for non-convex problems');
	return;
end

% compute initial guess (non-zero, since 0 is the solution)
x = zeros(2,1);
x(1) = c(2) / sqrt(c(1)^2 + c(2)^2);
x(2) = c(1) / sqrt(c(1)^2 + c(2)^2);

% compute matrix for quadratic; since this matrix
% is diagonal, diagonal entries will correspond
% to the eigenvalues
Q = diag([c(1),c(2)]);

% function handles for objective and gradient
f0 = @(x) 0.5*x'*Q*x;
g  = @(x) Q*x;

% compute norm of gradient for initial guess
ng0 = norm(g(x));
if ng0 < 1E-12, ng0 = 1.0; end

% allocate array for storing history / iterates
y = zeros([2,itermax+1]);
y(:,1) = x;

% display header
fprintf('%s\n',repmat('-' , [1,93]));
fprintf('iter  %5s %17s %17s %22s %13s\n', 'f0(x)', 'x(1)', 'x(2)', '||g||_rel', 'error');
fprintf('%s\n',repmat('-' , [1,93]));

% flag to indicate if we did converge after less then or equal to max
% number of iterations
converged = false;

f0eval = zeros(itermax,1);

% perform gradient descent with analytical line search
for iter = 1:itermax

	f0eval(iter) = f0(x);

	% minimizer is x^\star = (0,0)^\T
	delta = sqrt((xtrue(1) - x(1))^2 + (xtrue(1) - x(2))^2);
	gx    = g(x);

	fprintf('%3d   %+4.8e   %+4.8e   %+4.8e   %+4.8e   %+4.8e\n',iter, f0eval(iter), x(1), x(2), norm(gx)/ng0, delta);
	if delta < opttol
		converged = true;
		break;
	end

	% compute line search parameter analytically
	alpha = gx(:)'*gx(:)/(gx(:)'*Q*gx(:));

	% update iterate
	y(:,iter+1) = x - alpha.*g(x);
	x = y(:,iter+1);
end

% display meta info and error for final iterate
if (converged)
	fprintf('%s\n',repmat('-' , [1,93]));
	fprintf(' converged with error %2.12e (cond Q = %2.12e)\n', delta,max(c)/min(c));
	fprintf('%s\n',repmat('-' , [1,93]));
else
	fprintf('%s\n',repmat('-' , [1,93]));
	fprintf(' error after %d iterations: %2.12e (cond Q = %2.12e)\n', iter, delta,max(c)/min(c));
	fprintf('%s\n',repmat('-' , [1,93]));
end

% plot results
[x1,x2] = ndgrid(-1:1/100:1, -1:1/100:1);

f0s = zeros(size(x1));
for i = 1 : size(x1,1)
	for j = 1 : size(x1,2)
		x(1) = x1(i,j);
		x(2) = x2(i,j);
		f0s(i,j) = f0(x);
	end
end

figure();
contour(x1,x2,f0s);
hold on;
plot(y(1,1),y(2,1),'ok');
plot(y(1,1:iter),y(2,1:iter),'-r');
plot(y(1,2:iter),y(2,2:iter),'or');
hold off;


figure(),
s = surfc(x1,x2,f0s,'FaceAlpha',0.8,'EdgeColor','none');
hold on;
scatter3(y(1,1:iter),y(2,1:iter),f0eval(1:iter),'r','filled');
plot3(y(1,1:iter),y(2,1:iter),f0eval(1:iter),'-','LineWidth',2);
zlim([min(f0s(:))-0.1*min(f0s(:)),max(f0s(:))]);
hold off;
