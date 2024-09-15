% Step 1: Read the image
% img = imread('images/1.jpeg');
img = imread('images/3.jpeg');
% Step 2: Convert to grayscale
img_gray = rgb2gray(img);

% Step 3: Contrast enhancement to make the crack stand out
img_contrast = imadjust(img_gray);

% Step 4: Suppress texture using Gaussian blur (reduce noise and texture)
img_blur = imgaussfilt(img_contrast, 2);  % sigma=2 for moderate smoothing

% Step 5: Edge detection using Sobel (or Canny)
edges = edge(img_blur, 'sobel');  % Use Sobel edge detection to detect cracks

% Step 6: Morphological operations to enhance the cracks
se = strel('diamond', 5);  % Structuring element for dilation
dilated_edges = imdilate(edges, se);  % Dilate the edges to make the crack stronger

% Step 7: Remove small objects that are likely noise
cleaned_img = bwareaopen(dilated_edges, 2000);  % Remove noise smaller than 100 pixels

se = strel('square', 2);
cleaned_img2 = imclose(cleaned_img, se);

% Display the results
figure;
subplot(2, 3, 1), imshow(img), title('Original Image');
subplot(2, 3, 2), imshow(img_gray), title('Grayscale Image');
% subplot(2, 3, 3), imshow(img_contrast), title('Contrast Enhanced');
subplot(2, 3, 3), imshow(edges), title('sobel');
subplot(2, 3, 4), imshow(dilated_edges), title('Dilated');
subplot(2, 3, 5), imshow(cleaned_img), title('Enhanced Crack (Cleaned)');
subplot(2, 3, 6), imshow(cleaned_img2), title('Edge Detection (Sobel)');

% skeleton_img = bwskel(cleaned_img2, 'MinBranchLength', 5);  % Skeletonize with minimum branch length of 10 pixels
se = strel('square', 5);
ero_img = imerode(cleaned_img2, se);
figure;
subplot(1, 2, 1), imshow(cleaned_img2), title('Original Binary Image');
subplot(1, 2, 2), imshow(ero_img), title('Skeletonized Image');