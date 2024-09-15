n = 100;
p = zeros(n);
w = 10;
p(:,n/2 - w:n/2 + w) = 1;

figure;
imagesc(p);

image_fft = fft2(p);

figure;
imagesc(abs(fftshift(image_fft)));


