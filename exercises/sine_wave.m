function [x, n] = sine_wave(A, f0, phi, a, b)

n = a : b;
x = A * sin(2 * pi * f0 * n + phi);

stem(n, x);

% Fourier transform
F = fft(x);
F = fftshift(x);

% subplot(rows, columns, position) to display more images
% abs = modulo, real = real part, imag = imaginary part


end