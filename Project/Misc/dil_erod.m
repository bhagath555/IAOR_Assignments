% Step 1: Read the image
% img = imread('images/1.jpeg');
img = imread('images/1.jpeg');
% Step 2: Convert to grayscale
img_gray = rgb2gray(img);

SE = strel('disk', 2);

di = imdilate(img_gray, SE);
er = imerode(img_gray, SE);

result = di-er;

% result = imadjust(result,stretchlim(result),[]);
% 
% result =  imboxfilt(result, 5);
% result = imgaussfilt(result, 2);
SE = strel('square', 5);
edges2 = imdilate(result, SE);
% img_contrast = imopen(result, SE);


bin = imbinarize(result, 'adaptive', Sensitivity=0);

SE = strel('square', 5);
bin_open = bwareaopen(bin, 100);
% bin_open = imopen(bin, SE);

figure;
subplot(2, 3, 1), imshow(img), title('Original Image');
subplot(2, 3, 2), imshow(img_gray), title('Grayscale Image');
subplot(2, 3, 3), imshow(result), title('d-e');
subplot(2, 3, 4), imshow(edges2), title('contrast');
subplot(2, 3, 5), imshow(bin), title('Binarization');
subplot(2, 3, 6), imshow(bin_open), title('BIn open');