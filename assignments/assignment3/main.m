%%% Demosaicing & Automatic White Balancing & Color Correction & Gamma Correction
%%% Color checker, 24 colors (color correction) - converting .tiff to .jpg

% 1. AUTO FOCUS
% 2. AUTO EXPOSURE
% 3. DEMOSAICING
% 4. AUTOMATIC WHITE BALANCING
% 5. MATRIXING (COLOR CORRECTION)
% 6. TONE MAPPING
% 7. GAMMA CORRECTION

clear;
close all;

im = imread('IMG_1295.tiff');
im = im2double(im);

%%% Auto Exposure (AE), moving the mean of an object
% x' = m2 * x / m1 
im = im./max(im(:)); % sort of AE
% figure(1), clf, imshow(im)
% the image is now in greyscale and better exposed

%%% Demosaicing

% sensor configuration:
% R G R G
% G B G B
% R G R G
% G B G B

im2 = zeros(size(im, 1), size(im, 2), 3);
for r = 2 : size(im, 1) - 1 % no handling of borders
    for c = 2 : size(im, 2) - 1
        % 4 cases: rows even/odd, col. even/odd
        if mod(r, 2) == 0 && mod(c, 2) == 1 % G
            im2(r, c, 1) = (im(r - 1, c) + im(r + 1, c))/2;
            im2(r, c, 2) = im(r, c);
            im2(r, c, 3) = (im(r, c - 1) + im(r, c + 1))/2;
            
        elseif mod(r, 2) == 1 && mod(c ,2) == 0 % G
            im2(r, c, 1) = (im(r, c - 1) + im(r, c + 1))/2;
            im2(r, c, 2) = im(r, c);
            im2(r, c, 3) = (im(r - 1, c) + im(r + 1, c))/2;
            
        elseif mod(r, 2) == 1 % R
            im2(r, c, 1) = im(r, c); 
            im2(r, c, 2) = (im(r - 1, c) + im(r + 1, c) + im(r, c - 1) + im(r, c + 1))/4;
            im2(r, c, 3) = (im(r - 1, c - 1) + im(r - 1, c + 1) + im(r + 1, c - 1) + im(r + 1, c + 1))/4;
       
        else % B
            im2(r, c, 1) = (im(r - 1, c - 1) + im(r - 1, c + 1) + im(r + 1, c - 1) + im(r + 1, c + 1))/4;
            im2(r, c, 2) = (im(r - 1, c) + im(r + 1, c) + im(r, c - 1) + im(r, c + 1))/4;
            im2(r, c, 3) = im(r, c);
        end
    end
end

im = im2(2 : end - 1, 2 : end - 1, :); % borders cutting

%%% Automatic White Balance (AWB)
S = size(im);
RGB = reshape(im, [], 3); 
media = mean(RGB);
matrice = diag([0.5 0.5 0.5]./media); % Gray World
RGB = RGB * matrice;
im = reshape(RGB, S);

%%% Matrixing
gamma = 1.08;
RGBr = [107	83	70
182	147	128
103	122	154
96	108	69
129	128	172
132	189	170
197	122	55
79	92	164
171	85	97
84	62	103
168	187	75
211	159	56
52	65	143
102	148	78
151	53	59
227	198	53
165	85	147
66	136	164
245	245	240
200	201	200
160	160	160
120	121	120
84	85	86
53	53	54]; % from research paper
RGBr=(RGBr/255).^gamma; % leave it

figure();
imshow(im);
imwrite(im2uint8(im), 'image.jpg');
%figure(1), clf, imshow(im);

%%% TODO from here

RGBc = []; % to recover from the image
% [x,y] = ginput(24);
M = []; % matrix calculus --> ???

RGB = reshape(im, [], 3); 
RGB = RGB * M;
im = reshape(RGB, S);

%%% Gamma correction
im(im < 0) = 0;
im(im > 1) = 1;
im = im.^(1/gamma); % gamma correction

%%% saving image
imwrite(im2uint8(im), 'image.jpg')