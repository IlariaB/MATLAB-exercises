% clear; to clear environment
% close all; to close windows

% ; to not print on console

% variable assignment: a = 1;
% vector: a = [1 2; 3 4];
% mathematical operators + - * /

clear;
close all;

[x, n] = impulse(2, 17, 7);
[x1, n1] = step(2, 17, 7);
[x2, n2] = window(2, 17, 5, 10);
[x3, n3] = ramp(2, 17, 7);
[x4, n4] = sine_wave(2, 1/4, 0, 0, 39);

% discrete Fourier transform using the fast algorithm (FFT)
F = fft(x4);

% shift zero-frequency component to center of spectrum
F = fftshift(F);

% inverse
xr = ifftshift(F);
xr = ifft(xr);

% subplot(rows, columns, position) to display more images
% abs = modulo, real = real part, imag = imaginary part
xr = real(xr);

% numel = number of elements
% generate linearly spaced vector witn n points
normfreq = linspace(-1/2, 1/2, numel(F));

% figure window (title)
figure(1);
% axes in tiled position
subplot(2, 2, 1);
stem(n,x), title('Impulse');
% plot(n, x);
ylim([-0.1 1.1]);
subplot(2, 2, 2);
stem(n1,x1), title('Step');
ylim([-0.1 1.1]);
subplot(2, 2, 3);
stem(n2,x2), title('Window');
ylim([-0.1 1.1]);
subplot(2, 2, 4);
stem(n3, x3), title('Ramp');

figure(2);
subplot(3, 2, 1);
stem(normfreq, real(F)/numel(F)), title('Real part');
subplot(3, 2, 2);
stem(normfreq, imag(F)/numel(F)), title('Imaginary part');
ylim([-0.1 1.1]);
subplot(3, 2, 3);
stem(n4,x4), title('Sin wave');
ylim([-0.1 1.1]);
subplot(3, 2, 4);
stem(normfreq, abs(F)), title('Module');
subplot(3, 2, 5);
stem(normfreq, angle(F)/numel(F)), title('Phase');
subplot(3, 2, 6);
stem(n4, xr), title('Inverse transform');