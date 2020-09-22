clc
close all
clear variables

% problem 1-a
fsurf(@(x1, x2) (x2-x1).^4 + 8*x1.*x2 - x1 + x2 + 3, [0, 1])

% problem 1-b
fun = @(x) (x(2)-x(1))^4 + 8*x(1)*x(2) - x(1) + x(2) + 3;

x0 = [-1, 1];
[x, fval] = fminunc(fun, x0);
