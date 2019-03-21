close all;
clear;
clc;  % clear command window

% signal with more waves and constants
[x1, n] = sine_wave(1, 1/4, 0, 0, 39);
[x2, n] = sine_wave(2, 1/20, 0, 0, 39);
x = x1 + x2 + 10;

% sum of two signals
% figure(1), stem(x);

% Fourier transform modulo
F = fft(x);
normfreq = linspace(-1/2, 1/2, length(F));
figure(2);
% modulo (abs) of transform F, shifting the center
stem(normfreq, abs(fftshift(F))/length(F));
ylabel('Normalized frequency');
xlabel('Module');

% constant: peak on 0
% x = x1 + x2 + 10;

% zero-padding: adding zeros to signal to identify peaks
x = [x, zeros(1, 1000)];
% figure(3);
% stem(normfreq, abs(fftshift(F))/length(F));

% filtering in frequency domain
SF = 400;  % sampling frequency
D = 1 * SF;  % lentgh
f = 5;  % initial frequency (Hz)
k = 1;  % counter

x = [];
while f < 160
    for n = 1 : D
        % signal frequency / sampling frequency
        x(k) = sin(2 * pi * n* f/SF);
        k = k + 1;
    end
    % doubling the frequency
    f = f * 2;
end

% figure(4);
% plot(x);

% removing the 3 highest frequencies
% low pass filter

F = fft(x);
F = fftshift(F);
normfreq = linspace(-1/2, 1/2, numel(F));
% figure(5), plot(normfreq, abs(F)/numel(F));
% figure(5), plot(abs(F)/numel(F));

filter = zeros(1, numel(F));
filter(950 : 1052) = 1;  % arbitrary values
Xf = F .* filter;
% figure(6), plot(normfreq, abs(Xf)/numel(Xf));

% inverse transform
Xf = ifftshift(Xf);
xf = ifft(Xf);
xf = real(xf);
% figure(7), plot(xf);

% high pass filter (2)
F = fft(x);
F = fftshift(F);
normfreq = linspace(-1/2, 1/2, numel(F));

filter = zeros(1, numel(F));
filter(1 : 920) = 1;  % arbitrary values
filter(1080 : numel(F)) = 1;
Xf = F .* filter;

Xf = ifftshift(Xf);
xf = ifft(Xf);
xf = real(xf);
figure(8), plot(xf);

% low to high just with 1 - filter



