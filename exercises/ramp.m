function[x, n] = ramp(a, b, x0)

n = a : b;
x = zeros(size(n));

% x if x >= x0
% 0 otherwise

x(n >= x0) = 1 : numel(find(n >= x0));

stem(n, x);
ylim([-0.1, 1.1]);

end