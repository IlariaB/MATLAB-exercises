function [x, n] = window(a, b, x0, x1)

n = a : b;
x = zeros(size(n));

x(n >= x0 & n <= x1) = 1;

stem(n, x);
ylim([-0.1, 1.1]);

end