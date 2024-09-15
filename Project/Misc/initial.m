img = imread('images/1.jpeg'); % Replace with your image path
grayImage = rgb2gray(img); % Convert to grayscale if needed

figure; imshow(grayImage);


% Apply Median Filter to reduce salt-and-pepper noise

% Apply Gaussian Filter to smooth the image and reduce noise
img_gaussian_filtered = imgaussfilt(grayImage, 0.1); % sigma value of 2
img_median_filtered = medfilt2(grayImage, [5 5]);
% Display original and filtered images
figure;
subplot(1, 2, 1), imshow(grayImage), title('Original Image');
subplot(1, 2, 2), imshow(img_median_filtered), title('After Gaussian Filtering');


binaryImage = imbinarize(img_median_filtered, 'global');
figure; imshow(~binaryImage);


SE = strel("square",5);
op1 = imopen(~binaryImage, SE);

figure; imshow(op1);
