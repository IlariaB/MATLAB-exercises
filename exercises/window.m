function [x, n] = window(a, b, x0, x1)

n = a : b;
x = zeros(size(n));

% u = find(n==x0);
% x(u) = 1;

x(n >= x0 & n <= x1) = 1;

end