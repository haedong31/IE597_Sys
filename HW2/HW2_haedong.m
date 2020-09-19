%% Problem 1 - Lorenz 
clc
close all
clear variables

lparam0 = [10, 28, 0.5];
linit = [0, 1, 1.05];
[~, s1] = Lorenz(lparam0, linit, 50);

scatter3(s1(:,1), s1(:,2), s1(:,3))
xlabel('x'); ylabel('y'); zlabel('z')
set(gca,'CameraPosition', [205.8004 -261.1243  213.1089])
axis tight

%% Problem 1 - Rosller
clc
close all
clear variables

rparam0 = [0.2, 0.05, 1];
rinit = [1, 1, 1];
[~, s2] = Rosller(rparam0, rinit, 100);

figure(2)
scatter3(s2(:,1), s2(:,2), s2(:,3))
xlabel('x'); ylabel('y'); zlabel('z')
axis tight

%% Problem 2
clc
close all
clear variables

r = 0.01:0.001:4;
xpts = [];
ypts = [];
for i=1:length(r)
    fprintf('###ITER: %i/%i \n', i, length(r))
    lims = log_growth_lim(0.1, r(i), 50);
    x = r(i)*ones(1, length(lims));
    xpts = [xpts, x];
    ypts = [ypts, lims];
end

scatter(xpts, ypts, 0.15)
xlabel('r'); ylabel('The Attractor')

%% Problem 4 - Mutual Information
clc
close all
clear variables

rparam0 = [0.2, 0.2, 5.7];
rinit = [1, 1, 1];
[~, s2] = Rosller(rparam0, rinit, 100);

x = s2(:,1);

% tau is multiplier of time-step of ODE solver; approximate default is 0.01
tau = 1:100;
t = tau * 0.01;

mis = zeros(1, length(tau));
for i=1:length(tau)
    mis(i) = mutual_info(x, tau(i), 20);
end

plot(t, mis)
axis tight
xlabel('Tau (sec)')
ylabel('Mutual Information')

%% Problem 4 - FNN
clc
close all
clear variables

rparam0 = [0.2, 0.2, 5.7];
rinit = [1, 1, 1];
[~, s2] = Rosller(rparam0, rinit, 100);

x = s2(:,1);

% tau is multiplier of time-step of ODE solver; approximate default is 0.01
tau = 25;

% size of dimension
dim = 1:1:10;

% rth nearest neighbor
r = 1;

% FNN-criterion tolerance
tol = 5;

fnn_ratios = FNN(x, tau, dim, r, tol);
plot(dim, fnn_ratios, '-o')
axis tight
xlabel('m (Embedding Dimension)')
ylabel('False Nearest Neighbor Ratio')
