n = 100;
p = zeros(n);
w = 10;
for i= 1:20:100
    p(i:i+10, :) = 1;
end

figure;
imagesc(p);

image_fft = fft2(p);

figure;
imagesc(abs(fftshift(image_fft)));