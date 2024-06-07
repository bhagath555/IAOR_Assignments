clear all;
close all;

% Step a: Read the input image and convert it to grayscale
img = imread('taskA.png');
gray_img = rgb2gray(img);
gray_img = im2double(gray_img); % Convert to range [0, 1]

% Plot the grayscale image
figure;
imshow(gray_img);
title('Grayscale Image');

%% Image gaussian noise and fft
J = imnoise(gray_img,'gaussian', 0, 0.01);
figure;
subplot(2,2,1);
imshow(J);
title('Image with G-noise');

% Applying FFT to the image.
image_fft = fft2(J);
subplot(2,2,2); 
image_fft_s = log(abs(fftshift(image_fft)));
imagesc(image_fft_s);
title('Image FFT');

%% Gaussina noise mask
sigma =2.5;
r = round(3 * sigma);      % Mask radius
i = -r:r;                  % this represents x and y. both are same here.
% 1D Gaussian 
g = exp(-i.^2 / (2*sigma^2)) / (sqrt(2*pi)*sigma);
gaussian = g'*g;

%% Adjusting the padding and shifting 
extend_pad = size(J)-size(gaussian);
padding = padarray(gaussian,extend_pad, 0, "post");
padding = circshift(padding, -1 * round(size(gaussian)/2));

subplot(2,2,3); 
imshow(padding, []);
title('Padding gaussian mask');

% Applying FFT to Gaussian mask
fft_padding = fft2(padding);
fft_padding_s = log(abs(fftshift(fft_padding)));
subplot(2,2,4); 
imagesc(fft_padding_s);
title('Mask FFT');

%% Convolution of mask and image

Guv = image_fft .* fft_padding;

figure
imagesc(log(abs(fftshift(Guv))));

%% Inverse FFT
final = ifft2(Guv);

%% Helping functions

figure;
subplot(1,2,1);
imshow(J);
title("Blurred image");

subplot(1,2,2);
imshow(final);
title(["Final image, singma : ", sigma]);