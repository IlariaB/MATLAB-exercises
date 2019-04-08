% filtering audio tracks

% assignment: building an audio equalizer
% fasce arbitrarie, bisogna capire cos'è alto, cos'è medio, cos'è basso
% deve dimezzare le alte frequenze, lasciare inalterate le medie e
% raddoppiare le basse
% spettro prima e dopo il filtro

close all;

[y, fs] = audioread('andiamo.mp3');
% optimal value of samples/second for right speed

% sound(y, 48000);

y = y(:, 1);
% due canali: cuffia destra e sinistra

F = fft(y);
F = fftshift(F);
normfreq = linspace(-1/2, 1/2, numel(F));

center = round(numel(F) / 2);
low = 1000000;
high = 9000000;

filter = ones(1, numel(F));

width = 5000;
% 125000 non si sente nulla

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

% segnale originale, filtro, segnale trasformato
figure(1);
subplot(3, 1, 1);
plot(normfreq, abs(F)/numel(F)), title("Original signal");
subplot(3, 1, 2);
plot(filter), title("Filter");
subplot(3, 1, 3);
plot(xf), title("Filtered signal");
