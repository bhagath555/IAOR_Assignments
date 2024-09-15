% Load Image
img = imread('images/1.jpeg');
grayImg = rgb2gray(img);

% Enhance contrast
contrastImg = adapthisteq(grayImg);

% Apply edge detection to highlight the crack
edges = edge(contrastImg, 'Sobel');

% Dilate the crack edges for better visibility
se = strel('square', 3);
dilatedEdges = imdilate(edges, se);

% Reduce the texture noise using a median filter
smoothedImg = medfilt2(contrastImg, [5 5]);

% Overlay the enhanced crack on the smoothed background
finalImage = imoverlay(smoothedImg, dilatedEdges, [1 0 0]);
figure; imshow(finalImage)
% Display original and final images
figure, imshowpair(grayImg, finalImage, 'montage');
title('Original Image vs Enhanced Image');
