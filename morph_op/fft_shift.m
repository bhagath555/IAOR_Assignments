n = 100;
p = zeros(n);
w = 10;

p(1:50, :) = 1;

figure;
imagesc(p);

image_fft = fft2(p);

figure;
imagesc(abs(fftshift(image_fft)));

p = zeros(n);

p(31:80, :) = 1;

figure;
imagesc(p);

image_fft = fft2(p);

figure;
imagesc(abs(fftshift(image_fft)));