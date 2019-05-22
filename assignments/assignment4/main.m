%%% watermark

% take all images, find z transform, visualise it
% calculate treshold and see peak of each image
% peak probability of my watermark

clear;
close all;

im = imread('lena.bmp');
imycbcr = rgb2ycbcr(im);
y = imycbcr(:, :, 1);
% figure(1), imshow(y);

y_dct = dct2(y); % 512x512
% figure(2), imagesc(log(1 + abs(y_dct)));

L = 25000;
M = 16000;
alpha = 0.2;

mark = randn(1000, M); % watermark, randomix matrix 1000xn
x = mark(343, :);

%%% zig-zag read
c = zigzag(y_dct);

%%% watermark casting
t = c(1 : L + M);

for i = L + 1 : size(t, 2)
    t(1, i) = t(1, i) + alpha * abs(t(1, i)) * x(i - L);
    c(1, i) = t(1, i);
end

invc = invzigzag(c, 512, 512);
y2 = idct2(invc);

%%% saving
% figure(1), imshow(uint8(y2));
imwrite(uint8(y2), 'Lena_ila.bmp');

%%% copy images (all of them)
F = dir('Lena_X/*.bmp');
folder = F(1).folder;

array = [];
array2 = [];

for i = 1 : length(F)
   path = strcat(folder, "/" , F(i).name);
   lena = imread(path);
   
   %%% watermark detection for each image
   lena_dct = dct2(lena); % 512x512
   lenac = zigzag(lena_dct);
   
   lenat = lenac;
   
   z = 0;
   s = 0;
   
   for k = 1 : M
       lenat(L + k) = lenac(L + k) + alpha * abs(lenac(L + k)) * x(k);
   end
       
   for j = 1 : M
       z = z + lenac(1, L + j) * x(j);
       s = s + abs(lenat(1, L + j));
   end
   
   s = s * (alpha/(3 * M));
   z = z/M;
   
   array = [array, z];
   array2 = [array2, s];
   
end

%%% plot
figure(2), 
subplot(2, 2, 1), imshow(y);
title("Lena without watermark");
subplot(2, 2, 2), imshow(uint8(y2));
title("Lena with watermark");
subplot(2, 2, [3, 4]), plot(1 : 59, array2)
title("Probabilities");




