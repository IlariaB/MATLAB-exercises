% assignment: making a filter

% applying a band-pass and a band-block filter to the same transform
% third sin wave

close all;
clear;

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

figure(1);

F = fft(x);
F = fftshift(F);
normfreq = linspace(-1/2, 1/2, numel(F));

filter1 = zeros(1, numel(F));
filter1(870 : 926) = 1;
filter1(1074 : 1145) = 1;
Xf = F .* filter1;
subplot(2, 2, 1);
plot(normfreq, abs(Xf)/numel(Xf)), title('Transform with band-pass filter');

% inverse transform
Xf = ifftshift(Xf);
xf = ifft(Xf);
xf = real(xf);
subplot(2, 2, 2);
plot(xf), title('Signal with band-pass filter');

filter2 = 1 - filter1;
Xf = F .* filter2;
subplot(2, 2, 3);
plot(normfreq, abs(Xf)/numel(Xf)), title('Transform with band-stop filter');

% inverse transform
Xf = ifftshift(Xf);
xf = ifft(Xf);
xf = real(xf);
subplot(2, 2, 4);
plot(xf), title('Signal with band-stop filter');
