function [x, n] = sine_wave(A, f0, phi, a, b)

n = a : b;
x = A * sin(2 * pi * f0 * n + phi);

end