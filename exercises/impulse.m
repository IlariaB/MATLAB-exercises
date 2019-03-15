% clear; to clear environment
% close all; to close windows

% ; to not print on console

% variable assignment: a = 1;
% vector: a = [1 2; 3 4];
% mathematical operators + - * /

% function: takes in input time and centering of the impulse
function [x, n] = impulse(a, b, x0)

n = a : 1 : b;  % vector from a to b, step size 1 --> a : b
x = zeros(size(n));

x(n == x0) = 1;

stem(n, x);
ylim([-0.1, 1.1]);

end