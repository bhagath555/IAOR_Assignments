n = 100;
p = zeros(n);
w = 10;
vals = [0,1,2,3,4,4,3,2,1,0]/4;
for i= 1:10:100
    for j = 1:10
       p(i+j,:) = vals(j);
    end
end

figure;
imagesc(p);

image_ff = fft2(p);

figure;
imagesc(abs(fftshift(image_ff)));