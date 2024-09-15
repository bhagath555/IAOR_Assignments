% Step 1: Read the image
img = imread('training/4.png');

% Step 2: Convert to grayscale
img_gray = rgb2gray(img);

% Step 3: Binarization
level = graythresh(img_gray); 
img_bin = ~imbinarize(img_gray, level);

% Step 4: Suppress texture using Gaussian blur (reduce noise and texture)
img_blur = imgaussfilt(img_gray, 2);  % sigma=2 for moderate smoothing

% Step 5: Edge detection using Canny for more accurate crack edges
edges = edge(img_blur, 'sobel');  % Canny with tuned thresholds and sigma

% Step 6: Morphological operations to enhance and clean up the cracks
se_dilate = strel('disk', 5);  % Structuring element for dilation
dilated_edges = imdilate(img_bin, se_dilate);  % Dilate to make the crack stronger

% Step 7: Remove small objects that are likely noise
cleaned_img = bwareaopen(img_bin, 100);  % Remove small noise smaller than 100 pixels

% se_erode = strel('disk', 6);  % Structuring element for dilation
% cleaned_img = imerode(cleaned_img, se_erode);
% % Step 8: Perform morphological closing to ensure the cracks are continuous
% se_close = strel('disk', 6);
% cleaned_img = imclose(cleaned_img, se_close);  % Close small gaps in the crack

% Step 9: Fill small holes inside the cracks
% cleaned_img = imfill(cleaned_img, 'holes');

% Step 10: Display the result
figure;
subplot(1, 2, 1), imshow(img_gray), title('Original Grayscale Image');
subplot(1, 2, 2), imshow(img_bin), title('Enhanced Crack Detection');
