function [x, n] = step(a, b, x0)
n = a : b;
x = zeros(size(n));

x(n >= x0) = 1;

stem(n, x);
ylim([-0.1, 1.1]);

end