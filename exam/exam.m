%% problem 1
clc
close all
clear variables

F = @(x1, x2)(0.5*(x1.^2-6*x1.*x2+x2.^2) + (4*x1-4*x2) + 2);
A = [1, -3; 
    -3, 1];
d = [4; -4];

x1 = -3:0.1:3;
x2 = -3:0.1:3;
[xx1, xx2] = meshgrid(x1, x2);
yy = F(xx1, xx2);

figure(1)
surf(xx1, xx2, yy)
xlabel('x_1')
ylabel('x_2')
zlabel('F(x)')
axis tight
colorbar 

figure(2)
contourf(xx1, xx2, yy)
xlabel('x_1')
ylabel('x_2')
colorbar

%% problem 2
clc
close all
clear variables

F1 = @(x1, x2)(exp(2*x1.^2 + 2*x2.^2 + x1 -5*x2 + 10));
F2 = @(x1, x2)(exp(10)*(1 + x1 -5*x2 + (5/2)*x1.^2 +(29/2)*x2.^2  -5*x1.*x2));

x1 = -0.5:0.01:0.5;
x2 = -0.5:0.01:1.3;
[xx1, xx2] = meshgrid(x1, x2);
yy1 = F1(xx1, xx2);
yy2 = F2(xx1, xx2);

subplot(1, 2, 1)
surf(xx1, xx2, yy1)
axis tight
title('Original')

subplot(1, 2, 2)
surf(xx1, xx2, yy2)
axis tight
title('Approximated')

%% problem 3
% calculate eigenvalues
A = [0, 1;
    1, 0];
eig(A)

%% Problem 4
% calculate eigenvalues
A = [6, -2;
    -2, 6];
eig(A)

%% Problem 5
% calculate eigenvalues
A = [0, 0;
    0, 4];
eig(A)

%% Problem 7
clc
close all
clear variables

g = @(p)(1 + sin(pi*p/4));

% i
rng(1234)
p = unifrnd(-2, 2, 10, 1);
p = sort(p);
t = g(p);

% ii
W1 = [-2; -2/3; 2/3; 2];
bi1 = sqrt(4)/(4/3);
b1 = ones(4, 1) * bi1;
% b1 = b1*2;
b1 = b1*0.5;
Q = length(p);

z1 = cell(1, Q);
U = ones(Q, length(W1)+1);
for q=1:Q
    n1q = abs(W1 - p(q)).*b1;
    a1q = exp(-n1q.^2);
    z1{q} = [a1q; 1];
    U(q, :) = z1{q};
end

Xstar = inv(transpose(U)*U)*transpose(U)*t;

hat = zeros(Q, 1);
for q=1:Q
    hat(q) = transpose(Xstar)*z1{q};
end  

sum((hat - t).^2)

sim_input = -2:0.1:2;
input_len = length(sim_input);
sim_output = zeros(input_len, 1);
true_output = g(sim_input);
for q=1:input_len
    n1q = abs(W1 - sim_input(q)).*b1;
    a1q = exp(-n1q.^2);
    z1q = [a1q; 1];
    sim_output(q) = transpose(Xstar)*z1q;
end  

plot(sim_input, true_output, 'LineWidth',2)
hold on
    plot(sim_input, sim_output, 'LineWidth',2)
    scatter(p, t, 'g*')
hold off
legend('Target function', 'RBF', 'Training points')
axis tight
xlabel('p')

