function [result] = checkDerivative(f, x)
% Plots the error in the first-order Taylor approximation of 
% the function f, at x.  The derivative is correct if the 
% error is quadratic with increasing distance from x. 
% Plots the error in several random directions.

% inputs:
%    f          should be a function handle that takes two arguements:
%               x         current point to evaluate
%               flag      flag to identify what's going to be computed
%                           options are:
%                           'j'    objective value
%                           'g'    gradient
%                           'h'    hessian

%    x          current point to evaluate
% outputs:
%    result     does nothing

n = length(x);
num_directions = 10;
num_steps = 100;

h = logspace(-1, -10, num_steps);
error = zeros(num_directions,num_steps);

figure(); hold on;

for direction = 1:num_directions
    v = randn(n,1);
    for step = 1:num_steps
        error(direction,step) = abs( f(x+h(step).*v, 'j') - f(x, 'j') - h(step).*f(x, 'g')'*v); 
    end
    plot(h, error(direction,:));
end

title('Absolute error in first-order Taylor approximation');
xlabel('Distance from point x');
ylabel('Error');
result = 0;
