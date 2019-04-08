% filtering audio tracks

% assignment: building an audio equalizer
% arbitrary intervals
% double low frequencies, halve high frequencies
% display spectrum, filter and modified frequencies

close all;

[y, fs] = audioread('andiamo.mp3');
% optimal value of samples/second for right speed

% sound(y, 48000);

y = y(:, 1);
% two channels (two earphones)

F = fft(y);
F = fftshift(F);
normfreq = linspace(-1/2, 1/2, numel(F));

center = round(numel(F) / 2);
low = 1500000;
high = 8500000;

filter = ones(1, numel(F));

width = 8000;
% lower than 12500

filter((center - width) : (center + width)) = 2;  % arbitrary value

filter(1 : low) = 0.5;  % arbitrary values
filter(high : numel(F)) = 0.5;

Xf = F .* filter';

xf = ifftshift(Xf);
xf = ifft(xf);
xf = real(xf);

% sound([y; xf], fs);
% figure(2), plot(abs(xf)/numel(xf))
% figure(2), plot(xf)

% original signal, filter, filtered signal
figure(1);
subplot(3, 1, 1);
plot(normfreq, abs(F)/numel(F)), title("Original signal");
subplot(3, 1, 2);
plot(filter), title("Filter");
subplot(3, 1, 3);
plot(xf), title("Filtered signal");
