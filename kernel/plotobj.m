%######################################################
% This code is part of the Matlab-based toolbox
% OPTIK --- Optimization Toolkit
% For details see https://github.com/andreasmang/optik
%######################################################
function plotobj(f0,omega,x0,n,d1,d2)
% plotobj generate a plot of the objective in two variables
%
% inputs:
%    f0        function handle; takes n-d array as input
%    domain    domain we are going to explore
%    x0        point around which we evaluate the objective function
%    d1        index for direction along which we are going to explore objective
%    d2        index for direction along which we are going to explore objective
% outputs:
%    result    value of objective functional or gradient

% if no input is given, run default test function
if nargin == 0
	runTest; return;
end


if numel(omega) == 2
	omega = [omega,omega];
end

% set up in intial guess if not provided by user
if nargin > 2
	if ~exist('x0','var')
		x0 = zeros(2,1);
	end
else
	x0 = zeros(2,1);
end


% default number of points to be sampled
if nargin > 3
	if ~exist('n','var')
		n = [100,100];
	end
else
	n = [100,100];
end

% set up vector entries along which 2D surface is going to be plotted
% this is to generalize in case we are plotting a problem in R^n
if nargin < 5
	d1 = 1; d2 = 2;
end

% compute step size inside domain
h = (omega(2:2:end) - omega(1:2:end))./n;

% create grid for evaluation of function
[x1,x2] = ndgrid(omega(1):h(1):omega(2)-h(1), omega(3):h(2):omega(4)-h(2));

% initialize with x0
y = x0;

% allocate 2d array with
f = zeros(n);

for i = 1 : n(1)
	for j = 1 : n(2)
		y(d1) = x0(d1) + x1(i,j);
		y(d2) = x0(d2) + x2(i,j);

		f(i,j) = f0(y);
	end
end

% open figure
figure()
surfc(x1,x2,f);
title('f0(x)');


end



%######################################################
function runTest

Q = diag([0.5,0.5]);
%Q = [0.0,0.5;0.5,0.0]

f0  = @(x) x'*Q*x;

plotobj(f0,[-pi,pi,-pi,pi],zeros(2,1))

end
