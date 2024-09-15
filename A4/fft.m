p = zeros(100);
p(:,48:52) = 1;

image_fft = fft2(p);

imagesc(abs(fftshift(image_fft)));

figure;
