clear, close all;
clc;

% input data
rng(1,'v5normal');

n = 4096;
t = (0:n-1)';
y  = 0.5*sin((2*pi/n)*t).*sin(0.01*t);
ydelta = y + 0.05*randn(size(y));
bounds = [min(ydelta(:)),max(ydelta(:))];

% TODO: USE THIS FOR THE SECOND SIGNAL
% n = 4096; t = (0:n-1)';
% y = ones(n/4,1);
% y = [y; -y; y; -y];
% y = y + 0.5*sin((2*pi/n)*t);
% ydelta = y + 0.1*randn(size(y));
% bounds = [min(ydelta(:)),max(ydelta(:))];

% display input data
figure()
subplot(211); plot(t,y,'r-');
axis([0 n bounds(1) bounds(2)]);
title('original signal');

subplot(212); plot(t,ydelta,'k-');
axis([0 n bounds(1) bounds(2)]);
title('corrupted signal');


% construct differential operator B
% TODO: ADD CODE HERE

% find optimal regularization parameter
nopt    = 100;
regpara = logspace(-10,10,nopt);

obj1 = zeros([nopt,1]);
obj2 = zeros([nopt,1]);

fprintf('%s\n',repmat('-' , [1,60]));
fprintf('computing 100 points on tradeoff curve\n');
fprintf('%s\n',repmat('-' , [1,60]));
for i = 1:nopt
    beta = regpara(i);
    % TODO: ADD CVX CODE HERE

    fprintf('tradeoff point %-3d for beta=%e\n',i,beta);
end
fprintf('%s\n',repmat('-' , [1,60]));

figure()
plot(obj2,obj1,'kx-');
hold on;
% TODO: UNCOMMENT THE FOLLOWING LINE
% plot(0,norm(B*ydelta),'o');
plot(norm(ydelta),0,'o');
hold off;
h = xlabel('$||Bx||_2$');
set(h,'Interpreter','latex','FontSize',25);
h = ylabel('$||x-y||_2$');
set(h,'Interpreter','latex','FontSize',25);

% from inspection we have that the value is 3.0323
id = 1; %TODO: CHANGE THIS NUMBER TO WHAT YOU HAVE FOUND
dstar = obj2(id);
alpha = [1/3 1 3];

% allocate memory
xrecon = zeros([numel(y),numel(alpha)+1]);

% solve optimization problem for betastar
betastar = regpara(id);
% TODO: ADD CVX CODE HERE FOR OPTIMAL REGULARIZATION PARAMETER

% store result for optimal regularization parameter
% TODO: UNCOMMENT LINE
% xrecon(:,1) = x;

% solve constrained optimization problems
for i=1:numel(alpha)
    % TODO: ADD CVX CODE HERE

    % TODO: UNCOMMENT LINE TO STORE OPTIMIZATION VARIABLE
%    xrecon(:,i+1) = x;
end


% display results
figure()
subplot(411), plot(t,xrecon(:,1),'k');
hold on; plot(t,y,'r-'); hold off;
axis([0 n bounds(1) bounds(2)]);
h = title('$\beta^\star$');
set(h,'Interpreter','latex','FontSize',22);
l = legend('$x_{\textrm{sol}}$','$x^{\star}$');
set(l,'Interpreter','latex','FontSize',22);

subplot(412), plot(t,xrecon(:,2),'k');
hold on; plot(t,y,'r-'); hold off;
axis([0 n bounds(1) bounds(2)]);
h = title('$||x-y^\delta||_2= \frac{1}{3}d^\star$');
set(h,'Interpreter','latex','FontSize',22);
l = legend('$x_{\textrm{sol}}$','$x^{\star}$');
set(l,'Interpreter','latex','FontSize',22);

subplot(413), plot(t,xrecon(:,3),'k');
hold on; plot(t,y,'r-'); hold off;
axis([0 n bounds(1) bounds(2)]);
h = title('$||x-y^\delta||_2= d^\star$');
set(h,'Interpreter','latex','FontSize',22);
l = legend('$x_{\textrm{sol}}$','$x^{\star}$');
set(l,'Interpreter','latex','FontSize',22);

subplot(414), plot(t,xrecon(:,4),'k');
hold on; plot(t,y,'r-'); hold off;
axis([0 n bounds(1) bounds(2)]);
h = title('$||x-y^\delta||_2= 3d^\star$');
set(h,'Interpreter','latex','FontSize',22);
l = legend('$x_{\textrm{sol}}$','$x^{\star}$');
set(l,'Interpreter','latex','FontSize',22);

nt = norm(y(:));
fprintf('%s\n',repmat('-' , [1,60]));
fprintf('relative errors:\n');
fprintf('%s\n',repmat('-' , [1,60]));
fprintf('solution 1: %e\n',norm(y(:)-xrecon(:,1))/nt);
fprintf('solution 2: %e\n',norm(y(:)-xrecon(:,2))/nt);
fprintf('solution 3: %e\n',norm(y(:)-xrecon(:,3))/nt);
fprintf('solution 4: %e\n',norm(y(:)-xrecon(:,4))/nt);
fprintf('%s\n',repmat('-' , [1,60]));
