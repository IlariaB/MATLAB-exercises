% function: takes in input time and centering of the impulse
function [x, n] = impulse(a, b, x0)

n = a : 1 : b;  % vector from a to b, step size 1 --> a : b
x = zeros(size(n));

x(n == x0) = 1;

end