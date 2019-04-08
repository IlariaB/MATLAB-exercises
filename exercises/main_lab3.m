% image filtering

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

im = repmat(x, 2000, 1);
% figure(3), imshow(im);
% im = im + imrotate(im, 90);

F = fft2(im);  % bidimensional Fourier transform
F = fftshift(F);

% figure(4), imagesc(log(1+abs(F)));
% surf(abs(F));

center = size(im) / 2;
[xx, yy] = meshgrid(1:size(im, 1), 1:size(im, 2));
D = sqrt((xx - center(1)).^2 + (yy - center(2)).^2);
filter = zeros(size(D));
filter(D <= 150) = 1;

% figure(5), surf(filter);

F = F .* filter;

F = ifftshift(F);
X = ifft2(F);
X = real(X);
% figure(6), imshow(X);

im = imread('lena.bmp');
im = im2double(im);
im = rgb2gray(im);  % greyscale

F = fft2(im);  % bidimensional Fourier transform
F = fftshift(F);

% figure(7), imagesc(log(1+abs(F)));
% surf(abs(F));

center = size(im) / 2;
[xx, yy] = meshgrid(1:size(im, 1), 1:size(im, 2));
D = sqrt((xx - center(1)).^2 + (yy - center(2)).^2);
filter = zeros(size(D));
filter(D <= 25) = 1;
filter = 1 - filter;

% figure(8), surf(filter);

F = F .* filter;

F = ifftshift(F);
X = ifft2(F);
X = real(X);
figure(9), imshow(X);
